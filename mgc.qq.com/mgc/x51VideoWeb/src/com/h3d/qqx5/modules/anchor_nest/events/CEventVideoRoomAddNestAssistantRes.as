package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestAssistantInfo;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventVideoRoomAddNestAssistantRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventVideoRoomAddNestAssistantRes;
		}
		
		public function CEventVideoRoomAddNestAssistantRes()
		{
			registerField("assistant", getQualifiedClassName(AnchorNestAssistantInfo), Descriptor.Compound, 1);
			registerField("qq", "", Descriptor.Int64, 2);
			registerField("anchor_id", "", Descriptor.Int64, 3);
		}
		
		public var assistant :AnchorNestAssistantInfo = new AnchorNestAssistantInfo;
		public var qq : Int64;
		public var anchor_id : Int64;
	}
}
