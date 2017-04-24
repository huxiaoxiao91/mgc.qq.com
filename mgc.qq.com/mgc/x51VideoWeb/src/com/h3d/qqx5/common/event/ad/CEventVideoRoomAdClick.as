package com.h3d.qqx5.common.event.ad {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class CEventVideoRoomAdClick extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomADClick;
		}

		public function CEventVideoRoomAdClick() {
			super();
			
			registerField("ad_type",	"", 	Descriptor.Int32, 		1);
			registerField("ad_site", 	"", 	Descriptor.Int32, 		2);
		}

		public var AD_TYPE_SUSPEND:int    = 1;
		public var AD_TYPE_BACKGROUND:int = 2;

		/**
		 * 广告类型
		 */
		public var ad_type:int;
		/**
		 * 广告位置
		 */
		public var ad_site:int;
	}
}
