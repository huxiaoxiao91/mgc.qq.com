package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.comdata.VipSeatInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.VipAddtionInfo;

	import flash.utils.getQualifiedClassName;

	public class CEventTakeVipSeatRes extends INetMessage {
		public override function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventTakeVipSeatRes;
		}

		public function CEventTakeVipSeatRes() {
			registerField("cost", "", Descriptor.Int32, 1);
			registerField("seat_index", "", Descriptor.Int32, 2);
			registerField("pstid", "", Descriptor.Int64, 3);
			registerField("res", "", Descriptor.Int32, 4);
			registerField("balance", "", Descriptor.Int32, 5);
			registerField("seat_info", getQualifiedClassName(VipSeatInfo), Descriptor.Compound, 6);
			registerField("free_times", "", Descriptor.Int32, 7);
			registerField("has_avatar", "", Descriptor.TypeBoolean, 8);
			registerField("avatar", "", Descriptor.TypeNetBuffer, 9);
			registerField("charm", "", Descriptor.Int32, 10);
		}

		public var cost:int;
		public var seat_index:int;
		public var res:int;
		public var balance:int;
		public var pstid:Int64           = new Int64(0, 0);
		public var seat_info:VipSeatInfo = new VipSeatInfo;
		public var free_times:int;
		public var has_avatar:Boolean;
		public var avatar:NetBuffer      = new NetBuffer();
		public var charm:int;
	}
}
