package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import flash.utils.Dictionary;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadAllNestForRankRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadAllNestForRankRes;
		}
		
		public function CEventLoadAllNestForRankRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerFieldForDict("nest_list", "",Descriptor.Int64,"", Descriptor.Int32, 2);
		}
		
		public var trans_id : Int64;
		public var nest_list :Dictionary;
	}
}
