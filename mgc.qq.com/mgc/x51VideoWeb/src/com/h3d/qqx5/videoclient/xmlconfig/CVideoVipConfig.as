package com.h3d.qqx5.videoclient.xmlconfig
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.videoclient.data.CReward;
	import com.h3d.qqx5.videoclient.data.VideoVipConfigInfo;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class CVideoVipConfig
	{
		
		private var vip_config:Dictionary = new Dictionary;
		private var m_vip_rule_url:String ;// vip相关介绍页面
		
		private var externalXML:XML;   
		private var loader:URLLoader;
		private static var m_VipConfig:CVideoVipConfig = null;
		
		public static function  getInstance():CVideoVipConfig
		{
			if(m_VipConfig == null)
			{
				m_VipConfig = new CVideoVipConfig;
			}
			return m_VipConfig;
		}
		
		public function CVideoVipConfig()
		{
			
		}
			
		public function LoadVideoVipConfig(file_path:String):Boolean
		{
			var request:URLRequest = new URLRequest(file_path);
			loader = new URLLoader();
			
			try
			{
				loader.load(request);
			} 
			catch(error:Error) 
			{
				Globals.s_logger.error("read xml fail!" + file_path);
				return false;
			}
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			
			return true;
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			Globals.s_logger.error("open video vip xml file faile");
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
			var j:int = 0;
			
			//读取Vip规则的网址
			m_vip_rule_url = node.RuleURL.@value;
			//读取Vip 
			for ( i = 0;i<node.Vip.length();i++)
			{
				var vipleve:int = node.Vip[i].@level;
				var info:VideoVipConfigInfo = new VideoVipConfigInfo;
				info.enter_broadcast_type = node.Vip[i].EnterBrodcast;
				info.exclusive_car = node.Vip[i].ExclusiveCar;
				info.vip_name = node.Vip[i].Name;
				info.vip_icon = node.Vip[i].Icon;
				info.vip_font = node.Vip[i].Font;
				info.whistle_font = node.Vip[i].WhistleFont;
				info.free_whistle_resource = node.Vip[i].BounceResource;
				info.card_pattern = node.Vip[i].CardPattern;
				info.entereffect =  node.Vip[i].CarEffect;
				
				if(node.Vip[i]..CanBeInvisible !=null)
					info.invisible = true;
				
				//每周福利，按照通用物品配置来走
				if(node.Vip[i].WeeklyReward != null)
				{
					for (j = 0;j< node.Vip[i].WeeklyReward.Item.length();j++)
					{
						var rinfo:CReward = new CReward;
						rinfo.type = node.Vip[i].WeeklyReward.Item[j].@type;
						rinfo.male_data = node.Vip[i].WeeklyReward.Item[j].@male_para;
						rinfo.female_data = node.Vip[i].WeeklyReward.Item[j].@female_para;
						rinfo.count = node.Vip[i].WeeklyReward.Item[j].@count;
						info.daily_rewards.push(rinfo);
					}
				}
				vip_config[vipleve] = info;
			}
		}
		
		public function GetEnterBroadcastType(vip_level:int):int
		{
			var vipinfo:VideoVipConfigInfo = GetVipConfigInfo( vip_level );
			if ( vipinfo != null )
				return vipinfo.enter_broadcast_type;
			return 0;
		}
		public function GetExclusiveCar(vip_level:int):int
		{
			var vipinfo:VideoVipConfigInfo = GetVipConfigInfo( vip_level );
			if ( vipinfo != null )
				return vipinfo.exclusive_car;
			return 0;
		}
		public function GetExclusiveMedal(vip_level:int):int
		{
			var vipinfo:VideoVipConfigInfo = GetVipConfigInfo( vip_level );
			if ( vipinfo != null )
				return vipinfo.exclusive_medal;
			return 0;
		}
		
		public function GetVipName(vip_level:int):String
		{
			var vipname:String = "";
			switch(vip_level)
			{
				case 0:
					vipname = "";//非贵族
					break;
				case 1:
					vipname = "近卫";//近卫
					break;
				case 2:
					vipname = "骑士";//骑士
					break;
				case 3:
					vipname = "将军";//将军
					break;
				case 4:
					vipname = "亲王";//亲王
					break;
				case 5:
					vipname = "皇帝";//皇帝
					break;
			}
			return vipname;			
		}
		public function GetVipIcon(vip_level:int):String
		{
			var vipinfo:VideoVipConfigInfo = GetVipConfigInfo( vip_level );
			if ( vipinfo != null )
				return vipinfo.vip_icon;
			return "";
		}
		public function GetVipFont(vip_level:int):String
		{
			var vipinfo:VideoVipConfigInfo = GetVipConfigInfo( vip_level );
			if ( vipinfo != null )
				return vipinfo.vip_font;
			return "";
		}
		public function GetVipWhistleFont(vip_level:int):String
		{
			var vipinfo:VideoVipConfigInfo = GetVipConfigInfo( vip_level );
			if ( vipinfo != null )
				return vipinfo.whistle_font;
			return "";
		}
		public function GetBounceResource(vip_level:int):String
		{
			var vipinfo:VideoVipConfigInfo = GetVipConfigInfo(vip_level);
			if ( vipinfo != null )
				return vipinfo.free_whistle_resource;
			return "vip_whistle_lv0";
		}
		public function GetCardPattern(vip_level:int):String
		{
			var vipinfo:VideoVipConfigInfo = GetVipConfigInfo( vip_level );
			if ( vipinfo != null )
				return vipinfo.card_pattern;
			return "";
		}
		public function GetVipUrl():String
		{
			return m_vip_rule_url;
		}
		public function GetEnterVideoRoomEffect(vip_level:int):String
		{
			var vipinfo:VideoVipConfigInfo = GetVipConfigInfo( vip_level );
			if ( vipinfo != null )
				return vipinfo.entereffect;
			return "";
		}
		public function GetVipDailyReward(vip_level:int, reward:Array):Boolean
		{
			reward.splice(0);
			var vipinfo:VideoVipConfigInfo = GetVipConfigInfo(vip_level);
			if (vipinfo == null )
			{
				reward = vipinfo.daily_rewards;
				return true;
			}
			return false;
		}
		public function CanBeInvisible(vip_level:int):Boolean
		{
			var vipinfo:VideoVipConfigInfo = GetVipConfigInfo(vip_level);
			if(null != vipinfo)
			{
				return false;
			}
			return vipinfo.invisible;
		}
		
		public function GetAllVipMedal():Array
		{
			var ret:Array = new Array;
			for (var key:String in vip_config)
			{
				ret.push(int(key));
			}
			return ret;
		}
		//获取贵族昵称颜色
		public function GetVipNickColor(vip_level:int):String
		{
			var nickColor:String = "#111111";
			switch(vip_level)
			{
				case 0:
					nickColor = "#111111";//非贵族
					break;
				case 1:
					nickColor = "#1a6b00";//近卫
					break;
				case 2:
					nickColor = "#006772";//骑士
					break;
				case 3:
					nickColor = "#0a57af";//将军
					break;
				case 4:
					nickColor = "#8f00b1";//亲王
					break;
				case 5:
					nickColor = "#ae5600";//皇帝
					break;
			}
			return nickColor;
		}
		
		public function GetVipConfigInfo(vip_level:int):VideoVipConfigInfo
		{
			for (var key:String in vip_config)
			{
				if(vip_level == int(key))
					return vip_config[key];
			}
			return null;
		}		
	}
}