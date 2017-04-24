package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestAssistantInfo;
	
	import flash.utils.getQualifiedClassName;
	public class CEventSaveAnchorNestAssistant extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventSaveAnchorNestAssistant;
		}
		
		public function CEventSaveAnchorNestAssistant()
		{
			registerField("assistant", getQualifiedClassName(AnchorNestAssistantInfo), Descriptor.Compound, 1);
		}
		
		public var assistant :AnchorNestAssistantInfo = new AnchorNestAssistantInfo;
	}
}
