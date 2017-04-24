package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.getQualifiedClassName;

	public class RankTitle extends ProtoBufSerializable
	{
		public function RankTitle()
		{
			registerField("rank_name", "", Descriptor.TypeString, 1);
			registerField("sub_rank_name", "", Descriptor.TypeString, 2);
			registerField("data", getQualifiedClassName(RankAdditionalData), Descriptor.Compound, 3);
		}
		public var rank_name : String = "";
		public var sub_rank_name : String = "";
		public var data : RankAdditionalData = new RankAdditionalData;
	}
}
