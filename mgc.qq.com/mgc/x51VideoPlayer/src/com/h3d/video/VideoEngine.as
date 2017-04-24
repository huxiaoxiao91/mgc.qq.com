package com.h3d.video
{
	//import com.h3d.audio.AudioEngine;
	import com.h3d.flv.FlvWrapper;
	import com.h3d.util.Log;
	import com.h3d.util.Tracer;
	import com.h3d.video.FLVFrame;
	import com.junkbyte.console.Cc;
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	/*
	** 视频引擎：协调管理其他对象，提供对外接口
	** 收到网络断开事件时，尝试重新连接（未实现）
	*/
	public class VideoEngine implements VideoDataRevSink
	{
		private var _videoSprite:Sprite;
		private var _videoHttpChannel:VideoHttpChannel;
		private var _cdnUrls:Array;
		private var tqos:TQOSFrameRate = new TQOSFrameRate;
		/**
		 * 当前连接的url索引
		 */
		private var _urlIndex:int;
		
		/**
		 * 重连次数
		 */	
		public var _cdnRetryCount:int;
		
		/**
		 * 视频是否开始播放 
		 */		
		public var _startPlayVideo:Boolean;
		
		private var _updateTimer:Timer;
		//private var _syncAudioVideo:SyncAudioVideo;
		
		public var _videoMgr:VideoMgr;
		private var _mediaTypeBytes:ByteArray;
		
		//private var _audioEngine:AudioEngine = null;
		
		private static const MAX_URL_SIZE:int = 10;
		
		private static const TYPE_NORMAL_FRAME:int = 1; // 普通帧
		private static const TYPE_KEY_FRAME:int = 2; // 关键帧
		
		//是否丢音频
		private var lostAudio:Boolean = false;
		//是否丢视频
		private var lostVideo:Boolean = false;
		
		//视频宽
		public var width:Number = 0;
		
		//视频高
		public var height:Number = 0;
		
		public function VideoEngine() {
			_urlIndex = 0;
			_cdnRetryCount = 0;
			
			//_audioEngine = new AudioEngine();
			_videoMgr = new VideoMgr(this);
			
			_videoHttpChannel = new VideoHttpChannel(this);
			//_syncAudioVideo = new SyncAudioVideo();
			//_syncAudioVideo.init(_videoMgr, _audioEngine);
			
			_updateTimer = new Timer(20);
			_updateTimer.addEventListener(TimerEvent.TIMER, Update);
			
			_videoSprite = null;
			_startPlayVideo = false;

			//_videoMgr.SetAudioEngine(_audioEngine);
		}
		
		public function StartEngine(videoSprite:Sprite):void {
			_videoSprite = videoSprite;
			
			//渲染视频播放器
			_videoSprite.addChildAt(_videoMgr.GetVideoPlayer(),0);
			_videoMgr.GetVideoPlayer().setVideoSize(_videoSprite.stage.stageWidth, _videoSprite.stage.stageHeight);
		
			_videoSprite.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
		}
		
		private function keyDownHandler(e:KeyboardEvent):void
		{
			//0
			if(e.keyCode == 48)
			{
				lostAudio = false;
				lostVideo = false;
				return;
			}
			
			//A
			if(e.keyCode == 65)
			{
				lostAudio = true;
				return;
			}
			
			//V
			if(e.keyCode == 86)
			{
				lostVideo = true;
				return;
			}
		}
		
		/*public function StopEngine():void {
			_videoMgr.Stop();
			StopCDNClient();
		}*/
		
		public function StartCDNClient(_urlIndex:int):void 
		{
			//_audioEngine = new AudioEngine();
			//_videoMgr.SetAudioEngine(_audioEngine);
			
			//ConnectCDN(_urlIndex);	
			
			Cc.error("开始连接：" + _urlIndex + "   " + _cdnUrls[_urlIndex]);
			
			_videoMgr.GetVideoPlayer()._playStream.play(_cdnUrls[_urlIndex]);
			_videoMgr.GetVideoPlayer().showStopPane(false);
		}
		
		public function StopCDNClient():void {
			/*if (_cdnClient) {
				_cdnClient.stop();
				_cdnClient = null;
			}*/
			//_videoHttpChannel.stop();
			
			//_videoMgr.Stop();
			
			_videoMgr.GetVideoPlayer().stop();
			_videoMgr.GetVideoPlayer().showStopPane(true);
			
			/*_audioEngine = new AudioEngine();
			_videoMgr.SetAudioEngine(_audioEngine);*/
			
			// 停止播放
			_startPlayVideo = false;
			
			if (_updateTimer) {
				_updateTimer.stop();
				//_updateTimer.removeEventListener(TimerEvent.TIMER, Update);
				//_updateTimer = null;
			}
		}
		
		public function Update(param1:TimerEvent):void {
			_videoMgr.update();
			_videoHttpChannel.update();
			//_audioEngine.update();
		}
		
		public function SaveCdnUrl(urls:Array):void {
			if (urls.length == 0) {
				Tracer.log("cdn url num is empty");
				return;
			}
			
			if (urls.length > MAX_URL_SIZE) {
				return;
			}
			
			_cdnUrls = urls;
			Tracer.log("CDN URL: " + _cdnUrls[0]);
		}
		
		private function ConnectCDN(urlIndex:int): void {
			/*if (_cdnClient == null && urlIndex < _cdnUrls.length) {
				_cdnClient = new VideoHttpChannel(this);
				_cdnClient.connect(_cdnUrls[urlIndex], _cdnRetryCount);
			}*/
			if(_cdnUrls == null)return;
			_videoHttpChannel.connect(_cdnUrls[urlIndex], _cdnRetryCount);
		}
		
		//public function getAudioEngine():AudioEngine {
		//	return _audioEngine;
		//}
		
		//=====
		// http 回调
		public function OnClose(errCode:int, errmsg:String):void 
		{
			StopCDNClient();
			//ExternalInterface.call("alert", "网络断开："+ errCode + ", " + errmsg);
			
			switch(errCode)
			{
				// 数据接收超时，重新连接
				case VideoHttpChannel.RETRY_CODE:
					Cc.error("数据接收超时，重新连接");
					break;
				
				// 对端关闭连接时，重新连接当前正用的CDN
				case VideoHttpChannel.RETRY_BE_CLOSED_CODE:
					Cc.error("对端关闭连接时，重新连接当前正用的CDN");
					break;
				
				// CDN无法连接，或http响应不是200时，尝试连接列表中下一个CDN
				case VideoHttpChannel.ERROR:
					Cc.error("CDN无法连接，或http响应不是200时，尝试连接列表中下一个CDN");
					//_cdnRetryCount = VideoHttpChannel.RETRY_CDN_CNT;
					break;			
			}
			

			if(_cdnRetryCount == VideoHttpChannel.RETRY_CDN_CNT)
			{
				//所有地址都已重连
				if(_urlIndex == (_cdnUrls.length - 1))
				{
					//Cc.error("网络断开");
					//ExternalInterface.call("alert", "网络断开");
					//return;
					_cdnRetryCount = 0;
					_urlIndex = 0;
				}
				else//连下一个地址
				{
					_cdnRetryCount = 0;
					_urlIndex++;	
				}
			}
			
			_cdnRetryCount++;
			
			setTimeout(StartCDNClient,2000,_urlIndex);
			
			//StartCDNClient(_urlIndex);	
			
		}
		
		public function replay():void
		{
			StopCDNClient();
			StartCDNClient(_urlIndex);
		}
		
		//连接成功回调
		public function OnConnect():void 
		{
			_updateTimer.start();
			
			//重连次数置0
			_cdnRetryCount = 0;
		}
		
		public function OnMediaTypeRecv(buf:ByteArray):void {
			Tracer.log("OnMediaTypeRecv");
			_mediaTypeBytes = buf;
		}
		
		
		/**
		 * 
		 * 获取视频头信息 
		 * 
		 */		
		public function GetMediaHeader():Object {
			_mediaTypeBytes.position = 0;
			_mediaTypeBytes.endian = Endian.BIG_ENDIAN;
			
			//视频宽
			var w:uint = _mediaTypeBytes.readUnsignedInt();
			width = w;
			tqos.nVideo_width = w;
			//视频高
			var h:uint = _mediaTypeBytes.readUnsignedInt();
			height = h;
			tqos.nVideo_width = h;
			//比特率
			var bitrate:uint = _mediaTypeBytes.readUnsignedInt();
			tqos.nVideo_bitrate = bitrate;
			//？
			var bitcount:uint = _mediaTypeBytes.readUnsignedShort();
			var size_img:uint = _mediaTypeBytes.readUnsignedInt();
			
			//压缩？
			var compression:uint = _mediaTypeBytes.readUnsignedInt();
			
			//读取fps值为0 有问题
			var fps:uint = _mediaTypeBytes.readUnsignedShort();
			
			var header:Object = {};
			header.w = w;
			header.h = h;
			header.bitrate = bitrate;
			header.bitcount = bitcount;
			header.sizeImg = size_img;
			header.compression = compression;
			
			if (_mediaTypeBytes.bytesAvailable < 4)
				return header;
			var metaTagSize:uint = _mediaTypeBytes.readUnsignedInt();
			
			if (_mediaTypeBytes.bytesAvailable < metaTagSize)
				return header;
			var metaTag:ByteArray = new ByteArray();
			metaTag.endian = Endian.LITTLE_ENDIAN;
			_mediaTypeBytes.readBytes(metaTag, 0, metaTagSize);
			
			if (_mediaTypeBytes.bytesAvailable < 3)
				return header;
			var profile1:int = _mediaTypeBytes.readByte();
			var profile2:int = _mediaTypeBytes.readByte();
			var level:int = _mediaTypeBytes.readByte();
			
			if (_mediaTypeBytes.bytesAvailable < 4)
				return header;
			var sps_len:uint = _mediaTypeBytes.readUnsignedShort();
			
			if (_mediaTypeBytes.bytesAvailable < sps_len)
				return header;
			var sps_bytes:ByteArray = new ByteArray();
			sps_bytes.endian = Endian.LITTLE_ENDIAN;
			_mediaTypeBytes.readBytes(sps_bytes, 0, sps_len);
			
			if (_mediaTypeBytes.bytesAvailable < 4)
				return header;
			var pps_len:uint = _mediaTypeBytes.readUnsignedShort();
			
			if (_mediaTypeBytes.bytesAvailable < pps_len)
				return header;
			var pps_bytes:ByteArray = new ByteArray();
			pps_bytes.endian = Endian.LITTLE_ENDIAN;
			_mediaTypeBytes.readBytes(pps_bytes, 0, pps_len);
			
			if (_mediaTypeBytes.bytesAvailable < 4)
				return header;
			var sei_len:uint = _mediaTypeBytes.readUnsignedInt();
			
			if (_mediaTypeBytes.bytesAvailable < sei_len)
				return header;
			var sei_bytes:ByteArray = new ByteArray();
			sei_bytes.endian = Endian.LITTLE_ENDIAN;
			_mediaTypeBytes.readBytes(sei_bytes, 0, sei_len);	

			
			Tracer.log("Media type ===== " + 
				", w: " + w +
				", h: " + h +
				", bitrate: " + bitrate +
				", bitcount: " + bitcount + 
				", size_img: " + size_img +
				", compression: " + compression +
				", profile1: " + profile1 +
				", profile2: " + profile2 +
				", level: " + level +
				", sps_len: " + sps_len +
				", pps_len: " + pps_len + 
				", sei_len: " + sei_len);
			

			header.metaTag = metaTag;
			header.profile1 = profile1;
			header.profile2 = profile2;
			header.level = level;
			header.sps = sps_bytes;
			header.pps = pps_bytes;
			header.sei = sei_bytes;
			
			return header;
		}
		
		public function OnHttpDataRecv(flvFrame:FLVFrame):void {
			var dataType:int = flvFrame._data.readByte();
			if (dataType == VideoHttpChannel.CDNDataTypeAudio) {
				//Tracer.log("CDNDataTypeAudio: _data.bytesAvailable " + flvFrame._data.bytesAvailable
				//	+ " dataSize:" + flvFrame._dataSize);
				if(lostAudio)return;
				OnHttpRecvAudioData(flvFrame);
				
				//var b:ByteArray = new ByteArray();
				//flvFrame._data.position = 9;
				//flvFrame._data.readBytes(b,0,4);
				//Tracer.log("synctest audio time :" + b.readUnsignedInt()/44.1);
			}
			else if (dataType == VideoHttpChannel.CDNDataTypeVideo) {
				//Tracer.log("CDNDataTypeVideo: _data.bytesAvailable " + flvFrame._data.bytesAvailable
				//	+ " dataSize:" + flvFrame._dataSize);
				if(lostVideo)return;
				OnHttpRecvVideoData(flvFrame);
				
				Tracer.log("synctest video time :" + flvFrame._timestamp);
			}

			tqos.nFrameCnt ++;
			if(flvFrame._keyFrame == 2)
			{
				tqos.nKeyFrameCnt++;
				tqos.Response();
			}
		}
		
		private var lastDate:Date = new Date();
		private function OnHttpRecvAudioData(flvFrame:FLVFrame):void {
			try
			{
				//_audioEngine.ReceiveData(flvFrame._data);
			}
			catch(someError:Error)
			{
				Tracer.log("OnHttpRecvAudioData Error");
			}
			
			var date:Date = new Date();
			var time:String = String(date.hours) + ":" + String(date.minutes) + ":" + String(date.seconds) + ":" + String(date.milliseconds);
			var log:String = "audio time:" + time + " frameSeq:" + flvFrame._frameSeq + " dataSize:" + flvFrame._dataSize + " timestamp:" + flvFrame._timestamp + " gap:" + String(date.time - lastDate.time);
			//Log.debug(log);
			
			lastDate = date;
			//修改成功的帧数信息
			if(flvFrame._data.length == flvFrame._dataSize )
			{
				tqos.nSuccFrameCnt++;
				tqos.Response();
			}
		}
		
		/**
		 * 
		 * 解析视频数据
		 * 先放入视频头数据
		 * 
		 */		
		private function OnHttpRecvVideoData(flvFrame:FLVFrame):void {
			if (!_startPlayVideo) {
				_startPlayVideo = true;
				
				var header:Object = GetMediaHeader();
				_videoMgr.GetVideoPlayer().startPlay(header);
				
				/*
				var vp:VideoPlayer = _videoMgr.GetVideoPlayer();
				if (vp) {
					_videoSprite.addChild(vp);
					vp.setVideoSize(_videoSprite.stage.stageWidth, _videoSprite.stage.stageHeight);
					//Tracer.log("video.width=" + vp.video.width + ", video.height=" + vp.video.height);
				}
				*/
				
				// 设置初始的编码时间戳，用于播放时对齐音视频数据
				_videoMgr.SetBeginTime(flvFrame._timestamp);
			}
			
			if (_videoMgr != null) {
				var isKeyFrame:Boolean = (flvFrame._keyFrame == TYPE_KEY_FRAME);
				
				_videoMgr.OnHttpDataRecv(isKeyFrame, flvFrame._frameSeq,
					flvFrame._timestamp, flvFrame._data, flvFrame._dataSize);

			}
			//修改成功的帧数信息
			if(flvFrame._data.length == flvFrame._dataSize )
			{
				tqos.nSuccFrameCnt++;
				//修改成功的关键帧数信息
				if(flvFrame._keyFrame == 2  )
				{
					tqos.nKeySuccFrameCnt++;
					tqos.Response();
				}
				
			}
			

			var date:Date = new Date();
			var time:String = String(date.hours) + ":" + String(date.minutes) + ":" + String(date.seconds) + ":" + String(date.milliseconds);
			var log:String = "video time:" + time + " frameSeq:" + flvFrame._frameSeq + " dataSize:" + flvFrame._dataSize + " timestamp:" + flvFrame._timestamp + " keyFrame:" + flvFrame._keyFrame + " gap:" + String(date.time - lastDate.time);
			//Log.debug(log);
			
			lastDate = date;
			
		}
	}
}