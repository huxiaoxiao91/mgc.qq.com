package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.ChatResult;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoChatResult extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoChatResult;
		}
		
		public function CEventVideoChatResult()
		{
			registerField("rec_name", "", Descriptor.TypeString, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("module_result", "", Descriptor.Int32, 3);
			registerField("forbid_talk_time", "", Descriptor.Int32, 4);
			registerField("system_cd_time", "", Descriptor.Int32, 5);
			registerField("cd_remain_time", "", Descriptor.Int32, 6);
			registerField("diamond_balance", "", Descriptor.Int32, 7);
			registerField("res_ext", "", Descriptor.Int32, 8);
			registerField("reason_ext", "", Descriptor.TypeString, 9);
		}
		
		//获取结果
		 public function GetResult(  ):int
		{
			return result;
		}
		
		public var rec_name : String;//对方名称
		public var result : int;
		public var module_result : int;
		public var forbid_talk_time : int;// 剩余的禁言时间(分钟)
		public var system_cd_time : int;// 系统cd时间，毫秒
		public var cd_remain_time : int;// 发言剩余时间，毫秒
		public var diamond_balance : int;// 炫豆余额
		public var res_ext : int;
		public var reason_ext : String;
	}
}
