package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadAnchorNestInfoFromDB extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventLoadAnchorNestInfoFromDB;
		}
		
		public function CEventLoadAnchorNestInfoFromDB()
		{
			registerField("nest_id", "", Descriptor.Int32, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
			registerField("account_id", "", Descriptor.Int64, 3);
			registerField("by_account", "", Descriptor.TypeBoolean, 4);
		}
		
		public var nest_id : int;
		public var trans_id : Int64;
		public var account_id : Int64;
		public var by_account : Boolean;
	}
}
