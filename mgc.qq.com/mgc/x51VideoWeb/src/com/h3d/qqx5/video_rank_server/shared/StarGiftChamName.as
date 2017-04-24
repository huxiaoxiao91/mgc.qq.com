package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class StarGiftChamName extends ProtoBufSerializable
	{
		public function StarGiftChamName()
		{
			registerField("anchor_name", "", Descriptor.TypeString, 1);
			registerField("player_name", "", Descriptor.TypeString, 2);
		}
		
		public var anchor_name :String = "";
		public var player_name :String = "";
	}
}