package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;

	/**
	 * 抽奖
	 * @author gaolei
	 *
	 */
	public class CEventVideoRoomLuckyDraw extends INetMessage {

		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomLuckyDraw;
		}

		public function CEventVideoRoomLuckyDraw() {
			super();
			registerField("is_free", "", Descriptor.TypeBoolean, 1);
			registerField("is_continuous", "", Descriptor.TypeBoolean, 2);
			registerField("begin_time", "", Descriptor.Int32, 3);
			registerField("config_refresh_time", "", Descriptor.Int32, 4);

			registerField("open_id", "", Descriptor.TypeString, 5);
			registerField("open_key", "", Descriptor.TypeString, 6);
			registerField("pay_token", "", Descriptor.TypeString, 7);
			registerField("pf", "", Descriptor.TypeString, 8);
			registerField("pf_key", "", Descriptor.TypeString, 9);
//			registerField("avatar", "", Descriptor.TypeNetBuffer, 10);
		}

		/**
		 * 是否免费抽奖
		 */
		public var is_free:Boolean;
		/**
		 * 是否多次抽奖
		 */
		public var is_continuous:Boolean;
		/**
		 * 本期抽奖开始时间
		 */
		public var begin_time:int;
		/**
		 * 配置的刷新时间
		 */
		public var config_refresh_time:int;

		//=====================================================
		//
		// 以下属性web不使用
		//
		//=====================================================
		public var open_id:String   = "";

		public var open_key:String  = "";

		public var pay_token:String = "";

		public var pf:String        = "";

		public var pf_key:String    = "";

//		public var avatar:NetBuffer;// = new NetBuffer();
	}
}
