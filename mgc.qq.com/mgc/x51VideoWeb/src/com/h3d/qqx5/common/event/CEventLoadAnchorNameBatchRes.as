package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventLoadAnchorNameBatchRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadAnchorNameBatchRes;
		}
		
		public function CEventLoadAnchorNameBatchRes()
		{
			registerFieldForDict("anchor_names", "",Descriptor.Int64, "",Descriptor.TypeString, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
		}
		
		public var anchor_names :Dictionary;
		public var trans_id : Int64;
	}
}
