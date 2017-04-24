package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.LoveNestInfo;
	
	import flash.utils.getQualifiedClassName;
	
	public class VideoVipPlayerCardInfo extends ProtoBufSerializable
	{
		public function VideoVipPlayerCardInfo()
		{
			registerField("zone_id", "", Descriptor.Int32, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("wealth", "", Descriptor.Int64, 3);
			registerField("signature", "", Descriptor.TypeString, 4);
			registerField("vip_level", "", Descriptor.Int32, 5);
			registerField("portrait_url", "", Descriptor.TypeString, 6);
			registerFieldForList("followed_anchors", getQualifiedClassName(FollowAnchorAffinityInfo), Descriptor.Compound, 7);
			registerField("player_sex", "", Descriptor.Int32, 8);
			registerField("player_name", "", Descriptor.TypeString, 9);
			registerField("zone_name", "", Descriptor.TypeString, 10);
			registerField("vg_name", "", Descriptor.TypeString, 11);
			registerField("vgid", "", Descriptor.Int64, 12);
			registerField("pk_richman_order", "", Descriptor.Int32, 13);
			registerFieldForList("love_nest_info_vec", getQualifiedClassName(LoveNestInfo), Descriptor.Compound, 14);
			registerField("vip_remaining_time", "", Descriptor.Int32, 15);
			registerField("level", "", Descriptor.Int32, 16);
			registerField("exp", "", Descriptor.Int32, 17);
			registerField("levelup_exp", "", Descriptor.Int32, 18);
			registerField("video_money", "", Descriptor.Int32, 19);
			registerField("has_taken_wage_today", "", Descriptor.TypeBoolean, 20);
			registerField("m_player_url", "", Descriptor.TypeString, 21);
			registerField("wealth_level", "", Descriptor.Int32, 22);
			registerField("wealth_exp", "", Descriptor.Int32, 23);
			registerField("wealth_levelup_exp", "", Descriptor.Int32, 24);
		}
		
		public var zone_id :int;
		public var player_id : Int64 = new Int64();
		public var wealth : Int64 = new Int64();
		public var signature : String ="";
		public var vip_level : int;
		public var portrait_url : String ="";
		public var followed_anchors:Array = new Array;
		public var player_sex : int;
		public var player_name : String ="";
		public var zone_name : String = "";
		public var vg_name : String ="";
		public var vgid : Int64 = new Int64();
		public var pk_richman_order : int;
		public var love_nest_info_vec:Array = new Array;
		public var vip_remaining_time:int;
		public var level:int;
		public var exp:int;
		public var levelup_exp:int;
		public var video_money:int;
		public var has_taken_wage_today:Boolean;
		public var m_player_url:String = "";
		public var wealth_level:int;//财富等级
		public var wealth_exp:int;//财富经验
		public var wealth_levelup_exp:int;//升下一级所需要的
	}
}
