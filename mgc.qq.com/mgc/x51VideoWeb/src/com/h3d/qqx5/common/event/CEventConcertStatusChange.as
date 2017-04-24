package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.ConcertEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class CEventConcertStatusChange extends INetMessage
	{
		public override function CLSID() : int
		{
			return ConcertEventID.CLSID_CEventConcertStatusChange;
		}
		
		public function CEventConcertStatusChange()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("is_open", "", Descriptor.TypeBoolean, 2);
		}
		public var room_id:int;
		public var is_open:Boolean;
	}
}