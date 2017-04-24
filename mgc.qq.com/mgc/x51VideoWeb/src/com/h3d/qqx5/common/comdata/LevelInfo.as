package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class LevelInfo extends ProtoBufSerializable
	{
		public function LevelInfo()
		{
			registerField("level_up_exp", "", Descriptor.Int32, 1);
			registerField("buff_percent", "", Descriptor.Int32, 2);
		}
		
		public var level_up_exp:int;
		public var buff_percent:int;
	}
}