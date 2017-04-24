package com.h3d.qqx5.modules.anchor_nest.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class AnchorNestStarLogicData extends ProtoBufSerializable
	{
		public function AnchorNestStarLogicData()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("nest_id", "", Descriptor.Int32, 2);
			registerFieldForList("star_value", "", Descriptor.Int32, 3);
			registerField("sum_star", "", Descriptor.Int32, 4);
			registerField("total_star", "", Descriptor.Int64, 5);
			registerField("need_save", "", Descriptor.TypeBoolean, 6);
			registerField("last_save_time", "", Descriptor.Int32, 7);
			registerField("add_star", "", Descriptor.Int32, 8);
			registerField("total_add_star", "", Descriptor.Int64, 9);
		}
		public var player_id :Int64 = new Int64(0,0);
		public var nest_id : int;
		public var star_value : Array;
		public var sum_star : int;
		public var total_star : Int64= new Int64(0,0);
		public var need_save : Boolean;
		public var last_save_time : int;
		public var add_star : int;
		public var total_add_star : Int64= new Int64(0,0);
	}
}
