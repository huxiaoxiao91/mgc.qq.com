package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class VideoRoomAdminRelationDBData extends ProtoBufSerializable
	{

		public function VideoRoomAdminRelationDBData()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("pstid", "", Descriptor.Int64, 2);
			registerField("priviledge", "", Descriptor.Int32, 3);
		}
		
		public var room_id : int;
		public var pstid : Int64;
		public var priviledge : int;
	}
}
