package com.h3d.qqx5.videoclient.xmlconfig
{
	import com.h3d.qqx5.videoclient.main.AnchorImpressionIDToName;
	import com.junkbyte.console.Cc;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import com.h3d.qqx5.common.Globals;
	public class CAnchorImpressionConfig implements IImpressionConfig
	{
		private var m_impression_cfg:Dictionary = new Dictionary;
		private var m_begin_time:int;
		private var m_end_time:int;
		private var xmlNode:XML;  
		
		public function CAnchorImpressionConfig(path:String)
		{
			ReadConfig(path);
		}
		
		public function ReadConfig(path:String):Boolean
		{
			if(!Parse(path))
			{
				Globals.s_logger.log("read file faile" + path);
				return false;
			}
			return true;
		}
		
		public function RefreshConfig(content:String ):Boolean
		{
			if(!Parse(content))
			{
				Globals.s_logger.log("read file faile" + content);
				return false;
			}
			return true;
		}
		
		public function GetImpressionName(impression_id:int):String
		{
			for (var k:String in m_impression_cfg)
			{
				var intk:int = int(k);
				if(intk == impression_id)
				{
					return m_impression_cfg[k];
				}
			}
			return "未知";
		}
		
		public function GetImpressionVec(impressions:Array):void
		{
			for (var k:String in m_impression_cfg)
			{
				var intk:int = int(k);
				impressions.push(intk);
			}
		}
		
		//读取解析xml
		private var loader:URLLoader;
		private function Parse(path:String):Boolean
		{
			m_impression_cfg = new Dictionary;
			
			var request:URLRequest = new URLRequest(path);
			loader = new URLLoader();
		
			try
			{
				loader.load(request);
			} 
			catch(error:Error) 
			{
				Globals.s_logger.error("A SecurityError has occurred reand" +path+"fail!");
				return false;
			}
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
					
			return true;
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			Globals.s_logger.error("can't open xml file ");
		}
		
		private function loaderCompleteHandler(event:Event):void 
		{			
			try
			{
				xmlNode = new XML(loader.data);
				readNodes(xmlNode);    
			}
			catch (e:TypeError)
			{
				Globals.s_logger.error("Could not parse the XML file.");
			}
		}
		private function readNodes(node:XML):void
		{			
			for (var i:int = 0;i<node.impression.length();i++)
			{
				var id:int = node.impression[i].@id;
				var name:String = node.impression[i].@name;		
				AnchorImpressionIDToName.PushImpressin(id,name);
				m_impression_cfg[id] = name;
			}
		}
	}
}