package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.comdata.AnchorData;
	import com.h3d.qqx5.common.comdata.VideoGuardSeatInfo;
	import com.h3d.qqx5.common.comdata.VipSeatInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.common.event.roomskin.CEventRoomSkinDailyTaskInfo;
	import com.h3d.qqx5.common.event.roomskin.CEventRoomSkinLevelUpTaskInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomPlayerInfo;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomSyncInfo;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * 房间基础信息
	 * @author gaolei
	 *
	 */
	public class CEventVideoRoomBasicInfos extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomBasicInfos;
		}

		public function CEventVideoRoomBasicInfos() {
			super();

			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("anchor_data", getQualifiedClassName(AnchorData), Descriptor.Compound, 2);
			registerField("wealth_req", "", Descriptor.Int32, 3);
			registerFieldForList("guard_seats", getQualifiedClassName(VideoGuardSeatInfo), Descriptor.Compound, 4);
			registerFieldForList("vip_seats", getQualifiedClassName(VipSeatInfo), Descriptor.Compound, 5);
			registerFieldForList("super_funs", getQualifiedClassName(VideoRoomPlayerInfo), Descriptor.Compound, 6);
			registerFieldForList("rooms", getQualifiedClassName(VideoRoomSyncInfo), Descriptor.Compound, 7);
			registerField("online_player_count", "", Descriptor.Int32, 8);
			registerField("anchor_nick", "", Descriptor.TypeString, 9);
			registerField("levelup_need_exp", "", Descriptor.Int32, 10);
			registerField("bottle_neck_gift_id", "", Descriptor.Int32, 11);
			registerField("bottle_neck_need_count", "", Descriptor.Int32, 12);
			registerField("anchor_badge", "", Descriptor.Int32, 13);
			registerField("anchor_intro", "", Descriptor.TypeString, 14);
			registerField("room_name", "", Descriptor.TypeString, 15);
			registerField("room_capacity", "", Descriptor.Int32, 16);
			registerField("skin_level_up_task_info", getQualifiedClassName(CEventRoomSkinLevelUpTaskInfo), Descriptor.Compound, 17);
			registerField("skin_daily_task_info", getQualifiedClassName(CEventRoomSkinDailyTaskInfo), Descriptor.Compound, 18);
			
			registerFieldForDict("seat_protect_time", "", Descriptor.Int32, "", Descriptor.Int32, 19);
		}

		/**
		 * 房间id
		 */
		public var room_id:int;
		/**
		 * 当前主播信息
		 */
		public var anchor_data:AnchorData = new AnchorData();
		/**
		 *
		 */
		public var wealth_req:int;
		/**
		 * 守护宝座信息
		 */
		public var guard_seats:Array      = new Array;
		/**
		 * vip宝座信息
		 */
		public var vip_seats:Array        = new Array();
		/**
		 * 超级粉丝
		 */
		public var super_funs:Array       = new Array();
		/**
		 * 热门推荐
		 */
		public var rooms:Array            = [];
		public var online_player_count:int;

		public var anchor_nick:String     = "";

		public var levelup_need_exp:int;

		public var bottle_neck_gift_id:int;

		public var bottle_neck_need_count:int;

		public var anchor_badge:int;

		public var anchor_intro:String;

		public var room_name:String       = "";

		public var room_capacity:int;

		public var skin_level_up_task_info:CEventRoomSkinLevelUpTaskInfo;

		public var skin_daily_task_info:CEventRoomSkinDailyTaskInfo;

		public var seat_protect_time:Dictionary = new Dictionary();
	}
}
