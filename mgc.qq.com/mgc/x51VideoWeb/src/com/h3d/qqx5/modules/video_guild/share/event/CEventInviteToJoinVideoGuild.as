package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventInviteToJoinVideoGuild extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventInviteToJoinVideoGuild;
		}
		
		public function CEventInviteToJoinVideoGuild()
		{
			registerField("inviter_id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("vgid", "", Descriptor.Int64, 3);
			registerField("invite_from", "", Descriptor.Int32, 4);
			registerField("target_id", "", Descriptor.Int64, 5);
			registerField("serial_id", "", Descriptor.Int32, 6);
			registerField("trans_id", "", Descriptor.Int64, 7);
		}
		
		public var inviter_id : Int64 = new Int64();
		public var room_id : int;
		public var vgid : Int64  = new Int64();
		public var invite_from : int;
		public var target_id : Int64  = new Int64();
		public var serial_id : int;
		public var trans_id : Int64  = new Int64();
	}
}
