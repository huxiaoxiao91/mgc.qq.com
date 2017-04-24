package com.h3d.qqx5.videoclient.interfaces
{
	/**
	 * @author liuchui
	 */
	public interface IUISurpriseBox
	{
		function OnUpdateSurpriseBoxStatus(activity_id:int,active:Boolean, percent:int, left_open_box_times:int, cd_seconds:int, need_flower_count:int,total_cd_seconds:int,nest_left_open_times:int):void;
		function OnOpenSurpriseBoxResult(error_code:int):void;
	}	
}