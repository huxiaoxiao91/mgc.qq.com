package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;

	public class CEventQuerySkinGiftRes extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventQuerySkinGiftRes;
		}

		public function CEventQuerySkinGiftRes() {
			super();

			registerField("res", "", Descriptor.Int32, 1);
			registerFieldForDict("skin_gifts", "", Descriptor.Int32, "", Descriptor.Int32, 2);
		}

		/**
		 * 结果码
		 */
		public var res:int;
		/**
		 * 皮肤与礼物的对应关系（皮肤id<-->礼物id）
		 */
		public var skin_gifts:Dictionary = new Dictionary();
	}
}
