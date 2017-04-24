package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.CReward;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventConfirmFirstLoginRewardRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventConfirmFirstLoginRewardRes;
		}
		public function CEventConfirmFirstLoginRewardRes()
		{
			registerField("status", "", Descriptor.Int32, 1);
			registerField("mylevel", "", Descriptor.Int32, 2);
			registerFieldForList("rewards",getQualifiedClassName(CReward), Descriptor.Compound, 3);
			registerField("is_reissue", "", Descriptor.TypeBoolean, 4);
		}
		public var status : int;
		public var mylevel : int;
		public var rewards : Array = new Array();
		public var is_reissue : Boolean;
	}
}
