package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventReportAnchorResult extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventReportAnchorResult;
		}
		
		public function CEventReportAnchorResult()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("anchor_qq", "", Descriptor.Int64, 2);
			registerField("informer_qq", "", Descriptor.Int64, 3);
		}
		
		public var result : int;
		public var anchor_qq : Int64;
		public var informer_qq : Int64;
	}
}
