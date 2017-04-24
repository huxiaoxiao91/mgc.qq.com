package com.h3d.qqx5.framework.callcenter.event
{
	import com.h3d.qqx5.common.comdata.UserIdentity;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	
	/**
	 * @author Administrator
	 */
	public class CEventVideoInitConnectionResponse extends INetMessage
	{
		public  override function CLSID() : int
		{
			return CallCenterMessageID.CLSID_CEventVideoInitConnectionResponse;
		}
		
		public function CEventVideoInitConnectionResponse()			
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerField("server_time", "", Descriptor.Int32, 2);
			registerField("trans_id", "", Descriptor.Int64, 3);
			registerField("video_zone_id", "", Descriptor.Int32, 4);
			registerField("proxy_id", "", Descriptor.Int32, 5);
			registerField("tunnel_id", "", Descriptor.Int32, 6);
		}
		
		public var res:int = 0;
		public var server_time:int = 0;
		public var trans_id:Int64;
		public var video_zone_id:int = 0;
		public var proxy_id:int = 0;
		public var tunnel_id:int = 0;
		
		public function toString():String
		{
			return "[res:" + res + ",server_time:" + server_time + ",video_zone_id:" 
				+ video_zone_id + ",proxy_id:" + proxy_id + ",tunnel_id:" + tunnel_id + "]";
		}
	}	
}