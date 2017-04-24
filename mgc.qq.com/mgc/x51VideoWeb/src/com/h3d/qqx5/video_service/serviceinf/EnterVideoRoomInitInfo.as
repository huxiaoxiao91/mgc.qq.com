package com.h3d.qqx5.video_service.serviceinf {

	import com.h3d.qqx5.common.comdata.RedEnvelopePublicInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.modules.red_envelope.share.RedEnvelopeInfo;
	import com.h3d.qqx5.util.Int64;

	import flash.utils.getQualifiedClassName;

	public class EnterVideoRoomInitInfo extends ProtoBufSerializable {
		public static const VNT_Expired:int                 = -1;
		public static const VNT_None:int                    = 0;

		public function EnterVideoRoomInitInfo() {
			registerField("status", "", Descriptor.Int32, 1);
			registerField("subject", "", Descriptor.Int32, 2);
			registerField("room_name", "", Descriptor.TypeString, 3);
			registerField("audience_count", "", Descriptor.Int32, 4);
			registerField("room_pic_info", "", Descriptor.UInt32, 5);
			registerField("cur_giftpool_height", "", Descriptor.Int32, 6);
			registerField("max_giftpool_height", "", Descriptor.Int32, 7);
			registerField("live_detail", getQualifiedClassName(VideoRoomLiveStatusDetail), Descriptor.Compound, 8);
			registerField("forbid_public_chat", "", Descriptor.TypeBoolean, 9);
			registerField("open_chat_cd_check", "", Descriptor.TypeBoolean, 10);

			registerField("chat_cd_time", "", Descriptor.Int32, 11);
			registerField("player_capacity", "", Descriptor.Int32, 12);
			registerField("vote_info", getQualifiedClassName(VideoVoteInfo), Descriptor.Compound, 13);
			registerFieldForList("vote_selects", "", Descriptor.Int32, 14);
			registerField("vip_level", "", Descriptor.Int32, 15);
			registerField("vip_expire", "", Descriptor.Int32, 16);
			registerField("free_whistle_left", "", Descriptor.Int32, 17);
			registerField("vip_notify", "", Descriptor.Int32, 18);
			registerField("taken_vip_daily_reward_time", "", Descriptor.Int32, 19);
			registerField("talent_show_state", "", Descriptor.Int32, 20);

			registerField("judge_type", "", Descriptor.Int32, 21);
			registerField("talent_show_id", "", Descriptor.Int32, 22);
			registerField("video_guild_id", "", Descriptor.Int64, 23);
			registerField("notify_vg_name", "", Descriptor.TypeString, 24);
			registerField("low_video_uploadspeed", "", Descriptor.Int32, 25);
			registerField("normal_video_uploadspeed", "", Descriptor.Int32, 26);
			registerField("offline_become_member", "", Descriptor.TypeBoolean, 27);
			registerField("activity_type", "", Descriptor.Int32, 28);
			registerField("free_super_star_horn_left", "", Descriptor.Int32, 29);
			registerField("type", "", Descriptor.Int32, 30);

			registerField("public_chat_cd_on_enter", "", Descriptor.Int32, 31);
			registerField("flags", "", Descriptor.Int32, 32);
			registerField("vg_sp_anchor", "", Descriptor.Int64, 33);
			registerFieldForList("anchor_pk_rooms", "", Descriptor.Int32, 34);
			registerField("remain_crowdroom_count", "", Descriptor.Int32, 35);
			registerField("invisible", "", Descriptor.TypeBoolean, 36);
			registerFieldForList("redenvelopes", getQualifiedClassName(RedEnvelopeInfo), Descriptor.Compound, 37); //房间内是否已发出红包
			registerField("taken_vip_weekly_reward_time", "", Descriptor.Int32, 38);
			registerField("is_nest_room", "", Descriptor.TypeBoolean, 39); //是否为小窝房间
			registerField("is_assistant", "", Descriptor.TypeBoolean, 40);

			registerField("attached_room", "", Descriptor.Int32, 41);
			registerField("attached_anchor", "", Descriptor.TypeString, 42);
			registerField("is_concert", "", Descriptor.TypeBoolean, 43);
			registerField("has_concert_ticket", "", Descriptor.TypeBoolean, 44);
			registerField("concert_is_open", "", Descriptor.TypeBoolean, 45);
			registerField("attached_room_name", "", Descriptor.TypeString, 48);
			registerField("is_closed_by_admin", "", Descriptor.TypeBoolean, 49);
			registerField("redenvelope_public", getQualifiedClassName(RedEnvelopePublicInfo), Descriptor.Compound, 50);

			registerField("free_times", "", Descriptor.Int32, 51);
			registerField("seat_price_reset_notice", "", Descriptor.Int32, 52);
			registerField("can_punch_in_room", "", Descriptor.TypeBoolean, 53);
			registerField("room_skin_id", "", Descriptor.Int32, 54);
			registerField("room_skin_level", "", Descriptor.Int32, 55);
			registerField("video_definition", "", Descriptor.Int32, 56);// 视频清晰度
			registerField("free_barrage_left", "", Descriptor.Int32, 57);//免费弹幕数量
			//registerField("room_close_player_count ", "", Descriptor.Int32, 58);// 房间关闭时最后的在线人数
			registerField("edu_flag", "", Descriptor.Int32, 59);//通知玩家教学标记信息
			//xw83733 删除两个字段（页面没有引用）——服务器数据调整删除了这两个字段。
//			registerField("vip_attached_anchor_name", "", Descriptor.TypeString, 56);
//			registerField("vip_attached_anchor_id", "", Descriptor.Int64, 57);
		}

		public var status:int;
		public var subject:int;
		public var room_name:String                         = "";
		public var audience_count:int;
		public var room_pic_info:uint;
		public var cur_giftpool_height:int;
		public var max_giftpool_height:int;
		public var live_detail:VideoRoomLiveStatusDetail    = new VideoRoomLiveStatusDetail;
		public var forbid_public_chat:Boolean;
		public var open_chat_cd_check:Boolean;
		public var chat_cd_time:int;
		public var player_capacity:int;
		public var vote_info:VideoVoteInfo                  = new VideoVoteInfo;
		public var vote_selects:Array                       = new Array;
		public var vip_level:int;
		public var vip_expire:int;
		public var free_whistle_left:int;
		public var vip_notify:int;
		public var taken_vip_daily_reward_time:int;
		public var talent_show_state:int;
		public var judge_type:int;
		public var talent_show_id:int;
		public var video_guild_id:Int64;
		public var notify_vg_name:String                    = "";
		public var low_video_uploadspeed:int;
		public var normal_video_uploadspeed:int;
		public var offline_become_member:Boolean;
		/**
		 * 房间活动类型
		 * -1:null
		 *  0:全民选秀
		 *  1:舞团联盟争霸
		 *  2:年度盛典活动
		 */
		public var activity_type:int;
		public var free_super_star_horn_left:int;
		public var type:int;
		public var public_chat_cd_on_enter:int;
		public var flags:int;
		public var vg_sp_anchor:Int64;
		public var anchor_pk_rooms:Array                    = new Array;
		public var remain_crowdroom_count:int;
		public var invisible:Boolean;
		public var redenvelopes:Array                       = new Array;
		public var taken_vip_weekly_reward_time:int;
		public var is_nest_room:Boolean;
		public var is_assistant:Boolean;
		public var attached_room:int;
		public var attached_room_name:String                = "";
		public var attached_anchor:String                   = "";
		public var is_concert:Boolean;
		public var has_concert_ticket:Boolean;
		public var concert_is_open:Boolean;
		public var is_closed_by_admin:Boolean;
		public var redenvelope_public:RedEnvelopePublicInfo = new RedEnvelopePublicInfo();
		public var free_times:int;
		public var seat_price_reset_notice:int;

		/**
		 * 红点
		 */
		public var can_punch_in_room:Boolean;

		public var room_skin_id:int;

		public var room_skin_level:int;

		/**
		 * 贵族绑定的主播名
		 */
//		public var vip_attached_anchor_name:String          = "";
		/**
		 * 贵族绑定的主播id
		 */
//		public var vip_attached_anchor_id:Int64             = new Int64();
		
		public var video_definition:int;
		public var free_barrage_left:int;
		public var room_close_player_count:int;
		public var edu_flag:int;
	}
}
