package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class CEventGetAllTags  extends INetMessage
	{
		
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventGetAllTags;
		}
		
		public function CEventGetAllTags()
		{
			registerField("homepage", "", Descriptor.TypeBoolean, 1);
		}
		
		public var homepage:Boolean;
	}
}