package com.h3d.qqx5.modules.video_vip.shared.event {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventBuyVideoVip extends INetMessage {
		public override function CLSID():int {
			return VideoVipEventID.CLSID_CEventBuyVideoVip;
		}

		public function CEventBuyVideoVip() {
			registerField("vip_level",	"",		Descriptor.Int32, 	1);
			registerField("buy_type",	"", 	Descriptor.Int32, 	2);
			registerField("duration",	"", 	Descriptor.Int32, 	3);
			registerField("cost_type",	"", 	Descriptor.Int32, 	4);

			registerField("anchor_id",	"", 	Descriptor.Int64, 	10);
		}

		public var vip_level:int;
		public var buy_type:int;
		public var duration:int;
		public var cost_type:int;

		public var anchor_id:Int64 = new Int64();
	}
}
