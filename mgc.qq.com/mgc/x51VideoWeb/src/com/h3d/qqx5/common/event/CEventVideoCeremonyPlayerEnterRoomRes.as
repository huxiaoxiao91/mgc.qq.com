package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.ceremony.CeremonyStartInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventVideoCeremonyPlayerEnterRoomRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventVideoCeremonyPlayerEnterRoomRes;
		}
		
		public function CEventVideoCeremonyPlayerEnterRoomRes()
		{
			registerField("player_pstid", "", Descriptor.Int64, 1);
			registerField("sender_room_id", "", Descriptor.Int32, 2);
			registerField("info", getQualifiedClassName(CeremonyStartInfo), Descriptor.Compound, 3);
			registerField("ceremony_state", "", Descriptor.Int32, 4);
		}
		
		public var player_pstid : Int64;
		public var sender_room_id : int;
		public var info :CeremonyStartInfo = new CeremonyStartInfo;
		public var ceremony_state : int;
	}
}
