package com.h3d.qqx5.modules.video_vip.shared.event {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class CEventBuyVipNotice extends INetMessage {
		override public function CLSID():int {
			return VideoVipEventID.CLSID_CEventBuyVipNotice;
		}

		public function CEventBuyVipNotice() {
			super();

			registerField("player_name", "", Descriptor.TypeString, 1);
			registerField("weath_level", "", Descriptor.Int32, 2);
			registerField("vip_level", "", Descriptor.Int32, 3);
			registerField("anchor_name", "", Descriptor.TypeString, 4);
			registerField("room_id", "", Descriptor.Int32, 5);
		}

		public var player_name:String = "";
		public var weath_level:int;
		public var vip_level:int;
		public var anchor_name:String = "";
		/**
		 * pc端使用，web不需要。
		 */
		public var room_id:int;
	}
}
