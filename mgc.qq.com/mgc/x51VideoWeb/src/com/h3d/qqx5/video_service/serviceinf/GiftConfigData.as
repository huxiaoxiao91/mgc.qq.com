package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class GiftConfigData extends ProtoBufSerializable
	{
		public function GiftConfigData()
		{
			registerFieldForList("counts", "", Descriptor.Int32, 1);
			registerField("continuous_send_gifts_counts", "", Descriptor.Int32, 2);
		}
		public var counts : Array= new Array;
		public var continuous_send_gifts_counts:int;
	}
}