package view.components
{
	import com.bit101.utils.GeneralEventDispatcher;
	import com.bit101.utils.OverrideBulkLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import model.DataProxy;
	import model.data.GiftData;
	import model.data.MessagePaneVO;
	
	public class MessageSprite extends Sprite
	{
		private var overrideBulkLoader:OverrideBulkLoader;
		private var guardIconUrl:String = "";
		private var vipIconUrl:String = "";
		private var guardIcon:Bitmap;
		private var vipIcon:Bitmap;
		private var sendNametext:TextField;
		private var descriptionText:TextField;
		private var giftIcon:Bitmap;
		private var giftUrl:String = "";
		private var numText:TextField;
		private var tipText:TextField;
		
		private var uesrbutton:SimpleButton;
		
		private var wealthIcon:WealthIcon;
		
		private var _data:GiftData;
		
		private var textFormat1:TextFormat; 
		private var textFormat2:TextFormat; 
		private var textFormat3:TextFormat;
		private var textFormat4:TextFormat;
		
		private var textFormatLuckyDraw:TextFormat;
		private var fontName:String;
		public function MessageSprite()
		{
			//Cc.log("更新礼物   "+guardIconUrl + "   " + vipIconUrl + "   " + sendName + "   " + description + "   " + giftUrl);
			overrideBulkLoader = OverrideBulkLoader.getInstance();
			
			guardIcon = new Bitmap();
			
			vipIcon = new Bitmap();
			
			giftIcon = new Bitmap();
			
//			if (BrowserInfo.name == null || BrowserInfo.name == "")
//			{
//				BrowserInfo.getBrowserInfo();
//			}
			fontName = "微软雅黑";
//			if (BrowserInfo.name == BrowserInfo.MSIE)
//			{
//				fontName = "Microsoft YaHei";
//			}
			
			sendNametext = new TextField();
			uesrbutton = new SimpleButton(sendNametext, sendNametext, sendNametext, sendNametext);
			sendNametext.selectable = false;
			textFormat1 = new TextFormat();
			textFormat1.font = fontName; //"微软雅黑";
			textFormat1.size = 12;
			sendNametext.mouseEnabled = true;
			uesrbutton.useHandCursor = true;
			
			
			descriptionText = new TextField();
			descriptionText.selectable = false;
			textFormat2 = new TextFormat();
			textFormat2.font = fontName; //"微软雅黑";
			textFormat2.size = 12;
			textFormat2.color = 0xffd557;
			
			textFormatLuckyDraw = new TextFormat();
			textFormatLuckyDraw.font = fontName; //"微软雅黑";
			textFormatLuckyDraw.size = 12;
			textFormatLuckyDraw.color = 0x44dfba;
			
			numText = new TextField();
			numText.selectable = false;
			textFormat3 = new TextFormat();
			textFormat3.font = fontName; //"微软雅黑";
			textFormat3.size = 22;
			textFormat3.color = 0xffd557;
			
			tipText = new TextField();
			tipText.selectable = false;
			textFormat4 = new TextFormat();
			textFormat4.font = fontName; //"微软雅黑";
			textFormat4.size = 12;
			textFormat4.color = 0x00fcff;
			
		}
		
		public static const ITEM_COMMON_HEIGHT:int = 25;
		
		public var listWidth:int;
		
		public function get data():GiftData
		{
			return _data;
		}
		
		public function set data(value:GiftData):void
		{
			_data = value;
			
			removeAll();
			
			uesrbutton.addEventListener(MouseEvent.CLICK, alertUser);
			
			var sendName:String = data.senderName;
			
			var description:String = data.source == 0 
				? "" : "<font color='#23E3BA' face='" + fontName +"' size='12'> 通过幸运转盘</font>";
			description += "<font color='#ffd557' face='" + fontName +"' size='12'> 送了  </font>";
			//giftUrl = DataProxy.ImgDomain + "/css_img/flash/gift/gift_" + data.giftItemID + ".png";
			giftUrl = DataProxy.ImgDomain +DataProxy.GIFT_PATH + data.giftItemID + ".png";
			
			var num:String = " " + data.count;
			
			if(data.giftItemID == 98)
			{
				//" 在房间中进行了一次元气满满的超级捧场!";
				description = "<font color='#ffd557' face='" + fontName +"' size='12'> 在房间中进行了一次元气满满的超级捧场!</font>";
				giftUrl = "";
				num = "";
				//data.wealth_level = 0;
			}
			
			//免费礼物加×
			if(data.type == 6 || data.giftItemID == 16)
			{
				num = " ×" + data.count;
			}
			
			//圣诞礼物
			if(data.source == 3)
			{
				description = "<font color='#23E3BA' face='" + fontName +"' size='12'> 通过周年庆活动</font>";
				description += "<font color='#ffd557' face='" + fontName +"' size='12'> 送了  </font>";
				num = " ×" + data.count;
			}
			
			var isMe:Boolean = data.isSelf;
			
			//财富图标
			if(data.wealth_level > 0)
			{
				wealthIcon = new WealthIcon(data.wealth_level);
				addChild(wealthIcon);
			}
			
			if(data.guardIcon && data.guardIcon.length > 0)
			{
				//守护图标
				guardIconUrl = MessagePaneVO.getGuardIcon(data.guardIcon);
				
				if(overrideBulkLoader.hasItem(guardIconUrl))
				{
					addGuardIcon();
				}
				else
				{
					overrideBulkLoader.add(guardIconUrl,null,addGuardIcon);
				}
				this.addChild(guardIcon);
			}
			
			if(data.vipIcon && data.vipIcon.length > 0)
			{
				//贵族图标
				vipIconUrl = MessagePaneVO.getVipIcon(data.vipIcon);
				
				if(overrideBulkLoader.hasItem(vipIconUrl))
				{
					addVipIcon();
				}
				else
				{
					overrideBulkLoader.add(vipIconUrl,null,addVipIcon);
				}
				this.addChild(vipIcon);
			}
			
			if(isMe)
			{
				if(DataProxy.isCaveolaeBo)
				{
					textFormat1.color = 0x44ff51;
				}
				else
				{
					textFormat1.color = 0xdfad68;
				}
			}
			else
			{
				textFormat1.color = 0xffffff;
			}

			sendNametext.text = sendName;
			sendNametext.setTextFormat(textFormat1);
			sendNametext.width = sendNametext.textWidth+5;
			sendNametext.height = sendNametext.textHeight + 5;
			uesrbutton.width = sendNametext.width;
			uesrbutton.height = sendNametext.height;
			this.addChild(uesrbutton);
			
			descriptionText.htmlText = description;
			descriptionText.width = descriptionText.textWidth+5;
			descriptionText.height = descriptionText.textHeight + 5;
			this.addChild(descriptionText);
			
			if(giftUrl && giftUrl.length > 0)
			{
				
				if(overrideBulkLoader.hasItem(giftUrl))
				{
					addGiftIcon();
				}
				else
				{
					overrideBulkLoader.add(giftUrl,null,addGiftIcon,onError);
				}
				this.addChild(giftIcon);
			}
			
			numText.text = num;
			numText.setTextFormat(textFormat3);
			numText.width = numText.textWidth+5;
			numText.height = numText.textHeight + 2;
			this.addChild(numText);
			
			tipText.text = "";
			//筛子礼物
			if(data.count == data.maxCount && data.giftItemID == 46)
			{
				if((data.m_dice_val_1 == data.m_dice_val_2) && (data.m_dice_val_2 == data.m_dice_val_3) && (data.m_dice_val_3 == data.m_dice_val_1))
				{
					//tipText.border = true;
					tipText.text = "赌神附体，掷出三个\"" + data.m_dice_val_1 + "\"";
					tipText.setTextFormat(textFormat4);
					tipText.width = tipText.textWidth + 5;
					tipText.height = tipText.textHeight + 5;
					this.addChild(tipText);
				}
				else
				{
					tipText.text = "掷出\"" + (data.m_dice_val_1 + data.m_dice_val_2 + data.m_dice_val_3) + "\"点";
					tipText.setTextFormat(textFormat4);
					tipText.width = tipText.textWidth + 5;
					tipText.height = tipText.textHeight + 5;
					this.addChild(tipText);
				}
			}
			
			updatePosition();
		}

		private function removeAll():void
		{
			if (uesrbutton != null)
			{
				if (uesrbutton.hasEventListener(MouseEvent.CLICK))
				{
					uesrbutton.removeEventListener(MouseEvent.CLICK, alertUser);
				}
			}
			while (this.numChildren > 0)
			{
				var disObj:DisplayObject = this.removeChildAt(0);
				disObj = null;
			}
		}

		public function destroy():void
		{
			removeAll();
		}

		private function alertUser(e:MouseEvent):void
		{
			if(!GeneralEventDispatcher.getInstance().isConcertPlay && GeneralEventDispatcher.getInstance().isConcert)
				return;
			ExternalInterface.call("MGC_CommRequest.getPlayerInfo",data.senderName.replace(/\\/g,"\\\\"),data.zoneName,DataProxy.videoGift.mouseX,DataProxy.videoGift.mouseY);
			
			//设置点击玩家姓名的来源 送礼区为10
			ExternalInterface.call("setCardSource",10);
		}

		private function addGuardIcon(data:Object=null):void
		{
			var iconBitmapData:BitmapData = overrideBulkLoader.getBitmap(guardIconUrl).bitmapData;
			guardIcon.bitmapData = iconBitmapData;
			guardIcon.width = 24;
			guardIcon.height = 24;
			updatePosition();
		}

		private function isConcertPlay(e:Event):void
		{
			//Cc.log("GeneralEventDispatcher.getInstance().isConcertPlay1   =   " + GeneralEventDispatcher.getInstance().isConcertPlay);
			//Cc.log("button.enabled1  =   " + uesrbutton.enabled);
			if(uesrbutton.enabled == GeneralEventDispatcher.getInstance().isConcertPlay)
				return;
			uesrbutton.enabled = GeneralEventDispatcher.getInstance().isConcertPlay;
//			uesrbutton.mouseEnabled = GeneralEventDispatcher.getInstance().isConcertPlay;
		}

		private function addVipIcon(data:Object=null):void
		{
			var vipIconBitmapData:BitmapData = overrideBulkLoader.getBitmap(vipIconUrl).bitmapData;
			vipIcon.bitmapData = vipIconBitmapData;
			vipIcon.width = 24;
			vipIcon.height = 24;
			updatePosition();
		}
		
		/**
		 * 礼物图片加载失败
		 * 显示默认图标
		 */
		private function onError():void {
			giftUrl = GiftCell.defaultIcon;
			overrideBulkLoader.add(giftUrl,null,addGiftIcon);
		}

		private function addGiftIcon(data:Object=null):void
		{
			var giftIconBitmapData:BitmapData = overrideBulkLoader.getBitmap(giftUrl).bitmapData;
			giftIcon.bitmapData = giftIconBitmapData;
			giftIcon.width = 30;
			giftIcon.height = 30;
			updatePosition();
		}

		private function updatePosition():void
		{
			var i:uint = 1;
			if(this.numChildren > 0)
			{
				this.getChildAt(0).x = 25;
				this.getChildAt(0).y = (30 - this.getChildAt(0).height)/2;
			}

			while(i < this.numChildren)
			{
				//Cc.log("更新坐标" + this.getChildAt(i-1).width + "   " + this.getChildAt(i-1).x)
				this.getChildAt(i).x = this.getChildAt(i-1).x + this.getChildAt(i-1).width;
				this.getChildAt(i).y = (30 - this.getChildAt(i).height)/2;
				
				//增加显示文字超出显示范围的问题。
				if (this.getChildAt(i) == tipText && tipText != null && tipText.text != "")
				{
					if (tipText.x + tipText.textWidth > listWidth - 10)
					{
//						if (tipText.text.indexOf("，") > 0)
//						{
//							tipText.multiline = true;
//							tipText.wordWrap = true;
//							tipText.autoSize = TextFieldAutoSize.LEFT;
//							tipText.defaultTextFormat = textFormat4;
//							tipText.text = tipText.text.replace("，", "，\n");
//						}
						
						tipText.x = 25;
						tipText.y = int((30 - this.getChildAt(0).height) / 2 + this.getChildAt(0).height);
					}
				}

				/*if((i + 2) == this.numChildren)
				{
					this.getChildAt(i).y = (30 - this.getChildAt(i).height - 8)/2;
				}
				else
				{
					this.getChildAt(i).y = (30 - this.getChildAt(i).height)/2;
				}*/

				//TODO 
				
				i++;
			}
			
			numText.y = (30 - numText.height - 8)/2;
		}

		public function getItemHeight():int
		{
			if (tipText!= null && tipText.parent != null && tipText != null && tipText.text != "" && this.numChildren > 0)
			{
				if (tipText.y == int((30 - this.getChildAt(0).height) / 2 + this.getChildAt(0).height))
				{
					return ITEM_COMMON_HEIGHT + tipText.height;
				}
			}
			return ITEM_COMMON_HEIGHT;
		}
		
	}
}