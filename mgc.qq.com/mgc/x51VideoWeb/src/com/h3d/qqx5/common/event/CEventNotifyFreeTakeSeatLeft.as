package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_vip.shared.event.VideoVipEventID;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventNotifyFreeTakeSeatLeft extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventNotifyFreeTakeSeatLeft;
		}
		public function CEventNotifyFreeTakeSeatLeft()
		{
			registerField("free_take_seat_left", "", Descriptor.Int32, 1);
		}

		public var free_take_seat_left:int;
	}
}