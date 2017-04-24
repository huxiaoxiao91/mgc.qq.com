package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VideoVipBaseInfo;

	import flash.utils.getQualifiedClassName;

	/**
	 * 刷新vip基础信息
	 * @author gaolei
	 *
	 */
	public class CEventRefreshVipInfoToClient extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventRefreshVipInfoToClient;
		}

		public function CEventRefreshVipInfoToClient() {
			super();
			registerField("vip_info", getQualifiedClassName(VideoVipBaseInfo), Descriptor.Compound, 1);
		}

		public var vip_info:VideoVipBaseInfo = new VideoVipBaseInfo();
	}
}
