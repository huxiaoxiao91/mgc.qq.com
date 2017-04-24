package com.h3d.qqx5.videoclient.xmlconfig
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.gift.GiftVO;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;

	public class CGiftConfig
	{
		public function CGiftConfig()
		{
		}
		
		private var externalXML:XML;   
		private var loader:URLLoader;
		private var _giftList:Array = new Array();
		private var _giftIdArray:Array;
//		private var _luckyDrawData:Object;
		
		//private var GiftConfig:String = "http://ossweb-img.qq.com/images/mgc/css_img/config/gift.xml?v=" + (new Date()).time;
		/**
		 * 礼物配置文件地址。从private转换为public static让这个配置可以通过其他配置文件修改。
		 */		
		public static var GiftConfig:String = "/img/css_img/config/gift.xml";
		
		//private var iconPath:String = "http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/gift_"
		/**
		 * 礼物swf地址。从private转换为public static让这个配置可以通过其他配置文件修改。
		 */
//		public static var iconPath:String = "/img/css_img/flash/gift/gift_";
//		private var GiftConfig:String = "http://124.207.138.230/img1/css_img/config/gift.xml";
		public static var iconPath:String = "http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/gift_";
			
		private static var m_giftConfig:CGiftConfig = null;
		
		public var subjectGiftRate:int;
		public var nonSubjectGiftRate:int;
		
		public static function  getInstance():CGiftConfig
		{
			if(m_giftConfig == null)
			{
				m_giftConfig = new CGiftConfig;
			}
			return m_giftConfig;
		}
		
		public function LoadGiftConfig():Boolean
		{
			var request:URLRequest = new URLRequest(GiftConfig);
			loader = new URLLoader();
			
			try
			{
				loader.load(request);
			} 
			catch(error:Error) 
			{
				Globals.s_logger.error("read xml fail!" + GiftConfig);
				return false;
			}
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			
			return true;
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			Globals.s_logger.error("open video gift xml file faile");
		}
		
		private function loaderCompleteHandler(event:Event):void 
		{			
			try
			{
				externalXML = new XML(loader.data);
				readXML();    
			}
			catch (e:TypeError)
			{
				Globals.s_logger.error("parse the XML file fail!");
			}
		}
		
		private function  readXML():void
		{
			_giftList.splice(0,_giftList.length);
//			trace(externalXML);
			var obj:Object = readNodes(new XMLDocument(externalXML));

			if (obj.hasOwnProperty("SubjectGiftRate")) {
				subjectGiftRate = obj["SubjectGiftRate"]
			}
			if (obj.hasOwnProperty("SubjectGiftRate")) {
				nonSubjectGiftRate = obj["NonSubjectGiftRate"]
			}
			
//			trace(JSON.stringify(obj));
			var ar:Array = obj.VideoGiftCfg.OpenPeriods.default.gifts.split(" ");
			var ar1:Array = [];
			for each(var iii:uint in ar)
			{
				if(iii == 35 || iii == 36 || iii == 1 || iii == 16)
				{
					
				}
				else
				{
					ar1.push(iii);
				}
			}
			ar = ar1;
			var giftDataArr:Array = obj.VideoGiftCfg.GiftData;
			if(_giftIdArray && _giftIdArray.length > 0)
			{
				var giftIdArray1:Array = [];
				for each(var iiii:uint in _giftIdArray)
				{
					if(iiii == 35 || iiii == 36 || iiii == 1 || iiii == 16)
					{
						
					}
					else
					{
						giftIdArray1.push(iiii);
					}
				}
				_giftIdArray = giftIdArray1;
				
				
				for (var i:uint=0; i<_giftIdArray.length;i++)
				{
					var y:uint = 0;
					var giftDataObj:Object;
					for each(var o:Object in giftDataArr)
					{
						if(int(_giftIdArray[i]) == o.id)
						{
							giftDataObj = o;
							break;
						}
						y++;
					}
					giftDataArr.splice(y,1);
					giftDataArr.splice(i,0,giftDataObj);
				}
			}
			else
			{
				for (var idx:uint=0; idx<ar.length;idx++)
				{
					var idx_y:uint = 0;
					var gift_Obj:Object;
					for each(var gifto:Object in giftDataArr)
					{
						if(int(ar[idx]) == gifto.id)
						{
							gift_Obj = gifto;
							break;
						}
						idx_y++;
					}
					giftDataArr.splice(idx_y,1);
					giftDataArr.splice(idx,0,gift_Obj);
				}
			}
			
			
			var tempArr:Array = [];
			for each(var oo:Object in giftDataArr)
			{
				var vo:GiftVO = new GiftVO(oo);
				vo.icon = iconPath + vo.id.toString() + ".png";
				tempArr.push(vo);
				for each(var item:Object in oo.DropList)
				{
					if(item is Array)
					{
						vo.dropList = item as Array;
					}
					else
					{
						vo.dropList.push(item);
					}
				}
			}
			_giftList = tempArr;

//			if (obj.VideoGiftCfg.hasOwnProperty("LuckyDraw")) {
//				_luckyDrawData = obj.VideoGiftCfg.LuckyDraw;
//			}
		}
		
		public function simpleType(val:Object):Object
		{
			var result:Object = val;
			
			if (val != null)
			{
				if (val is String && String(val) == "")
				{
					result = val.toString();    
				}
				else if (isNaN(Number(val)) || (val.charAt(0) == '0') || ((val.charAt(0) == '-') && (val.charAt(1) == '0')) || val.charAt(val.length -1) == 'E')
				{
					var valStr:String = val.toString();
					
					var valStrLC:String = valStr.toLowerCase();
					if (valStrLC == "true")
						result = true;
					else if (valStrLC == "false")
						result = false;
					else
						result = valStr;
				}
				else
				{
					result = Number(val);
				}
			}
			
			return result;
		}
		
		public function getLocalName(xmlNode:XMLNode):String
		{
			var name:String = xmlNode.nodeName;
			var myPrefixIndex:int = name.indexOf(":");
			if (myPrefixIndex != -1)
			{
				name = name.substring(myPrefixIndex+1);
			}
			return name;
		}
		
		
		private function readNodes(dataNode:XMLNode):Object
		{	
			var result:Object;
			var isSimpleType:Boolean = false;
			
			if (dataNode == null)
				return null;
			
			var children:Array = dataNode.childNodes;
			if (children.length == 1 && children[0].nodeType == XMLNodeType.TEXT_NODE)
			{
				isSimpleType = true;
				result = simpleType(children[0].nodeValue);
			}
			else if (children.length > 0)
			{
				result = {};
				
				for (var i:uint = 0; i < children.length; i++)
				{
					var partNode:XMLNode = children[i];
					
					if (partNode.nodeType != XMLNodeType.ELEMENT_NODE)
					{
						continue;
					}
					
					var partName:String = getLocalName(partNode);
					var partObj:Object = readNodes(partNode);
					
					var existing:Object = result[partName];
					if (existing != null)
					{
						if (existing is Array)
						{
							existing.push(partObj);
						}
						else
						{
							existing = [existing];
							existing.push(partObj);
							
							result[partName] = existing;
						}
					}
					else
					{
						result[partName] = partObj;
					}
				}
			}
			
			var attributes:Object = dataNode.attributes;
			for (var attribute:String in attributes)
			{
				if (attribute == "xmlns" || attribute.indexOf("xmlns:") != -1)
					continue;
				
				if (result == null)
				{
					result = {};
				}
				
				result[attribute] = simpleType(attributes[attribute]);
			}
			
			return result;
		}
		
		public function GetGiftData(giftid:int):Object
		{
			var obj:Object = new Object;
			for (var i:int = 0; i < _giftList.length; i++) 
			{
				var vo:GiftVO = _giftList[i];
				if( vo.id == giftid )
				{
					obj.id = vo.id;
					obj.name = vo.name;
					obj.price = vo.price;
					obj.icon = vo.icon;
					obj.intro = vo.intro;
					if (vo.icon != null && vo.icon != "") {
						if (String(vo.icon).indexOf(path) == 0) {
						var path:String = "/img/css_img";
							obj.css_url = String(vo.icon).substr(path.length);
						}
					}
					obj.skin_id = vo.skinsubject;
					obj.price = vo.price;
					return obj;
				}
			}
			return null;
		}
		
		public function GetGiftDropListData(giftid:int):Array
		{
			var obj:Array = new Array;
			for (var i:int = 0; i < _giftList.length; i++) 
			{
				var vo:GiftVO = _giftList[i];
				if( vo.id == giftid )
				{
					obj = vo.dropList;
				}
			}
			return obj;
		}

//		public function getLuckyDrawPrice():int {
//			if (_luckyDrawData != null) {
//				return _luckyDrawData.Price;
//			}
//			return 0;
//		}
	}
}