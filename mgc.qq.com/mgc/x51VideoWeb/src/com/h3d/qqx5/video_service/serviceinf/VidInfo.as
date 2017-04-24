package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.getQualifiedClassName;
	public class VidInfo extends ProtoBufSerializable
		
	{
		public function VidInfo()
		{
			registerField("vid", "", Descriptor.Int32, 1);
			registerField("ip", "", Descriptor.TypeString, 2);
			registerFieldForList("ports", "", Descriptor.Int32, 3);
		}
		
		public var vid : int;
		public var ip : String ="";
		public var ports : Array = new Array;
	}
}
