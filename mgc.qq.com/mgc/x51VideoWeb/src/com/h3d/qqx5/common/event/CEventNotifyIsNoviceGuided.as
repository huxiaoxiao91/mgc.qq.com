package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventNotifyIsNoviceGuided extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventNotifyIsNoviceGuided;
		}
		
		public function CEventNotifyIsNoviceGuided()
		{
			registerField("guided", "", Descriptor.TypeBoolean, 1);
		}
		
		public var guided : Boolean;
	}
}