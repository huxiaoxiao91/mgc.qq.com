package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class CEventSendVideoGuildMonthTicket extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventSendVideoGuildMonthTicket;
		}
		
		public function CEventSendVideoGuildMonthTicket()
		{
			registerField("ticket_cnt", "", Descriptor.Int32, 1);
			registerField("serial_id", "", Descriptor.Int32, 2);
		}
		
		public var ticket_cnt : int;
		public var serial_id : int;
	}
}
