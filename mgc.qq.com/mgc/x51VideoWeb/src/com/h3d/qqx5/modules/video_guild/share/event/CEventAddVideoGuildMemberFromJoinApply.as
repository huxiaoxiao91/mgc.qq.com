package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAddVideoGuildMemberFromJoinApply extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventAddVideoGuildMemberFromJoinApply;
		}
		
		public function CEventAddVideoGuildMemberFromJoinApply()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("target_id", "", Descriptor.Int64, 2);
			registerField("vgid", "", Descriptor.Int64, 3);
			registerField("player_id", "", Descriptor.Int64, 4);
			registerField("target_offline", "", Descriptor.TypeBoolean, 5);
			registerField("target_roomsrv_id", "", Descriptor.Int32, 6);
			registerField("vg_name", "", Descriptor.TypeString, 7);
		}
		
		public var trans_id : Int64;
		public var target_id : Int64;
		public var vgid : Int64;
		public var player_id : Int64;
		public var target_offline : Boolean;
		public var target_roomsrv_id : int;
		public var vg_name : String;
	}
}
