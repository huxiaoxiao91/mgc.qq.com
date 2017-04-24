package
{
	import com.h3d.util.Log;
	import com.h3d.util.Tracer;
	import com.h3d.video.MarqueePane;
	import com.h3d.video.TopPane;
	import com.h3d.video.VideoEngine;
	import com.h3d.video.VideoHttpChannel;
	import com.h3d.video.VideoPlayer;
	import com.junkbyte.console.Cc;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.ByteArray;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	//[SWF(backgroundColor="#4a1eb9")]
	[SWF(backgroundColor="#000000")]
	public class x51VideoPlayer extends Sprite
	{
		private var version_number:String = "version:388.3.9.1";
		
		//主播视频
		private var videoEngine:VideoEngine;
		
		//受邀主播视频
		private var videoEngine1:VideoEngine;
		
		//flash初始化完毕后回调
		static public var INIT:int = -8;
		//开始播放视频回调
		static public var PLAY:int = -9;
		
		//是否为演唱会房间
		static public var IS_CONCERT:Boolean = false;
		
		//是否连上   逻辑flash断开连接时  此值为false 视频断开
		static public var isConnect:Boolean = false;
		
		//关注按钮  音量  顶部提示都在这里
		static public var topPane:TopPane;
		
		//视频区裁剪
		private var marginTop:Number = 0;
		
		//视频分辨率 
		static public var VideoWidth:int;
		static public var VideoHeight:int;
		
		private var timeid:uint = 0;
		
		/**
		 * 是否竖屏显示
		 */
		static public var isVertical:Boolean = false;
		
		public function x51VideoPlayer() {
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			//初始化Log
			initLoggerConsole();
			
			//清除右键菜单
			var myContextMenu:ContextMenu = new ContextMenu(); 
			myContextMenu.hideBuiltInItems(); 
			this.contextMenu = myContextMenu;
			
			//读取配置后在初始化。
//			initVersion();
			
			//引流页面视频区裁剪
			/*var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			if (paramObj.hasOwnProperty("margin_top")) {
				TopPane.SOUND_BOTTOM = 30 + parseInt(paramObj["margin_top"]);
			}*/
			//Js调用Flash
			ExternalInterface.addCallback("setMarginTop", setMarginTop);
			ExternalInterface.addCallback("getLog", getLog);
			
			if(stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function setMarginTop(num:Number):void
		{
			TopPane.SOUND_BOTTOM = 30 + num;
			topPane.setSize(stage.stageWidth,stage.stageHeight);
		}
		
		private function getLog():void
		{
			ExternalInterface.call("console.log",Log.LOG);
		}
		
		private function init():void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Log.formatLogMsg(0,"视频插件初始化完成");
			
			topPane = new TopPane();
			topPane.setSize(stage.stageWidth,stage.stageHeight);
			addChild(topPane);
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			//是否开启硬件编码
			VideoPlayer.useHardwareDecoder = false//stage.loaderInfo.parameters["useHardwareDecoder"] == "true"?true:false;
			
			//Cc.error(stage.loaderInfo.parameters["useHardwareDecoder"],VideoPlayer.useHardwareDecoder);
			
			videoEngine = new VideoEngine();
			videoEngine.StartEngine(this);
			topPane.addStream(videoEngine._videoMgr.GetVideoPlayer()._playStream);

			ExternalInterface.addCallback("start", start);
			ExternalInterface.addCallback("stop", stop);

			//Cc.startOnStage(this, "`");
			//Cc.config.remotingPassword = ""; // Just so that remote don't ask for password
			//Cc.remoting = true;
			
			//Js调用Flash
			ExternalInterface.addCallback("request_as", request_as);
			
			//通知页面flash初始化成功
			var tojson:Object = new Object();
			tojson.op_type = x51VideoPlayer.INIT;
//			var str:String = JSON.stringify(tojson);
			ExternalInterface.call("response_as",tojson);
			
			stage.addEventListener(MouseEvent.CLICK,stageClick);
			
			var lastIndex:int = stage.loaderInfo.url.indexOf("/", 7);
			var domain:String = stage.loaderInfo.url.substring(0, lastIndex);
			new VersionConfigLoader().loadConfig(loadVersionConfigCompleted, domain + VersionConfigLoader.DEFAULT_CONFIG_URL);
		}
		
		private function loadVersionConfigCompleted(loader:VersionConfigLoader):void
		{
			if (loader != null)
			{
				version_number = loader.playerClientVer;
				
				initVersion();
			}
			else
			{
				Cc.log("load version_config faile");
			}
		}
		
		//通知JS  flash舞台被点击
		private function stageClick(e:MouseEvent):void
		{
			ExternalInterface.call("flashClick");
		}
		
		//JS通知页面被点击
		private function jsClick():void
		{
			stage.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		/**
		 * 请求一些初始化数据
		 */
		private function request():void
		{
			//请求是否游客
			var o:Object = new Object();
			o.op_type = 203;
			ExternalInterface.call("gift_send",o);
		}
		
		/**
		 * JS回调接口
		 */
		private function request_as(jsonparam:*):void
		{
			//Cc.log(jsonparam);
			var params:Object; 
			
			//判断obj str
			if(jsonparam is String)
			{
				try{
					params = JSON.parse(jsonparam);
				}
				catch(e:SyntaxError)
				{
					return;
				}
			}
			else
			{
				params = jsonparam;
			}
			
			if(params == null)return;
			
			switch(params.op_type as int)
			{					
				//房间状态更新回调
				case 35:
					Log.showLog("房间状态更新回调：",JSON.stringify(jsonparam));
					Log.formatLogMsg(35,"房间状态更新回调：" + JSON.stringify(jsonparam));
					
					request();
					
					//是否竖屏
					isVertical = params.anchor_device_type != 0 && params.vertical_live;
					//是否演唱会房间
					IS_CONCERT = params.isConcert;
					topPane.isConcert = IS_CONCERT;
					
					VideoWidth = params.width;
					VideoHeight = params.height;
					
					//false 为没门票
					if(!params.isHasTicket && IS_CONCERT)
					{
						TopPane.SOUND_BOTTOM = 80;
					}
					else
					{
						TopPane.SOUND_BOTTOM = 30;
					}
					
					//开播
					if(params.status == 2)
					{
						//炫舞2超过一定时间没有开播时 ，强制刷新页面
						if(ExternalInterface.call("MgcAPI.SNSBrowser.IsX52") && !topPane.isPlay)
						{
							clearTimeout(timeid);
							timeid = setTimeout(ExternalInterface.call,10000,"location.reload");
						}
					}
					else
					{
						stop();
					}
					
					stage.dispatchEvent(new Event(Event.RESIZE));
					break;
				
				//开播回调
				case 52:
					Log.showLog("开播消息：",JSON.stringify(jsonparam));
					Log.formatLogMsg(52,"开播消息：" + JSON.stringify(jsonparam));
					
					//是否演唱会房间
					IS_CONCERT = params.isConcert;
					
					start(params);
					//openSplit();
					//startSplit({cdnUrls:[]});

					
					//获取房间信息
					var tojson:Object = new Object();
					tojson.op_type = 35;
					ExternalInterface.call("gift_send",tojson);
					
					break;
				
				//停止直播回调
				case 53:
					Log.showLog("停止直播：",JSON.stringify(jsonparam));
					Log.formatLogMsg(53,"停止直播：" + JSON.stringify(jsonparam));
					
					stop();
					closeSplit();
					stopSplit();

					break;
				
				//关注主播回调
				case 116:
					Log.showLog("关注主播：",JSON.stringify(jsonparam));
					if(params.res == 0 && params.anchorID == topPane.anchorId)
					{
						topPane.isFollow = true;
					}
					//关注主播满了
					else if(params.res == 1)
					{
						ExternalInterface.call("MGC_CommResponse.IsMaxFollow");
					}
					else if(params.res == 9)
					{
						ExternalInterface.call("MGC_CommResponse.NotMaxFollow");
					}
					break;
				
				//取消关注主播回调
				case 117:
					Log.showLog("取消关注主播：",JSON.stringify(jsonparam));
					if(params.res == 0 && params.anchorID == topPane.anchorId)
					{
						topPane.isFollow = false;
					}
					break;
				
				//服务器连接状态回调  如果逻辑flash断开  视频也要停播
				case 178:
					Log.showLog("服务器连接状态回调：",JSON.stringify(jsonparam));
					if(!params.res && topPane.isPlay)
					{
						videoEngine._cdnRetryCount = VideoHttpChannel.RETRY_CDN_CNT;
						
						if(videoEngine1)
						{
							videoEngine1._cdnRetryCount = VideoHttpChannel.RETRY_CDN_CNT;
						}
						
						stop();
						closeSplit();
						stopSplit();
					}
					
					break;
				
				//刷新分屏状态回调
				case 200:
					Log.showLog("刷新分屏状态：",JSON.stringify(jsonparam));
					Log.formatLogMsg(200,"刷新分屏状态：" + JSON.stringify(jsonparam));
					
					if(IS_CONCERT)return;
					
					topPane.isFollow = params.is_follow;
					topPane.anchorId = params.anchorId;
					topPane.anchorName = params.anchorName;
					
					switch(params.status)
					{
						case 0:
							closeSplit();
							//stopSplit();
							break;
						
						case 1:
							openSplit();
							//stopSplit();
							break;
						
						case 2:
							openSplit();
							break;
					}

					break;
				
				//分屏直播开启回调
				case 201:
					Log.showLog("分屏直播开启：",JSON.stringify(jsonparam));
					Log.formatLogMsg(201,"分屏直播开启：" + JSON.stringify(jsonparam));
					
					if(IS_CONCERT)return;
					
					startSplit(params);

					break;
				
				//分屏直播关闭回调
				case 202:
					Log.showLog("分屏直播关闭：",JSON.stringify(jsonparam));
					Log.formatLogMsg(202,"分屏直播关闭：" + JSON.stringify(jsonparam));
					
					if(IS_CONCERT)return;
					
					stopSplit();
					
					break;
				
				//是否游客
				case 203:
					Log.showLog("是否游客：",JSON.stringify(jsonparam));
					topPane.isVisitor = params.isVisitor;
					break;
				
			}
		}
		
		
		
		/**
		 * 
		 * @param json 要播放的视频地址 json串
		 * {"cdnUrls":["http://125.39.127.145:1863/6060512.flv","http://125.39.127.145:1863/6060513.flv?apptype=live&xHttpTrunk=1&buname=x5h3d&uin=49605824"]}
		 */		
		private function start(o:Object):void 
		{ 
			//var o:Object = JSON.parse(json);
			
			videoEngine.SaveCdnUrl(o.cdnUrls);
			videoEngine.StartCDNClient(0);
			
			topPane.isPlay = true;
			
			clearTimeout(timeid);
		}
		
		private function stop():void 
		{ 
			videoEngine.StopCDNClient();
			
			topPane.isPlay = false;
		}
		
		/**
		 * 开启分屏
		 */
		private function openSplit():void
		{
			if(!videoEngine1)
			{
				videoEngine1 = new VideoEngine();
				videoEngine1.StartEngine(this);
				topPane.addStream(videoEngine1._videoMgr.GetVideoPlayer()._playStream);
			}
			
			videoEngine._videoMgr.GetVideoPlayer().position = 0;
			videoEngine._videoMgr.GetVideoPlayer().isSplit = true;
			videoEngine1._videoMgr.GetVideoPlayer().position = 1;
			videoEngine1._videoMgr.GetVideoPlayer().isSplit = true;
			videoEngine1._videoMgr.GetVideoPlayer().showStopPane(true);

/*			
			var width:Number = videoEngine._videoMgr.GetVideoPlayer().video.width;
			videoEngine._videoMgr.GetVideoPlayer().x = -width/4;
			videoEngine1._videoMgr.GetVideoPlayer().x = width/4;*/
		}
		
		/**
		 * 关闭分屏
		 */
		private function closeSplit():void
		{
			videoEngine._videoMgr.GetVideoPlayer().isSplit = false;
			if(videoEngine1)
			{
				videoEngine1._videoMgr.GetVideoPlayer().isSplit = false;
			}
		}
		
		/**
		 * 播放分屏
		 */
		private function startSplit(o:Object):void
		{
			videoEngine1.SaveCdnUrl(o.cdnUrls);
			videoEngine1.StartCDNClient(0);
			
			topPane.isSplit = true;
		}
		
		/**
		 * 停播分屏
		 */
		private function stopSplit():void
		{
			if(videoEngine1)
			{
				videoEngine1.StopCDNClient();
			}
			
			topPane.isSplit = false;
		}
		
		private function initLoggerConsole():void
		{
			Cc.visible = true;
			//Cc.config.style.big();
			Cc.config.style.whiteBase();
			Cc.config.style.backgroundAlpha=1;
			Cc.width = 200;
			Cc.height = 100;
			Cc.x = 0;
			Cc.y = 0;
			Cc.startOnStage(this, "h3d.com");
			//showAS();
			//Cc.start(this);
			ExternalInterface.addCallback("showAS",showAS);
			ExternalInterface.addCallback("hideAS",hideAS);
		}
		
		private function showAS(e:Event = null):void
		{
			Cc.start(this);
		}
		
		private function hideAS():void
		{
			Cc.remove();
		}
		
		private function initVersion():void
		{
			var myContextMenu:ContextMenu = new ContextMenu(); 
			myContextMenu.hideBuiltInItems(); 
			this.contextMenu = myContextMenu; 
			
			var item:ContextMenuItem = new ContextMenuItem(version_number); 
			myContextMenu.customItems.push(item); 
		}
	}
}