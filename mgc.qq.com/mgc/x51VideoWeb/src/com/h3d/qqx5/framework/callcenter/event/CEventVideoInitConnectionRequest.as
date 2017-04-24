package com.h3d.qqx5.framework.callcenter.event
{
	import com.h3d.qqx5.common.comdata.UserIdentity;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author Administrator
	 */
	public class CEventVideoInitConnectionRequest extends INetMessage
	{
		public  override function CLSID() : int
		{
			return CallCenterMessageID.CLSID_CEventVideoInitConnectionRequest;
		}
		
		public function CEventVideoInitConnectionRequest()			
		{
			registerField("uid", getQualifiedClassName(UserIdentity), Descriptor.Compound, 1);
			registerField("roomID", "", Descriptor.Int32, 2);
			registerField("trans_id", "", Descriptor.Int64, 3);
			registerField("client_device_type", "", Descriptor.Int32, 4);
			registerField("appid", "", Descriptor.Int32, 5);
			registerField("skey", "", Descriptor.TypeString, 6);
			
		}
		
		public var uid:UserIdentity = new UserIdentity;
		public var roomID:int = 0;
		public var trans_id:Int64;
		public var client_device_type:int = 0;
		public var appid:int;
		public var skey:String;
	}	
}