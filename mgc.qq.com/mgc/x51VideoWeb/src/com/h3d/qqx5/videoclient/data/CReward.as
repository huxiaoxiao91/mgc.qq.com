package com.h3d.qqx5.videoclient.data
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class CReward extends ProtoBufSerializable
	{
		public function CReward()
		{
			registerField("type", "", Descriptor.Int32, 1);
			registerField("male_data", "", Descriptor.Int32, 2);
			registerField("female_data", "", Descriptor.Int32, 3);
			registerField("count", "", Descriptor.Int32, 4);
			registerField("channel", "", Descriptor.Int32, 5);
		}
		public var type:int;
		public var male_data:int;
		public var female_data:int;
		public var count:int;
		public var channel:int;
	}
}