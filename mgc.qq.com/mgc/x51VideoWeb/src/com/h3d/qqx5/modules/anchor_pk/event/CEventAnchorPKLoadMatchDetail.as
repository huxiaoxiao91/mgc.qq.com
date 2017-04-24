package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorPKLoadMatchDetail extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKLoadMatchDetail;
		}
		
		public function CEventAnchorPKLoadMatchDetail()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
		}
		
		public var player_id : Int64;
	}
}
