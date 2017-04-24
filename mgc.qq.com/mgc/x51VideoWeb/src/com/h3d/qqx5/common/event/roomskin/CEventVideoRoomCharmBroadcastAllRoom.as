package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * 魅力榜变成第一走马灯消息
	 * @author gaolei
	 *
	 */
	public class CEventVideoRoomCharmBroadcastAllRoom extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomCharmBroadcastAllRoom;
		}

		public function CEventVideoRoomCharmBroadcastAllRoom() {
			super();

			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("room_name", "", Descriptor.TypeString, 2);
			registerField("skin_level", "", Descriptor.Int32, 3);
			registerField("rank_timedimension", "", Descriptor.Int32, 4);
			registerField("skin_id", "", Descriptor.Int32, 5);
		}

		public var room_id:int;

		public var room_name:String;
		/**
		 * 皮肤等级
		 */
		public var skin_level:int;
		/**
		 * 榜的类别，日榜，周榜，月榜，总榜
		 */
		public var rank_timedimension:int;
		/**
		 * 皮肤id
		 */
		public var skin_id:int;
	}
}
