package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class AnchorData2 extends ProtoBufSerializable
	{
		
		public function AnchorData2()
		{
			registerField("pstid", "", Descriptor.Int64, 1);
//			registerField("level", "", Descriptor.Int32, 2);
			registerField("starlight", "", Descriptor.Int32, 3);
			registerField("popularity", "", Descriptor.Int32, 4);
			registerField("followed", "", Descriptor.Int32, 5);
		}
		
		public var pstid : Int64;
//		public var level : int;
		public var starlight : int;
		public var popularity : int;
		public var followed : int;
	}
}
