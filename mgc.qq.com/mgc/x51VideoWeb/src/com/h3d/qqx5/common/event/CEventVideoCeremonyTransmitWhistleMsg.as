package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventVideoCeremonyTransmitWhistleMsg extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventVideoCeremonyTransmitWhistleMsg;
		}
		
		public function CEventVideoCeremonyTransmitWhistleMsg()
		{
			registerField("room_id", "", Descriptor.Int32, 3);
			registerField("had_attached", "", Descriptor.TypeBoolean, 1);
			registerField("buf", "", Descriptor.TypeNetBuffer, 2);
		}
		
		public var room_id : int;
		public var had_attached : Boolean;
		public var buf :NetBuffer;
	}
}
