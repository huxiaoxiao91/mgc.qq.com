package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestStarDBData;
	
	import flash.utils.getQualifiedClassName;

	public class CEventSavePlayerNestStar extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventSavePlayerNestStar;
		}
		
		public function CEventSavePlayerNestStar()
		{
			registerField("player_star", getQualifiedClassName(AnchorNestStarDBData), Descriptor.Compound, 1);
		}
		
		public var player_star :AnchorNestStarDBData = new AnchorNestStarDBData;
	}
}
