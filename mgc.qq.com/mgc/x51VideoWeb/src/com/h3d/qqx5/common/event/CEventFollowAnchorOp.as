package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventFollowAnchorOp extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventFollowAnchorOp;
		}
		
		public function CEventFollowAnchorOp()
		{
			registerField("anchor", "", Descriptor.Int64, 1);
			registerField("op_type", "", Descriptor.Int32, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
			registerField("anchor_nick", "", Descriptor.TypeString, 4);
			registerField("from", "", Descriptor.Int32, 5);
		}
		
		public var anchor : Int64;
		public var op_type : int;
		public var room_id : int;
		public var anchor_nick : String= "";
		public var from : int;
	}
}
