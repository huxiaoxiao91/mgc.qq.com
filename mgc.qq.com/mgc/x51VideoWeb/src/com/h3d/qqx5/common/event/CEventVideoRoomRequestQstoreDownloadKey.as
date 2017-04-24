package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomRequestQstoreDownloadKey extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomRequestQstoreDownloadKey;
		}
		
		public function CEventVideoRoomRequestQstoreDownloadKey()
		{
			registerField("transid", "", Descriptor.Int64, 1);
			registerField("playerid", "", Descriptor.Int64, 3);
			registerField("target_qq", "", Descriptor.Int64, 4);
			registerField("full_path", "", Descriptor.TypeString, 5);
		}
		
		public var transid : Int64;
		public var playerid : Int64;
		public var target_qq : Int64;
		public var full_path : String;
	}
}
