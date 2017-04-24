package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestAssistantInfo;
	
	import flash.utils.getQualifiedClassName;

	public class CeventVideoRoomInitNestAssistantList extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CeventVideoRoomInitNestAssistantList;
		}
		
		public function CeventVideoRoomInitNestAssistantList()
		{
			registerFieldForList("assistantInfos", getQualifiedClassName(AnchorNestAssistantInfo), Descriptor.Compound, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
		}
		
		public var assistantInfos : Array = new Array;
		public var room_id :int;
	}
}
