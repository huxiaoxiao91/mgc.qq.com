package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	
	import flash.utils.getQualifiedClassName;
	
	public class RoomAnchorInfo  
	{
		public function RoomAnchorInfo()
		{
			anchor_qq = 0;
			room_type = 0;
		}
		
		public var anchor_qq :int;
		public var room_type:int;
		public var room_name:String = "";
		public var  anchor_name:String = "";
	}
}
