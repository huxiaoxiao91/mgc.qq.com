package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.LiveTaskInfo;
	import com.h3d.qqx5.common.event.eventid.ConcertEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.junkbyte.console.addons.commandprompt.CommandChoice;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventRefreshLiveTaskInfoToClient extends INetMessage
	{
		public override function CLSID() : int
		{
			return ConcertEventID.CLSID_CEventRefreshLiveTaskInfoToClient;
		}
		public function CEventRefreshLiveTaskInfoToClient()
		{
			registerFieldForList("info", getQualifiedClassName(LiveTaskInfo), Descriptor.Compound, 1);
			registerField("has_new_task", "", Descriptor.TypeBoolean, 2);
		}
		public var info : Array= new Array;
		public var has_new_task : Boolean;
	}
}
