package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.Dictionary;
	
	public class StarGiftInfo extends ProtoBufSerializable
	{
		public function StarGiftInfo()
		{
			registerField("gift_id","",Descriptor.Int32,1);
			registerField("gift_cnt","",Descriptor.Int32,2);
			registerField("rank","",Descriptor.Int32,3);
			registerField("last_anchor_rank","",Descriptor.Int32,4);
			registerField("gift_count_diff","",Descriptor.Int32,5);
		}
		
		public var gift_id :int;
		public var gift_cnt :int;
		public var rank :int;
		public var last_anchor_rank:int;
		public var gift_count_diff:int;
	}
}