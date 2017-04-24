package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventInviteToDeputyAnchor extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventInviteToDeputyAnchor;
		}
		
		public function CEventInviteToDeputyAnchor()
		{
			registerField("rs_transid", "", Descriptor.Int64, 1);
			registerField("anchor", "", Descriptor.Int64, 2);
			registerField("deputy_anchor", "", Descriptor.Int64, 3);
			registerField("anchor_video_server_id", "", Descriptor.Int32, 5);
			registerField("room_id", "", Descriptor.Int32, 6);
			registerField("video_srv_udp_port", "", Descriptor.Int32, 7);
			registerField("udp_key", "", Descriptor.Int64, 8);
			registerFieldForDict("video_server_addr", "",Descriptor.Int32,"", Descriptor.TypeString, 9);
		}
		
		public var rs_transid : Int64;
		public var anchor : Int64;
		public var deputy_anchor : Int64;
		public var anchor_video_server_id : int;
		public var room_id : int;
		public var video_srv_udp_port : int;
		public var udp_key : Int64;
		public var video_server_addr :Dictionary;
	}
}
