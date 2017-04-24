package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class AnchorPKWinnerDBData extends ProtoBufSerializable
	{
		
		public function AnchorPKWinnerDBData()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("activity_id", "", Descriptor.Int32, 2);
			registerField("guild_id", "", Descriptor.Int32, 3);
		}
		
		public var anchor_id : Int64;
		public var activity_id : int;
		public var guild_id : int;
	}
}
