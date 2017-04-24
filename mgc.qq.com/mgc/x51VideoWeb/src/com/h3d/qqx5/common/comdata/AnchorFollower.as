package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class AnchorFollower extends ProtoBufSerializable
	{

		public function AnchorFollower()
		{
			registerField("affinity", "", Descriptor.Int64, 1);
			registerField("player_zone", "", Descriptor.TypeString, 2);
			registerField("nick", "", Descriptor.TypeString, 3);
			registerField("guardLevel", "", Descriptor.Int32, 4);
			registerField("viplevel", "", Descriptor.Int32, 5);
			registerField("player_psid", "", Descriptor.Int64, 6);
			registerField("has_portrait", "", Descriptor.TypeBoolean, 7);
		}
		
		public var affinity:Int64;
		public var player_zone:String ="";
		public var nick:String = "";
		public var guardLevel:int;
		public var viplevel:int;
		public var player_psid:Int64;
		public var has_portrait:Boolean;
	}
}
