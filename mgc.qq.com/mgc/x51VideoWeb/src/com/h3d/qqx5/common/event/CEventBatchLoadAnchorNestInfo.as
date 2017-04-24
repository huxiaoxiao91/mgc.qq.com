package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;

	public class CEventBatchLoadAnchorNestInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventBatchLoadAnchorNestInfo;
		}
		
		public function CEventBatchLoadAnchorNestInfo()
		{
			registerFieldForList("nest_ids", "", Descriptor.Int32, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
		}
		
		public var nest_ids : Array ;
		public var trans_id : Int64;
	}
}
