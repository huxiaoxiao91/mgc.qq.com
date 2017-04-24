package com.h3d.qqx5.common.event
{
	
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	public class CEventNotifyAudiencePublishAnchorTask  extends INetMessage
	{
		public function CEventNotifyAudiencePublishAnchorTask()
		{
			public override function CLSID() : int
			{
				return EEventIDVideoRoom.CLSID_CEventRefreshVideoCharInfoToClient;
			}
			
			public function CEventRefreshVideoCharInfoToClient()
			{
				registerField("is_show","", Descriptor.TypeBoolean, 1);
				registerField("need_show_special","", Descriptor.TypeBoolean, 2);
				registerField("show_red_dot","", Descriptor.TypeBoolean, 3);
			}
			
			public var is_show : Boolean ;
			public var need_show_special : Boolean ;
			public var show_red_dot : Boolean ;
		}
	}
}