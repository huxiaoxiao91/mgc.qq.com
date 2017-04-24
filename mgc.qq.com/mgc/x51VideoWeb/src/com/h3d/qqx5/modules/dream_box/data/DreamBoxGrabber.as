package com.h3d.qqx5.modules.dream_box.data
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class DreamBoxGrabber extends ProtoBufSerializable
	{
		public function DreamBoxGrabber()
		{
			registerField("player_name", "", Descriptor.TypeString, 1);
			registerField("player_zone", "", Descriptor.TypeString, 2);
			registerField("money", "", Descriptor.Int32, 3);
			registerField("money_type", "", Descriptor.Int32, 4);
		}
		public var player_name : String = "";
		public var player_zone : String = "";
		public var money : int;
		public var money_type : int;
	}
}
