package com.h3d.qqx5.modules.video_vip.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAddVideoVipRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventAddVideoVipRes;
		}
		
		public function CEventAddVideoVipRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("ret", "", Descriptor.Int32, 2);
			registerField("vip_level", "", Descriptor.Int32, 3);
			registerField("duration", "", Descriptor.Int32, 4);
			registerField("pre_vip_level", "", Descriptor.Int32, 5);
			registerField("player_zid", "", Descriptor.Int64, 6);
			registerField("vip_expire", "", Descriptor.Int32, 7);
			registerField("video_room_id", "", Descriptor.Int32, 8);
		}
		
		public var trans_id : Int64;
		public var ret : int;
		public var vip_level : int;
		public var duration : int;
		public var pre_vip_level : int;
		public var player_zid : Int64;
		public var vip_expire : int;
		public var video_room_id : int;
	}
}
