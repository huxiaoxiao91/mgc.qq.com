package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.SplitScreenInfo;
	import com.h3d.qqx5.videoclient.data.VideoResolution;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class VideoRoomLiveStatusDetail extends ProtoBufSerializable
	{
		public function VideoRoomLiveStatusDetail()
		{
			registerField("vid", "", Descriptor.Int32, 1);
			registerField("anchor_pstid", "", Descriptor.Int64, 2);
			registerField("start_time", "", Descriptor.Int32, 3);
			registerField("sex", "", Descriptor.Int32, 4);
			registerField("name", "", Descriptor.TypeString, 5);
			registerField("description", "", Descriptor.TypeString, 6);
			registerField("popularity", "", Descriptor.Int32, 7);
			registerField("startlight", "", Descriptor.Int32, 8);
			registerField("place", "", Descriptor.TypeString, 9);
			registerField("followed", "", Descriptor.Int32, 10);
			registerField("deputy_anchor_name", "", Descriptor.TypeString, 11);
			registerField("deputy_anchor_zone_name", "", Descriptor.TypeString, 12);
			registerField("deputy_anchor_id", "", Descriptor.Int64, 13);
			registerField("talent_show_rank", "", Descriptor.Int32, 14);
			registerField("star_anchor", "", Descriptor.TypeBoolean, 15);
			registerField("pk_winner_order", "", Descriptor.Int32, 16);
			registerField("vid2", "", Descriptor.Int32, 17);
			registerField("starlight_needed", "", Descriptor.Int32, 18);
			registerField("impression", getQualifiedClassName(AnchorImpressionDataServer), Descriptor.Compound, 19);
			registerField("twoweek_starlight", "", Descriptor.Int32, 20);
			registerField("anchor_type", "", Descriptor.Int32, 21);
			registerField("level", "", Descriptor.Int32, 22);
			registerField("server_id", "", Descriptor.Int32, 23);
			registerFieldForDict("extra_vid", "", Descriptor.Int32, "", Descriptor.Int32, 24);
			registerField("m_anchor_url", "", Descriptor.TypeString, 25);
			registerField("split_screen_info", getQualifiedClassName(SplitScreenInfo), Descriptor.Compound, 28);
			registerField("is_anchor_pk_anchor", "", Descriptor.TypeBoolean, 29);
			registerField("anchor_level", "", Descriptor.Int32, 30);
			registerField("anchor_exp", "", Descriptor.Int32, 31);
			registerField("anchor_levelup_exp", "", Descriptor.Int32, 32);
			registerField("is_bottleneck", "", Descriptor.TypeBoolean, 33);
			registerField("bottleneck_count", "", Descriptor.Int32, 34);
			registerField("bottleneck_need_count", "", Descriptor.Int32, 35);
			registerField("bottleneck_gift_id", "", Descriptor.Int32, 36);
			registerField("buff_percent", "", Descriptor.Int32, 37);
			registerField("starlight_rest_exp_today", "", Descriptor.Int32, 38);
			registerField("dream_gift_rest_exp_today", "", Descriptor.Int32, 39);
			registerField("anchor_badge", "", Descriptor.Int32, 40);
			registerField("lucky_draw_rest_exp_tody", "", Descriptor.Int32, 41);
			registerFieldForDict("vid_resolutions", "", Descriptor.Int32, getQualifiedClassName(VideoResolution), Descriptor.Compound, 42);
			registerField("fps", "", Descriptor.Int32, 43);
			registerField("anchor_device_type", "", Descriptor.Int32, 44);
			registerField("is_vertical_live", "", Descriptor.TypeBoolean, 45);
		}
		
		public var vid : int;
		public var anchor_pstid : Int64 = new Int64();
		public var start_time : int;
		public var sex : int;
		public var name : String ="";
		public var description : String = "";
		public var popularity : int;
		public var startlight : int;
		public var place : String ="";
		public var followed : int;//粉丝数量
		public var deputy_anchor_name : String ="";
		public var deputy_anchor_zone_name : String ="";
		public var deputy_anchor_id : Int64 = new Int64;
		public var talent_show_rank : int;
		public var star_anchor : Boolean;
		public var pk_winner_order : int;
		public var vid2:int;
		public var starlight_needed : int;
		public var impression : AnchorImpressionDataServer = new AnchorImpressionDataServer;
		public var twoweek_starlight : int;
		public var anchor_type:int;
		public var level:int;
		public var server_id:int;
		public var extra_vid:Dictionary = new Dictionary;
		public var m_anchor_url:String = "";
		public var split_screen_info:SplitScreenInfo = new SplitScreenInfo();		
		public var is_anchor_pk_anchor:Boolean;
		public var anchor_level:int;//主播等级
		public var anchor_exp:int;//主播经验
		public var anchor_levelup_exp:int;//主播升级所需经验
		public var is_bottleneck:Boolean;//是否是瓶颈期
		public var bottleneck_count:int;//已送数量
		public var bottleneck_need_count:int;//突破需要的礼物数量
		public var bottleneck_gift_id:int;//突破评价需要的礼物id
		public var buff_percent:int;//主播经验提供的增益
		public var starlight_rest_exp_today:int;//通过涨星耀值还可增加的主播经验
		public var dream_gift_rest_exp_today:int;//收梦幻币礼物还可增加的主播经验
		public var anchor_badge:int;
		/**
		 * 41 今日抽奖还可增加的主播经验值
		 */
		public var lucky_draw_rest_exp_tody:int;
		
		public var vid_resolutions:Dictionary;
		public var fps:int;
		/**
		 *  主播端类型
		 *  CDT_INVALID = -1,
		 *  CDT_PC = 0,
		 *  CDT_Android,
		 *	CDT_WEB,
		 *	CDT_SDK,
		 *	CDT_QGAME,
		 *	CDT_IFRAME,
		 *	CDT_X52,
		 *	CDT_IOS
		 */
		public var anchor_device_type:int = -1;
		//主播选择横屏还是竖屏
		public var is_vertical_live : Boolean = false;
	}
}
