package com.h3d.qqx5.modules.dream_box.data
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class DreamBoxClientInfo extends ProtoBufSerializable
	{
		public function DreamBoxClientInfo()
		{
			registerField("box_id", "", Descriptor.Int64, 1);
			registerField("generate_time", "", Descriptor.Int32, 2);
			registerField("count_down", "", Descriptor.Int32, 3);
			registerField("total_money", "", Descriptor.Int32, 4);
			registerField("has_grabbed", "", Descriptor.TypeBoolean, 5);
		}
		public var box_id : Int64 = new Int64(0,0);
		public var generate_time : int;
		public var count_down : int;
		public var total_money : int;
		public var has_grabbed : Boolean;
	}
}
