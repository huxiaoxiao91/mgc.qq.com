package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.CVideoPlayerInfo;

	import flash.utils.getQualifiedClassName;

	public class CEventLoadPlayerInfoForHomePageRes extends INetMessage {
		public override function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventLoadPlayerInfoForHomePageRes;
		}

		public function CEventLoadPlayerInfoForHomePageRes() {
			registerField("res", "", Descriptor.Int32, 1);
			registerField("player", getQualifiedClassName(CVideoPlayerInfo), Descriptor.Compound, 2);
		}

		public var res:int;
		public var player:CVideoPlayerInfo = new CVideoPlayerInfo();
	}
}
