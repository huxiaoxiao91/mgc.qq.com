package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class LiveCDNInfo extends ProtoBufSerializable
	{
		public function LiveCDNInfo()
		{
			registerFieldForList("ip_vec", "", Descriptor.TypeString, 1);
			registerField("vkey", "", Descriptor.TypeString, 2);
		}
		
		public var ip_vec : Array = new Array;
		public var vkey : String;
	}
}
