package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class VideoVoteStartInfo extends ProtoBufSerializable
	{
		public function VideoVoteStartInfo()
		{
			registerField("vote_topic", "", Descriptor.TypeString, 1);
			registerField("anchor", "", Descriptor.Int64, 2);
			registerField("optional_max_count", "", Descriptor.Int32, 3);
			registerFieldForList("vote_entries", "", Descriptor.TypeString, 4);
		}
		
		public var vote_topic : String = "";
		public var anchor : Int64;
		public var optional_max_count : int;
		public var vote_entries : Array = new Array;
	}
}
