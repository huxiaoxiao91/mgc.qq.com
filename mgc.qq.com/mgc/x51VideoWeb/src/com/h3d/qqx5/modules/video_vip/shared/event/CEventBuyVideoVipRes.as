package com.h3d.qqx5.modules.video_vip.shared.event {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventBuyVideoVipRes extends INetMessage {
		public override function CLSID():int {
			return VideoVipEventID.CLSID_CEventBuyVideoVipRes;
		}

		public function CEventBuyVideoVipRes() {
			registerField("ret", 						"", Descriptor.Int32, 		1);
			registerField("vip_level", 					"", Descriptor.Int32, 		2);
			registerField("buy_type", 					"", Descriptor.Int32, 		3);
			registerField("duration", 					"", Descriptor.Int32, 		4);
			registerField("pre_vip_level", 				"", Descriptor.Int32, 		5);
			registerField("player_id", 					"", Descriptor.Int64, 		6);
			registerField("vip_expire", 				"", Descriptor.Int32, 		7);
			registerField("video_room_id", 				"", Descriptor.Int32, 		8);
			registerField("cost_type", 					"", Descriptor.Int32, 		9);
			registerField("video_money", 				"", Descriptor.Int32, 		10);

			registerField("balance", 					"", Descriptor.Int32, 		11);
			registerField("vip_attached_anchor_name", 	"", Descriptor.TypeString, 	12);
			registerField("rebate", 					"", Descriptor.Int32, 		13);
		}

		public var ret:int;
		public var vip_level:int;
		public var buy_type:int;
		public var duration:int;
		public var pre_vip_level:int;
		public var player_id:Int64;
		public var vip_expire:int;
		public var video_room_id:int;
		public var cost_type:int; //花费类型
		public var video_money:int; //梦幻币
		public var balance:int; //钻石或者炫豆余额
		/**
		 * 绑定的主播名
		 */
		public var vip_attached_anchor_name:String = "";
		/**
		 * 返利炫豆或者炫贝数量
		 */
		public var rebate:int;
	}
}
