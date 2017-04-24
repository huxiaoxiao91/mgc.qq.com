package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventRefreshNestCreditsLevel extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventRefreshNestCreditsLevel;
		}
		public function CEventRefreshNestCreditsLevel()
		{
			registerField("nest_id", "", Descriptor.Int32, 1);
			registerField("credits", "", Descriptor.Int32, 2);
			registerField("credits_level", "", Descriptor.Int32, 3);
		}
		public var nest_id : int;
		public var credits : int;
		public var credits_level : int;
	}
}
