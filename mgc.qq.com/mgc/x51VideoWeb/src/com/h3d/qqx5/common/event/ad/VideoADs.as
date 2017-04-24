package com.h3d.qqx5.common.event.ad {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;

	import flash.utils.getQualifiedClassName;

	/**
	 * 广告列表
	 * @author gaolei
	 *
	 */
	public class VideoADs extends ProtoBufSerializable {
		public function VideoADs() {
			super();

			registerFieldForList("fixed_video_ad", getQualifiedClassName(VideoAD), Descriptor.Compound, 1);
			registerFieldForList("background_video_ad", getQualifiedClassName(VideoAD), Descriptor.Compound, 2);
//			registerField("edge_video_ad", "", Descriptor.TypeString, 3);
		}

		/**
		 * 固定广告列表
		 */
		public var fixed_video_ad:Array      = [];
		/**
		 * 背景广告列表
		 */
		public var background_video_ad:Array = [];
//		/**
//		 * 贴边广告
//		 */
//		public var edge_video_ad:String      = "";
	}
}
