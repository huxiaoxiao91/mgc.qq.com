package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_pk.share.AnchorPKMatchDetail;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventAnchorPKLoadMatchDetailRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKLoadMatchDetailRes;
		}
		
		public function CEventAnchorPKLoadMatchDetailRes()
		{
			registerField("anchorA_info", getQualifiedClassName(AnchorPKMatchDetail), Descriptor.Compound, 1);
			registerField("anchorB_info", getQualifiedClassName(AnchorPKMatchDetail), Descriptor.Compound, 2);
			registerField("result", "", Descriptor.Int32, 3);
			registerField("player_id", "", Descriptor.Int64, 4);
		}
		
		public var anchorA_info : AnchorPKMatchDetail = new AnchorPKMatchDetail;
		public var anchorB_info : AnchorPKMatchDetail = new AnchorPKMatchDetail;
		public var result : int;
		public var player_id : Int64;
	}
}
