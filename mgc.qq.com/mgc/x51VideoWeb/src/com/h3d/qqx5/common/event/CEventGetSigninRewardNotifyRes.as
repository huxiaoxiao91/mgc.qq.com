package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventGetSigninRewardNotifyRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventGetSigninRewardNotifyRes;
		}
		public function CEventGetSigninRewardNotifyRes()
		{
			registerField("status", "", Descriptor.Int32, 1);
			registerField("is_Daily", "", Descriptor.TypeBoolean, 2);
			registerField("is_Acc", "", Descriptor.TypeBoolean, 3);
		}
		public var status : int;
		public var is_Daily : Boolean;
		public var is_Acc : Boolean;
	}
}
