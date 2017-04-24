package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoBoxItem;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.common.comdata.EvtVidoeBoxStatusData;

	public class CEventVideoOpenGiftPoolBoxRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoOpenGiftPoolBoxRes;
		}
		
		public function CEventVideoOpenGiftPoolBoxRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("sender_id", "", Descriptor.Int64, 2);
			registerField("box_id", "", Descriptor.Int32, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("box_item", getQualifiedClassName(VideoBoxItem), Descriptor.Compound, 5);
			registerField("chooseIndex", "", Descriptor.Int32, 6);
			registerField("cur_height", "", Descriptor.Int32, 7);
			registerField("max_height", "", Descriptor.Int32, 8);
			registerField("rand_seed", "", Descriptor.Int32, 9);
			registerFieldForList("box_data_buf", getQualifiedClassName(EvtVidoeBoxStatusData), Descriptor.Compound, 10);
		}
		
		public var result:int;
		public var sender_id:Int64;
		public var box_id:int;
		public var room_id:int;
		public var box_item:VideoBoxItem = new VideoBoxItem;
		public var chooseIndex:int;
		public var cur_height:int;
		public var max_height:int;
		public var rand_seed:int;
		public var box_data_buf:Array = new Array;
	}
}
