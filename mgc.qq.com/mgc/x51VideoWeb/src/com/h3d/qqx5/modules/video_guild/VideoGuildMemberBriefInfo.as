package com.h3d.qqx5.modules.video_guild
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoGuildMemberBriefInfo extends ProtoBufSerializable
	{
		
		public function VideoGuildMemberBriefInfo()
		{
			registerField("member_id", "", Descriptor.Int64, 1);
			registerField("member_sex", "", Descriptor.Int32, 2);
			registerField("member_vip", "", Descriptor.Int32, 3);
			registerField("position", "", Descriptor.Int32, 4);
			registerField("member_nick", "", Descriptor.TypeString, 5);
			registerField("member_zone", "", Descriptor.TypeString, 6);
			registerField("ctrbt", "", Descriptor.Int32, 7);
			registerField("enter_time", "", Descriptor.Int32, 8);
			registerField("wealth_level", "", Descriptor.Int32, 9);
			registerField("wealth", "", Descriptor.Int32, 10);
		}
		
		public var member_id : Int64 = new Int64();
		public var member_sex : int;
		public var member_vip : int;
		public var position : int;
		public var member_nick : String = "";
		public var member_zone : String = "";
		public var ctrbt : int;
		public var enter_time : int;
		public var wealth_level:int;//玩家财富等级
		public var wealth:int;//财富值
	}
}
