package com.h3d.qqx5.videoclient.data
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class FriendPayInfo extends ProtoBufSerializable
	{
		public function FriendPayInfo()
		{
			registerField("presenter_qq", "", Descriptor.Int64, 1);
			registerField("presenter_nick", "", Descriptor.TypeString, 2);
			registerField("amount", "", Descriptor.Int64, 3);
		}
		
		public var presenter_qq : Int64;
		public var presenter_nick : String;
		public var amount : Int64;
	}
}