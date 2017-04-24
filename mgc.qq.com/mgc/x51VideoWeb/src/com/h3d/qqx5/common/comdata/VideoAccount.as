package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoAccount extends ProtoBufSerializable
	{
		public function VideoAccount()
		{
			registerField("pstid", "", Descriptor.Int64, 1);
			registerField("account_type", "", Descriptor.Int32, 2);
			registerField("active", "", Descriptor.TypeBoolean, 3);
			registerField("sex", "",Descriptor.Int32, 4);
			registerField("nick", "", Descriptor.TypeString, 5);
			registerField("place", "", Descriptor.TypeString, 6);
			registerField("intro", "", Descriptor.TypeString, 7);
			registerField("last_login", "", Descriptor.Int32, 8);
			registerField("last_logout", "", Descriptor.Int32, 9);
		}
		
		public var pstid : Int64 = new Int64();
		public var account_type : int;
		public var active : Boolean;
		public var sex : int;
		public var nick : String ="";
		public var place : String ="";
		public var intro : String ="";
		public var last_login : int;
		public var last_logout : int;
	}
}
