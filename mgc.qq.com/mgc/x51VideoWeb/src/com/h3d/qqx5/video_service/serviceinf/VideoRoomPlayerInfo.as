package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.common.comdata.UserIdentity;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class VideoRoomPlayerInfo extends ProtoBufSerializable
	{
		public function VideoRoomPlayerInfo()
		{
			registerField("online", "", Descriptor.TypeBoolean, 1);
			registerField("zoneName", "", Descriptor.TypeString, 2);
			registerField("playerNick", "", Descriptor.TypeString, 3);
			registerField("playerType", "", Descriptor.Int32, 4);
			registerField("sex", "", Descriptor.Int32, 5);
			registerField("level", "", Descriptor.Int32, 6);
			registerField("uid", getQualifiedClassName(UserIdentity), Descriptor.Compound, 7);
			registerField("pstid", "", Descriptor.Int64, 8);
			registerField("wealth", "", Descriptor.Int64, 9);
			registerField("affinity", "", Descriptor.Int64, 10);
			registerField("total_affinity", "", Descriptor.Int64, 11);
			registerField("chat_banned", "", Descriptor.Int32, 12);
			registerField("portrait_info", "", Descriptor.Int32, 13);
			registerField( "ip", "", Descriptor.UInt32, 14 );
			registerField("guardLevel", "", Descriptor.Int32, 15);
			registerField("purplediamond_level", "", Descriptor.Int32, 16);
			registerField("nfpurplediamond_user", "", Descriptor.Int32, 17);
			registerField("video_vip_level", "", Descriptor.Int32, 18);
			registerField("video_vip_expire", "", Descriptor.Int32, 19);
			registerField("judge_type", "", Descriptor.Int32, 20);
			registerField("talent_show_rank", "", Descriptor.Int32, 21);
			registerField("star_anchor", "", Descriptor.Int32, 22);
			registerField("pk_richman_order", "", Descriptor.Int32, 23);
			registerField("annual2014_title", "", Descriptor.Int32, 24);
			registerField("invisible", "", Descriptor.TypeBoolean, 25);//隐身
			registerField("assistant", "", Descriptor.TypeBoolean, 26);
			registerField("nest_star", "", Descriptor.Int64, 27);
			registerField("credits_level","",Descriptor.Int32,28);
			registerField("video_level","",Descriptor.Int32,29);
			registerField("video_exp","",Descriptor.Int32,30);
			registerField("video_levelup_exp","",Descriptor.Int32,31);
			registerField("m_player_url","",Descriptor.TypeString,32);
			registerField("is_anchor_pk_anchor","",Descriptor.TypeBoolean,33);
			registerField("wealth_level","",Descriptor.Int32,34);
			registerField("anchor_level","",Descriptor.Int32,35);
		}
		public function  IsPerpetualChatBan() :Boolean
		{
			return (chat_banned & RoomPlayerChatBanType.RPCB_Perpetual_Ban) ? true : false;
		}
		public function  IsNormalChatBan() :Boolean
		{
			return (chat_banned & RoomPlayerChatBanType.RPCB_Normal_Ban) ? true : false;
		}
		
		public function IsChatBanAllRoom() :Boolean 
		{
			return (chat_banned &RoomPlayerChatBanType. RPCB_Ban_All_Room) ? true : false;
		}
		
		public function  IsChatBan() :Boolean
		{
			if(IsPerpetualChatBan())
			{
				return true;
			}
			else if(IsNormalChatBan())
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		public var online : Boolean;
		public var zoneName : String ="";
		public var playerNick : String ="";
		public var playerType : int;
		public var sex : int;
		public var level:int;
		public var uid :UserIdentity = new UserIdentity;
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
		public var credits_level:int;
		public var video_level:int;
		public var video_exp:int;
		public var video_levelup_exp:int;
		public var m_player_url:String = "";
		public var is_anchor_pk_anchor:Boolean;////是否为主播pk主播
		public var wealth_level:int;//财富等级
		public var anchor_level:int;//主播等级
	}
}
