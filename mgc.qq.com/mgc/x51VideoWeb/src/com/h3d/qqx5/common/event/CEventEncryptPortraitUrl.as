package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventEncryptPortraitUrl extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventEncryptPortraitUrl;
		}
		public function CEventEncryptPortraitUrl()
		{
			registerField("url", "", Descriptor.TypeString, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
		}
		public var url : String = "";
		public var trans_id : Int64 = new Int64(0,0);
	}
}
