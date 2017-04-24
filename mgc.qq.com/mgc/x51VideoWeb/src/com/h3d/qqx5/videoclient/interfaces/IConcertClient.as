package com.h3d.qqx5.videoclient.interfaces
{
	public interface IConcertClient
	{
		function IsConcert():Boolean ;
		
		// 获取演唱会购票url
		function GetBuyConcertTicketURL() :String;
		// 获取演唱会无票玩家在房间内显示的图片url
		function GetConcertStaticImageURL() :String;
		// 玩家是否有演唱会门票
		function HasConcertTicket() :Boolean;
		// 演唱会当前状态，是否开启
		function IsConcertStarted():Boolean;
	}
}