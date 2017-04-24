package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadFollowingAnchorInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventLoadFollowingAnchorInfo;
		}
		
		public function CEventLoadFollowingAnchorInfo()
		{
			registerFieldForList("anchors", "", Descriptor.Int64, 1);
			registerField("proxy_id", "", Descriptor.Int32, 2);
			registerField("tunnel_id", "", Descriptor.Int32, 3);
			registerField("serial_id", "", Descriptor.Int32, 4);
			registerField("trans_id", "", Descriptor.Int64, 5);
			registerField("from", "", Descriptor.Int32, 6);
		}
		
		public var anchors : Array = new Array();
		public var proxy_id : int;
		public var tunnel_id : int;
		public var serial_id : int;
		public var trans_id : Int64 = new Int64();
		public var from : int;
	}
}
