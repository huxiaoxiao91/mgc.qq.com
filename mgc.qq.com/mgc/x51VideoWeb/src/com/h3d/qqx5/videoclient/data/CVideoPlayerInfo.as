package com.h3d.qqx5.videoclient.data {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class CVideoPlayerInfo extends INetMessage {
		public function CVideoPlayerInfo() {
			registerField("pstid", "", Descriptor.Int64, 1);
			registerField("nick", "", Descriptor.TypeString, 2);
			registerField("signature", "", Descriptor.TypeString, 3);
			registerField("photo_url", "", Descriptor.TypeString, 4);
			registerField("sex_male", "", Descriptor.Int32, 5);
			registerField("video_wealth", "", Descriptor.Int64, 6);
			registerField("video_money_balance", "", Descriptor.Int64, 7);
			registerField("free_gift_count", "", Descriptor.Int32, 8);
			registerField("daily_free_whistle_count", "", Descriptor.Int32, 9);
			registerField("vip_level", "", Descriptor.Int32, 10);

			registerField("vip_remaining_time", "", Descriptor.Int32, 11);
			registerField("block_public_chat", "", Descriptor.TypeBoolean, 12);
			registerField("invisible", "", Descriptor.TypeBoolean, 13); //隐身
			registerField("zone_name", "", Descriptor.TypeString, 14);
			registerField("video_dream_money", "", Descriptor.Int32, 15);
			registerField("video_level", "", Descriptor.Int32, 16);
			registerField("zone_id", "", Descriptor.Int32, 17); //大区id
			registerField("video_exp", "", Descriptor.Int32, 18); //当前等级经验
			registerField("video_levelup_exp", "", Descriptor.Int32, 19); //升级所需经验
			registerFieldForList("followinfo_vec", getQualifiedClassName(CFollowedAnchorInfoForHomePage), Descriptor.Compound, 20);

			registerField("m_player_url", "", Descriptor.TypeString, 21);
			registerField("wealth_level", "", Descriptor.Int32, 22);
			registerField("wealth_exp", "", Descriptor.Int32, 23);
			registerField("wealth_levelup_exp", "", Descriptor.Int32, 24);
			registerField("vip_attached_anchor_name", "", Descriptor.TypeString, 25);
			registerField("vip_attached_anchor_id", "", Descriptor.Int64, 26);
			registerField("tips_notice", "", Descriptor.TypeBoolean, 27);
			registerField("is_show_week_star_url","",Descriptor.TypeBoolean, 28);
		}

		public var pstid:Int64                     = new Int64();
		public var nick:String                     = "";
		public var signature:String                = "";
		public var photo_url:String                = "";
		public var sex_male:int;
		public var video_wealth:Int64              = new Int64();
		public var video_money_balance:Int64       = new Int64();
		public var free_gift_count:int;
		public var daily_free_whistle_count:int;
		public var vip_level:int;

		public var vip_remaining_time:int;
		public var block_public_chat:Boolean;
		public var invisible:Boolean;
		public var zone_name:String                = "";
		public var video_dream_money:int;
		public var video_level:int;
		public var zone_id:int;
		public var video_exp:int;
		public var video_levelup_exp:int;
		public var followinfo_vec:Array            = new Array(); //std::vector<>,

		public var m_player_url:String             = "";
		public var wealth_level:int; //玩家财富等级
		public var wealth_exp:int; //玩家财富经验
		public var wealth_levelup_exp:int; //玩家达到下一级财富等级所需要的经验值
		/**
		 * 25-绑定的主播名
		 */
		public var vip_attached_anchor_name:String = "";
		/**
		 * 26-绑定的主播ID
		 */
		public var vip_attached_anchor_id:Int64    = new Int64();
		/**
		 * 27-任务引导是否提示过
		 * XW81897 是否完成新任务引导
		 */
		public var tips_notice:Boolean;
		public var is_show_week_star_url:Boolean;


		public function IsInvisible():Boolean {
			return invisible;
		}

		public function SetInvisible(_invisible:Boolean):void {
			invisible = _invisible;
		}
	}
}
