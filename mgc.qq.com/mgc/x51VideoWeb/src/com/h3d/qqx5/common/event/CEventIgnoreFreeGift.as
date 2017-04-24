package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * 是否忽略免费礼物消息。
	 * @author gaolei
	 * 
	 */
	public class CEventIgnoreFreeGift extends INetMessage
	{
		public function CEventIgnoreFreeGift()
		{
			super();

			registerField("is_ignore", "", Descriptor.TypeBoolean, 1);
		}

		public override function CLSID():int
		{
			return EEventIDVideoRoomExt.CLSID_CEventIgnoreFreeGift;
		}

		public var is_ignore:Boolean;
	}
}
