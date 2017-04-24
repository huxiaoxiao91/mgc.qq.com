package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventSaveAnchorNestInfoToDBRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventSaveAnchorNestInfoToDBRes;
		}
		
		public function CEventSaveAnchorNestInfoToDBRes()
		{
			registerField("success", "", Descriptor.TypeBoolean, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
		}
		
		public var success : Boolean;
		public var trans_id : Int64;
	}
}
