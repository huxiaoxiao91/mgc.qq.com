package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.share.NestCredtisLevelConfigInfo;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class CEventNestGrowUpInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventNestGrowUpInfo;
		}
		public function CEventNestGrowUpInfo()
		{
			registerField("credits", "", Descriptor.Int32, 1);
			registerField("credits_level", "", Descriptor.Int32, 2);
			registerField("rank", "", Descriptor.Int32, 3);
			registerField("credits_distance_of_prev_or_1000", "", Descriptor.Int32, 4);
			registerField("rank_need_promote", "", Descriptor.Int32, 5);
			registerField("credits_need_promote", "", Descriptor.Int32, 6);
			registerField("honor_num_need_promote", "", Descriptor.Int32, 7);
			registerField("is_get_guard_wage", "", Descriptor.TypeBoolean, 8);
			registerField("get_guard_wage_credits", "", Descriptor.Int32, 9);
			registerFieldForList("nest_credits_level_config_vec", getQualifiedClassName(NestCredtisLevelConfigInfo), Descriptor.Compound, 10);
			registerFieldForDict("guard_wage_info", "", Descriptor.Int32, "", Descriptor.Int32, 11);
			registerField("get_guard_wage", "", Descriptor.TypeBoolean, 12);
		}
		public var credits : int;
		public var credits_level : int;
		public var rank : int;
		public var credits_distance_of_prev_or_1000 : int;
		public var rank_need_promote : int;
		public var credits_need_promote : int;
		public var honor_num_need_promote : int;
		public var is_get_guard_wage : Boolean;
		public var get_guard_wage_credits : int;
		public var nest_credits_level_config_vec : Array = new Array();
		public var guard_wage_info : Dictionary = new Dictionary();
		public var get_guard_wage:Boolean;//领取成功与否
	}
}
