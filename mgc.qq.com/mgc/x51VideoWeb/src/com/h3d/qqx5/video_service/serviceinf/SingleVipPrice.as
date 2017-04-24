package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class SingleVipPrice extends ProtoBufSerializable
	{
		public function SingleVipPrice()
		{
			registerField("duartion", "", Descriptor.Int32, 1);
			registerField("cost", "", Descriptor.Int32, 2);
			registerField("fullcost", "", Descriptor.Int32, 3);
			registerField("cost_type", "", Descriptor.Int32, 4);
		}
		
		public var duartion : int;
		public var cost : int;
		public var fullcost : int;
		public var cost_type:int;
	}
}
