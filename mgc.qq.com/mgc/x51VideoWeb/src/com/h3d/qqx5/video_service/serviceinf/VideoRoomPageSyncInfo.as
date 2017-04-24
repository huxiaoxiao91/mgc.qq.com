package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.PublicAnchorTaskRes;
	
	import flash.utils.Dictionary;
	
	public class VideoRoomPageSyncInfo extends ProtoBufSerializable
	{
	  public function VideoRoomPageSyncInfo()
	  {
	    registerField("id", "", Descriptor.Int32, 1);
	    registerField("type", "", Descriptor.Int32, 2);
	    registerField("subject", "", Descriptor.Int32, 3);
	    registerField("room_name", "", Descriptor.TypeString, 4);
	    registerField("player_num", "", Descriptor.Int32, 5);
	    registerField("state", "", Descriptor.Int32, 6);
	    registerField("live_start_time", "", Descriptor.Int32, 7);
	    registerField("anchor_pstid", "", Descriptor.Int64, 8);
	    registerField("anchor_name", "", Descriptor.TypeString, 9);
	    registerField("room_attribute_flag", "", Descriptor.Int32, 10);
	    registerField("player_capcity", "", Descriptor.Int32, 11);
	    registerField("room_pic_info", "", Descriptor.Int32, 12);
	    registerField("is_closed", "", Descriptor.TypeBoolean, 13);
	    registerField("is_nest", "", Descriptor.TypeBoolean, 14);
		registerField("attached_room_id", "", Descriptor.Int32, 15);
		registerField("large_anchor_posing_url", "", Descriptor.TypeString, 16);//摆拍大图
		registerField("small_anchor_posing_url", "", Descriptor.TypeString, 17);//摆拍小图
		registerField("is_anchor_pk_room", "", Descriptor.TypeBoolean, 18);
		registerField("is_special_room", "", Descriptor.TypeBoolean, 19);
		registerField("nest_owner", "", Descriptor.Int64, 20);
		registerField("nest_status", "", Descriptor.Int32, 21);
		registerField("anchor_level", "", Descriptor.Int32, 22);
		registerField("is_star_gift_champion", "", Descriptor.TypeBoolean, 23);
		registerField("anchor_badge", "", Descriptor.Int32, 24);	// 主播徽章
		registerField("qgame_anchor_posing_url","",Descriptor.TypeString,25);//QGame摆拍图片地址
		registerField("room_skin_level", "", Descriptor.Int32, 26);	
		registerField("room_skin_id", "", Descriptor.Int32, 27);	
		registerField("is_test_room","",Descriptor.TypeBoolean,28);
		registerField("tag_name","",Descriptor.TypeString,29);//房间开播标签名称：空为普通房间，非空为标签房间public var definition:int;
		registerField("week_star_grade","",Descriptor.Int32,30);//段位
		registerField("week_star_sub_level","",Descriptor.Int32,31);//段位等级
		registerField("is_use_mobile_anchor_posing","",Descriptor.TypeBoolean,32);//是否使用移动摆拍
		registerField("vertical_live","",Descriptor.TypeBoolean,33);//直播中截图屏幕朝向    1：横屏     2:竖屏
	  }

	  public var id : int;
	  public var type : int;
	  public var subject : int;
	  public var room_name : String = "";
	  public var player_num : int;
	  public var state : int;
	  public var live_start_time : int;
	  public var anchor_pstid : Int64;
	  public var anchor_name : String = "";
	  public var room_attribute_flag : int;
	  public var player_capcity : int;
	  public var room_pic_info : int;
	  public var is_closed : Boolean;
	  public var is_nest : Boolean;
	  public var attached_room_id : int;
	  public var large_anchor_posing_url : String = "";
	  public var small_anchor_posing_url : String = "";
	  public var is_anchor_pk_room:Boolean;//是否主播pk房间	 
	  public var is_special_room:Boolean;//是否官方活动房间
	  public var nest_owner:Int64 = new Int64();//小窝主人qq，这个用来拼摆拍图片（个人直播间，主播未正在直播）
	  public var nest_status:int;//小窝的冻结状态
	  public var anchor_level:int;//主播等级
	  public var is_star_gift_champion:Boolean;
	  public var anchor_badge:int;
	  public var qgame_anchor_posing_url:String = "";
	  
	  public var room_skin_level:int;
	  public var room_skin_id:int;
	  public var is_test_room:Boolean;
	  public var tag_name:String = "";
	  
	  public var week_star_grade:int;
	  public var week_star_sub_level:int;
	  public var is_use_mobile_anchor_posing:Boolean;
	  public var vertical_live:Boolean;
	}
}
