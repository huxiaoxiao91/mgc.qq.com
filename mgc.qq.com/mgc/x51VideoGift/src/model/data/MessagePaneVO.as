package model.data
{	
	import com.bit101.components.Component;
	import com.bit101.utils.MessageSpanElement;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	import flashx.textLayout.elements.InlineGraphicElement;
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.events.FlowElementMouseEvent;
	import flashx.textLayout.formats.TextDecoration;
	
	import model.DataProxy;
	
	import view.components.MessageSprite;

	/**
	 * 
	 * 礼物消息界面数据模型
	 */
	public class MessagePaneVO extends EventDispatcher
	{
		/**
		 * 文本数据
		 */
		public var content:Component;
		
		//seo①更改为200ms
		//seoII 定时器一秒钟触发两次，每次最多处理10条
		private var timer:Timer = new Timer(20);
		
		/**
		 * 原始礼物消息数组
		 */
		public var msgArray:Array = [];
		
		/**
		 * 模拟生成消息数组
		 */
		public var msgArray2:Array = [];
		
		/**
		 * 列表宽度。
		 */		
		public var listWidth:int;
		
		public var listContentHeight:int;
		
		/**
		 * 当前送礼的玩家ID
		 */
		private var senderPlayerID:String = "";
		
		/**
		 * 当前连送次数   大于1为有连送
		 */
		private var continuous_send_gift_times:int = 0;
		
		/**
		 * 礼物消息显示对象池  100个
		 */
		private var messageSpriteArr:Array = [];
		
		/**
		 * 当前正在显示的礼物显示对象索引
		 */
		private var messageSpriteIndex:int = 0;
		
		/**
		 * 当前正在播放的消息数据
		 */
		private var curGiftData:GiftData; 
		
		/**
		 * 开始，结束，时间间隔
		 * 毫秒
		 */
		private var startTime:Number = 0;
		private var endTime:Number = 0;
		private var nowTime:Number = 0;
		private var gapTime:Number = 3000;
		
		private var _isPlay:Boolean = false;
		
		public function MessagePaneVO()
		{
			initMessageSpriteArr();
			
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
		}
		
		public function get isPlay():Boolean
		{
			return _isPlay;
		}

		public function set isPlay(value:Boolean):void
		{
			_isPlay = value;
			
			if(isPlay)
			{
				startTime = (new Date()).time;
				endTime = startTime + 3000;
			}
		}

		/**
		 * 
		 * 初始化礼物消息显示对象池
		 * 
		 */		
		private function initMessageSpriteArr():void
		{
			for(var i:int = 0;i<100;i++)
			{
				var messageSprite:MessageSprite = new MessageSprite();
				messageSpriteArr.push(messageSprite);
			}
		}
		
		/**
		 * 
		 * 获取下一个要显示的礼物消息
		 * 
		 */	
		private function getNextMessageSprite():MessageSprite
		{
			var messageSprite:MessageSprite = messageSpriteArr[messageSpriteIndex];
			
			messageSpriteIndex++;
			if(messageSpriteIndex == messageSpriteArr.length)
			{
				messageSpriteIndex = 0;
			}
			
			return messageSprite;
		}

		private function timerHandler(e:TimerEvent):void {
			if (curGiftData) {
				showMessage(curGiftData);
				return;
			}

			if (msgArray.length != 0) {
				sortMessage();
				curGiftData = msgArray[0];
				showMessage(curGiftData);
				return;
			}
		}
		
		/**
		 * 刷新礼物消息排序
		 */
		public function sortMessage():void
		{
			if(msgArray.length == 0)return;
			
			//优先显示自己
			var tempArr:Array = msgArray.filter(filterSelf);
			var length:int = tempArr.length;
			if(length != 0)
			{
				for(var i:int = tempArr.length - 1;i>=0;i--)
				{
					var data:GiftData = tempArr[i];
					var index:int = msgArray.indexOf(data);
					if(index != -1)
					{
						msgArray.splice(index,1);
						msgArray.splice(0,0,data);		
					}
					
					data.setPlayTime(3/length);
				}
				return;
			}
				
			//是否新一轮
			nowTime = (new Date()).time;
			if(nowTime > endTime)
			{
				startTime = (new Date()).time;
				endTime = startTime + 3000;
				//按时间顺序
				msgArray.sortOn(["createTime","senderPlayerID"],[Array.NUMERIC,Array.NUMERIC]);
				
				senderPlayerID = msgArray[0].senderPlayerID;
			}

			//将当前的玩家送礼消息置前
			var tempArrJ:Array = msgArray.filter(filterPlayer);
			var lengthJ:int = tempArrJ.length;
			for(var j:int = tempArrJ.length - 1;j>=0;j--)
			{
				var dataJ:GiftData = tempArrJ[j];
				var indexJ:int = msgArray.indexOf(dataJ);
				if(indexJ != -1)
				{
					msgArray.splice(indexJ,1);
					msgArray.splice(0,0,dataJ);		
				}
				
				dataJ.setPlayTime(3/lengthJ);
			}
			
			//dispatchEvent(new Event("MessagePaneVO.sortMessage"));
			
		}
		
		
		private function filterPlayer(element:GiftData, index:int, arr:Array):Boolean
		{
			if((element.senderPlayerID == senderPlayerID) && (nowTime < endTime))
			{
				return true;
			}
			return false;
		}
		
		/**
		 * 
		 * 过滤自己
		 * 
		 */		
		private function filterSelf(element:GiftData, index:int, arr:Array):Boolean
		{
			if((element.senderPlayerID == DataProxy.userId) && (nowTime < endTime))
			{
				return true;
			}
			return false;
		}
		
		/**
		 * 
		 * 获取下一个礼物消息
		 * 先播当前连送玩家的  再播自己的
		 * 
		 */
		private function getNextMsg():GiftData
		{
			var vo:GiftData;
			
			
			
			return vo;
			
			//是否连送
			/*if(continuous_send_gift_times > 0)
			{
				for(var i:int = 0;i<msgArray.length;i++)
				{
					//找到同一个玩家
					if(msgArray[i].senderPlayerID == senderPlayerID)
					{
						vo = msgArray.splice(i,1)[0];
						senderPlayerID = vo.senderPlayerID;
						continuous_send_gift_times = vo.continuous_send_gift_times;
						return vo;
					}
				}
			}*/
			
			//找到自己
			/*for(i = 0;i<msgArray.length;i++)
			{
				if(msgArray[i].senderPlayerID == DataProxy.userId)
				{
					vo = msgArray.splice(i,1)[0];
					senderPlayerID = vo.senderPlayerID;
					continuous_send_gift_times = vo.continuous_send_gift_times;
					return vo;
				}
			}*/
			
			//顺序播放
			/*vo = msgArray.shift();
			senderPlayerID = vo.senderPlayerID;
			continuous_send_gift_times = vo.continuous_send_gift_times;
			return vo;*/
		}
		
		/**
		 * 
		 * 是否加速播放礼物消息
		 * 当队列中有连送礼物时  加速播放
		 * 
		 */
		private function isQuick():Boolean
		{
			for(var i:int = 0;i < msgArray.length;i++)
			{
				if(msgArray[i].continuous_send_gift_times > 0)
				{
					return true;
				}
			}	
			return false;
		}
		
		
		/**
		 * 
		 * 加速播放当前礼物消息
		 * 保留100条  后10条 中间90条
		 */
		public function currentQuick():void
		{
			if(msgArray2.length < 100)return;
			
			var arr:Array = [];
			var length:int = msgArray2.length;
			var numArr:Array = [];
			var end:int = length - 10;
			
			var i:int;
			var vo:Object;
			
			//取后10个
			for(i = end;i < length; i++)
			{
				numArr.push(i);
			}
			
			//取中间90个
			var tempArr:Array = [];
			for(var j:int = 0;j < end;j++)
			{
				tempArr.push(j);
			}
			
			tempArr = randomArr(tempArr);
			tempArr.splice(90);
			
			numArr = numArr.concat(tempArr);
			numArr.sort(Array.NUMERIC);	
			
			for(i = 0;i < numArr.length; i++)
			{
				vo = msgArray2[numArr[i]];
				arr.push(vo);
			}
			
			msgArray2 = arr;
		}
		
		/** 随机排列数组里的顺序 */
		public function randomArr(arr:Array):Array
		{
			var _arr:Array = [];
			var length:uint = arr.length;
			for(var i:uint; i<length; i++)
			{
				var random:uint = Math.random() * arr.length;
				_arr.push(arr[random]);
				arr.splice(random, 1);
			}
			return _arr;
		}

		/**
		 *
		 * 移除所有消息
		 *
		 */
		public function removeAllMessage():void
		{
			msgArray.splice(0, msgArray.length);

			while (content.numChildren > 0)
			{
				var disObj:DisplayObject = content.removeChildAt(0);
				disObj = null;
			}
			content.dispatchEvent(new Event("updateEvent"));
		}
		
		public function clear():void
		{
			msgArray.splice(0,msgArray.length);
			
			curGiftData = null;
			
			while(content.numChildren > 0)
			{
				var disObj:DisplayObject = content.removeChildAt(0);
				disObj = null;
			}
			content.dispatchEvent(new Event("updateEvent"));
			
		}
		
		/**
		 * 添加一条礼物消息
		 */
		public function addMessage(vo:GiftData):void
		{
			msgArray.push(vo);
			sortMessage();
		}

		private var count:Number = 0;

		/**
		 * 显示一条礼物消息
		 * o示例  {"gift":{"senderName":"mynamesasa","anchorID":"871838309","anchorName":"sasa","male":false,"giftName":"鲜花","senderPlayerID":"7810934898697105","giftIcon":null,"data":{"length":0,"objectEncoding":3,"bytesAvailable":0,"endian":"bigEndian","position":0},"giftItemID":1,"invisible":false,"ceremony":false,"count":1,"popularityChange":0,"occupyIndex":0,"sender_channelid":0,"vip_level":0,"support_degree_add":0,"zoneName":"web大区"},"op_type":36}
		 * seoII 增加每次显示最大显示条数设置。
		 * @param vo
		 * @param unitMaxCount
		 * 
		 */
		public function showMessage(vo:GiftData, unitMaxCount:int = 10):void {
			//count++;

			//超过100个段落不保存
			while (content.numChildren > 100) {
				var disObj:DisplayObject = content.removeChildAt(0);
				if (disObj is MessageSprite) {
					(disObj as MessageSprite).destroy();
				}
				disObj = null;
			}

			//seo③每次只显示一条消息
			//播完的移除
//			if ((vo.curCount + vo.perCount - 1) > vo.maxCount) {
//				vo.perCount = vo.maxCount - vo.curCount + 1;
//				var index:int = msgArray.indexOf(curGiftData);
//				if (index != -1) {
//					msgArray.splice(index, 1);
//				}
//				curGiftData = null;
//			}

			//vo.curCount 该播的条目编号
			if (vo.curCount <= vo.maxCount) {
				//只显示一条
//				vo.perCount = 1;
				
				if(vo.curCount + unitMaxCount <= vo.maxCount){
					vo.perCount = unitMaxCount;
					unitMaxCount = 0;
				} else {
					vo.perCount = vo.maxCount - vo.curCount + 1;
					unitMaxCount -= vo.perCount;
				}
				
				for (var j:int = vo.curCount; j < (vo.curCount + vo.perCount); j++) {
					var messageSprite:MessageSprite = getNextMessageSprite();
					vo.count = j;
					messageSprite.listWidth = listWidth;
					messageSprite.data = vo;
					content.addChild(messageSprite);
				}
			}
			vo.curCount = vo.curCount + vo.perCount;
			if (vo.curCount > vo.maxCount) {
				var index:int = msgArray.indexOf(curGiftData);
				if (index != -1) {
					msgArray.splice(index, 1);
				}
				curGiftData = null;
				//如果单次显示的数量未达到最大限制的情况下，判断是否显示下一条送礼消息。
				if (unitMaxCount > 0) {
					if (msgArray.length > 0) {
						sortMessage();
						curGiftData = msgArray[0];
						showMessage(curGiftData, unitMaxCount);
						return;
					}
				}
			}

//			content.dispatchEvent(new Event("updateEvent"));

			listContentHeight = 0;
			var i:uint = 0;
			while (i < content.numChildren) {
				var sortMS:MessageSprite = content.getChildAt(i) as MessageSprite;
				sortMS.y = listContentHeight + 10;
				listContentHeight += sortMS.getItemHeight();
				//content.getChildAt(i).y = (i>0 ? content.getChildAt(i-1).y + content.getChildAt(i-1).height : 0) + 10;//i*25 + 10;
				i++;
			}
			content.dispatchEvent(new Event("updateEvent"));
		}
		 
		
		/**
		 *
		 * 获取VIP图标地址 
		 * @param vipIcon
		 * @return 
		 * 
		 */		
		static public function getVipIcon(vipIcon:String):String
		{
			vipIcon = DataProxy.ImgDomain + "/css_img/flash/icon/identity_" + vipIcon + ".png";
			
			return vipIcon;
		}
		
		/**
		 *
		 * 获取守护图标地址 
		 * @param vipIcon
		 * @return 
		 * 
		 */		
		static public function getGuardIcon(guardIcon:String):String
		{
			guardIcon = DataProxy.ImgDomain + "/css_img/flash/icon/identity_" + guardIcon + ".png";
			
			return guardIcon;
		}
		
		/**
		 *
		 * 获取财富图标地址 
		 * @param wealthIcon
		 * @return 
		 * 
		 */		
		static public function getWealthIcon(wealthIcon:String):String
		{
			wealthIcon = DataProxy.ImgDomain + "/css_img/flash/icon/wealth_" + wealthIcon.toString() + ".png";
			
			return wealthIcon;
		}
		
		private function getRandom(arr:Array):String
		{
			var n:int = arr.length * Math.random();
			return arr[n];
		}
		
		/**
		 * 获取时间文本
		 */	
		private function getTimeText():SpanElement
		{
			var span:SpanElement = new SpanElement();
			var date:Date = new Date();
			span.text = doubleDigitFormat(date.hours) + ":" + doubleDigitFormat(date.minutes) + ":" + doubleDigitFormat(date.seconds);
			span.color = 0x666666;
			return span;	
		}
		
		private function getLinkElement(data:Object,s:String, color:uint=0x000000, fontSize:int = 12):LinkElement
		{
			var span:LinkElement = new LinkElement();
			span.addEventListener(FlowElementMouseEvent.CLICK,alertUser);
			var span1:MessageSpanElement = new MessageSpanElement(); // for text associated with link
			span1.data= data;
			span1.text = s;
			span1.color = color;
			span1.fontSize = fontSize;
			span1.textDecoration = TextDecoration.NONE;
			span.addChild(span1);
			return span;
		}
		
		
		private function alertUser(e:FlowElementMouseEvent):void
		{
			var span:LinkElement = e.flowElement as LinkElement;
			var span1:MessageSpanElement = span.getChildAt(0) as MessageSpanElement;
			trace(DataProxy.videoGift.mouseX + "    "+ DataProxy.videoGift.mouseY);
			ExternalInterface.call("MGC_CommRequest.getPlayerInfo",span1.data.senderName,span1.data.zoneName,DataProxy.videoGift.mouseX,DataProxy.videoGift.mouseY);
		}
		
		private function getSpanElement(s:String, color:uint=0x000000, fontSize:int = 12,isBold:Boolean = false):SpanElement
		{
			var span:SpanElement = new SpanElement();
			span.text = s;
			span.color = color;
			span.fontSize = fontSize;
			if(!isBold)
			{
				span.fontFamily = "微软雅黑";
			}
			return span;
		}
		
		/**
		 * 获取图片元素
		 */	
		private function getGraphicElement(url:String,width:Number,height:Number):InlineGraphicElement
		{
			var graphic:InlineGraphicElement = new InlineGraphicElement();
			graphic.source = url;
			graphic.width = width;
			graphic.height = height;
			return graphic;
		}
		
		/**
		 *格式化成两位数
		 */
		private function doubleDigitFormat(num:Number):String 
		{
			if(num < 10) 
			{
				return ("0" + num);
			}
			return num.toString();
		}
	}
}