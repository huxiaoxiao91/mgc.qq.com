package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.User_identity;
	import com.h3d.qqx5.common.event.eventid.QueryUserEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	import flash.utils.getQualifiedClassName;

	public class CEventQueryUserServerInfo extends INetMessage
	{
		public override function CLSID():int
		{
			return QueryUserEventID.CLSID_CEventQueryUserServerInfo;
		}

		public function CEventQueryUserServerInfo()
		{
			registerField("uid", getQualifiedClassName(User_identity), Descriptor.Compound, 1);
			registerField("dev_type", "", Descriptor.Int32, 2);
		}

		public var uid:User_identity = new User_identity();
		public var dev_type:int;
	}
}
