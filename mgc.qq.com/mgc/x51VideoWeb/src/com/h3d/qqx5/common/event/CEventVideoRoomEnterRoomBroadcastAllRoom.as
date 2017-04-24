package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * 进入房间全屏广播消息
	 * @author gaolei
	 * 
	 */
	public class CEventVideoRoomEnterRoomBroadcastAllRoom extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoomBroadcastAllRoom;
		}
		
		public function CEventVideoRoomEnterRoomBroadcastAllRoom()
		{
			registerField("vip_level", "", Descriptor.Int32, 1);
			registerField("player_name", "", Descriptor.TypeString, 2);
			registerField("room_name", "", Descriptor.TypeString, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("guard_level", "", Descriptor.Int32, 5);
			registerField("zone_name", "", Descriptor.TypeString, 6);
		}
		
		public var vip_level : int = 1;
		public var player_name : String ="";
		public var room_name : String ="";
		public var room_id : int;
		public var guard_level:int = 0;
		public var zone_name:String = "";//大区名
	}
}
