package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	/**
	 * 屏蔽/打开免费礼物消息返回结果。
	 * @author gaolei
	 * 
	 */	
	public class CEventIgnoreFreeGiftRes extends INetMessage
	{
		public function CEventIgnoreFreeGiftRes()
		{
			super();
			
			registerField("res", "", Descriptor.Int32, 1);
			registerField("is_ignore", "", Descriptor.TypeBoolean, 2);
		}
		
		public override function CLSID():int
		{
			return EEventIDVideoRoomExt.CLSID_CEventIgnoreFreeGiftRes;
		}
		
		public var res:int;
		public var is_ignore:Boolean;
	}
}