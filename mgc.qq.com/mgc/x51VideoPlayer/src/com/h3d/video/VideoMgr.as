package com.h3d.video
{
	//import com.h3d.audio.AudioEngine;
	import com.h3d.flv.FlvWrapper;
	import com.h3d.util.Log;
	import com.h3d.util.Tracer;
	import com.junkbyte.console.Cc;
	
	import flash.display.Shape;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	/*
	** 主要功能：
	** 从VideoFrameMgr和AudioEngine中取出数据放到VideoPlayer中
	*/
	public class VideoMgr
	{
		private var _videoFrameMgr:VideoFrameMgr;
		private var _videoPlayer:VideoPlayer;

		private var _timestamp:int;
		private var _frameNum:uint;
		
		//private var _audioEngine:AudioEngine;
		private var _videoPlayQueue:Array;
		
		private var _audioDataTimestamp:uint;
		private var _videoDataTimestamp:uint;
		
		public function VideoMgr(videoEngine:VideoEngine)
		{
			_videoFrameMgr = new VideoFrameMgr();
			_videoPlayer = new VideoPlayer(videoEngine);
			
			_timestamp = 0;
			_frameNum = 0;
			
			//_audioEngine = null;
			_videoPlayQueue = new Array();
			
			_audioDataTimestamp = 0;
			_videoDataTimestamp = 0;
		}

		public function GetVideoPlayer():VideoPlayer {
			return _videoPlayer;
		}
		
		public function OnHttpDataRecv(isKey:Boolean, frameSeq:uint, 
							timestamp:uint, data:ByteArray, currentSize:int):void {
			_videoFrameMgr.HttpWrite(isKey, frameSeq, timestamp, data, currentSize);
		}
		
		public function SetBeginTime(t:int):void {
			//_audioEngine.SetBeginTime(t);
			_audioDataTimestamp = t;
			_videoDataTimestamp = t;
		}
		
		public function update():void {
			playVideo();
		}
		
		public function getFrameCount():int {
			return _videoFrameMgr.getFrameCount();
		}
		
		public function getDataTimestamp():int {
			return _videoDataTimestamp;
		}
		
		public function Stop():void 
		{
			_timestamp = 0;
			_frameNum = 0;

			_videoPlayQueue = new Array();
			
			_audioDataTimestamp = 0;
			_videoDataTimestamp = 0;
			
			_videoFrameMgr.reset();
			
			_videoPlayer.isPlaying = false;
		}
		
		/*public function SetAudioEngine(ae:AudioEngine):void {
			_audioEngine = ae;
		}*/
		
		public function playVideo():void 
		{
			var frame:VideoFrame;
			
			if (_videoFrameMgr.getFrameCount() != 0)
			{
				while (true) 
				{
					frame = _videoFrameMgr.getCurrentReadFrame();
					if (frame == null) 
					{
						break;
					}
					_videoPlayQueue.push(frame);
					_videoFrameMgr.deleteFrame(frame);
				}
				
				
				//Cc.log("------开始修改时间戳------")
				//测试
				for (var i:int = 0; i < _videoPlayQueue.length - 1; i++) {
					frame = _videoPlayQueue[i];
					//_videoDataTimestamp = frame.encodeTime;
					var ts:int = frame.encodeTime - _videoDataTimestamp;
					_videoPlayer.handleVideoFrame(frame, _frameNum, ts);
					//Cc.error("视频原始时间戳:",frame.encodeTime,"新时间戳:",ts)
					_frameNum++;
					//vts += interval;
					
					//Log.debug("视频时间戳:" + ts);
				}
				_videoPlayQueue.splice(0, _videoPlayQueue.length - 1);
			}
			
			/*if (_audioEngine.GetBlockCount() != 0)
			{
				var audioBlock:ByteArray = _audioEngine.popFrontBlock();
				_videoPlayer.handleAudioFrame(audioBlock, _timestamp);
				_timestamp += 250;

				//Log.debug("音频时间戳:" + _timestamp);
			}*/
		}
		
	}
}