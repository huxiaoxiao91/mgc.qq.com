package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventSendVideoGuildMonthTicketRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventSendVideoGuildMonthTicketRes;
		}
		
		public function CEventSendVideoGuildMonthTicketRes()
		{
			registerField("game_transid", "", Descriptor.Int64, 1);
			registerField("vgid", "", Descriptor.Int64, 2);
			registerField("sender_id", "", Descriptor.Int64, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("score_add", "", Descriptor.Int32, 5);
			registerField("anchor_id", "", Descriptor.Int64, 6);
			registerField("ticket_cnt", "", Descriptor.Int32, 7);
			registerField("result", "", Descriptor.Int32, 8);
			registerField("cur_vg_wealth", "", Descriptor.Int32, 9);
			registerField("cur_ticket_acc", "", Descriptor.Int32, 10);
			registerField("sender_sex", "", Descriptor.Int32, 11);
			registerField("sender_level", "", Descriptor.Int32, 12);
			registerField("sender_qq", "", Descriptor.Int64, 13);
			registerField("sender_ip", "", Descriptor.TypeString, 14);
			registerField("serial_id", "", Descriptor.Int32, 15);
		}
		
		public var game_transid : Int64;
		public var vgid : Int64;
		public var sender_id : Int64;
		public var room_id : int;
		public var score_add : int;
		public var anchor_id : Int64;
		public var ticket_cnt : int;
		public var result : int;
		public var cur_vg_wealth : int;
		public var cur_ticket_acc : int;
		public var sender_sex : int;
		public var sender_level : int;
		public var sender_qq : Int64;
		public var sender_ip : String;
		public var serial_id : int;
	}
}
