package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoGuardSeatInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventTakeRoomGuardSeatRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventTakeRoomGuardSeatRes;
		}
		public function CEventTakeRoomGuardSeatRes()
		{
			registerField("m_room_id", "", Descriptor.Int32, 1);
			registerField("m_seat_index", "", Descriptor.Int32, 2);
			registerField("m_res", "", Descriptor.Int32, 3);
			registerField("m_diamond_balance", "", Descriptor.Int32, 4);
			registerField("m_res_ext", "", Descriptor.Int32, 5);
			registerField("m_reason_ext", "", Descriptor.TypeString, 6);
			registerField("cost", "", Descriptor.Int32, 7);
			registerField("player_id", "", Descriptor.Int64, 8);
			registerField("seat_info", getQualifiedClassName(VideoGuardSeatInfo ), Descriptor.Compound, 9);
			registerField("has_avatar", "", Descriptor.TypeBoolean, 10);
			registerField("avatar", "", Descriptor.TypeNetBuffer, 11);
			registerField("charm", "", Descriptor.Int32, 12);
		}
		
		public var m_room_id:int = 0;
		public var m_seat_index:int = 0;
		public var m_res:int = 0;
		public var m_diamond_balance:int = 0;
		public var m_res_ext:int = 0;
		public var m_reason_ext:String = "";
		public var cost:int;
		public var player_id:Int64 = new Int64(0,0);
		public var seat_info:VideoGuardSeatInfo = new VideoGuardSeatInfo;
		public var charm:int;
		
		public var has_avatar:Boolean;
		public var avatar:NetBuffer = new NetBuffer();
	}
}