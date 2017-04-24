package com.h3d.video
{
	import com.h3d.util.Tracer;
	import com.h3d.video.VideoFrame;
	import com.junkbyte.console.Cc;
	
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	/*
	** 缓存、管理视频帧数据
	*/
	public class VideoFrameMgr {
		private var _videoFrames:Vector.<VideoFrame>;
		private var _fps:uint;
		private var _isRecvedFirstKeyFrame:Boolean;
		private var _firstFrameTime:int;
		private var _currentReadFrameSeq:uint;
		private var _minWriteFrameSeq:uint;
		private var _maxWriteFrameSeq:uint;
		private var _lastFrameTimeStamp:int;
		private var _onPlayTime:int;
		private var _notifyPlay:Boolean;
		
		public function VideoFrameMgr() {
			_videoFrames = new Vector.<VideoFrame>();
			reset();
		}
		
		
		/**
		 * 
		 * 获取视频缓存的帧数
		 * @return 
		 * 
		 */		
		public function getFrameCount():int {
			return _videoFrames.length;
		}
		
		/**
		 * 
		 * 获取某帧的视频数据
		 * 
		 */	
		public function getVideoFrame(i:uint):VideoFrame {
			if (i < 0 || i >= _videoFrames.length) {
				return null;
			}
			
			return _videoFrames[i];
		}
		
		public function get currentReadFrameSeq():uint {
			return _currentReadFrameSeq;
		}
		
		/**
		 * 
		 * 获取当前要播放的视频数据
		 * 
		 */		
		public function getCurrentReadFrame():VideoFrame {
			if (_videoFrames.length == 0) {
				return null;
			}
			
			if (_currentReadFrameSeq > _maxWriteFrameSeq) {
				return null;
			}
			
			var pos:int = searchFramePos(_currentReadFrameSeq);
			if (pos == -1) {
				return null;
			}
			
			var frame:VideoFrame = _videoFrames[pos];
			if (frame == null) {
				_currentReadFrameSeq++;
				return null;
			}
			
			//Tracer.log("VideoFrameMgr.getCurrentReadFrame, pos=" + pos
			//	+ ", _currentReadFrameSeq=" + _currentReadFrameSeq);
			
			var frameReady:Boolean = frame.checkFrameReady();
			if (frameReady && !frame.isFull() && getFrameCount() < 2 * _fps) {
				return null;	
			}
			
			_currentReadFrameSeq++;
			
			if (pos != -1) {
				_videoFrames.splice(pos, 1);
			}
			
			if (frame.isKeyFrame() && _notifyPlay && frame.isFull()) {
				_onPlayTime = getTimer();
			}
			
			// notify play ...
			if (_notifyPlay && _onPlayTime != 0 && getTimer() - _onPlayTime > 1000) {
				_notifyPlay = false;
				
				// ...
			}
			
			return frame;
		}
		
		public function HttpWrite(isKey:Boolean, frameSeq:uint, 
								  timestamp:uint, data:ByteArray, currentSize:int):void {
			/*Cc.log("VideoFrameMgr.HttpWrite:frameSeq, " + frameSeq
				+ ", timestamp:" + timestamp
				+ ", currentSize:" + currentSize
				+ ", isKey:" + isKey);*/
			
			/**
			 * 测试 
			 */
			/*var frame:VideoFrame = searchFrame(frameSeq);
			if (frame == null) {
				// FIXME(zhou): 用 video frame pool实现
				frame = new VideoFrame(frameSeq, _fps)
				insertFrame(frame);		
			}
			
			frame.HttpWrite(frameSeq, isKey, timestamp, data, currentSize);
			return;*/
			/**
			 * 测试 
			 */
			
			
			if (getFrameCount() > 16 * 1000) {
				//Tracer.log("HttpWrite 1. getFrameCount()=" + getFrameCount());
				return;
			}
			
			// 摄像头缓存超过一定数据之后，就不再缓存普通帧
			if ((getFrameCount() > 10 * _fps) && !isKey) {
				//Tracer.log("HttpWrite 2. getFrameCount()=" + getFrameCount());
				return;
			}
			
			// cache from key frame
			if (!_isRecvedFirstKeyFrame) {
				if (_firstFrameTime == 0) {
					_firstFrameTime == getTimer();
				}
				
				if (isKey) {
					_isRecvedFirstKeyFrame = true;
					_currentReadFrameSeq = frameSeq;
					if (frameSeq > _maxWriteFrameSeq) {
						_maxWriteFrameSeq = frameSeq;
					}
					if (frameSeq < _minWriteFrameSeq) {
						_minWriteFrameSeq = frameSeq;
					}
					
					var diffTime:uint = getTimer() - _firstFrameTime;
					
					// 删除第一个关键帧之前的所有帧
					var count:uint = 0;
					for(var i:int = 0; i < _videoFrames.length; i++) {
						if (_videoFrames[i].seq < _currentReadFrameSeq) {
							_videoFrames[i].reset();
							count++;
						}
					}
					
					_videoFrames.splice(0, count);
				}
			}
			
			// skip expire frame
			if (frameSeq < _currentReadFrameSeq) {
				return;
			}
			
			// 添加一种异常过大序号帧的处理
			// 应对在同一个主播再次开启直播的时候，第一帧已到，然后上次直播的最后一帧（比如是40000）在第一帧之后收到
			// 这个时候应该根据时间戳递增的特性过滤掉过期的数据，避免插入过大的帧序号导致过多空帧
			if (timestamp != 0) {
				if (timestamp - _lastFrameTimeStamp < 0 && frameSeq - _currentReadFrameSeq > 10 * _fps) {
					return;
				}
			}
			
			//下一次帧序号与上次帧序号差距过大
			//预防有过期帧到来的情况，做异常保护
			if (frameSeq > _maxWriteFrameSeq + 1000) {
				return;
			}
			
			_lastFrameTimeStamp = timestamp;
			
			var frame:VideoFrame = searchFrame(frameSeq);
			if (frame == null) {
				// FIXME(zhou): 用 video frame pool实现
				frame = new VideoFrame(frameSeq, _fps)
				insertFrame(frame);
				
				if (frameSeq > _maxWriteFrameSeq) {
					for (var s:int = _maxWriteFrameSeq + 1; s < frameSeq; s++) {
						// insert lost frame
						insertFrame(new VideoFrame(s, _fps));
					}
					_maxWriteFrameSeq = frameSeq;
				}
				if (frameSeq < _minWriteFrameSeq) {
					_minWriteFrameSeq = frameSeq;
				}
			}
			
			frame.HttpWrite(frameSeq, isKey, timestamp, data, currentSize);
			
			//Cc.log("解析视频VideoFrame,seq:",frameSeq," ",(new Date).time);
		}
		
		public function reset():void {
			_videoFrames.splice(0, _videoFrames.length);
			_fps = 15;
			_isRecvedFirstKeyFrame = false;
			_firstFrameTime = 0;
			_currentReadFrameSeq = 0;
			_minWriteFrameSeq = 0;
			_maxWriteFrameSeq =0;
			_lastFrameTimeStamp = 0;
			_onPlayTime = 0;
		}
		
		public function dispose():void {
			reset();
			_videoFrames = null;
		}
		
		public function destroyVideoFrames(startPos:uint, count:uint):void {
			if (count <= 0) {
				return;
			}
			
			var frame:VideoFrame = null;
			var i:uint = startPos;
			while (i < startPos + count) {
				frame = _videoFrames[i];
				if (frame) {
					frame.reset();
					frame = null;
				}
				
				i++;
			}
			
			_videoFrames.splice(startPos, count);
		}
		
		public function deleteFrame(frame:VideoFrame):void {
			var pos:int = searchFramePos(frame.seq);
			if (pos != -1) {
				_videoFrames.splice(pos, 1);
			}
		}
		
		private function insertFrame(frame:VideoFrame):void {
			var low:int = 0;
			var high:int = _videoFrames.length;
			var len:int = _videoFrames.length;
			var half:int;
			var mid:int;
			while (len > 0) {
				half = len / 2;
				mid = low;
				mid += half;
				var midFrame:VideoFrame = _videoFrames[mid];
				if (midFrame.seq < frame.seq) {
					low = mid + 1;
					len = len - half - 1;
				}
				else {
					len = half;
				}
			}
			
			_videoFrames.splice(low, 0, frame);
		}
		
		private function searchFrame(frameSeq:uint):VideoFrame {
			var pos:int = searchFramePos(frameSeq);
			if (pos == -1) {
				return null;
			}
			
			return _videoFrames[pos];
		}
		
		private function searchFramePos(frameSeq:uint):int {
			var low:int = 0;
			var high:int = _videoFrames.length - 1;
			var mid:int = 0;
			while (low <= high) {
				mid = low + (high - low) / 2;
				var frame:VideoFrame = _videoFrames[mid];
				if (frameSeq > frame.seq) {
					low = mid + 1;
				}
				else if (frameSeq < frame.seq) {
					high = mid - 1;
				}
				else {
					return mid;
				}
			}
			
			return -1;
		}
	}
}
