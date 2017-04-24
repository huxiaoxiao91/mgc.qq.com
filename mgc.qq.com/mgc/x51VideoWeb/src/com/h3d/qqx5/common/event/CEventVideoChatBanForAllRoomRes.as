package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;

	public class CEventVideoChatBanForAllRoomRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoChatBanForAllRoomRes;
		}
		
		public function CEventVideoChatBanForAllRoomRes()
		{
			registerField("target_zoneName", "", Descriptor.TypeString, 1);
			registerField("target_nickName", "", Descriptor.TypeString, 2);
			registerField("target_player_id", "", Descriptor.Int64, 3);
			registerField("ban", "", Descriptor.TypeBoolean, 4);
			registerField("success", "", Descriptor.TypeBoolean, 5);
		}
		
		public var target_zoneName : String= "";
		public var target_nickName : String = "";
		public var target_player_id : Int64 = new Int64;
		public var ban : Boolean;
		public var success : Boolean;
	}
}
