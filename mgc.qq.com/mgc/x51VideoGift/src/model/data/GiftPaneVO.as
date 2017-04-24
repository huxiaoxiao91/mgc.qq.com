package model.data
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.bit101.utils.OverrideBulkLoader;
	import com.bit101.utils.XML2JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.utils.setTimeout;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	
	import model.DataProxy;
	
	import view.mediators.GiftPaneMediator;
	
	/**
	 * 
	 * 礼物界面数据模型
	 */
	public class GiftPaneVO extends EventDispatcher
	{
		private var _selectid:int = -1;
		
		/**
		 * 鼠标滑过的礼物id
		 */
		public var overid:int = -1;
		
		private var _giftList:Array = new Array();
		private var _giftIdArray:Array;
		
		private var _canInvite:Boolean = false;
		
		private var bulkLoader:BulkLoader = BulkLoader.getLoader("gift");
		
		private var overrideBulkLoader:OverrideBulkLoader;
		
		public var subjectGiftRate:int;
		public var nonSubjectGiftRate:int;
		
		private var giftObject:Object; //= GiftJosnData.DATA;
//		private var xml:XML;
		
		/**
		 * 服务器下发的礼物配置
		 */
		private var giftConfig:Object;
		
		/**
		 * 服务器下发的周星礼物配置
		 */
		private var starGiftConfig:Object;
		
		/**
		 * 服务器下发的PK礼物配置
		 */
		private var pkGiftConfig:Array;
		
		private var _isConcert:Boolean = false;
		
		/**
		 * 带随机数的礼物配置地址 
		 */
		private var configUrl:String;
		
		/**
		 * 配置的礼物id
		 */
		private var gifts:Array = [];
		
		public function GiftPaneVO()
		{
			initXML();
		}
		
		/**
		 * 选中的礼物id
		 */
		public function get selectid():int
		{
			return _selectid;
		}
		
		/**
		 * @private
		 */
		public function set selectid(value:int):void
		{
			_selectid = value;
			
			dispatchEvent(new Event("selectIdChange"));
		}
		
		/**
		 * 礼物列表
		 * [GiftVO]
		 */
		public function get giftList():Array
		{
			//过滤出数量为0的免费礼物
			/*var arr:Array = [];
			for(var i:int = 0;i < _giftList.length;i++)
			{
			var vo:GiftVO = _giftList[i] as GiftVO;
			if(vo.type == 1)
			{
			if(vo.num != 0)
			{
			arr.push(vo);
			}
			}
			else
			{
			arr.push(vo);
			}
			}
			
			return arr;*/
			
			return _giftList;
		}
		
		private var isXMLComplete:Boolean = false;
		private var _isCall:Boolean = false;
		
		public function set isCall(value:Boolean):void
		{
			_isCall = value;
			if(_isCall && isXMLComplete)
			{
				//Cc.warn("_isCall 执行");
				giftListComplete();
			}
		}
		
		
		public function set giftIdArray(value:Array):void
		{
			_giftIdArray = value;
			isCall = true;
		}
		
		public function set canInvite(value:Boolean):void
		{
			_canInvite = value;
			isCall = true;
		}
		
		public function get canInvite():Boolean
		{
			return _canInvite;
		}
		
		private var _isSupport:Boolean = false;
		
		public function get isSupport():Boolean
		{
			return _isSupport;
		}
		
		public function set isSupport(value:Boolean):void
		{
			_isSupport = value;
			isCall = true;
		}
		
		/**
		 * 是否是演唱会
		 */
		public function get isConcert():Boolean
		{
			return _isConcert;
		}
		
		/**
		 * @private
		 */
		public function set isConcert(value:Boolean):void
		{
			_isConcert = value;
			
			dispatchEvent(new Event("isConcert"));
		}
		
		
		private function giftListComplete():void
		{
			//清空
			_giftList.splice(0,_giftList.length);

			
			var ar:Array = giftObject.OpenPeriods.default.gifts.split(" ");
			var ar1:Array = []
			for each(var iii:uint in ar)
			{
				if(iii != 35 && iii != 36  && iii != 1 && iii != 100 && iii != 101 && iii != 102)
				{
					ar1.push(iii);
				}
			}
			ar = ar1;
				
			var giftDataArr:Array = giftObject.GiftData;
			if(_giftIdArray && _giftIdArray.length > 0)
			{
				var giftIdArray1:Array = [];
				for each(var iiii:uint in _giftIdArray)
				{
					if(iiii != 35 && iiii != 36 && iiii != 1 && iiii != 100 && iiii != 101 && iiii != 102)
					{
						giftIdArray1.push(iiii);
					}
				}
				_giftIdArray = giftIdArray1;
				
				//Cc.log("_giftIdArray = " + _giftIdArray.toString());
				
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
				
				gifts = _giftIdArray;
			}
			else
			{
				for (var j:uint=0; j<ar.length;j++)
				{
					var ar_y:uint = 0;
					var ar_giftDataObj:Object;
					for each(var ar_o:Object in giftDataArr)
					{
						if(int(ar[j]) == ar_o.id)
						{
							ar_giftDataObj = ar_o;
							break;
						}
						ar_y++;
					}
					giftDataArr.splice(ar_y,1);
					giftDataArr.splice(j,0,ar_giftDataObj);
				}
				
				gifts = ar;
			}
			
			
			var tempArr:Array = [];
			var count:uint = 0;
			for each(var oo:Object in giftDataArr)
			{
				var vo:GiftVO = new GiftVO(oo);
				//vo.icon = DataProxy.ImgDomain + "/css_img/flash/gift/gift_" + vo.id.toString() + ".png";
				vo.icon = DataProxy.ImgDomain +DataProxy.GIFT_PATH + vo.id.toString() + ".png";
				vo.isShow = false;
				if(_giftIdArray &&  count < _giftIdArray.length )
				{
					if(canInvite && vo.id == 16)
					{
						vo.isShow = true;
					}
					else if(!canInvite && vo.id == 16)
					{
						vo.isShow = false;
					}
					else if(vo.skinsubject > 0)
					{
						//xw74551 未解锁不显示专属礼物
						vo.isShow = DataProxy.isSkinOpened;
					}
					else
					{
						vo.isShow = true;
					}
				}
				else if(!_giftIdArray &&　count < ar.length)
				{
					if(canInvite && vo.id == 16)
					{
						vo.isShow = true;
					}
					else if(!canInvite && vo.id == 16)
					{
						vo.isShow = false;
					}
					else if(vo.skinsubject > 0)
					{
						//xw74551 未解锁不显示专属礼物
						vo.isShow = DataProxy.isSkinOpened;
					}
					else
					{
						vo.isShow = true;
					}
				}
				tempArr.push(vo);
				overrideBulkLoader.add(vo.icon);
				
				if(oo.hasOwnProperty("UIInfoList")){
					if(!(oo.UIInfoList.uiinfo is Array))
					{
						oo.UIInfoList.uiinfo = [oo.UIInfoList.uiinfo];
					}
					for each(var uiinfo:Object in oo.UIInfoList.uiinfo)
					{
						var effectVO:EffectVO = new EffectVO(uiinfo);
						effectVO.level = int(effectVO.path);
						effectVO.type = vo.type;
						//effectVO.path = DataProxy.ImgDomain + "/css_img/flash/gift/gift_" + vo.id.toString() + "_" + effectVO.path + ".swf";
						effectVO.path = DataProxy.ImgDomain +DataProxy.GIFT_PATH + vo.id.toString() + "_" + effectVO.path + ".swf";
						//trace("特效地址       " + effectVO.path + "      vo.id = " + vo.id + "    oo.UIInfoList.uiinfo.length = " + oo.UIInfoList.uiinfo.length);
						vo.effectList.push(effectVO);
					}
				}
				
				if(oo.hasOwnProperty("DropList")){
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
				count++;
			}
			_giftList = tempArr;
			
			changeGiftConfig(giftConfig);
			
			updataGiftStar(starGiftConfig);
			
			updataPKGift(pkGiftConfig);
			
			updataGiftNum(_GiftNumArray);
			//将礼物数据传给页面
			ExternalInterface.call("MGCData.setGiftData",_giftList);
			
			//更新显示列表
			dispatchEvent(new Event("giftList"));
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
		
		public function decodeXML(dataNode:XMLNode):Object
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
					var partObj:Object = decodeXML(partNode);
					
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
		
		/**
		 * 加载XML数据
		 */
		public function initXML():void
		{
			configUrl = DataProxy.GiftConfig + "?v=" + Math.random().toString();
			bulkLoader.add(configUrl);
			bulkLoader.addEventListener(BulkLoader.COMPLETE, onComplete);
			bulkLoader.start();

			//Cc.log("加载礼物XML:",DataProxy.GiftConfig);
		}
		
		/**
		 * XML加载完毕
		 */		
		private function onComplete(e:Event):void
		{
			bulkLoader.removeEventListener(BulkLoader.COMPLETE, onComplete);
			overrideBulkLoader = OverrideBulkLoader.getInstance();
			//解析
			var xml:XML = bulkLoader.getXML(configUrl);
			
			//Cc.log("礼物XML加载完毕：",xml);
			giftObject = XML2JSON.parse(xml);
			
			isXMLComplete= true;
			
			giftListComplete();	
			
			bulkLoader.dispatchEvent(new Event("XMLComplete"));
		}
		
		
		private var _isShowGuardFace:Boolean = false;
		
		public function get isShowGuardFace():Boolean
		{
			return _isShowGuardFace;
		}
		
		public function set isShowGuardFace(value:Boolean):void
		{
			if(_isShowGuardFace == value)
				return;
			
			_isShowGuardFace = value;
			if(_isShowGuardFace && _giftList.length > 0)
			{
				var temp:Array = [];
				for each(var vo:GiftVO in _giftList)
				{
					if(vo.id != 11)
					{
						temp.push(vo);
					}
				}
				
				_giftList = temp;
				dispatchEvent(new Event("giftList"));
			}
			
		}
		
		/**
		 *
		 * 初始化礼物效果
		 * 
		 */
		public function initEffectList():void
		{
			var giftDataArr:Array = giftObject.GiftData;
			for each(var o:Object in giftDataArr)
			{
				var vo:GiftVO = getGiftById(o.id);
				if(vo)
				{
					vo.effectList = [];
					
					if(o.hasOwnProperty("UIInfoList")){
						for(var j:int = 0;j<o.UIInfoList.uiinfo.length;j++)
						{
							var effectVO:EffectVO = new EffectVO();
							effectVO.count = o.UIInfoList.uiinfo[j].count;
							effectVO.level = o.UIInfoList.uiinfo[j].path;
							effectVO.path = o.UIInfoList.uiinfo[j].path;
							effectVO.path = DataProxy.ImgDomain +DataProxy.GIFT_PATH + vo.id.toString() + "_" + effectVO.path + ".swf";
							effectVO.isVipEffect = o.UIInfoList.uiinfo[j].isVipEffect;
							vo.effectList.push(effectVO);
						}
					}
				}
			}
		}
		
		/**
		 *
		 * 根据id获取礼物数据 
		 * @param id 礼物id
		 * @return 
		 * 
		 */		
		public function getGiftById(id:int):GiftVO
		{
			var vo:GiftVO;
			
			for(var i:int = 0;i < _giftList.length;i++)
			{
				if((_giftList[i] as GiftVO).id == id)
				{
					vo = _giftList[i] as GiftVO;
					return vo;
				}
			}
			
			return vo;
		}
		
		/**
		 * 获取免费礼物
		 */		
		public function getFreeGift():GiftVO
		{
			var vo:GiftVO;
			
			for(var i:int = 0;i < _giftList.length;i++)
			{
				if((_giftList[i] as GiftVO).type == 1)
				{
					vo = _giftList[i] as GiftVO;
					return vo;
				}
			}
			
			return vo;
		}
		
		private var _GiftNumArray:Object = null;
		
		public function updataGiftNum(o:Object):void {
			_GiftNumArray = o;
			
			for each (var giftVO:GiftVO in _giftList) {
				if (giftVO.type == 6 || giftVO.type == 8) {
					if (_GiftNumArray == null) {
						giftVO.num = 0;
					} else {
						if (_GiftNumArray.onlySkin) {
							if (giftVO.type == 8) {
								giftVO.num = 0;
							}
						} else {
							giftVO.num = 0;
						}
						for each (var objGift:Object in _GiftNumArray.videoGift) {
							if (giftVO.id == objGift.giftId) {
								giftVO.num = objGift.giftCount;
							}
						}
					}
				}else{
					// giftVO.type == 2 || giftVO.type == 3 || giftVO.type == 4 || giftVO.type == 5 || giftVO.type == 7
					if (_GiftNumArray == null) {
						giftVO.num = 0;
					} else {
//						if (!_GiftNumArray.onlySkin) {
							giftVO.num = 0;
							for each (var objGift:Object in _GiftNumArray.videoGift) {
								if (giftVO.id == objGift.giftId) {
									giftVO.num = objGift.giftCount;
								}
							}
//						}
					}
				}	
			}
		}
		
		/**
		 * 礼物配置变更
		 */		
		public function changeGiftConfig(obj:Object):void
		{
			if(!obj)return;
			
			giftConfig = obj;
			
			for each(var giftdata:Object in giftConfig)
			{
				var vo:GiftVO = getGiftById(giftdata.id);			
				if(vo)
				{
					vo.combo = giftdata.countinueCounts;
					
					var counts:Array = giftdata.counts;
					if(counts.length > 0)
					{
						vo.effectList = [];
					}
					
					for(var i:int = 0;i < counts.length;i++)
					{
						var effectVO:EffectVO = new EffectVO();
						effectVO.count = counts[i];
						effectVO.level = (i+1);
						effectVO.path = (i+1).toString();
						//effectVO.path = DataProxy.ImgDomain + "/css_img/flash/gift/gift_" + vo.id.toString() + "_" + effectVO.path + ".swf";
						effectVO.path = DataProxy.ImgDomain +DataProxy.GIFT_PATH + vo.id.toString() + "_" + effectVO.path + ".swf";
						vo.effectList.push(effectVO);
					}
				}
			}
		}
		
		/**
		 * 根据守护等级加锁礼物
		 * @param guardLevel 守护等级
		 * 
		 */		
		public function updataGuardLevel(guardLevel:int):void
		{
			var gift:GiftVO = getGiftById(40);
			if(!gift)return;
			var giftPaneMediator:GiftPaneMediator = ApplicationFacade.getInstance().retrieveMediator(GiftPaneMediator.NAME) as GiftPaneMediator;
			
			//高级守护礼物加锁
			if(guardLevel < 400)
			{	
				gift.isLock = true;
				gift.enabled = false;
			}
			else
			{
				gift.isLock = false;
				gift.enabled = true;
			}
		}
		
		/**
		 * 刷新周星礼物列表/冠名
		 */		
		public function updataGiftStar(obj:Object):void
		{	
			if(!obj)return;
			
			starGiftConfig = obj;
			
			//刷新冠名
			var star_gifts:Array = starGiftConfig.star_gifts;
			
			for(var i:int = 0;i<star_gifts.length;i++)
			{
				var gift:GiftVO = getGiftById(star_gifts[i].gift_id);
				
				if(gift)
				{
					gift.anchor_name = star_gifts[i].anchor_name;
					gift.player_name = star_gifts[i].player_name;
				}
			}
			
			//刷新周星礼物
			var cur_star_gifts:Array = starGiftConfig.cur_star_gifts;
			for(var j:int = 0;j<cur_star_gifts.length;j++)
			{
				var giftJ:GiftVO = getGiftById(cur_star_gifts[j].gift_id);
				if(giftJ)
				{
					giftJ.isStar = true;
				}
			}
		}
		
		/**
		 * 刷新pk礼物，pk的角标
		 */		
		public function updataPKGift(arr:Array):void
		{	
			if(!arr)return;
			
			pkGiftConfig = arr;
			
			for(var i:int = 0;i < _giftList.length;i++)
			{
				(_giftList[i] as GiftVO).isPK = false;
			}
			
			for(i = 0;i<pkGiftConfig.length;i++)
			{
				var gift:GiftVO = getGiftById(pkGiftConfig[i]);
				
				if(gift)
				{
					gift.isPK = true;
				}
			}
		}
		
		/**
		 * 判断某个礼物id是否在配置里
		 */		
		public function isGifts(id:int):Boolean
		{	
			for(var i:int = 0;i<gifts.length;i++)
			{
				if(id == gifts[i])
				{
					return true;
				}
			}
			
			return false;
		}
		
	}
}