package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class TPersistID extends ProtoBufSerializable
	{
		public function TPersistID()
		{
			registerField("persist_id", "", Descriptor.Int64, 1);
			registerField("index", "", Descriptor.Int32, 2);
		}
		public var persist_id:Int64;
		public var name :int = 2;
	}
}