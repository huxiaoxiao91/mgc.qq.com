package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class LoveNestInfo extends ProtoBufSerializable
	{
		public function LoveNestInfo()
		{
			registerField("nest_id", "", Descriptor.Int32, 1);
			registerField("nest_name", "", Descriptor.TypeString, 2);
			registerField("credits", "", Descriptor.Int32, 3);
			registerField("credits_level", "", Descriptor.Int32, 4);
			registerField("is_live", "", Descriptor.TypeBoolean, 5);
			
			registerField("anchor_id", "", Descriptor.Int64, 6);
		}
		public var nest_id : int;
		public var nest_name : String= "";
		public var credits : int;
		public var credits_level : int;
		public var is_live : Boolean;
		public var anchor_id : Int64 = new Int64();
	}
}