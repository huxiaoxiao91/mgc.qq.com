package com.h3d.qqx5.common.comdata.ceremony
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	
	public class ConcertPlaybackRoomInfo extends ProtoBufSerializable
	{
		
		public function ConcertPlaybackRoomInfo()
		{
			registerField("concert_id", "", Descriptor.Int32, 1);//演唱会id
			registerField("concert_name", "", Descriptor.TypeString, 2);//演唱会名称
			registerField("preview_pic", "", Descriptor.TypeString, 3);//预览图
			registerField("accumulate_watch", "", Descriptor.Int32, 4);//观看次数
		}
		
		public var concert_id : int;
		public var concert_name : String ="";
		public var preview_pic : String = "";
		public var accumulate_watch : int;
	}
}
