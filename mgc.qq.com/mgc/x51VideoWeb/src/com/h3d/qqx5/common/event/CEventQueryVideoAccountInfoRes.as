package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.comdata.RoomProxyInfo;
	import com.h3d.qqx5.common.comdata.UserIdentity;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoVersion;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	import flash.utils.getQualifiedClassName;

	/**
	 * 询问角色
	 * @author gaolei
	 *
	 */
	public class CEventQueryVideoAccountInfoRes extends INetMessage {
		public override function CLSID():int {
			return EEventIDVideoVersion.CLSID_CEventQueryVideoAccountInfoRes;
		}

		public function CEventQueryVideoAccountInfoRes() {
			registerField("time_stamp", "", Descriptor.UInt32, 1); // 请求时间
			registerField("succ", "", Descriptor.TypeBoolean, 2); // 是否成功，返回false其他信息无效
			registerFieldForList("room_proxy_infos", getQualifiedClassName(RoomProxyInfo), Descriptor.Compound, 3); // 所选择大区room_proxy信息
			registerFieldForList("account_infos", getQualifiedClassName(UserIdentity), Descriptor.Compound, 4); // 视频角色信息
			registerField("err_code", "", Descriptor.Int32, 5); // 错误码
			registerField("last_login_acc", getQualifiedClassName(UserIdentity), Descriptor.Compound, 6);
		}

		public var time_stamp:uint; // 请求时间
		public var succ:Boolean; //是否成功，返回false其它所有信息无效
		public var account_infos:Array; //视频角色信息
		public var err_code:int; //错误码
		public var room_proxy_infos:Array; //所选大区room_proxy信息
		public var last_login_acc:UserIdentity = new UserIdentity(); //上次登录的角色
	}
}
