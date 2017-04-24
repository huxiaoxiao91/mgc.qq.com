package com.h3d.qqx5.common.comdata.ceremony
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	
	public class CeremonyFansInfo extends ProtoBufSerializable
	{
		
		public function CeremonyFansInfo()
		{
			registerField("name", "", Descriptor.TypeString, 1);
			registerField("zone", "", Descriptor.TypeString, 2);
			registerField("support_degree", "", Descriptor.Int32, 3);
			registerField("support_anchor", "", Descriptor.Int64, 4);
			registerField("vip_level", "", Descriptor.Int32, 5);
		}
		
		public var name : String ="";
		public var zone : String = "";
		public var support_degree : int;
		public var support_anchor : Int64;
		public var vip_level : int;
	}
}
