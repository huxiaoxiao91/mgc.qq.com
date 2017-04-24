package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	//登陆成功
	public class CEventVideoUserLogin extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoUserLogin;
		}
		public function CEventVideoUserLogin()
		{
			registerField("real_login","",Descriptor.TypeBoolean,1);
		}
		public var real_login:Boolean ;
	}
}
