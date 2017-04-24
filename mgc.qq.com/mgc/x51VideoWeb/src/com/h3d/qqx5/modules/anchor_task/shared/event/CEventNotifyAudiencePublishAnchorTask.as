package com.h3d.qqx5.modules.anchor_task.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	public class CEventNotifyAudiencePublishAnchorTask extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorTaskEventID.CLSID_CEventNotifyAudiencePublishAnchorTask;
		}
		
		public function CEventNotifyAudiencePublishAnchorTask()
		{
			registerField("is_show", "", Descriptor.TypeBoolean, 1);
			registerField("need_show_special", "", Descriptor.TypeBoolean, 2);
			
		}
		public var is_show:Boolean;
		public var need_show_special : Boolean;
		
	}
}
