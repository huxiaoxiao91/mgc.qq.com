package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.ByteArray;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventReportAnchor extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventReportAnchor;
		}
		
		public function CEventReportAnchor( qq:Int64, room_type:int,report_type:int,room_name:String,anchor_name:String, report_content:String,picContent:ByteArray)
		{
			registerField("anchor_qq", "", Descriptor.Int64, 1);
			registerField("informer_pstid", "", Descriptor.Int64, 2);
			registerField("informer_qq", "", Descriptor.Int64, 3);
			registerField("room_type", "", Descriptor.Int32, 4);
			registerField("report_type", "", Descriptor.Int32, 5);
			registerField("room_name", "", Descriptor.TypeString, 6);
			registerField("anchor_name", "", Descriptor.TypeString, 7);
			registerField("report_content", "", Descriptor.TypeString, 8);
			registerField("pic", "", Descriptor.TypeNetBuffer, 9);
			registerField("vid", "", Descriptor.Int32, 10);
			registerField("room_id", "", Descriptor.Int32, 11);
			registerField("client_ip", "", Descriptor.UInt32, 11);
			
			registerField("room_player_num", "", Descriptor.Int32, 13);
			registerField("show_time", "", Descriptor.Int32, 14);
			registerField("upload_path", "", Descriptor.TypeString, 15);
			registerField("report_time", "", Descriptor.Int32, 16);
			
			anchor_qq = qq;
			room_type = room_type;
			report_type = report_type;
			room_name = room_name;
			anchor_name = anchor_name;
			report_content = report_content;
			vid = 0;
			room_id = 0;
			client_ip = 0;
			room_player_num = 0;
			show_time = 0;
			report_time = 0;

				if(picContent != null)
				{
					pic.putBytes( picContent);
				}
		}
		
		public var anchor_qq : Int64;
		public var informer_pstid : Int64;
		public var informer_qq : Int64;
		public var room_type : int;
		public var report_type : int;
		public var room_name : String ="";
		public var anchor_name : String= "";
		public var report_content : String = "";
		public var pic :NetBuffer = new NetBuffer;
		public var vid : int;
		public var room_id : int;
		public var client_ip:uint;
		public var room_player_num : int;
		public var show_time : int;
		public var upload_path : String = "";
		public var report_time : int;
	}
}
