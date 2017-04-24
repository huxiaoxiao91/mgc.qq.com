package com.h3d.qqx5.videoclient.xmlconfig
{
	import com.h3d.qqx5.videoclient.data.ActivityRewardData;
	import com.h3d.qqx5.videoclient.data.LotType;
	import com.h3d.qqx5.common.Globals;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class CVideoActivityRewardConfig
	{
		private var rewardData:Array = null;//ActivityRewardData
		private var externalXML:XML;   
		private var loader:URLLoader;
		private static var instance:CVideoActivityRewardConfig = null;
		
		public static function getInsatce():CVideoActivityRewardConfig
		{
			if(instance == null)
				instance = new CVideoActivityRewardConfig;
			return instance;
		}
					
		//读取解析xml	
		public function LoadActivityRewardConfig(path:String):Boolean
		{			
			var request:URLRequest = new URLRequest(path);
			rewardData = new Array;
			loader = new URLLoader();
			
			try
			{
				loader.load(request);
			} 
			catch(error:Error) 
			{
				Globals.s_logger.error("read xml fail!");
				return false;
			}
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);			
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);			
			return true;
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			Globals.s_logger.error("open activity reward xml file faile");
		}
		
		private function loaderCompleteHandler(event:Event):void 
		{			
			try
			{
				externalXML = new XML(loader.data);
				readNodes(externalXML);    
			}
			catch (e:TypeError)
			{
				Globals.s_logger.error("parse the XML file fail!");
			}
		}
		
		private function readNodes(node:XML):void
		{			
			var i:int = 0;
			for (i=0; i<node.GiftData.length();i++)
			{
				var tmp:ActivityRewardData = new ActivityRewardData;
				tmp.giftType = node.GiftData[i].@gift_type;
				tmp.giftId = node.GiftData[i].@id;
				tmp.giftName = node.GiftData[i].Name;
				tmp.giftIcon = node.GiftData[i].Icon;
				tmp.giftIntro = node.GiftData[i].Intro;			
				rewardData.push(tmp);
			}
		}
		
		//获取奖励名称
		public function GetRewardName(type:int,id:int):String
		{
			var name:String = "未知名称";
			
			for each(var rd:ActivityRewardData in rewardData)
			{
				if(rd.giftType == type)
				{
					if(type == LotType.LotType_VideoExp || type == LotType.LotType_VideoMoney || rd.giftId == id)
					{
						name = rd.giftName;
						break;
					}					
				}			
			}			
			return name;
		}
		
		//获取奖励图标
		public function GetRewardIcon(type:int,id:int):String
		{
			var icon:String = "未知图标";
			for each(var rd:ActivityRewardData in rewardData)
			{
				if(rd.giftType == type)
				{
					if(type == LotType.LotType_VideoExp || type == LotType.LotType_VideoMoney || rd.giftId == id)
					{
						icon = rd.giftIcon;
						break;
					}					
				}
			}
			return icon;
		}
		
		//获取奖励介绍
		public function GetRewardIntro(type:int,id:int):String
		{
			var intro:String = "未知";
			for each(var rd:ActivityRewardData in rewardData)
			{
				if(rd.giftType == type)
				{
					if(type == LotType.LotType_VideoExp || type == LotType.LotType_VideoMoney || rd.giftId == id)
					{
						intro = rd.giftIntro;
						break;
					}					
				}
			}
			return intro;
		}
	}
}