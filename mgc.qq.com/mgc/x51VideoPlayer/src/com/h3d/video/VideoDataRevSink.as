package com.h3d.video
{
	import com.h3d.video.FLVFrame;
	
	import flash.utils.ByteArray;

	/*
	** http通知VideoEngine的接口
	*/
	public interface VideoDataRevSink {
		/*
		** 网络连接相关的错误处理
		*/
		// 数据接收超时，重新连接
		//public static const RETRY_CODE:int = 1000;
		// 对端关闭连接时，重新连接当前正用的CDN
		//public static const RETRY_BE_CLOSED_CODE:int = 1001;
		// CDN无法连接，或http响应不是200时，尝试连接列表中下一个CDN
		//public static const ERROR:int = 0;
		// 对一个CDN地址尝试重连的次数，超过最大次数时，就不再连接这个CDN地址，
		//public static const RETRY_CDN_CNT:int = 10;
		// 数据接收超时时间
		//public static const NO_DATA_INTER:int = 4000; // 毫秒
		
		function OnClose(errCode:int, errmsg:String):void;
		function OnConnect():void;
		
		function OnMediaTypeRecv(buf:ByteArray):void;
		function OnHttpDataRecv(flvFrame:FLVFrame):void;
	}
}