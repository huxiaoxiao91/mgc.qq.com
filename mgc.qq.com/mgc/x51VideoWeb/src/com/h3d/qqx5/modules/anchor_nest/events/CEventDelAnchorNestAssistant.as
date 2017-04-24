package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class CEventDelAnchorNestAssistant extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventDelAnchorNestAssistant;
		}
		
		public function CEventDelAnchorNestAssistant()
		{
			registerField("nest_id", "", Descriptor.Int32, 1);
			registerField("assistant_id", "", Descriptor.Int64, 2);
		}
		
		public var nest_id : int;
		public var assistant_id : Int64;
	}
}
