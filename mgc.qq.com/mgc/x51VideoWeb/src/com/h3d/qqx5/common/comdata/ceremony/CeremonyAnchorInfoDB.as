package com.h3d.qqx5.common.comdata.ceremony
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class CeremonyAnchorInfoDB extends ProtoBufSerializable
	{
		public function CeremonyAnchorInfoDB()
		{
			registerField("activity_id", "", Descriptor.Int32, 1);
			registerField("session", "", Descriptor.Int32, 2);
			registerField("ceremony_state", "", Descriptor.Int32, 3);
			registerField("anchor_name", "", Descriptor.TypeString, 4);
			registerField("anchor_id", "", Descriptor.Int64, 5);
			registerField("total_support_degree", "", Descriptor.Int32, 6);
		}
		
		public var activity_id : int;
		public var session : int;
		public var ceremony_state : int;
		public var anchor_name : String = "";
		public var anchor_id : Int64;
		public var total_support_degree : int;
	}
}
