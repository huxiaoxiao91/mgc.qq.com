package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoRoomChatBan extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomChatBan;
		}
		
		public function CEventVideoRoomChatBan()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("op_player_id", "", Descriptor.Int64, 3);
			registerField("target_zoneName", "", Descriptor.TypeString, 4);
			registerField("target_nickName", "", Descriptor.TypeString, 5);
			registerField("ban", "", Descriptor.TypeBoolean, 6);
			registerField("perpetual", "", Descriptor.TypeBoolean, 7);
			registerField("op_zoneName", "", Descriptor.TypeString, 8);
			registerField("op_nick", "", Descriptor.TypeString, 9);
			registerField("op_guard_level", "", Descriptor.Int32, 10);
			registerField("target_guard_level", "", Descriptor.Int32, 11);
			registerField("op_vip_level", "", Descriptor.Int32, 12);
			registerField("target_vip_level", "", Descriptor.Int32, 13);
			registerField("op_guard_level_new", "", Descriptor.Int32, 14);
			registerField("target_guard_level_new", "", Descriptor.Int32, 15);
			registerField("op_credits_level", "", Descriptor.Int32, 16);
			registerField("target_credits_level", "", Descriptor.Int32, 17);
			registerField("op_is_assistant", "", Descriptor.TypeBoolean, 18);
			registerField("target_is_assistant", "", Descriptor.TypeBoolean, 19);
			registerField("op_wealth_level", "", Descriptor.Int32, 20);
			registerField("target_wealth_level", "", Descriptor.Int32, 21);
			registerField("target_player_id","",Descriptor.Int64,22);
			registerField("op_type","",Descriptor.TypeString,23);
		}
		
		public var trans_id : Int64;
		public var room_id : int;
		public var op_player_id : Int64;
		public var target_zoneName : String="";
		public var target_nickName : String="";
		public var ban : Boolean;
		public var perpetual : Boolean;
		public var op_zoneName : String ="";
		public var op_nick : String="";
		public var op_guard_level : int;
		public var target_guard_level : int;
		public var op_vip_level : int;
		public var target_vip_level : int;
		public var op_guard_level_new : int;
		public var target_guard_level_new : int;
		public var op_credits_level:int;//信用等级
		public var target_credits_level:int;
		public var op_is_assistant:Boolean;//助理
		public var target_is_assistant:Boolean;
		public var op_wealth_level:int;
		public var target_wealth_level:int;
		public var target_player_id : Int64;
		public var op_type : String="";
	}
}
