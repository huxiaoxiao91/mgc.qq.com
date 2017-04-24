package com.h3d.qqx5.modules.video_guild
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoGuildBoardRenderInfo extends ProtoBufSerializable
	{
		public function VideoGuildBoardRenderInfo()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("boardtype", "", Descriptor.Int32, 2);
			registerField("effname", "", Descriptor.TypeString, 3);
			registerField("uirname", "", Descriptor.TypeString, 4);
			registerField("vg_name", "", Descriptor.TypeString, 5);
			registerField("remainTime", "", Descriptor.Int32, 6);
			registerField("is_continually_show", "", Descriptor.TypeBoolean, 7);
			registerField("fans_board_name", "", Descriptor.TypeString, 8);
		}
		
		public var vgid : Int64;
		public var boardtype : int;
		public var effname : String;
		public var uirname : String;
		public var vg_name : String;
		public var remainTime : int;
		public var is_continually_show : Boolean;
		public var fans_board_name : String;
	}
}
