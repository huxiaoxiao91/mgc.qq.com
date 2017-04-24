package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventSetInvisibleOp extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventSetInvisibleOp;
		}
		
		public function CEventSetInvisibleOp()
		{
			registerField("invisible", "", Descriptor.TypeBoolean, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
		}
		
		public var invisible : Boolean;
		public var room_id : int;
	}
}
