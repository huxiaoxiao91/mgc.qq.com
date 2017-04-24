package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.QueryUserEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventQueryUserServerInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return QueryUserEventID.CLSID_CEventQueryUserServerInfoRes;
		}
		public function CEventQueryUserServerInfoRes()
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerField("ip", "", Descriptor.TypeString, 2);
			registerField("port", "", Descriptor.Int32, 3);
		}
		public var res:int;
		public var ip:String = "";
		public var port:int;
	}
}