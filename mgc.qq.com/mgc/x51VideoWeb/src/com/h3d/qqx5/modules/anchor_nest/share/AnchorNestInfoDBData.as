package com.h3d.qqx5.modules.anchor_nest.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class AnchorNestInfoDBData extends ProtoBufSerializable
	{
		public function AnchorNestInfoDBData()
		{
			registerFieldForList("adv_support", getQualifiedClassName(PlayerSimpleInfo), Descriptor.Compound, 7);
			registerFieldForDict("adv_support_map","",Descriptor.Int64, getQualifiedClassName(AnchorNestAdvSupport),Descriptor.Compound, 8);
			registerField("popularity", "", Descriptor.Int64, 9);
			registerField("publish_task_time", "", Descriptor.Int32, 10);
			registerField("create_time", "", Descriptor.Int32, 11);
			registerField("freeze_time", "", Descriptor.Int32, 12);
		}
		
		public var adv_support : Array = new Array();
		public var adv_support_map :Dictionary = new Dictionary();
		public var popularity : Int64;
		public var publish_task_time : int;
		public var create_time : int;
		public var freeze_time : int;
	}
}
