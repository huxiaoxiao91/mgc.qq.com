package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.PublicAnchorTaskRes;
	
	import flash.utils.Dictionary;
	
	public class VideoRoomSyncInfo extends ProtoBufSerializable
	{
	  public function VideoRoomSyncInfo()
	  {
	    registerField("id", "", Descriptor.Int32, 1);
	    registerField("type", "", Descriptor.Int32, 2);
	    registerField("subject", "", Descriptor.Int32, 3);
	    registerField("server_id", "", Descriptor.Int32, 4);
	    registerField("online", "", Descriptor.TypeBoolean, 5);
	    registerField("last_visit_time", "", Descriptor.Int64, 6);//unsigned long long
	    registerField("room_name", "", Descriptor.TypeString, 7);
	    registerField("room_desc", "", Descriptor.TypeString, 8);
	    registerField("player_num", "", Descriptor.Int32, 9);
	    registerField("state", "", Descriptor.Int32, 10);
	    registerField("vid", "", Descriptor.Int32, 11);
	    registerField("live_start_time", "", Descriptor.Int32, 12);
	    registerField("anchor_pstid", "", Descriptor.Int64, 13);
	    registerField("anchor_name", "", Descriptor.TypeString, 14);
	    registerField("gift_pool_height", "", Descriptor.Int32, 15);
	    registerField("room_attribute_flag", "", Descriptor.Int32, 16);
	    registerField("player_capcity", "", Descriptor.Int32, 17);
	    registerField("audience_num", "", Descriptor.Int32, 18);
	    registerField("audience_capcity", "", Descriptor.Int32, 19);
	    registerField("room_pic_info", "", Descriptor.Int32, 20);
	    registerField("current_popularity", "", Descriptor.Int32, 21);
	    registerField("talent_show_rank", "", Descriptor.Int32, 22);
	    registerField("star_anchor", "", Descriptor.Int32, 23);
	    registerField("anchor_score", "", Descriptor.Int32, 24);
	    registerField("pk_anchor_winner_order", "", Descriptor.Int32, 25);
	    registerField("ticket_room", "", Descriptor.TypeBoolean, 26);
	    registerField("is_closed", "", Descriptor.TypeBoolean, 27);
	    registerField("anchor_follower_num", "", Descriptor.Int32, 28);
	    registerField("anchor_first_live_time", "", Descriptor.Int32, 29);
	    registerField("is_nest", "", Descriptor.TypeBoolean, 30);
		registerField("attached_room_id", "", Descriptor.Int32, 31);
	    registerField("create_time", "", Descriptor.Int32, 32);
		registerFieldForDict("server_ids", "", Descriptor.Int32,"",Descriptor.Int64, 33);//unsigned long long
		registerFieldForDict("load_data", "", Descriptor.Int32,"",Descriptor.Int32, 34);
		registerField("robot_num", "", Descriptor.Int32, 35);
		registerField("is_ceremony", "", Descriptor.TypeBoolean, 36);
		registerField("robot_state", "", Descriptor.TypeBoolean, 37);
		registerFieldForList("online_server_ids", "", Descriptor.Int32, 38);
		registerField("is_union_room", "", Descriptor.TypeBoolean, 39);
		registerField("large_anchor_posing_url", "", Descriptor.TypeString, 40);//摆拍大图
		registerField("small_anchor_posing_url", "", Descriptor.TypeString, 41);//摆拍小图
		registerField("anchor_sex", "", Descriptor.Int32, 42);
		registerField("is_anchor_pk_room", "", Descriptor.TypeBoolean, 43);
		registerFieldForList("nominate_nests", "", Descriptor.Int32, 44);
		registerField("is_special_room", "", Descriptor.TypeBoolean, 45);
		registerField("last_stop_live_time", "", Descriptor.Int32, 46);
		registerField("nest_owner", "", Descriptor.Int64, 47);
		registerField("nest_status", "", Descriptor.Int32, 48);
		registerField("anchor_level", "", Descriptor.Int32, 49);
		registerField("is_star_gift_champion", "", Descriptor.TypeBoolean, 50);
		registerField("anchor_badge", "", Descriptor.Int32, 51);	// 主播徽章
		registerField("tag_id", "", Descriptor.Int32, 52);	
		registerField("qgame_anchor_posing_url","",Descriptor.TypeString,53);//QGame摆拍图片地址
		registerField("room_skin_level", "", Descriptor.Int32, 54);	
		registerField("room_skin_id", "", Descriptor.Int32, 55);	
		registerField("definition","",Descriptor.Int32,56);//房间直播清晰度，未开播无效
		registerField("is_test_room","",Descriptor.TypeBoolean,57);//是否是测试房间
		registerField("week_star_grade","",Descriptor.Int32,58);//段位
		registerField("week_star_sub_level","",Descriptor.Int32,59);//段位等级
	  }

	  public var id : int;
	  public var type : int;
	  public var subject : int;
	  public var server_id : int;
	  public var online : Boolean;
	  public var last_visit_time : Int64;
	  public var room_name : String = "";
	  public var room_desc : String = "";
	  public var player_num : int;
	  public var state : int;
	  public var vid : int;
	  public var live_start_time : int;
	  public var anchor_pstid : Int64;
	  public var anchor_name : String = "";
	  public var gift_pool_height : int;
	  public var room_attribute_flag : int;
	  public var player_capcity : int;
	  public var audience_num : int;
	  public var audience_capcity : int;
	  public var room_pic_info : int;
	  public var current_popularity : int;
	  public var talent_show_rank : int;
	  public var star_anchor : int;
	  public var anchor_score : int;
	  public var pk_anchor_winner_order : int;
	  public var ticket_room : Boolean;
	  public var is_closed : Boolean;
	  public var anchor_follower_num : int;
	  public var anchor_first_live_time : int;
	  public var is_nest : Boolean;
	  public var attached_room_id : int;
	  public var create_time:int;
	  public var server_ids:Dictionary = new Dictionary;
	  public var load_data:Dictionary = new Dictionary;
	  public var robot_num:int;
	  public var is_ceremony:Boolean;
	  public var robot_state:Boolean;
	  public var online_server_ids:Array;
	  public var is_union_room : Boolean;
	  
	  public var large_anchor_posing_url : String = "";
	  public var small_anchor_posing_url : String = "";
	  public var anchor_sex:int;//主播性别 0女1男
	  public var is_anchor_pk_room:Boolean;//是否主播pk房间	  
	  public var nominate_nests:Array;//旗下主播列表值
	  public var is_special_room:Boolean;//是否官方活动房间
	  public var last_stop_live_time:int;
	  public var nest_owner:Int64 = new Int64();//小窝主人qq，这个用来拼摆拍图片（个人直播间，主播未正在直播）
	  public var nest_status:int;//小窝的冻结状态
	  public var anchor_level:int;//主播等级
	  public var is_star_gift_champion:Boolean;
	  public var anchor_badge:int;
	  public var tag_id:int;
	  public var qgame_anchor_posing_url:String = "";
	  
	  public var room_skin_level:int;
	  public var room_skin_id:int;
	  
	  public var definition:int;
	  public var is_test_room:Boolean;
	  public var week_star_grade:int;
	  public var week_star_sub_level:int;
	}
}
