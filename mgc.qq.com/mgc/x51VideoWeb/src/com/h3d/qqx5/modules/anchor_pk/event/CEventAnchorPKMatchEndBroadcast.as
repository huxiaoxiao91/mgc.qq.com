package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	public class CEventAnchorPKMatchEndBroadcast extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKMatchEndBroadcast;
		}
		
		public function CEventAnchorPKMatchEndBroadcast()
		{
			registerField("winner", "", Descriptor.TypeString, 1);
			registerField("loser", "", Descriptor.TypeString, 2);
			registerField("is_draw", "", Descriptor.TypeBoolean, 3);
		}
		
		public var winner : String;
		public var loser : String;
		public var is_draw : Boolean;
	}
}
