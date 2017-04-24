package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class RaffleRewardInfo extends ProtoBufSerializable
	{
		public function RaffleRewardInfo()
		{
			registerField("desc", "", Descriptor.TypeString, 1);
			registerField("url", "", Descriptor.TypeString, 2);
		}
		public var desc : String = "";
		public var url : String = "" ;
	}
}
