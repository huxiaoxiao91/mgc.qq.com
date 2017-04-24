package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class VideoBoxItem extends ProtoBufSerializable
	{
		public function VideoBoxItem()
		{
			registerField("item_id_male", "", Descriptor.Int32, 1);
			registerField("item_id_female", "", Descriptor.Int32, 2);
			registerField("count", "", Descriptor.Int32, 3);
			registerField("item_type", "", Descriptor.Int32, 4);
			registerField("item_channel", "", Descriptor.Int32, 5);
		}
		
		public var item_id_male : int;
		public var item_id_female : int;
		public var count : int;
		public var item_type:int;//LotType的值
		public var item_channel:int;
	}
}
