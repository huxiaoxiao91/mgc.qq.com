package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventPlayerContributionInCurPKRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventPlayerContributionInCurPKRes;
		}
		
		public function CEventPlayerContributionInCurPKRes()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("contribution", "", Descriptor.Int64, 2);
			registerField("result", "", Descriptor.Int32, 3);
		}
		
		public var player_id : Int64;
		public var contribution : Int64;
		public var result : int;
	}
}
