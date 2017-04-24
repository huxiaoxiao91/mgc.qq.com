package com.h3d.qqx5.modules.video_vip.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventQueryFreeSuperStarHornLeftRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventQueryFreeSuperStarHornLeftRes;
		}
		
		public function CEventQueryFreeSuperStarHornLeftRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("left_count", "", Descriptor.Int32, 3);
		}
		
		public var trans_id : Int64;
		public var player_id : Int64;
		public var left_count : int;
	}
}
