package com.h3d.video
{
	import com.h3d.util.TQosLogger;
	
	import flash.display.Sprite;

	public class TQOSFrameRate
	{
		public function TQOSFrameRate()
		{
			nType = 	12;//TQOS_FrameRate:int = 12;//视频帧率
		}
		private var log:TQosLogger = new TQosLogger();
		public var nType:int ;//体验类型
		public var CDT_WEB:int = 2 ;//三端类型
		public var nVideo_width:int;
		public var nVideo_height:int;
		public var nVideo_bitrate:int;
		public var nFrameCnt:int;//总帧数
		public var nSuccFrameCnt:int;//成功帧数
		public var nKeyFrameCnt:int;//总关键帧数
		public var nKeySuccFrameCnt:int;//关键帧成功帧数
		
		public function Response():void
		{
			var frame:int = nSuccFrameCnt * 100 / nFrameCnt;
			var keyframe:int = nKeySuccFrameCnt * 100 / nKeyFrameCnt; 
			log.tqos(nType+"@"+CDT_WEB+"@"+frame+"@"+keyframe);
		}
	}
}