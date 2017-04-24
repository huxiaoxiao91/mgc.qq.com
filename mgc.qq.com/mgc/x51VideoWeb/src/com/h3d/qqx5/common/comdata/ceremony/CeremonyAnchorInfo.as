package com.h3d.qqx5.common.comdata.ceremony
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class CeremonyAnchorInfo extends ProtoBufSerializable
	{
		
		public function CeremonyAnchorInfo()
		{
			registerField("name", "", Descriptor.TypeString, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
			registerField("total_support_degree", "", Descriptor.Int32, 3);
			registerField("is_online", "", Descriptor.TypeBoolean, 4);
			registerField("type", "", Descriptor.Int32, 5);
		}
		
		public var name : String ="";
		public var anchor_id : Int64;
		public var total_support_degree : int;
		public var is_online : Boolean;
		public var type : int;
	}
}
