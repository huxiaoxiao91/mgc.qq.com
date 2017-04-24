package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class AnchorBadge extends ProtoBufSerializable
	{
		public function AnchorBadge()
		{
			registerField("anchor_id","", Descriptor.Int64,  1);
			registerField("badge_id","", Descriptor.Int32,  2);
			registerField("start_time","", Descriptor.Int32,  3);
			registerField("end_time","", Descriptor.Int32,  4);
		}
		
		public var anchor_id:Int64 = new Int64();
		public var badge_id:int = 0;
		public var start_time:int = 0;   
		public var end_time:int = 0;   
		
	}
}