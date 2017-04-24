package com.h3d.qqx5.tqos
{
	import com.h3d.qqx5.common.Globals;

	public class TQOSCDNHttpRequest
	{
		public function TQOSCDNHttpRequest()
		{
			nType = TQOS_WebType.TQOS_CDNHttpRequest;
		}
		public var nType:int ;//体验类型
		public var nDeviceType:int ;//三端类型
		public var nConnCnt:int ;//连接数
		public var nConnTotalTime:int;//连接时长
		public static  var nConnBeginTime:int ;
		public function Response():void
		{
			Globals.s_logger.tqos(nType+"@"+nDeviceType+"@"+nConnCnt+"@"+nConnTotalTime );
		}
	}
}