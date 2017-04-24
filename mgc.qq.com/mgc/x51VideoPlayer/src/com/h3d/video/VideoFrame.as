package com.h3d.video
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getTimer;
	
	/*
	** 视频帧
	*/
	public class VideoFrame {
		
		private var _seq:uint;
		
		//数据包大小
		private var _size:int;
		
		//当前数据包大小
		private var _currentSize:int;
		
		private var _initialized:Boolean;
		
		//时间戳
		private var _encodeTime:uint;
		
		private var _maxCacheTime:int;
		private var _data:ByteArray;
		private var _fps:int;
		
		//是否关键帧
		private var _isKeyFrame:Boolean;
		private var _initTick:int;
		private var _delayTimesInit:int;
		private var _delayTimesUnInit:int;
		
		
		public function VideoFrame(seq:uint, fps:int) {
			reset();
			
			_seq = seq;
			_fps = fps;
			_initTick = getTimer();
		}

		public function IsInitialize():Boolean {
			return _initialized;
		}
		
		public function get data():ByteArray {
			return _data;
		}
		
		public function checkFrameReady():Boolean {
			var ok:Boolean = false;
			if (_initialized) {
				// 已经初始化，如果完整或者已经延迟了数据包数一致多次，则不再缓冲。每帧延迟次数跟该帧占用数据包数一致
				ok = (isFull() || ++_delayTimesInit > (size + 511) / 512);
			}
			else {
				// 未初始化，则默认延迟两次再取出
				ok = ++_delayTimesUnInit > 2;
			}
			
			return ok;
		}
		
		public function HttpWrite(seq:uint, key:Boolean, timestamp:uint, data:ByteArray, currentSize:int):void {
			_initialized = true;
			_seq = seq;
			_isKeyFrame = key;
			_encodeTime = timestamp;
			_currentSize = currentSize;
			_data = new ByteArray();
			_data.endian = Endian.LITTLE_ENDIAN;
			_data.writeBytes(data, 0, data.length);
		}
		
		public function isFull():Boolean {
			return _currentSize == this.size && this.size != 0;
		}
		
		public function get seq():uint {
			return _seq;
		}
		
		public function get size():int {
			if (_data == null)
				return 0;
			return _data.length;
		}
		
		public function isKeyFrame():Boolean {
			return _isKeyFrame;
		}
		
		public function reset():void {
			_seq = 0;
			_fps = 0;
			_currentSize = 0;
			_initialized = false;
			_encodeTime = 0;
			_maxCacheTime = 4000;
			_data = null;
			_isKeyFrame = false;
		}
		
		/**
		 * 此对象缓存在内存的时间
		 */		
		public function get cacheTime():int {
			return getTimer() - _initTick;
		}
		
		public function get cacheRatio():Number {
			return _currentSize / size;
		}
		
		public function get encodeTime():int {
			return _encodeTime;
		}
	}

}