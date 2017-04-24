package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	public class CEventVideoRoomNestAssistantChange extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventVideoRoomNestAssistantChange;
		}
		
		public function CEventVideoRoomNestAssistantChange()
		{
			registerField("is_add", "", Descriptor.TypeBoolean, 1);
			registerField("name", "", Descriptor.TypeString, 2);
			registerField("zone_name", "", Descriptor.TypeString, 3);
		}
		
		public var is_add : Boolean;
		public var name : String;
		public var zone_name : String;
	}
}
