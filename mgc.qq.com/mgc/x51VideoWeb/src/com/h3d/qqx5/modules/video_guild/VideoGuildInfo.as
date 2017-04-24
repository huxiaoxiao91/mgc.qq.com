package com.h3d.qqx5.modules.video_guild
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoGuildInfo extends ProtoBufSerializable
	{
	
		public function VideoGuildInfo()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("chief_pstid", "", Descriptor.Int64, 2);
			registerField("level", "", Descriptor.Int32, 3);
			registerField("anchor_pstid", "", Descriptor.Int64, 4);
			registerField("vg_desc", "", Descriptor.TypeString, 5);
			registerField("vg_name", "", Descriptor.TypeString, 6);
			registerField("vg_wealth", "", Descriptor.Int32, 7);
			registerField("vg_score", "", Descriptor.Int32, 8);
			registerField("vg_dismiss", "", Descriptor.Int32, 9);
			registerField("chief_name", "", Descriptor.TypeString, 10);
			registerField("chief_zname", "", Descriptor.TypeString, 11);
			registerField("anchor_cont_score", "", Descriptor.Int32, 12);
			registerField("anchor_give_score", "", Descriptor.Int32, 13);
			registerField("anchor_name", "", Descriptor.TypeString, 14);
			registerField("total_score", "", Descriptor.Int64, 15);
			registerField("create_time", "", Descriptor.Int32, 16);
			registerField("member_count", "", Descriptor.Int32, 17);
			registerField("member_limit", "", Descriptor.Int32, 18);
			registerField("vg_notice", "", Descriptor.TypeString, 19);
			registerField("last_month_score", "", Descriptor.Int32, 20);
			registerField("last_month_cont", "", Descriptor.Int32, 21);
			registerField("last_score_rank", "", Descriptor.Int32, 22);
			registerField("last_cont_rank", "", Descriptor.Int32, 23);
			registerField("system_score", "", Descriptor.Int32, 24);
			registerField("today_ticket_acc", "", Descriptor.Int32, 25);
			registerField("last_send_ticket_time", "", Descriptor.Int32, 26);
			registerField("fans_board_type", "", Descriptor.Int32, 27);
			registerField("fans_board_time_limit", "", Descriptor.Int32, 28);
			registerField("system_score_clear_time", "", Descriptor.Int32, 29);
			registerField("forbid_join_apply", "", Descriptor.Int32, 30);
			registerField("chief_qq", "", Descriptor.Int64, 31);
			registerField("vg_demise_time", "", Descriptor.Int32, 32);
			registerField("demised_chief_pstid", "", Descriptor.Int64, 33);
			registerField("pk_anchor_winner_order", "", Descriptor.Int32, 34);
			registerField("fans_board_name", "", Descriptor.TypeString, 35);
			registerField("custom_fans_board_name", "", Descriptor.TypeBoolean, 36);
			registerField("ban_custom_fans_board_time", "", Descriptor.Int32, 37);
			registerField("chief_wealth_level", "", Descriptor.Int32, 38);
			registerField("chief_wealth", "", Descriptor.Int32, 39);
			registerField("anchor_level", "", Descriptor.Int32, 40);
		}
		
		public var vgid : Int64 = new Int64();
		public var chief_pstid : Int64 = new Int64();
		public var level : int;
		public var anchor_pstid : Int64 = new Int64();
		public var vg_desc : String = "";
		public var vg_name : String = "";
		public var vg_wealth : int;
		public var vg_score : int;
		public var vg_dismiss : int;
		public var chief_name : String= "";
		public var chief_zname : String = "";
		public var anchor_cont_score : int;
		public var anchor_give_score : int;
		public var anchor_name : String = "";
		public var total_score : Int64 = new Int64();
		public var create_time : int;
		public var member_count : int;
		public var member_limit : int;
		public var vg_notice : String = "";
		public var last_month_score : int;
		public var last_month_cont : int;
		public var last_score_rank : int;
		public var last_cont_rank : int;
		public var system_score : int;
		public var today_ticket_acc : int;
		public var last_send_ticket_time : int;
		public var fans_board_type : int;
		public var fans_board_time_limit : int;
		public var system_score_clear_time : int;
		public var forbid_join_apply : int;
		public var chief_qq : Int64 = new Int64();
		public var vg_demise_time : int;
		public var demised_chief_pstid : Int64 = new Int64();
		public var pk_anchor_winner_order : int;
		public var fans_board_name : String = "";
		public var custom_fans_board_name : Boolean;
		public var ban_custom_fans_board_time : int;
		public var chief_wealth_level:int;  // 团长财富等级
		public var chief_wealth:int;//团长财富值
		public var anchor_level:int;//主播等级
	}
}
