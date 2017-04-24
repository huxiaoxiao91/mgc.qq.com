package com.h3d.qqx5.tqos
{
	import com.h3d.qqx5.common.Globals;

	public class TQOSEnterRoom
	{
		
		public static var nBeginTime:int;//
		public function TQOSEnterRoom()
		{
			nType = TQOS_WebType.TQOS_EnterRoom;
		}
		
		public var nType:int ;//体验类型
		public var nQQ:int;//qq号码
		public var strClientIP:String = "";//客户端ip
		public var nDeviceType:int ;//三端类型
		public var nErrorCode:int = 0 ;//错误码
		public var strErrorMsg:String = ".";//错误描述
		
		public var nRoomId:int;//房间ID
		public var nEnterSuccTime:int;//进入时长
		
		public var StrRoomServerIP:String = "";
		public function Response():void
		{
			Globals.s_logger.tqos(nType+"@"+nRoomId+"@"+nQQ+"@"+nEnterSuccTime+"@"+strClientIP+"@"+nDeviceType+"@"+nErrorCode+"@"+strErrorMsg);
		}
	}
}