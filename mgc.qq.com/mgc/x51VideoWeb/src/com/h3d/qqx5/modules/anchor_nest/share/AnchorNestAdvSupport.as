package com.h3d.qqx5.modules.anchor_nest.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class AnchorNestAdvSupport extends ProtoBufSerializable
	{
		public function AnchorNestAdvSupport()
		{
			registerField("player_info", getQualifiedClassName(PlayerSimpleInfo), Descriptor.Compound, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("count", "", Descriptor.Int32, 3);
			registerField("last_time", "", Descriptor.Int32, 4);
		}
		public var player_info : PlayerSimpleInfo = new PlayerSimpleInfo;
		public var player_id : Int64 = new Int64(0,0);
		public var count : int;
		public var last_time : int;
	}
}
