package com.h3d.qqx5.common.event.ad {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;

	/**
	 * 广告信息
	 * @author gaolei
	 *
	 */
	public class VideoAD extends ProtoBufSerializable {
		public function VideoAD() {
			super();
			registerField("id", 		"", 	Descriptor.Int32, 		1);
			registerField("pic_link", 	"", 	Descriptor.TypeString, 	2);
			registerField("jump_link", 	"", 	Descriptor.TypeString, 	3);
			registerField("begin_time", "", 	Descriptor.Int32, 		4);
			registerField("end_Time", 	"", 	Descriptor.Int32, 		5);
		}

		/**
		 * 广告id
		 */
		public var id:int;
		/**
		 * 图片连接
		 */
		public var pic_link:String;
		/**
		 * 跳转连接
		 * {room_id:10005, room_type:0\1\2}
		 * http://
		 */
		public var jump_link:String;
		/**
		 * 开始时间
		 */
		public var begin_time:int;
		/**
		 * 结束时间
		 */
		public var end_Time:int;

		public function toJSObj():Object {
			var jsobj:Object = new Object();
			jsobj["id"] = id;
			jsobj["pic_link"] = pic_link;
			jsobj["jump_link"] = jump_link;
			jsobj["begin_time"] = begin_time;
			jsobj["end_Time"] = end_Time;
			return jsobj;
		}
	}
}
