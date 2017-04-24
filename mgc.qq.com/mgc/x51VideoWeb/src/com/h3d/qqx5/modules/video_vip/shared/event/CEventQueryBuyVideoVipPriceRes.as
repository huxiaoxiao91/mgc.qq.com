package com.h3d.qqx5.modules.video_vip.shared.event {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VipPriceInfo;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class CEventQueryBuyVideoVipPriceRes extends INetMessage {
		public override function CLSID():int {
			return VideoVipEventID.CLSID_CEventQueryBuyVideoVipPriceRes;
		}

		public function CEventQueryBuyVideoVipPriceRes() {
			registerField("ret", "", Descriptor.Int32, 1);
			registerField("vip_price_info", getQualifiedClassName(VipPriceInfo), Descriptor.Compound, 2);
			registerFieldForDict("vip_rebate_info", "", Descriptor.Int32, "", Descriptor.Int32, 3);
		}

		public var ret:int;
		public var vip_price_info:VipPriceInfo = new VipPriceInfo();
		/**
		 * 贵族等级-返利比例
		 */
		public var vip_rebate_info:Dictionary  = new Dictionary();
	}
}
