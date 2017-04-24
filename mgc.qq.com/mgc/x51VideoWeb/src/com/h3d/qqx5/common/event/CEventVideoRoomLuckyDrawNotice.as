package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.comdata.LuckyDrawNotice;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	import flash.utils.getQualifiedClassName;

	/**
	 * 同步抽奖公告
	 * @author gaolei
	 *
	 */
	public class CEventVideoRoomLuckyDrawNotice extends INetMessage {

		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomLuckyDrawNotice;
		}

		public function CEventVideoRoomLuckyDrawNotice() {
			super();

			registerField("notice", getQualifiedClassName(LuckyDrawNotice), Descriptor.Compound, 1);
		}

		/**
		 * 抽奖公告
		 */
		public var notice:LuckyDrawNotice;
	}
}
