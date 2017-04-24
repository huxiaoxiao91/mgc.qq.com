package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomRequestQstoreDownloadKeyRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomRequestQstoreDownloadKeyRes;
		}
		
		public function CEventVideoRoomRequestQstoreDownloadKeyRes()
		{
			registerField("transid", "", Descriptor.Int64, 1);
			registerField("playerid", "", Descriptor.Int64, 2);
			registerField("target_qq", "", Descriptor.Int64, 3);
			registerField("ret_code", "", Descriptor.Int32, 4);
			registerField("full_path", "", Descriptor.TypeString, 5);
			registerField("auth_key", "", Descriptor.TypeString, 6);
		}
		
		public var transid : Int64;
		public var playerid : Int64;
		public var target_qq : Int64;
		public var ret_code : int;
		public var full_path : String;
		public var auth_key : String;
	}
}
