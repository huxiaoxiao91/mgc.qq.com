package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class VideoStarGiftPlayerContributionContainer extends ProtoBufSerializable
	{
		public function VideoStarGiftPlayerContributionContainer()
		{
			registerField("gift_id", "", Descriptor.Int32, 1);//周星礼物id
			registerField("anchor_id", "", Descriptor.Int64, 2);//被送的主播id
			registerField("player_id", "", Descriptor.Int64, 3);//送礼的玩家id
			registerField("player_nick_str", "", Descriptor.TypeString, 4);//玩家昵称
			registerField("wealth_level", "", Descriptor.Int32, 5);//玩家财富等级
			registerField("gift_contribution", "", Descriptor.Int32, 6);//周星礼物贡献数量
		}
		
		public var gift_id:int;
		public var anchor_id:Int64 = new Int64();
		public var player_id:Int64 = new Int64();
		public var player_nick_str:String ="";
		public var wealth_level:int;
		public var gift_contribution:int;
	}
}