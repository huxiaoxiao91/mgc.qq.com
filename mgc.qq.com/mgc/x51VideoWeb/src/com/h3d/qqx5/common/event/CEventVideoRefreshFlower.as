package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRefreshFlower extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRefreshFlower;
		}
		
		public function CEventVideoRefreshFlower()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("flower_cnt", "", Descriptor.Int32, 2);
			registerField("next_refresh_leftTime", "", Descriptor.Int32, 3);
		}
		
		public var player_id : Int64;
		public var flower_cnt : int;
		public var next_refresh_leftTime : int;
	}
}
