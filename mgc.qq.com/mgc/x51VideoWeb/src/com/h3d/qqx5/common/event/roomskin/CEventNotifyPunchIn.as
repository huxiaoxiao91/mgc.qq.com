package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * 打开增加魅力值通知
	 * @author gaolei
	 * 
	 */
	public class CEventNotifyPunchIn extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventNotifyPunchIn;
		}

		public function CEventNotifyPunchIn() {
			super();
			registerField("player_nick", "", Descriptor.TypeString, 1);
			registerField("player_zone", "", Descriptor.TypeString, 2);
			registerField("charm", "", Descriptor.Int32, 3);
		}

		/**
		 * 打卡玩家名称
		 */
		public var player_nick:String;
		/**
		 * 打卡玩家大区
		 */
		public var player_zone:String;
		/**
		 * 增加的魅力值
		 */
		public var charm:int;
	}
}
