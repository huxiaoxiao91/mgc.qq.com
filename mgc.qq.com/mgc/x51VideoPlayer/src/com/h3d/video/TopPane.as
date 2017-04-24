package com.h3d.video
{
	import com.bit101.components.Component;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.NetStream;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * 顶部面板
	 * @author WJ
	 * 
	 */	
	public class TopPane extends Component
	{
		private var text_tip:Label;
		
		/**
		 * 是否游客
		 */
		public var isVisitor:Boolean = false;
		
		/**
		 * 是否分屏
		 */
		private var _isSplit:Boolean = false;
		
		/**
		 * 音量条距底部位置
		 */
		static public var SOUND_BOTTOM:Number = 30;
		
		/**
		 * 是否显示关注按钮
		 */	
		static public var showFan:Boolean = false;
		
		/**
		 * 关注按钮
		 */
		private var btn_fan:PushButton;
		
		/**
		 * 全屏按钮
		 */
		private var btn_full:PushButton;
		
		/**
		 * 取消全屏按钮
		 */
		private var btn_cancelFull:PushButton;
		
		/**
		 * 取消全屏按钮tips
		 */
		private var cancelfullTip:MC_9;
		
		/**
		 * 进入全屏按钮tips
		 */
		private var fullTip:MC_11;
		
		/**
		 * 是否全屏
		 */
		private var isFullScreen:Boolean = false;
		
		/**
		 * 是否静音
		 */
		private var isMute:Boolean = false;
		
		/**
		 * 静音前音量
		 */
		private var volume:Number;
		
		/**
		 * 音量调节界面
		 */
		private var soundBar:SoundBar;
		
		/**
		 * 流
		 */
		private var streamArr:Array = [];
		
		private var _isFollow:Boolean = false;
		
		/**
		 * 主播id
		 */
		public var anchorId:String;
		
		/**
		 * 主播昵称
		 */
		public var anchorName:String;
		
		/**
		 * 是否在播放
		 */
		public var isPlay:Boolean = false;
		
		private var _isConcert:Boolean = false;
		
		//走马灯
		private var marqueePane:MarqueePane;
		
		public function TopPane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			initUI();
		}
		
		public function get isConcert():Boolean
		{
			return _isConcert;
		}

		public function set isConcert(value:Boolean):void
		{
			_isConcert = value;
			
			refreshBtn();
		}

		public function initUI():void
		{
			text_tip = new Label(this,0,0,"精彩互动正在进行，赶紧退出全屏去看看");	
			text_tip.autoSize = false;
			var tf:TextFormat = new TextFormat("微软雅黑",14,0xffffff); 
			tf.align = TextFormatAlign.CENTER;
			text_tip.textFormat = tf;
			text_tip.visible = false;
			
			btn_fan = new PushButton(this,35,35);
			btn_fan.setSize(66,22);
			btn_fan.toggle = true;
			btn_fan.upSkin = new MC_6_1();
			btn_fan.overSkin = new MC_6_2();
			btn_fan.downSkin = new MC_6_2();
			btn_fan.selectUpSkin = new MC_7_1();
			btn_fan.selectOverSkin = new MC_7_2();
			btn_fan.selectDownSkin = new MC_7_2();
			btn_fan.addEventListener(MouseEvent.CLICK,fanClick);
			btn_fan.visible = false;
			
			btn_full = new PushButton(this);
			btn_full.setSize(48,22);
			btn_full.upSkin = new MC_10_1();
			btn_full.overSkin = new MC_10_1();
			btn_full.downSkin = new MC_10_1();
			btn_full.addEventListener(MouseEvent.CLICK,doubleClick);
			btn_full.addEventListener(MouseEvent.MOUSE_OVER,fullover);
			btn_full.addEventListener(MouseEvent.MOUSE_OUT,fullout);
			btn_full.visible = false;
			
			btn_cancelFull = new PushButton(this);
			btn_cancelFull.setSize(78,22);
			btn_cancelFull.upSkin = new MC_8_1();
			btn_cancelFull.overSkin = new MC_8_1();
			btn_cancelFull.downSkin = new MC_8_1();
			btn_cancelFull.addEventListener(MouseEvent.CLICK,doubleClick);
			btn_cancelFull.addEventListener(MouseEvent.MOUSE_OVER,cancelfullover);
			btn_cancelFull.addEventListener(MouseEvent.MOUSE_OUT,cancelfullout);
			btn_cancelFull.visible = false;
			
			soundBar = new SoundBar(this);
			soundBar.btn_mute.addEventListener(MouseEvent.MOUSE_DOWN,btn_mute_Click);
			soundBar.volumeBar.addEventListener(Event.CHANGE,volumeChange);
			soundBar.visible = false;
			
			cancelfullTip = new MC_9();
			this.addChild(cancelfullTip);
			cancelfullTip.visible = false;
			
			fullTip = new MC_11();
			this.addChild(fullTip);
			fullTip.visible = false;
			
			marqueePane = new MarqueePane(this,0,0);
			
			this.addEventListener(Event.ADDED_TO_STAGE,addToStage);
			
		}
		
		private function addToStage(e:Event):void
		{
			this.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			this.addEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			stage.addEventListener(FullScreenEvent.FULL_SCREEN,fullScreenHandler);
			
			this.doubleClickEnabled = true;
			this.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClick);
			
			stage.addEventListener(Event.RESIZE,resizeHandler);
			
			ExternalInterface.addCallback("fullScreen",doubleClick);
		}
		
		private function fullScreenHandler(e:FullScreenEvent):void
		{
			isFullScreen = e.fullScreen;
			
			text_tip.visible = isFullScreen;
			
			refreshBtn();
			
			//走马灯是否显示
			marqueePane.visible = !isFullScreen;
			
			cancelfullTip.visible = false;
			fullTip.visible = false;
		}
		
		private function refreshBtn():void
		{
			if(!isConcert)
			{
				btn_cancelFull.visible = false;
				btn_full.visible = false;
				return;
			}
			
			if(isFullScreen)
			{
				btn_cancelFull.visible = true;
				btn_full.visible = false;
			}
			else
			{
				btn_cancelFull.visible = false;
				btn_full.visible = true;
			}
		}
		
		private function doubleClick(e:MouseEvent = null):void
		{
			if(!isFullScreen)
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}
			else
			{
				stage.displayState = StageDisplayState.NORMAL;
			}
		}
		
		private function fullover(e:MouseEvent):void
		{
			fullTip.visible = true;
		}
		
		private function fullout(e:MouseEvent):void
		{
			fullTip.visible = false;
		}
		
		private function cancelfullover(e:MouseEvent):void
		{
			cancelfullTip.visible = true;
		}
		
		private function cancelfullout(e:MouseEvent):void
		{
			cancelfullTip.visible = false;
		}
		
		private function overHandler(e:MouseEvent):void
		{
			if(isSplit && anchorId != "0")
			{
				btn_fan.visible = true;
			}
			
			if(isPlay)
			{
				soundBar.visible = true;
			}
		}
		
		private function outHandler(e:MouseEvent):void
		{
			btn_fan.visible = false;
			soundBar.visible = false;
			stage.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
		}
		
		private function btn_mute_Click(e:MouseEvent):void
		{
			trace("静音");
			if(!isMute)
			{
				volume = soundBar.volumeBar.value;
				soundBar.volumeBar.value = 0;
				
				isMute = true;
				soundBar.btn_mute.selected = true;
			}
			else
			{
				soundBar.volumeBar.value = volume;
				
				isMute = false;
				soundBar.btn_mute.selected = false;
			}
			
			var st:SoundTransform = new SoundTransform();
			st.volume = soundBar.volumeBar.value * 0.01;
			
			/*for(var i:int = 0;i<streamArr.length;i++)
			{
				streamArr[i].soundTransform = st;
			}*/
			
			SoundMixer.soundTransform = st;
		}
		
		private function volumeChange(e:Event):void
		{
			isMute = false;
			soundBar.btn_mute.selected = false;
			
			var st:SoundTransform = new SoundTransform();
			st.volume = soundBar.volumeBar.value * 0.01;
			/*for(var i:int = 0;i<streamArr.length;i++)
			{
				streamArr[i].soundTransform = st;
			}*/
			
			SoundMixer.soundTransform = st;
			
			if(soundBar.volumeBar.value == 0)
			{
				//soundBar.btn_mute.selected = true;
			}
			else
			{
				soundBar.btn_mute.selected = false;
			}
		}

		/**
		 * 点击关注
		 */
		private function fanClick(e:MouseEvent):void
		{
			if (isVisitor)
			{
				ExternalInterface.call("MGC_Comm.CheckGuestStatus");
				return;
			}

			if (isFollow)
			{
				//取消关注
				var tojson:Object = new Object();
				tojson.op_type = 117;
				tojson.anchor_id = anchorId;
				tojson.anchor_nick = anchorName;
				ExternalInterface.call("gift_send", tojson);
			}
			else
			{
				//关注
				var tojson116:Object = new Object();
				tojson116.op_type = 116;
				tojson116.anchor_id = anchorId;
				tojson116.anchor_nick = anchorName;
				ExternalInterface.call("gift_send", tojson116);
			}
		}
		
		/**
		 * 是否关注了主播
		 */
		public function get isFollow():Boolean
		{
			return _isFollow;
		}
		
		/**
		 * @private
		 */
		public function set isFollow(value:Boolean):void
		{
			_isFollow = value;
			
			btn_fan.selected = isFollow;
		}
		
		/**
		 * 是否分屏
		 */
		public function get isSplit():Boolean
		{
			return _isSplit;
		}
		
		/**
		 * @private
		 */
		public function set isSplit(value:Boolean):void
		{
			_isSplit = value;
			
			//没有分屏时要立即隐藏
			if(!isSplit)
			{
				btn_fan.visible = isSplit;
			}
		}
		
		private function resizeHandler(e:Event):void
		{
			setSize(stage.stageWidth,stage.stageHeight);
		}
		
		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w, h);
			
			text_tip.setSize(w,24);
			text_tip.graphics.clear();
			text_tip.graphics.beginFill(0x000000,0.45);
			text_tip.graphics.drawRect(0,0,width,24);
			text_tip.graphics.endFill();
			
			//透明热区
			this.graphics.clear();
			this.graphics.beginFill(0x000000,0);
			this.graphics.drawRect(0,0,w,h);
			this.graphics.endFill();
			
			//关注按钮位置
			btn_fan.x = w - 80;
			btn_fan.y = 40;
			
			//音量条底部居中
			soundBar.x = (w - soundBar.width)/2;
			soundBar.y = h - SOUND_BOTTOM;
			
			//全屏按钮位置
			btn_full.x = w - btn_full.width - 20;
			btn_full.y = h - 30 - 2;
			fullTip.x = btn_full.x - 70;
			fullTip.y = btn_full.y - 35;
			
			//取消全屏按钮位置
			btn_cancelFull.x = soundBar.x + 200;
			btn_cancelFull.y = h - SOUND_BOTTOM;
			cancelfullTip.x = btn_cancelFull.x;
			cancelfullTip.y = btn_cancelFull.y - 35;
			
			marqueePane.setSize(w,50);	
		}
		
		/**
		 * 添加一个要控制的流
		 * @param netStream
		 * 
		 */		
		public function addStream(netStream:NetStream):void
		{
			streamArr.push(netStream);
		}
	}
}