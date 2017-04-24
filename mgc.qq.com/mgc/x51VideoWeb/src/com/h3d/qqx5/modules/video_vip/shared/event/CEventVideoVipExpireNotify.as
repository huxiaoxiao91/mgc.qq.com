package com.h3d.qqx5.modules.video_vip.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoVipExpireNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventVideoVipExpireNotify;
		}
		
		public function CEventVideoVipExpireNotify()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("old_vip_level", "", Descriptor.Int32, 2);
		}
		
		public var player_id : Int64;
		public var old_vip_level : int;
	}
}
