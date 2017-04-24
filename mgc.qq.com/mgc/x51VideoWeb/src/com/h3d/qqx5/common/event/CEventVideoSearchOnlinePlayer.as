package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoSearchOnlinePlayer extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoSearchOnlinePlayer;
		}
		
		public function CEventVideoSearchOnlinePlayer()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("key_words", "", Descriptor.TypeString, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
		}
		
		public var player_id : Int64;
		public var key_words : String;
		public var room_id : int;
	}
}
