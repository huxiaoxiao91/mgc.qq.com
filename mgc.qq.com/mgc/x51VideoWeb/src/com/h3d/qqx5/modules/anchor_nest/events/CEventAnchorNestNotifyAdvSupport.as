package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestAdvSupport;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class CEventAnchorNestNotifyAdvSupport extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventAnchorNestNotifyAdvSupport;
		}
		
		public function CEventAnchorNestNotifyAdvSupport()
		{
			registerField("player_name", "", Descriptor.TypeString, 1);
			registerField("zone_id", "", Descriptor.Int32, 2);
			registerField("player_id", "", Descriptor.Int64, 3);
			registerField("zone_name", "", Descriptor.TypeString, 4);
			registerFieldForDict("adv_support","", Descriptor.Int64, getQualifiedClassName(AnchorNestAdvSupport),Descriptor.Compound, 5);
			registerField("add_popularity", "", Descriptor.Int32, 6);
			registerField("nest_star", "", Descriptor.Int64, 7);
		}
		
		public var player_name : String = "";
		public var zone_id : int;
		public var player_id : Int64= new Int64(0,0);
		public var zone_name : String = "";
		public var adv_support :Dictionary = new Dictionary();
		public var add_popularity : int;
		public var nest_star : Int64 = new Int64(0,0);
	}
}
