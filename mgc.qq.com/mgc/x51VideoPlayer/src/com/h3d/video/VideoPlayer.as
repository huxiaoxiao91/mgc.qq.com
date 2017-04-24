package com.h3d.video
{
	import com.h3d.flv.FlvWrapper;
	import com.h3d.util.Byte2Hex;
	import com.h3d.util.Log;
	import com.h3d.util.Tracer;
	import com.junkbyte.console.Cc;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.FileReference;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.NetStreamAppendBytesAction;
	import flash.system.System;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	/*
	** 构建flv流，播放音频、视频
	*/
	public class VideoPlayer extends Sprite
	{		
		//音量条距底部位置
		static public var bottom:Number = 30;
		
		//是否开启硬件编码
		static public var useHardwareDecoder:Boolean = true;
		
		private var bg:MC_LoadingPane_1 = new MC_LoadingPane_1();
		
		private var _playLink:NetConnection = null;
		private var _video:Video = null;
		public var _playStream:NetStream = null;
		private var _header:Object = null;
		private var _isPlaying:Boolean = false;
		private var _lastTimestamp:int = 0;
		
		//音量调节界面
		private var soundBar:SoundBar;
		//顶部文字
		private var topBar:TopPane;
		//加载画面
		private var loadingPane:LoadingPane;
		//停止画面
		private var stopPane:StopPane;
		//网络不给力画面
		private var loadTipPane:LoadTipPane;
		
		
		//是否全屏
		private var isFullScreen:Boolean = false;
		
		//静音前音量
		private var volume:Number;
		
		//是否静音
		private var isMute:Boolean = false;
		
		private static const LOG_FILTER:String = "VideoPlayer: ";
		
		private var timer:Timer = new Timer(1000);
		
		private var infoPane:InfoPane = new InfoPane();
		
		
		private var flvByteArray:ByteArray = new ByteArray();
		
		//是否输出画面
		private var appendVideo:Boolean = true;
		
		/**
		 * 是否分屏
		 */
		private var _isSplit:Boolean = false;
		
		/**
		 * 遮罩
		 */
		private var maskShape:Shape = new Shape();
		
		/**
		 * 视频位置
		 * 0 左 1 右
		 */
		public var position:int = 0;
		
		private var videoEngine:VideoEngine;
		
		private var timeid:int = 0;
		
		public function VideoPlayer(_videoEngine:VideoEngine)
		{
			videoEngine = _videoEngine;
			
			_playLink = new NetConnection();
			_playLink.client = this;
			_playLink.addEventListener(NetStatusEvent.NET_STATUS, onPlayStatus);
			_playLink.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_playLink.connect(null);
			_playStream = new NetStream(_playLink);
			_playStream.useHardwareDecoder = useHardwareDecoder;
			_playStream.dataReliable = false;
			_playStream.bufferTime = 1;
			_playStream.bufferTimeMax = 3;
			_playStream.client = this;
			_playStream.checkPolicyFile = false;
			_playStream.play(null);
			//_playStream.appendBytesAction(NetStreamAppendBytesAction.RESET_BEGIN);
			
			//var flvHeader:ByteArray = FlvWrapper.getHeader();
			//_playStream.appendBytes(flvHeader);
			_playStream.addEventListener(NetStatusEvent.NET_STATUS, this.onPlayStatus);
			
			//addChild(bg);
			
			_video = new Video();
			_video.smoothing = true;
			_video.attachNetStream(_playStream);
			this.addChild(_video);
			
			//测试本地视频
			//_playStream.play("r.mp4");
			
//			soundBar = new SoundBar(this);
//			soundBar.btn_mute.addEventListener(MouseEvent.MOUSE_DOWN,btn_mute_Click);
//			soundBar.volumeBar.addEventListener(Event.CHANGE,volumeChange);
//			soundBar.visible = false;
//			
			//topBar = new TopPane(this);
			//topBar.visible = false;
			
			loadTipPane = new LoadTipPane(this);
			loadTipPane.visible = false;

			loadingPane = new LoadingPane(this);
			loadingPane.visible = true;
			
			stopPane = new StopPane(this);
			stopPane.visible = false;
						
			addChild(maskShape);
			maskShape.visible = false;
			
			_lastTimestamp = 0;
			
			this.addEventListener(Event.ADDED_TO_STAGE,addToStage);
			
			addChild(infoPane);
			
			timer.addEventListener(TimerEvent.TIMER,onTick);
			
		}

		/**
		 * 是否将4：3裁剪成16：9
		 */
		public function cut():void
		{
			Cc.warn("分辨率：" + videoEngine.width + "," + videoEngine.height);
			
			if(x51VideoPlayer.isVertical)
			{
				_video.height = stage.stageHeight;
				_video.width = _video.height * 9/16;
				_video.x = (stage.stageWidth - _video.width)/2;
				return;
			}
			
			
			if((videoEngine.width != 0) && (videoEngine.height != 0))
			{
				//判断16:9还是4:3
				var scale:Number = videoEngine.width/videoEngine.height;
				Cc.warn("舞台宽高:" + stage.stageWidth + ":" + stage.stageHeight);
				var stageScale:Number = stage.stageWidth/stage.stageHeight;
				if(scale > stageScale)
				{
					//高度为主  计算左右裁边
					_video.height = stage.stageHeight;
					_video.width = _video.height * scale;	
					_video.x = -(_video.width - stage.stageWidth)/2;
					Cc.warn("转16：9" + "视频宽高:" + _video.width + ":" + _video.height + "左右裁边尺寸：" + _video.x);
				}
				else if(scale < stageScale)
				{
					//宽度为主 计算上下裁边
					_video.width = stage.stageWidth;
					_video.height = _video.width/scale;		
					_video.y = -(_video.height - stage.stageHeight)/2;
					Cc.warn("转16：9" + "视频宽高:" + _video.width + ":" + _video.height + "上下裁边尺寸：" + _video.y);
				}
				else{
					
				}
				
				//离16/9远的算4/3
				/*
				if((Math.abs(scale - 16/9) - Math.abs(scale - 4/3)) > 0)
				{
					_video.height = stage.stageHeight/9*12;
					_video.y = -(_video.height/12)*1.5;
					Cc.warn("转16：9" + "视频宽高:" + _video.width + ":" + _video.height + "裁边尺寸：" + _video.y);
				}
				*/
				/*if(videoEngine.width/videoEngine.height != 16/9)
				{
					
				}*/
			}
		}

		private function addToStage(e:Event):void
		{
			this.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			this.addEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			//stage.scaleMode = StageScaleMode.SHOW_ALL;
			//stage.addEventListener(FullScreenEvent.FULL_SCREEN,fullScreenHandler);
			
			//this.doubleClickEnabled = true;
			//this.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClick);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			
			stage.addEventListener(Event.RESIZE,resizeHandler);
		}
		
		private function resizeHandler(e:Event = null):void
		{
			setVideoSize(stage.stageWidth,stage.stageHeight);
			bg.width = stage.stageWidth;
			bg.height = stage.stageHeight;
		}
		
		private function fullScreenHandler(e:FullScreenEvent):void
		{
			/*if(stage.displayState == StageDisplayState.NORMAL)
			{
				isFullScreen = false;
			}
			else if(stage.displayState == StageDisplayState.FULL_SCREEN)
			{
				isFullScreen = true;
			}*/
			
			isFullScreen = e.fullScreen;
			
			topBar.visible = isFullScreen;
		}
		
		private function keyDownHandler(e:KeyboardEvent):void
		{
			var file:FileReference = new FileReference();
			//1
			if(e.keyCode == 49)
			{
				//file.save(flvByteArray,"test.flv");
				//appendVideo = !appendVideo;
				//isSplit = !isSplit;
				/*_playStream.dispose();
				//_playStream.close();
				videoEngine._startPlayVideo = false;
				_playStream.play(null);
				var firstFrameHeader:ByteArray = FlvWrapper.getVideoHeaderTag(_header);
				_playStream.appendBytes(firstFrameHeader);*/
				//videoEngine.replay();
				return;
			}
			
			//2
			if(e.keyCode == 50)
			{
				/*var date:Date = new Date();
				
				var name:String = "web_log_" + date.fullYear.toString() + "-" + (date.month + 1).toString() + "-" + date.date.toString() + "_" + Log.getTimeString2() + ".txt";
				file.save(Log.LOG,name);*/
				return;
			}
			
			//3
			if(e.keyCode == 51)
			{
				if(timer.running)
				{
					timer.stop();
					infoPane.log("");
				}
				else{
					timer.start();
				}
				
				return;
			}
		}
		
		private function doubleClick(e:MouseEvent):void
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
		
		/**
		 * 绘制遮罩
		 */
		private function drawMask(w:Number,h:Number):void
		{
			maskShape.graphics.clear();
			maskShape.graphics.beginFill(0xFFFFFF,1);
			maskShape.graphics.drawRect(w/4,0,w*2/4,h);
			maskShape.graphics.endFill();
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
			
			loadingPane.isSplit = isSplit;
			
			stopPane.isSplit = isSplit;
			
			if(isSplit)
			{
				drawMask(_video.width,_video.height);
				
				this.mask = maskShape;
				
				this.x = -_video.width/4 + this.position * _video.width/2;
			}
			else
			{
				this.mask = null;
				
				this.x = 0;
			}
		}
		
		private function overHandler(e:MouseEvent):void
		{
			soundBar.visible = true;
		}
		
		private function outHandler(e:MouseEvent):void
		{
			soundBar.visible = false;
			stage.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
		}
		
		private function btn_mute_Click(e:MouseEvent):void
		{
			trace("静音");
			if(!isMute)
			{
				volume = soundBar.volumeBar.value;
				//_playStream.soundTransform.volume = 0;
				soundBar.volumeBar.value = 0;
				
				isMute = true;
				soundBar.btn_mute.selected = true;
			}
			else
			{
				//_playStream.soundTransform.volume = 80 * 0.01;
				soundBar.volumeBar.value = volume;
				
				isMute = false;
				soundBar.btn_mute.selected = false;
			}
			
			var st:SoundTransform = new SoundTransform();
			st.volume = soundBar.volumeBar.value * 0.01;
			_playStream.soundTransform = st;
		}
		
		private function volumeChange(e:Event):void
		{
			isMute = false;
			soundBar.btn_mute.selected = false;
			
			var st:SoundTransform = new SoundTransform();
			st.volume = soundBar.volumeBar.value * 0.01;
			_playStream.soundTransform = st;
			
			//SoundMixer.soundTransform.volume = 0.2//soundBar.volumeBar.value * 0.01;
			//_playStream.soundTransform.volume = soundBar.volumeBar.value * 0.01;
			//SoundMixer.stopAll();
			trace("音量变化:",st.volume,_playStream.soundTransform.volume);
			
			if(soundBar.volumeBar.value == 0)
			{
				//soundBar.btn_mute.selected = true;
			}
			else
			{
				soundBar.btn_mute.selected = false;
			}
		}
		
		public function disposes():void {
			isPlaying = false;
			// other destory ...
		}
		
		private function onTick(e:TimerEvent):void {
			
			infoPane.log("fps:" + _playStream.currentFPS + "\n" + 
						"time:" + _playStream.time + "\n" + 
						"bufferLength:" + _playStream.bufferLength + "\n" +
						"audioBufferLength:" + _playStream.info.audioBufferLength + "\n" +
						"videoBufferLength:" + _playStream.info.videoBufferLength);
			
			if(_playStream.currentFPS < 12)
			{
				var date:Date = new Date();
				var time:String = String(date.hours) + ":" + String(date.minutes) + ":" + String(date.seconds) + ":" + String(date.milliseconds);
				Log.warn("low FPS:" + _playStream.currentFPS + " time:" + _playStream.time);
			}
			
			//防止声音视频不同步
			/*if((_playStream.info.audioBufferLength - _playStream.info.videoBufferLength)>5)
			{
				videoEngine.replay();
			}*/
			
			Log.log("bufferLength:" + _playStream.bufferLength + " fps:" + _playStream.currentFPS);
		}
		
		public function pause():void {
			isPlaying = false;
			_playStream.pause();
		}
		
		public function resume():void {
			isPlaying = true;
			_playStream.resume();	
		}
		
		public function stop():void
		{
			_playStream.close();
			_playStream.play(null);
			
			_video.clear();
			
			isPlaying = false;
		}
		
		/**
		 *
		 * 数据当前存在于缓冲区中的秒数。
		 * @return 
		 * 
		 */		
		public function getBufLen():Number {
			return _playStream.bufferLength;	
		}
		
		/*public function isPlaying():Boolean {
			return _isPlaying;
		}*/
		
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}
		
		public function set isPlaying(b:Boolean):void
		{
			_isPlaying = b;
			
			loadingPane.visible = !isPlaying;
		}
		
		public function getPlayTime():Number {
			return _playStream.time;
		}
		
		public function seek():void {
			_playStream.seek(0);
			_playStream.appendBytesAction(NetStreamAppendBytesAction.RESET_SEEK);
		}
		
		public function startPlay(header:Object):Boolean {
			if (header.metaTag == null || header.sei == null) {
				return false;
			}
			
			_header = header;

			_playStream.close();
			_playStream.play(null);

			_video.clear();

			//_playStream.appendBytes(header.metaTag);
			
			/*var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(header.metaTag);
			byteArray.position = 0;
			Byte2Hex.Trace(byteArray);*/
			//trace(Base64.encodeByteArray(header.metaTag));
			
			var firstFrameHeader:ByteArray = FlvWrapper.getVideoHeaderTag(header);
			_playStream.appendBytes(firstFrameHeader);
			//Byte2Hex.Trace(firstFrameHeader);
			isPlaying = true;
			
			Log.showLog("Header数据");
			//通知页面视频开始播放
			var tojson:Object = new Object();
			tojson.op_type = x51VideoPlayer.PLAY;
//			var str:String = JSON.stringify(tojson);
			ExternalInterface.call("response_as",tojson);
			
			
			var flvHeader:ByteArray = FlvWrapper.getHeader();
			flvByteArray.writeBytes(flvHeader);
			flvByteArray.writeBytes(header.metaTag);
			flvByteArray.writeBytes(firstFrameHeader);
			
			resizeHandler();
			
			return true;
		}
		
		private function onPlayStatus(param1:NetStatusEvent) : void
		{
			//Tracer.log(LOG_FILTER + "VideoPlayer.onNsPlayStatus:" + param1.info.code);
			Cc.error("NetStatusEvent:",param1.info.code);
			switch(param1.info.code)
			{
				case "NetStream.Buffer.Empty":
					/*Tracer.log(LOG_FILTER + "VideoPlayer.onNsPlayStatus, ns empty" +
						", backBufferLength:" + _playStream.backBufferLength +
						", backBufferTime:" + _playStream.backBufferTime + 
						", bufferLength:" + _playStream.bufferLength + 
						", bufferTime:" + _playStream.bufferTime + 
						", bufferTimeMax:" + _playStream.bufferTimeMax + 
						", currentFPS:" + _playStream.currentFPS);*/
					Cc.error("Empty:",_playStream.time,"  ",_playStream.bufferLength);
					
					timeid = setTimeout(videoEngine.OnClose,5000,VideoHttpChannel.RETRY_CODE,"");
					
					var date:Date = new Date();
					var time:String = String(date.hours) + ":" + String(date.minutes) + ":" + String(date.seconds) + ":" + String(date.milliseconds);
					Log.showLog("empty  time:" + _playStream.time);
					
					loadTipPane.visible = true;
					
					//isPlaying = false;
					break;
				case "NetStream.Buffer.Full":
//					Tracer.log(LOG_FILTER + "VideoPlayer.onNsPlayStatus, ns full" +
//						", backBufferLength:" + _playStream.backBufferLength +
//						", backBufferTime:" + _playStream.backBufferTime + 
//						", bufferLength:" + _playStream.bufferLength + 
//						", bufferTime:" + _playStream.bufferTime + 
//						", bufferTimeMax:" + _playStream.bufferTimeMax + 
//						", currentFPS:" + _playStream.currentFPS);
					//isPlaying = true;
					
					loadTipPane.visible = false;
					
					clearTimeout(timeid);
					
					Log.showLog("Full:",_playStream.time,"  ",_playStream.bufferLength);
					if(_playStream.bufferLength < 1)
					{
						timeid = setTimeout(videoEngine.OnClose,5000,VideoHttpChannel.RETRY_CODE,"");
					}
					break;
				case "NetStream.Play.Failed":
					Log.showLog("NetStream.Play.Failed");
					isPlaying = false;
					videoEngine.OnClose(VideoHttpChannel.ERROR,"");
					break;
				case "NetStream.Play.Start":
					Log.showLog("NetStream.Play.Start");
					
					timeid = setTimeout(videoEngine.OnClose,5000,VideoHttpChannel.RETRY_CODE,"");
					
					var date:Date = new Date();
					var time:String = String(date.hours) + ":" + String(date.minutes) + ":" + String(date.seconds) + ":" + String(date.milliseconds);
					break;
				case "NetStream.Play.Stop":
					Log.showLog("NetStream.Play.Stop");
					break;
				case "NetStream.Play.Reset":
					Log.showLog("NetStream.Play.Reset");
					break;
				case "NetStream.Play.StreamNotFound":
					Log.showLog("NetStream.Play.StreamNotFound");
					videoEngine.OnClose(VideoHttpChannel.ERROR,"");
					break;
				case "NetStream.Video.DimensionChange":
					Log.showLog("NetStream.Video.DimensionChange");
					Log.formatLogMsg(0,"开始播放首帧画面");
					break;
			}
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			Log.showLog("securityErrorHandler: " + event);
		}
		
		/*public function onMetaData(info:Object):void {
			Log.showLog("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
		}*/
		
		public function onMetaData(infoObject:Object):void {
			for (var propName:String in infoObject) {
				Log.showLog(propName + " = " + infoObject[propName]);
			}
			
			/*videoEngine.width = infoObject["width"];
			videoEngine.height = infoObject["height"];*/
			videoEngine.width = x51VideoPlayer.VideoWidth;
			videoEngine.height = x51VideoPlayer.VideoHeight;
			resizeHandler();
			
			isPlaying = true;
		}
		
		public function onCuePoint(info:Object):void {
			Log.showLog("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
		}
		
		public function getBufferLength():Number {
			return _playStream.bufferLength;
		}
		
		public function get video():Video {
			return _video;
		}
		
		/*public function attachVideo(param1:Video):void {
			if (_playStream) {
				param1.attachNetStream(_playStream);
			}
		}*/
		
		public function setVideoSize(w:uint, h:uint):void {
			if (_video) {
				_video.width = w;
				_video.height = h;
				_video.x = _video.y = 0;
			}
			
			//更新分屏位置
			if(isSplit)
			{
				this.x = -_video.width/4 + this.position * _video.width/2;
			}
			
			//更新遮罩尺寸
			drawMask(_video.width,_video.height);
			
			//裁剪16:9
			cut();
			
			//音量条底部居中
			//soundBar.x = (w - soundBar.width)/2;
			//soundBar.y = h - bottom;
			
			//顶部信息适应尺寸
			//topBar.setSize(w,24);
			
			//loading画面尺寸
			loadingPane.setSize(w,h);
			
			//网络不给力提示尺寸
			loadTipPane.setSize(w,h);
			
			//主播停播提示尺寸
			stopPane.setSize(w,h);
			
			//更新背景色
			this.graphics.clear();
			this.graphics.beginFill(0x292929,1);
			this.graphics.drawRect(0,0,w,h);
			this.graphics.endFill();
		}
		
		/**
		 *
		 * 将一个 音频数据 传递到 NetStream 以进行播放 
		 * @param audioBlock
		 * @param ts
		 * 
		 */		
		public function handleAudioFrame(audioBlock:ByteArray, ts:int):void {
			var audioTag:ByteArray = FlvWrapper.getAudioTag(audioBlock, ts);
			_playStream.appendBytes(audioTag);
			
			//flvByteArray.writeBytes(audioTag);
			//Cc.log("播放音频",(new Date).time);
			//Log.showLog("音频数据","数据包长度：",audioBlock.length,"时间戳：",ts);
		}
		
		/**
		 *
		 * 将一个 视频数据 传递到 NetStream 以进行播放 
		 * 
		 */	
		public function handleVideoFrame(videoFrame:VideoFrame, frameNum:int, ts:int): void {
			if (_header == null) {
				return;
			}
			//Cc.log("frame:" + frameNum,"\n","timestamp:" + ts);
			
			//Cc.log("播放视频,seq:",videoFrame.seq," ",(new Date).time);
			//Cc.log("fps:",_playStream.currentFPS);
			
			if(!appendVideo)return;

			var videoTag:ByteArray = null;
			//frameNum为0 为第一针  需要header
			if (frameNum == 0) {
				var videoData:ByteArray = new ByteArray();
				videoData.endian = Endian.LITTLE_ENDIAN;
				
				videoData.writeBytes(_header.sei);
				videoData.writeBytes(videoFrame.data);
				
				_lastTimestamp = ts;
				//Tracer.log("video timestamp: " + ts);
					
				videoTag = FlvWrapper.getVideoTag(videoData, videoFrame.isKeyFrame(), ts);
				_playStream.appendBytes(videoTag);
				//Log.showLog("视频数据","数据包长度：",videoData.length,"时间戳：",ts);
			}
			else {
				//Tracer.log("video timestamp: " + ts + ", diff: " + (ts - _lastTimestamp));
				_lastTimestamp = ts;
				
				videoTag = FlvWrapper.getVideoTag(videoFrame.data, videoFrame.isKeyFrame(), ts);
				_playStream.appendBytes(videoTag);
				//Log.showLog("视频数据","数据包长度：",videoFrame.size,"时间戳：",ts);
			}
			
			//flvByteArray.writeBytes(videoTag);
			
			var size:int = 0;
			if(videoFrame.data)
			{
				size = videoFrame.data.length;
			}
			
			var date:Date = new Date();
			var time:String = String(date.hours) + ":" + String(date.minutes) + ":" + String(date.seconds) + ":" + String(date.milliseconds);
			var log:String = "@video time:" + time + " frameSeq:" + videoFrame.seq + " dataSize:" + videoFrame.size + " data:" + size.toString() + " timestamp:" + videoFrame.encodeTime + " keyFrame:" + videoFrame.isKeyFrame();
			Log.debug(log);
			
			//Cc.error(ts," ",videoFrame.isKeyFrame());
			/*infoPane.log("fps:" + _playStream.currentFPS + "\n" + 
				"time:" + _playStream.time + "\n" + 
				"bufferLength:" + _playStream.bufferLength + "\n" + 
				"frame:" + frameNum + "\n" + 
				"timestamp:" + ts);*/
			
			/*if(_playStream.currentFPS < 12)
			{
				Cc.error("frame:" + frameNum," ","timestamp:" + ts,"  ","seq:" + videoFrame.seq);
			}*/
			
			//Tracer.log(LOG_FILTER + "handleFrame, " + "seq:" + videoFrame.seq + 
			//	", _frameNum: " + _frameNum);
		}
		
		/**
		 *
		 * 是否显示停播画面
		 * 
		 */	
		public function showStopPane(b:Boolean):void
		{
			stopPane.visible = b;
		}
	}
}