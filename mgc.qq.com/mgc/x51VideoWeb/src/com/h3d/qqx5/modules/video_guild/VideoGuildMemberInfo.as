package com.h3d.qqx5.modules.video_guild
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoGuildMemberInfo extends ProtoBufSerializable
	{
		public function VideoGuildMemberInfo()
		{
			registerField("member_id", "", Descriptor.Int64, 1);
			registerField("member_sex", "", Descriptor.Int32, 2);
			registerField("member_vip", "", Descriptor.Int32, 3);
			registerField("position", "", Descriptor.Int32, 4);
			registerField("member_nick", "", Descriptor.TypeString, 5);
			registerField("member_zone", "", Descriptor.TypeString, 6);
			registerField("ctrbt", "", Descriptor.Int32, 7);
			registerField("member_score", "", Descriptor.Int32, 8);
			registerField("enter_time", "", Descriptor.Int32, 9);
			registerField("last_sign_in_time", "", Descriptor.Int32, 10);
			registerField("vg_id", "", Descriptor.Int64, 11);
			registerField("member_qq", "", Descriptor.Int64, 12);
			registerField("wealth_level", "", Descriptor.Int32, 13);
		}
		
		public var member_id : Int64 = new Int64();
		public var member_sex : int;
		public var member_vip : int;
		public var position : int;
		public var member_nick : String = "";
		public var member_zone : String = "";
		public var ctrbt : int;
		public var member_score : int;
		public var enter_time : int;
		public var last_sign_in_time : int;
		public var vg_id : Int64 = new Int64();
		public var member_qq : Int64 = new Int64();
		public var wealth_level:int;//玩家财富等级
	}
}
