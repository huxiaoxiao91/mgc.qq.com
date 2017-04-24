package com.h3d.qqx5.common.comdata {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_rank_server.shared.AnchorWeekStarMatchInfo;
	import com.h3d.qqx5.videoclient.data.AnchorBadge;
	import com.h3d.qqx5.videoclient.data.AnchorPlayerAffinityStatstics;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class AnchorCard extends ProtoBufSerializable {
		public function AnchorCard() {
			registerField("pstid", "", Descriptor.Int64, 1);
			registerField("account_type", "", Descriptor.Int32, 2);
			registerField("sex", "", Descriptor.Int32, 3);
			registerField("nick", "", Descriptor.TypeString, 4);
			registerField("place", "", Descriptor.TypeString, 5);
			registerField("intro", "", Descriptor.TypeString, 6);
			registerField("popularity", "", Descriptor.Int32, 7);
			registerField("starlight", "", Descriptor.Int32, 8);
			registerFieldForList("followers", getQualifiedClassName(AnchorFollower), Descriptor.Compound, 9);
			registerField("followed", "", Descriptor.Int32, 10);

			registerFieldForDict("guard_count", "", Descriptor.Int32, "", Descriptor.Int32, 11);
			registerField("total_affinity", "", Descriptor.Int32, 12);
			registerField("super_guard_level", "", Descriptor.Int32, 13);
			registerField("talent_show_rank", "", Descriptor.Int32, 14);
			registerFieldForList("card_video_guilds", getQualifiedClassName(AnchorCardVideoGuildInfo), Descriptor.Compound, 15);
			registerField("vg_count", "", Descriptor.Int32, 16);
			registerField("star_anchor", "", Descriptor.TypeBoolean, 17);
			registerField("anchor_score", "", Descriptor.Int32, 18);
			registerField("attached_player_pstid", "", Descriptor.Int64, 19);
			registerField("pk_anchor_winner_order", "", Descriptor.Int32, 20);

			registerField("annual2014_title", "", Descriptor.Int32, 21);
			registerField("nest_id", "", Descriptor.Int32, 22);
			registerField("m_anchor_url", "", Descriptor.TypeString, 23);
			registerField("is_with_dance_mark", "", Descriptor.TypeBoolean, 24);
			registerField("is_anchor_pk_anchor", "", Descriptor.TypeBoolean, 25);
			registerField("affinity_statistics_ver", "", Descriptor.Int32, 26);
			registerField("affinity_statistics", getQualifiedClassName(AnchorPlayerAffinityStatstics), Descriptor.Compound, 27);
			registerField("anchor_level", "", Descriptor.Int32, 28);
			registerField("anchor_exp", "", Descriptor.Int32, 29);
			registerField("anchor_levelup_exp", "", Descriptor.Int32, 30);

			registerField("is_bottleneck", "", Descriptor.TypeBoolean, 31);
			registerField("bottleneck_count", "", Descriptor.Int32, 32);
			registerField("bottleneck_need_count", "", Descriptor.Int32, 33);
			registerField("bottleneck_gift_id", "", Descriptor.Int32, 34);
			registerField("buff_percent", "", Descriptor.Int32, 35);
			registerField("dream_gift_rest_exp_today", "", Descriptor.Int32, 36); //
			registerField("starlight_rest_exp_today", "", Descriptor.Int32, 37); //今日通过涨星耀值还可增加的主播经验值
			registerFieldForList("anchor_badge_vec", getQualifiedClassName(AnchorBadge), Descriptor.Compound, 38); //主播徽章
			registerField("nest_skin_info", getQualifiedClassName(AnchorNestSkinInfo), Descriptor.Compound, 39); //小窝房间皮肤信息
			registerField("anchor_live_status", "", Descriptor.Int32, 40); //主播直播状态
			
			registerField("is_vip_attached_anchor", "", Descriptor.TypeBoolean, 41); //是否是贵族绑定主播
			registerField("anchor_posing_large_url", "", Descriptor.Int32, 42); // 主播截图
			registerField("week_star_match_info", getQualifiedClassName(AnchorWeekStarMatchInfo), Descriptor.Compound, 43); // 周星赛数据
		}

		public var pstid:Int64                                       = new Int64();
		public var account_type:int;
		public var sex:int;
		public var nick:String                                       = "";
		public var place:String                                      = "";
		public var intro:String                                      = "";
		public var popularity:int;
		public var starlight:int;
		public var followers:Array                                   = new Array;
		public var followed:int;
		public var guard_count:Dictionary                            = new Dictionary;
		public var total_affinity:int;
		public var super_guard_level:int;
		public var talent_show_rank:int;
		public var card_video_guilds:Array                           = new Array;
		public var vg_count:int;
		public var star_anchor:Boolean;
		public var anchor_score:int;
		public var attached_player_pstid:Int64                       = new Int64();
		public var pk_anchor_winner_order:int;
		public var annual2014_title:int;
		public var nest_id:int;
		public var m_anchor_url:String                               = "";
		public var is_with_dance_mark:Boolean; // 是否有“舞”字标识
		public var is_anchor_pk_anchor:Boolean; //// 是否为主播pk主播
		public var affinity_statistics_ver:int                       = 0;
		public var affinity_statistics:AnchorPlayerAffinityStatstics = new AnchorPlayerAffinityStatstics();
		public var anchor_level:int; //主播等级
		public var anchor_exp:int; //主播经验值
		public var anchor_levelup_exp:int; //主播升级所需经验
		public var is_bottleneck:Boolean; //是否是瓶颈期
		public var bottleneck_count:int; //已送数量
		public var bottleneck_need_count:int; //突破需要的礼物数量
		public var bottleneck_gift_id:int; //突破评价需要的礼物id
		public var buff_percent:int;
		//今日收梦幻币礼物还可增加的主播经验值
		public var dream_gift_rest_exp_today:int;
		//今日通过涨星耀值还可增加的主播经验值
		public var starlight_rest_exp_today:int;
		public var anchor_badge_vec:Array                            = new Array();
		public var nest_skin_info:AnchorNestSkinInfo                 = new AnchorNestSkinInfo();
		public var anchor_live_status:int;
		public var is_vip_attached_anchor:Boolean;
		public var anchor_posing_large_url:int;
		public var week_star_match_info:AnchorWeekStarMatchInfo		 = new AnchorWeekStarMatchInfo();
	}
}
