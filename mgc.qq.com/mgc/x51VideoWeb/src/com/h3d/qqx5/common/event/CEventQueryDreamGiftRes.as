package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class CEventQueryDreamGiftRes extends INetMessage
	{
		
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventQueryDreamGiftRes;
		}
		
		public function CEventQueryDreamGiftRes()
		{
			registerField("succ", "", Descriptor.TypeBoolean, 1);
			registerFieldForDict("video_gifts","",Descriptor.Int32,"",Descriptor.Int32,2);
		}	
		public var succ:Boolean;
		public var video_gifts:Dictionary;
	}
}