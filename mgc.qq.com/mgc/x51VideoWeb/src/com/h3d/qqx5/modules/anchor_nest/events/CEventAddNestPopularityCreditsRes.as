package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventAddNestPopularityCreditsRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventAddNestPopularityCreditsRes;
		}
		public function CEventAddNestPopularityCreditsRes()
		{
			registerField("free_popularity_limit", "", Descriptor.TypeBoolean, 1);
			registerField("is_need_hint", "", Descriptor.TypeBoolean, 2);
			registerField("add_popularity", "", Descriptor.Int32, 3);
			registerField("add_credits", "", Descriptor.Int32, 4);
			registerField("cur_credits", "", Descriptor.Int32, 5);
			registerField("cur_credits_level", "", Descriptor.Int32, 6);
		}
		public var free_popularity_limit : Boolean;
		public var is_need_hint : Boolean;
		public var add_popularity : int;
		public var add_credits : int;
		public var cur_credits : int;
		public var cur_credits_level : int;
	}
}
