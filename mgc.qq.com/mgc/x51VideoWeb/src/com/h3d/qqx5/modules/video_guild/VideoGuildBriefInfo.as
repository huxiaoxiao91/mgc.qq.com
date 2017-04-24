package com.h3d.qqx5.modules.video_guild
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoGuildBriefInfo extends ProtoBufSerializable
	{
		public function VideoGuildBriefInfo()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("chief_zone", "", Descriptor.TypeString, 2);
			registerField("chief_name", "", Descriptor.TypeString, 3);
			registerField("anchor_name", "", Descriptor.TypeString, 4);
			registerField("vg_name", "", Descriptor.TypeString, 5);
			registerField("vg_score", "", Descriptor.Int32, 6);
			registerField("vg_total_score", "", Descriptor.Int64, 7);
			registerField("member_count", "", Descriptor.Int32, 8);
			registerField("member_limit", "", Descriptor.Int32, 9);
			registerField("anchor_qq", "", Descriptor.Int64, 10);
			registerField("chief_wealth_level", "", Descriptor.Int32, 11);
			registerField("chief_wealth", "", Descriptor.Int64, 12);
			registerField("anchor_level", "", Descriptor.Int32, 13);
		}
		
		public var vgid:Int64;
		public var chief_zone:String = "";
		public var chief_name:String = "";
		public var anchor_name:String = "";
		public var vg_name:String ="";
		public var vg_score:int;
		public var vg_total_score:Int64;
		public var member_count:int;
		public var member_limit:int;
		public var anchor_qq:Int64;
		public var chief_wealth_level:int;//团长财富等级
		public var chief_wealth:Int64;//团长财富值
		public var anchor_level:int;//主播等级
	}
}
