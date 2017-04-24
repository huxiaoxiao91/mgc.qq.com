package com.h3d.qqx5
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.enum.PlayerSex;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.VideoWebPayParam;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientAdapter;
	
	import flash.utils.Dictionary;

	/**
	 * @author liuchui
	 */
	public class VideoClientX5Bridge implements IVideoClientAdapter
	{
		public function VideoClientX5Bridge()
		{
			
		}
		
		public function GetLocalPlayerQQ():Int64
		{
			return Int64.fromNumber(0);
			//return Int64.fromNumber(Globals.sCallCenter.GetQQ());
		}
		
		public function GetLocalPlayerPstid():Int64
		{
			return Int64.fromNumber(0);
			//return Globals.sVideoClient.GetVideoClientPlayer().GetVideoPersistID();
		}
		
		public function GetLocalPlayerName():String
		{
			return "";
			//return Globals.sVideoClient.GetVideoClientPlayer().GetVideoNick();
		}
		
		public function IsLocalPlayerMale():Boolean
		{
			return false;
			//return Globals.sVideoClient.GetVideoClientPlayer().IsMale();
		}
		
		public function GetZoneID():int
		{
			return 0;
			//return Globals.sCallCenter.GetZoneId();
		}
		
		public function GetPlayerLevel():int
		{
			return 0;
			//return Globals.sVideoClient.GetVideoClientPlayer().GetVideoLevel();
		}
		
//		public function GetVideoMoneyAmount():int
//		{
//			return Globals.sVideoClient.GetVideoClientPlayer().GetVideoMoneyNum();
//		}
//		
		public function RefreshMobilePlayerDiamondBalance(balance:int):void
		{
			// not used
		}
		public function GetVideoWebPayParam():VideoWebPayParam
		{
			var param:VideoWebPayParam = new VideoWebPayParam;
			param.open_id = GetLocalPlayerQQ().toString();
			param.open_key = "";//(m_player_module.getPaySKey());
			param.pay_token = "";
			param.pf = "";//setPf(global_config.MIDAS_PAY_PF);
			param.pf_key = "";// .setPf_key(global_config.MIDAS_PAY_PFKEY);
			return param;
		}
		
		public function SaveRaffleID(room_id:int, raffle_id:Int64) :void
		{
			return ;
		}
		public function GetRaffleID( raffle_id:Dictionary) :void
		{
			return ;
		}
	}	
}