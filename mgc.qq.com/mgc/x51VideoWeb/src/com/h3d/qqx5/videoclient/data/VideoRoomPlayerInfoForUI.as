package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.common.comdata.UserIdentity;
	import com.h3d.qqx5.util.Int64;

	public class VideoRoomPlayerInfoForUI
	{
		public var online : Boolean;
		public var zoneName : String;
		public var playerNick : String;
		public var playerType : int;
		public var sex : int;
		public var level : int;
		public var uid :UserIdentity;
		public var pstid : Int64 = new Int64();
		public var wealth : Int64 = new Int64();
		public var affinity : Int64 = new Int64();
		public var total_affinity : Int64 = new Int64();
		public var chat_banned : int;
		public var portrait_info : int;
		public var ip:uint;
		public var guardLevel:int;
		public var purplediamond_level : int;
		public var nfpurplediamond_user : int;
		public var video_vip_level : int;
		public var video_vip_expire : int;
		public var judge_type : int;
		public var talent_show_rank : int;
		public var star_anchor : int;
		public var pk_richman_order : int;
		public var annual2014_title : int;
		public var invisible : Boolean;
		public var assistant : Boolean;
		public var nest_star : Int64 = new Int64();
		public var guardIcon:String = "";//守护图标
		public var vipIcon:String = "";//vip图标
	}
}