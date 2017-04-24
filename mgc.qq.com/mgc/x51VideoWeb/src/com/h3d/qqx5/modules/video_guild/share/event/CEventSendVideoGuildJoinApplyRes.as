package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventSendVideoGuildJoinApplyRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventSendVideoGuildJoinApplyRes;
		}
		
		public function CEventSendVideoGuildJoinApplyRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("vgid", "", Descriptor.Int64, 3);
			registerField("result", "", Descriptor.Int32, 4);
			registerField("notify_vg_name", "", Descriptor.TypeString, 5);
			registerField("offline_become_member", "", Descriptor.TypeBoolean, 6);
		}
		
		public var trans_id : Int64 = new Int64();
		public var player_id : Int64  = new Int64();
		public var vgid : Int64  = new Int64();
		public var result : int;
		public var notify_vg_name:String = "";
		public var offline_become_member:Boolean;
	}
}
