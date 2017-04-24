package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventOperateVideoGuildJoinApplyNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventOperateVideoGuildJoinApplyNotify;
		}
		
		public function CEventOperateVideoGuildJoinApplyNotify()
		{
			registerField("resev_transid", "", Descriptor.Int64, 1);
			registerField("target_id", "", Descriptor.Int64, 2);
			registerField("vgid", "", Descriptor.Int64, 3);
			registerField("vg_name", "", Descriptor.TypeString, 4);
			registerField("need_reply", "", Descriptor.TypeBoolean, 5);
			registerField("room_server_id", "", Descriptor.Int32, 6);
		}
		
		public var resev_transid : Int64;
		public var target_id : Int64;
		public var vgid : Int64;
		public var vg_name : String;
		public var need_reply : Boolean;
		public var room_server_id : int;
	}
}
