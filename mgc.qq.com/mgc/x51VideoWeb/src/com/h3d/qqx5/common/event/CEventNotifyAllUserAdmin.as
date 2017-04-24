package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.MobileUserAdminId;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class CEventNotifyAllUserAdmin extends INetMessage
	{
		public override function CLSID():int
		{
			return MobileUserAdminId.CLSID_CEventNotifyAllUserAdmin;
		}
		//拉取玩家贡献榜返回结果
		public function CEventNotifyAllUserAdmin()
		{
			registerFieldForList("m_user_admins", "", Descriptor.Int64, 1);
		}
		public var m_user_admins:Array = new Array;
	}
}