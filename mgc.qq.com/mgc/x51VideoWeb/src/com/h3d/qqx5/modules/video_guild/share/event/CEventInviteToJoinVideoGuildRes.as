package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventInviteToJoinVideoGuildRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventInviteToJoinVideoGuildRes;
		}
		
		public function CEventInviteToJoinVideoGuildRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("inviter_id", "", Descriptor.Int64, 3);
			registerField("target_id", "", Descriptor.Int64, 4);
			registerField("vgid", "", Descriptor.Int64, 5);
			registerField("vg_name", "", Descriptor.TypeString, 6);
			registerField("invite_from", "", Descriptor.Int32, 7);
			registerField("support_anchor_id", "", Descriptor.Int64, 8);
			registerField("serial_id", "", Descriptor.Int32, 9);
		}
		
		public var result : int;
		public var room_id : int;
		public var inviter_id : Int64 = new Int64();
		public var target_id : Int64 = new Int64();
		public var vgid : Int64 = new Int64();
		public var vg_name : String;
		public var invite_from : int;
		public var support_anchor_id : Int64 = new Int64();
		public var serial_id : int;
	}
}
