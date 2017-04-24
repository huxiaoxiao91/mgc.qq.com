package com.h3d.qqx5.videoclient.xmlconfig
{
	public interface IImpressionConfig
	{
		function GetImpressionName(impression_id:int):String;
		function GetImpressionVec(impressions:Array):void;
	}
}