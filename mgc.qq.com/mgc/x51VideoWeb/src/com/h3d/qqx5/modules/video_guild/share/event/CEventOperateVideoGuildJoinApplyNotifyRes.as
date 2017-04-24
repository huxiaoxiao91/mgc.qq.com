package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventOperateVideoGuildJoinApplyNotifyRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventOperateVideoGuildJoinApplyNotifyRes;
		}
		
		public function CEventOperateVideoGuildJoinApplyNotifyRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("target_id", "", Descriptor.Int64, 2);
			registerField("vgid", "", Descriptor.Int64, 3);
			registerField("vg_name", "", Descriptor.TypeString, 4);
			registerField("result", "", Descriptor.Int32, 5);
			registerField("room_server_id", "", Descriptor.Int32, 6);
			registerField("target_vip_level", "", Descriptor.Int32, 7);
			registerField("target_name", "", Descriptor.TypeString, 8);
			registerField("target_roomsrv_id", "", Descriptor.Int32, 9);
		}
		
		public var trans_id : Int64;
		public var target_id : Int64;
		public var vgid : Int64;
		public var vg_name : String;
		public var result : int;
		public var room_server_id : int;
		public var target_vip_level : int;
		public var target_name : String = "";
		public var target_roomsrv_id : int;
	}
}
