package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class VideoAnchorPKRichmanRank extends ProtoBufSerializable
	{
		public function VideoAnchorPKRichmanRank()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("player_nick", "", Descriptor.TypeString, 2);
			registerField("session", "", Descriptor.Int32, 3);
			registerField("contribution", "", Descriptor.Int64, 4);
			registerField("onboard_time", "", Descriptor.Int32, 5);
			registerField("record_id", "", Descriptor.Int64, 6);
			registerField("score", "", Descriptor.Int32, 7);
			registerField("m_player_url", "", Descriptor.TypeString, 8);
			registerField("player_portrait", "", Descriptor.Int32, 9);
			registerField("player_gender", "", Descriptor.Int32, 10);
		}
		
		public var player_id : Int64 = new Int64(0,0);
		public var player_nick : String = "";
		public var session : int;
		public var onboard_time : int;//hss
		public var record_id : Int64= new Int64(0,0);
		public var score : int;
		public var contribution:Int64= new Int64(0,0);
		public var m_player_url:String = "";
		public var player_portrait:int ;//玩家是否上传过头像,非0表示上传
		public var player_gender:int ;//玩家性别 0女 1男
	}
}
