package com.h3d.qqx5.videoclient.data
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.getQualifiedClassName;
	
	public class CDailySiginReward extends ProtoBufSerializable
	{
		public function CDailySiginReward()
		{
			registerField("type", "", Descriptor.Int32, 1);
			registerField("male_data", "", Descriptor.Int32, 2);
			registerField("female_data", "", Descriptor.Int32, 3);
			registerField("count", "", Descriptor.Int32, 4);
			registerField("channel", "", Descriptor.Int32, 5);
			//以上字段来自CReward
			registerField("level", "", Descriptor.Int32, 101);
			registerField("multiply", "", Descriptor.Int32, 102);

		}
		public var type:int;
		public var male_data:int;
		public var female_data:int;
		public var count:int;
		public var level:int;
		public var multiply:int = 1;
		public var channel:int;
	}
}