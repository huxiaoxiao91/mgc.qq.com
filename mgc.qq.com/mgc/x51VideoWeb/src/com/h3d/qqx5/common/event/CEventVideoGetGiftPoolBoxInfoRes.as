package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.common.comdata.EvtVidoeBoxStatusData;

	public class CEventVideoGetGiftPoolBoxInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoGetGiftPoolBoxInfoRes;
		}
		
		public function CEventVideoGetGiftPoolBoxInfoRes()
		{
			registerField("sender_id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("cur_height", "", Descriptor.Int32, 3);
			registerField("max_height", "", Descriptor.Int32, 4);
			registerField("result", "", Descriptor.Int32, 5);
			registerFieldForList("box_data_buf", getQualifiedClassName(EvtVidoeBoxStatusData), Descriptor.Compound, 6);
			registerFieldForDict("vip_cnt_info", "",Descriptor.Int32,"", Descriptor.Int32, 7);
			registerField("vip_addition", "", Descriptor.Int32, 8);
		}
		
		public var sender_id : Int64;
		public var room_id : int;
		public var cur_height : int;
		public var max_height : int;
		public var result : int;
		public var box_data_buf : Array = new Array;
		public var vip_cnt_info :Dictionary = new Dictionary;
		public var vip_addition : int;
	}
}
