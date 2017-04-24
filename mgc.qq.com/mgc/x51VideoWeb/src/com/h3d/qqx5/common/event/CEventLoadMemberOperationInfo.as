package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadMemberOperationInfo extends INetMessage {
		public override function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventLoadMemberOperationInfo;
		}

		public function CEventLoadMemberOperationInfo() {
			registerField("name", "", Descriptor.TypeString, 1);
			registerField("zoneName", "", Descriptor.TypeString, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
			registerField("trans_id", "", Descriptor.Int64, 4);
			registerField("member_id", "", Descriptor.Int64, 5);
		}

		public var name:String     = "";
		public var zoneName:String = "";
		/**
		 * 暂时不用，占位使用
		 */
		public var room_id:int;
		/**
		 * 暂时不用，占位使用
		 */
		public var trans_id:Int64  = new Int64();
		/**
		 * player_pstid
		 */
		public var member_id:Int64;
	}
}