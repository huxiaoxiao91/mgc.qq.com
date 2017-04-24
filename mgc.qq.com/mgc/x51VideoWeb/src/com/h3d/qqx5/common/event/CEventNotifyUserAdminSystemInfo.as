package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.MobileUserAdminId;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class CEventNotifyUserAdminSystemInfo extends INetMessage
	{
		public override function CLSID():int
		{
			return MobileUserAdminId.CLSID_CEventNotifyUserAdminSystemInfo;
		}
		//拉取玩家贡献榜返回结果
		public function CEventNotifyUserAdminSystemInfo()
		{
			registerField("m_player_pstid", "", Descriptor.Int64, 1); //玩家pstid
			registerField("m_wealth_level", "", Descriptor.Int32, 2);//玩家财富值等级
			registerField("m_vip_level", "", Descriptor.Int32, 3);//贵族等级
			registerField("m_nick", "", Descriptor.TypeString, 4);//玩家昵称
			registerField("m_status", "", Descriptor.TypeBoolean, 5);//状态 false被解除 true 被任命
			registerField("m_room_id", "", Descriptor.Int32, 6);//房间ID
			registerField("m_guard_level", "", Descriptor.Int32, 7);//财富等级
			registerField("m_zone_name", "", Descriptor.TypeString, 8);//大区名
		}
		public var m_player_pstid:Int64;
		public var m_wealth_level:int;
		public var m_vip_level:int;
		public var m_nick:String		 		= "";
		public var m_status:Boolean;
		public var m_room_id:int;
		public var m_guard_level:int;
		public var m_zone_name:String		 	= "";
	}
}