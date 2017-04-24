package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestInfoDBData;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventSaveAnchorNestInfoToDB extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventSaveAnchorNestInfoToDB;
		}
		
		public function CEventSaveAnchorNestInfoToDB()
		{
			registerField("info", getQualifiedClassName(AnchorNestInfoDBData), Descriptor.Compound, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
		}
		
		public var info :AnchorNestInfoDBData = new AnchorNestInfoDBData;
		public var trans_id : Int64;
	}
}
