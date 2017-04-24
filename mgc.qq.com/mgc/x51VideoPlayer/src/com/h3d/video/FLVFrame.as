package com.h3d.video {
	import flash.utils.ByteArray;

	/*
	** http下载的数据格式
	*/
	public class FLVFrame {
		public var _dataSize:uint;
		public var _headerSize:uint;
		public var _version:uint;
		public var _type:uint;
		
		/**
		 * 1为普通帧 2为关键帧
		 */	
		public var _keyFrame:uint;
		
		/**
		 * 时间戳 毫秒
		 */	
		public var _timestamp:uint;
		
		public var _frameSeq:uint;
		public var _segId:uint;
		public var _checksum:uint;
		
		/**
		 * 视频数据
		 */
		public var _data:ByteArray;
	}
}