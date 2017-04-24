package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventLoadAnchorPKWinnerFromDB extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventLoadAnchorPKWinnerFromDB;
		}
		
		public function CEventLoadAnchorPKWinnerFromDB()
		{
			registerField("activity_id", "", Descriptor.Int32, 1);
			registerFieldForList("load_players", "", Descriptor.Int64, 2);
			registerField("trans_id", "", Descriptor.Int64, 3);
		}
		
		public var activity_id : int;
		public var load_players : Array = new Array;
		public var trans_id : Int64;
	}
}
