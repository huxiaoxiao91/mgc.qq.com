package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class RoomAdminInfo extends ProtoBufSerializable
	{
		public function RoomAdminInfo()
		{
			registerField("admin_qq", "", Descriptor.Int64, 1);
			registerField("nick", "", Descriptor.TypeString, 2);
		}
		
		public var admin_qq : Int64;
		public var nick : String = "";
	}
}
