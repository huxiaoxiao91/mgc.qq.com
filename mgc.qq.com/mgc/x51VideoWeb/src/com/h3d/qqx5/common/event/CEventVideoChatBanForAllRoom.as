package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;

	public class CEventVideoChatBanForAllRoom extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoChatBanForAllRoom;
		}
		
		public function CEventVideoChatBanForAllRoom()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("op_player_id", "", Descriptor.Int64, 3);
//			registerField("target_zoneName", "", Descriptor.TypeString, 4);
//			registerField("target_nickName", "", Descriptor.TypeString, 5);
			registerField("target_player_id", "", Descriptor.Int64, 4);
			registerField("ban", "", Descriptor.TypeBoolean, 5);
		}
		
		public var trans_id : Int64;
		public var room_id : int;
		public var op_player_id : Int64;
//		public var target_zoneName : String="";
//		public var target_nickName : String="";
		public var target_player_id : Int64 = new Int64;
		public var ban : Boolean;
	}
}
