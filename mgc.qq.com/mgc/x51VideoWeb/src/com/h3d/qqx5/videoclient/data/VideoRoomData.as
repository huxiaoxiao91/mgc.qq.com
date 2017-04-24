package com.h3d.qqx5.videoclient.data
{
	/**
	 * @author liuchui
	 */
	public class VideoRoomData
	{
		public var index:int;	// 下标
		public var module_type:int;	// 模块
		public var status:int;	// 对应RoomStatus
		public var type:int;	// 房间类型，对应枚举VideoRoomType
		public var category:int;	// 房间类型
		public var playerCount:int;//当前玩家人数
		public var time:int; // 已开播时间
		public var giftPoolHeight:int; // 礼物池高度(即热度值)
		public var roomID:int;
		public var anchorID:String = "";//主播ID
		public var activity:int; // 活动房
		public var room_icon_type:int; ///< 房间图标类型
		public var roomName:String = "";
		public var anchorName:String = "";
		public var attched_anchor:String = "";
		public var room_attribute_flag:int;
		public var picInfo:uint;// 每bit表示相册对应位置是否有图片
		public var roomPics:Array = new Array;	// 房间图片url，空串表示对应位置没上传图片
		public var roomLogoUrl:String = "";	//房间列表上那个logo的url
		public var player_capacity:int;
		public var talent_show_rank:int;
		public var star_anchor:Boolean;
		public var pk_anchor_winner_order:int; //优胜主播排名
		public var ticket_room:Boolean;
		public var attached_room_id:int;
		public var attached_room_name:String="";
		public var bSuperRoom:Boolean;
		public var large_anchor_posing_url:String = "";
		public var small_anchor_posing_url:String = "";
		public var anchor_level:int;//主播等级
		public var isNest:Boolean;//是否小窝
		public var is_star_gift_champion:Boolean;
		public var is_anchor_pk_room:Boolean;//是否PK房间
		public var anchor_badge:int;//主播徽章
		public var qgame_anchor_posing_url:String;//QGame摆拍图片地址
		public var room_skin_level:int;
		public var room_skin_id:int;
		public var forbid_public_chat:Boolean;
		public var tag_name:String = "";
		public var week_star_grade:int;//段位
		public var week_star_sub_level:int;//段位下的等级
		public var vertical_live:Boolean;//直播中截图屏幕朝向    1：横屏     2:竖屏
	}	
}