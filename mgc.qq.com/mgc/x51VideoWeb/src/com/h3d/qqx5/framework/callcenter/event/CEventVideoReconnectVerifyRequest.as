package com.h3d.qqx5.framework.callcenter.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	/**
	 * @author Administrator
	 */
	public class CEventVideoReconnectVerifyRequest extends INetMessage
	{
		public  override function CLSID() : int
		{
			return CallCenterMessageID.CLSID_CEventVideoReconnectVerifyRequest;
		}
		
		public function CEventVideoReconnectVerifyRequest()			
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("last_proxy_id", "", Descriptor.Int32, 2);
			registerField("last_tunnel_id", "", Descriptor.Int32, 3);
		}
		
		public var last_proxy_id:int = 0;
		public var last_tunnel_id:int = 0;
		public var trans_id:Int64;
	}	
}