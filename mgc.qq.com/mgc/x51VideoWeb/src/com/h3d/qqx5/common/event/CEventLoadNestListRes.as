package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.share.NestInfoLogicData;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventLoadNestListRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadNestListRes;
		}
		
		public function CEventLoadNestListRes()
		{
			registerFieldForList("nest_info_logic", getQualifiedClassName(NestInfoLogicData), Descriptor.Compound, 1);
			registerField("pic_url", "", Descriptor.TypeString, 2);
			registerField("is_out_of_room", "", Descriptor.TypeBoolean, 3);
			registerField("attached_room_id", "", Descriptor.Int32, 4);
			registerField("attached_room_name", "", Descriptor.TypeString, 5);
			registerField("anchor_id", "", Descriptor.Int64, 6);
		}
		
		public var nest_info_logic : Array = new Array;
		public var pic_url : String = "";
		public var is_out_of_room : Boolean;
		public var attached_room_id : int;
		public var attached_room_name : String="";
		public var anchor_id : Int64= new Int64(0,0);
	}
}
