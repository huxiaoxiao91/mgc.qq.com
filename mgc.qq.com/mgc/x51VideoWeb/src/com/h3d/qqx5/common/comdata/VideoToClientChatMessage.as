package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;
	
	public class VideoToClientChatMessage extends ProtoBufSerializable
	{
		public function VideoToClientChatMessage()
		{
			registerField("sender_ID", "", Descriptor.Int64, 1);
			registerField("receiver_ID", "", Descriptor.Int64, 2);
			registerField("sender_name", "", Descriptor.TypeString, 3);
			registerField("recver_name", "", Descriptor.TypeString, 4);
			registerField("sender_zoneName", "", Descriptor.TypeString, 5);
			registerField("recver_zoneName", "", Descriptor.TypeString, 6);
			registerField("message", "", Descriptor.TypeString, 7);
			registerField("type", "", Descriptor.Int32, 8);
			registerField("is_purple", "", Descriptor.Int32, 9);
			registerField("in_vip_seat", "", Descriptor.Int32, 10);
			registerField("sender_type", "", Descriptor.Int32, 11);
			registerField("receiver_type", "", Descriptor.Int32, 12);
			registerField("roomid", "", Descriptor.Int32, 13);
			registerField("sender_jacket", "", Descriptor.Int32, 14);
			registerField("guard_level", "", Descriptor.Int32, 15);
			registerField("vip_level", "", Descriptor.Int32, 16);
			registerField("is_free_whistle", "", Descriptor.TypeBoolean, 17);
			registerField("judge_type", "", Descriptor.Int32, 18);
			registerField("videoguild_id", "", Descriptor.Int64, 19);
			registerField("sender_device_type", "", Descriptor.Int32, 20);
			registerField("guard_level_new", "", Descriptor.Int32, 21);
			registerField("invisible", "", Descriptor.TypeBoolean, 22);
			registerField("forbid_talk_all_room", "", Descriptor.TypeBoolean, 23);
			registerField("nest_assistant", "", Descriptor.TypeBoolean, 24);
			registerField("credits_level", "", Descriptor.Int32, 25);
			registerField("wealth_level", "", Descriptor.Int32, 26);
		}
		
		public var sender_ID : Int64;
		public var receiver_ID : Int64;
		public var sender_name : String;
		public var recver_name : String;
		public var sender_zoneName : String;
		public var recver_zoneName : String;
		public var message : String;
		public var type : int;
		public var is_purple : int;
		public var in_vip_seat : int;
		public var sender_type : int;
		public var receiver_type : int;
		public var roomid : int;
		public var sender_jacket : int;
		public var guard_level : int;
		public var vip_level : int;
		public var is_free_whistle : Boolean;
		public var judge_type : int;
		public var videoguild_id : Int64;
		public var sender_device_type : int;
		public var guard_level_new : int;
		public var invisible : Boolean;
		public var forbid_talk_all_room : Boolean;
		public var nest_assistant : Boolean;
		public var credits_level:int;
		public var wealth_level:int;//财富等级
		public var add_anchor_exp:int;//主播增加的经验
	}
}
