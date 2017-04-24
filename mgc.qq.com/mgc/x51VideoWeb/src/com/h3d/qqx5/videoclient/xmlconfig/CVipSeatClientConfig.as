
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
	
	public class CVipSeatClientConfig
	{
		
		private var vip_seat_msg:Array = new Array;
		
		private var externalXML:XML;   
		private var loader:URLLoader;
		private static var m_Config:CVipSeatClientConfig = null;
		
		public static function  getInstance():CVipSeatClientConfig
		{
			if(m_Config == null)
			{
				m_Config = new CVipSeatClientConfig;
			}
			return m_Config;
		}
		
		public function CVipSeatClientConfig()
		{
			
		}
		
		public function LoadVipSeatConfig(file_path:String):Boolean
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
			//读取Vip 
			for ( i = 0;i<node.WhistleMsg.msg.length();i++)
			{
				var msg:String =node.WhistleMsg.msg[i].@value;
				vip_seat_msg.push(msg);
			}
		}
		
		public function GetVipSeatMsg(index:int):String
		{
			if( vip_seat_msg.length != 0 )
				return vip_seat_msg[index % vip_seat_msg.length];
			return null;
		}		
	}
}