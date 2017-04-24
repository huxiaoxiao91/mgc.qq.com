package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.common.comdata.AnchorPKInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventLoadAnchorPKWinnerFromDBRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventLoadAnchorPKWinnerFromDBRes;
		}
		
		public function CEventLoadAnchorPKWinnerFromDBRes()
		{
			registerFieldForList("data_loaded", getQualifiedClassName(AnchorPKInfo), Descriptor.Compound, 1);
			registerFieldForList("players", "", Descriptor.Int64, 2);
			registerField("trans_id", "", Descriptor.Int64, 3);
		}
		
		public var data_loaded : Array = new Array;
		public var players : Array = new Array;
		public var trans_id : Int64;
	}
}
