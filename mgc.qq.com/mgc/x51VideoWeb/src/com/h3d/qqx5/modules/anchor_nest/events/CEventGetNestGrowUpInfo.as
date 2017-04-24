package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.events.AnchorNestEventID;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventGetNestGrowUpInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventGetNestGrowUpInfo;
		}
		public function CEventGetNestGrowUpInfo()
		{
			registerField("nest_id", "", Descriptor.Int32, 1);
		}
		public var nest_id : int;
	}
}
