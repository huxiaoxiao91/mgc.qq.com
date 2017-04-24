package com.h3d.qqx5.common.event.ad {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;

	/**
	 * 下发视频广告。
	 * @author gaolei
	 *
	 */
	public class CEventVideoAD extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoAD;
		}

		public function CEventVideoAD() {
			super();

			registerField("video_ad", getQualifiedClassName(VideoADs), Descriptor.Compound, 1);
			registerField("edge_video_ad", getQualifiedClassName(VideoAD), Descriptor.Compound, 2);
		}

		/**
		 * 视频广告
		 */
		public var video_ad:VideoADs     = new VideoADs();
		/**
		 * 贴边广告
		 */
		public var edge_video_ad:VideoAD = new VideoAD();
	}
}
