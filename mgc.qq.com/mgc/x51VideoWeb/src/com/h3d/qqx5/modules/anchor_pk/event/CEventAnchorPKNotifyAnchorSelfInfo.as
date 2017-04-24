package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_pk.share.AnchorDataForClient;
	
	import flash.utils.getQualifiedClassName;

	public class CEventAnchorPKNotifyAnchorSelfInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKNotifyAnchorSelfInfo;
		}
		
		public function CEventAnchorPKNotifyAnchorSelfInfo()
		{
			registerField("anchorA_info", getQualifiedClassName(AnchorDataForClient), Descriptor.Compound, 1);
			registerField("anchorB_info", getQualifiedClassName(AnchorDataForClient), Descriptor.Compound, 2);
			registerField("notify_ui", "", Descriptor.TypeBoolean, 3);
		}
		
		public var anchorA_info :AnchorDataForClient = new AnchorDataForClient;
		public var anchorB_info : AnchorDataForClient = new AnchorDataForClient;
		public var notify_ui : Boolean;
	}
}
