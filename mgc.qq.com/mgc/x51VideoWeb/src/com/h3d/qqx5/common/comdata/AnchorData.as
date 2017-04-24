package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class AnchorData extends ProtoBufSerializable
	{

		public function AnchorData()
		{
			registerField("pstid", "", Descriptor.Int64, 1);
			registerField("level", "", Descriptor.Int32, 2);
			registerField("starlight", "", Descriptor.Int32, 3);
			registerField("popularity", "", Descriptor.Int32, 4);
			registerField("followed", "", Descriptor.Int32, 5);
			registerField("version", "", Descriptor.Int32, 6);
			registerField("pop_last_update", "", Descriptor.Int32, 7);
			registerField("open_surprise_box_times", "", Descriptor.Int32, 8);
			registerField("daily_operation_time", "", Descriptor.Int32, 9);
			registerFieldForDict("guard_count", "",Descriptor.Int32,"", Descriptor.Int32, 10);
			registerField("talent_show_starlight", "", Descriptor.Int32, 11);
			registerField("talent_show_vote_cnt", "", Descriptor.Int32, 12);
			registerField("talent_show_score", "", Descriptor.Int32, 13);
			registerField("talent_show_activity_id", "", Descriptor.Int32, 14);
			registerField("month_system_welfare", "", Descriptor.Int32, 15);
			registerField("month_system_welfare_time", "", Descriptor.Int32, 16);
			registerField("anchor_score", "", Descriptor.Int32, 17);
			registerField("anchor_score_last_update", "", Descriptor.Int32, 18);
			registerField("guild_champion_honor", "", Descriptor.Int64, 19);
			registerField("starlight_today", "", Descriptor.Int32, 20);
			registerField("starlight_today_last_update", "", Descriptor.Int32, 21);
			registerField("first_live_time", "", Descriptor.Int32, 22);
			registerField("twoweek_starlight", "", Descriptor.Int32, 23);
			registerField("twoweek_starlight_last_update", "", Descriptor.Int32, 24);
			registerFieldForDict("impressions",  "",Descriptor.Int32,"", Descriptor.Int32, 25);
			registerField("impression_count", "", Descriptor.Int32, 26);
			registerField("nest_open_surprise_box_times", "", Descriptor.Int32, 27);
			
			registerField("last_divert_concert_id", "", Descriptor.Int32, 28);
			registerField("anchor_posing_large_sec_url", "", Descriptor.TypeString, 29);
			registerField("anchor_posing_small_sec_url", "", Descriptor.TypeString, 30);
			registerField("is_apply_anchor_posing", "", Descriptor.Int32, 31);
			registerField("stScore_data", getQualifiedClassName(Score_data), Descriptor.Compound, 32);
			registerField("stStarlight_data", getQualifiedClassName(Starlight_data), Descriptor.Compound, 33);
			registerField("recommend_score", "", Descriptor.Int32, 34);
			registerField("take_rcmd_score_time", "", Descriptor.Int32, 35);
			registerField("exp", "", Descriptor.Int32, 36);
			registerField("stGrowth_data", getQualifiedClassName(Growth_data), Descriptor.Compound, 37);
			registerField("taken_first_live_score", "", Descriptor.TypeBoolean, 38);
			
//			registerField("star_gift", getQualifiedClassName(StarGiftInfo), Descriptor.Compound, 39);
//			registerField("anchor_badge", "", Descriptor.Int32, 41);
//			registerField("anchor_posing_qgame_sec_url", "", Descriptor.TypeString, 42);
//			registerField("rcmd_score_last_clear_time", "", Descriptor.Int32, 43);
			
			registerField("anchor_portrait_url", "", Descriptor.TypeString, 46);
		}
		
		public var pstid:Int64;
		public var level:int;
		public var starlight:int;
		public var popularity:int;
		public var followed:int;
		public var version:int;
		public var pop_last_update:int;
		public var open_surprise_box_times:int;
		public var daily_operation_time:int;
		public var guard_count:Dictionary;
		public var talent_show_starlight:int;
		public var talent_show_vote_cnt:int;
		public var talent_show_score:int;
		public var talent_show_activity_id:int;
		public var month_system_welfare:int;
		public var month_system_welfare_time:int;
		public var anchor_score:int;
		public var anchor_score_last_update:int;
		public var guild_champion_honor:Int64;
		public var starlight_today:int;
		public var starlight_today_last_update:int;
		public var first_live_time:int;
		public var twoweek_starlight:int;
		public var twoweek_starlight_last_update:int;
		public var impressions:Dictionary = new Dictionary();
		public var impression_count:int;
		public var nest_open_surprise_box_times:int;

		public var last_divert_concert_id:int; //上次分流的演唱会id
		public var anchor_posing_large_sec_url:String = "";//主播摆拍加密url，大图片
		public var anchor_posing_small_sec_url:String = "";//主播摆拍加密url，小图片
		public var is_apply_anchor_posing:int;//是否使用主播摆拍作为房间列表截图
		public var stScore_data:Score_data;//记录周日维度积分
		public var stStarlight_data:Starlight_data;//记录星耀值
		public var recommend_score:int;//推荐积分
		public var take_rcmd_score_time:int;//领取每周推荐积分的时间
		public var exp:int;//主播经验值
		public var stGrowth_data:Growth_data;//主播成长相关数据
		public var taken_first_live_score:Boolean; //主播是否首次直播奖励积分

//		public var star_gift:StarGiftInfo;
//		public var anchor_badge:int;
//		public var anchor_posing_qgame_sec_url:String = "";
//		public var rcmd_score_last_clear_time:int;

		/**
		 * 主播头像
		 */
		public var anchor_portrait_url:String = "";
	}
}
