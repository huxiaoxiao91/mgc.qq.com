package com.h3d.qqx5.framework.network
{	
	import com.h3d.qqx5.common.comdata.UserIdentity;
	
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author liuchui
	 */
	public class CEventRoomProxyWrapEvent extends INetMessage
	{			
		public override function CLSID():int
		{
			return MessageID.CLSID_CEventRoomProxyWrapEvent;
		}
		
		public function CEventRoomProxyWrapEvent()			
		{
			registerField("tunnel_id", "", Descriptor.UInt32, 1);
			registerField("uid", getQualifiedClassName(UserIdentity), Descriptor.Compound, 2);
			registerField("serialID", "", Descriptor.Int32, 3);
			registerField("ip", "", Descriptor.Int32, 4);
			registerField("diamond_info", "", Descriptor.UInt32, 5);
			registerField("payload", "", Descriptor.TypeNetBuffer, 6);
			registerField("client_device_type", "", Descriptor.Int32, 7);
			registerField("clsid", "", Descriptor.Int32, 8);
			registerField("client_version", "", Descriptor.Int32, 9);
		}
		
		public var tunnel_id:uint = 0;
		public var uid:UserIdentity = new UserIdentity;
		public var serialID:int = 0;
		public var ip:uint = 0;
		public var diamond_info:int = 0;
		public var payload:NetBuffer = new NetBuffer;
		public var client_device_type:int = 0;
		public var clsid:int = 0;
		public var client_version:int = 0;
	}
}
