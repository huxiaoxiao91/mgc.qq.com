package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class AnchorCardVideoGuildInfo extends ProtoBufSerializable
	{
		public function AnchorCardVideoGuildInfo()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("vg_name", "", Descriptor.TypeString, 2);
			registerField("vg_score", "", Descriptor.Int64, 3);
		}
		
		public var vgid : Int64 = new Int64();
		public var vg_name : String = "";
		public var vg_score : Int64 = new Int64();
	}
}
