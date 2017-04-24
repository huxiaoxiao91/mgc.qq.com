package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVipGuildMemberGiftAddAnchorScore extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVipGuildMemberGiftAddAnchorScore;
		}
		
		public function CEventVipGuildMemberGiftAddAnchorScore()
		{
			registerField("sender_id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("anchor_qq", "", Descriptor.Int64, 3);
			registerField("videoguild_id", "", Descriptor.Int64, 4);
			registerField("score_add", "", Descriptor.Int64, 5);
			registerField("gift_id", "", Descriptor.Int32, 6);
			registerField("gift_count", "", Descriptor.Int32, 7);
		}
		
		public var sender_id : Int64;
		public var room_id : int;
		public var anchor_qq : Int64;
		public var videoguild_id : Int64;
		public var score_add : Int64;
		public var gift_id : int;
		public var gift_count : int;
	}
}
