package view.components
{
	import com.bit101.components.Image;
	import com.bit101.utils.OverrideBulkLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import model.DataProxy;
	import model.data.GiftData;
	import model.data.MessagePaneVO;
	
	public class GiftTipSprite extends Sprite
	{
		private var overrideBulkLoader:OverrideBulkLoader;
		private var guardIconUrl:String = "";
		private var vipIconUrl:String = "";
		private var wealthImage:Image;
		private var guardIcon:Bitmap;
		private var vipIcon:Bitmap;
		private var sendNametext:TextField;
		private var descriptionText:TextField;
		private var giftIcon:Bitmap;
		private var giftUrl:String = "";
		private var numText:TextField;
		private var _data:GiftData;
		private var bg:Sprite;
		private var show:Sprite;
		
		public function GiftTipSprite(guardIconUrl:String,vipIconUrl:String,sendName:String,description:String,num:String,data:GiftData,isMe:Boolean)
		{
			if(DataProxy.isCaveolaeBo)
			{
				if(DataProxy.isSkinOpened)
				{
					bg = new GiftTipBG1();
				} 
				else 
				{
					bg = new GiftTipBG();
				}
			}
			else
			{
				bg = new GiftTipBG1();
			}
			
			this.addChild(bg);
			show = new Sprite();
			this.addChild(show);
			
			//Cc.log("更新礼物   "+guardIconUrl + "   " + vipIconUrl + "   " + sendName + "   " + description + "   " + giftUrl);
			overrideBulkLoader = OverrideBulkLoader.getInstance();
			super();
			_data = data;
			
			//财富图标
			if(data.wealth_level > 0)
			{
				var wealthIcon:String = MessagePaneVO.getWealthIcon(data.wealth_level.toString());
				wealthImage = new Image(show,0,0,wealthIcon);
				wealthImage.setSize(24,24);
			}
			
			this.guardIconUrl = guardIconUrl;
			if(guardIconUrl && guardIconUrl.length > 0)
			{
				guardIcon = new Bitmap();
				if(overrideBulkLoader.hasItem(guardIconUrl))
				{
					addGuardIcon();
				}
				else
				{
					overrideBulkLoader.add(guardIconUrl,null,addGuardIcon);
				}
				show.addChild(guardIcon);
			}
			
			this.vipIconUrl = vipIconUrl;
			if(vipIconUrl && vipIconUrl.length > 0)
			{
				vipIcon = new Bitmap();
				if(overrideBulkLoader.hasItem(vipIconUrl))
				{
					addVipIcon();
				}
				else
				{
					overrideBulkLoader.add(vipIconUrl,null,addVipIcon);
				}
				show.addChild(vipIcon);
			}
			
			
			
			sendNametext =new TextField();
			var button:SimpleButton=new SimpleButton(sendNametext,sendNametext,sendNametext,sendNametext);
			sendNametext.text = sendName;
			sendNametext.selectable = false;
			var textFormat1:TextFormat = new TextFormat();
			textFormat1.font = "微软雅黑";
			textFormat1.size = 14;
			
			if(isMe)
			{
				if(DataProxy.isCaveolaeBo)
				{
					if(DataProxy.isSkinOpened)
					{
						textFormat1.color = 0xdfad68;
					} 
					else 
					{
						textFormat1.color = 0x44ff51; 
					}
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
			
			sendNametext.mouseEnabled = true;
			sendNametext.setTextFormat(textFormat1);
			sendNametext.width = sendNametext.textWidth+5;
			sendNametext.height = sendNametext.textHeight + 5;
			button.addEventListener(MouseEvent.CLICK,alertUser);
			button.useHandCursor = true;
			button.width = sendNametext.width;
			button.height = sendNametext.height;
			show.addChild(button);
			
			descriptionText =new TextField();
			descriptionText.text = description;
			descriptionText.selectable = false;
			var textFormat2:TextFormat = new TextFormat();
			textFormat2.font = "微软雅黑";
			textFormat2.size = 14;
			if(DataProxy.isCaveolaeBo)
			{
				if(DataProxy.isSkinOpened)
				{
					textFormat2.color = 0xffd557;
				}
				else
				{
					textFormat2.color = 0xfcff00;
				}
			}
			else
			{
				textFormat2.color = 0xffd557;
			}
			descriptionText.setTextFormat(textFormat2);
			descriptionText.width = descriptionText.textWidth+5;
			descriptionText.height = descriptionText.textHeight + 5;
			show.addChild(descriptionText);
			
			//内裤显示不同的礼物图标
			if(_data.giftItemID == 50)
			{
				giftUrl = DataProxy.ImgDomain +DataProxy.GIFT_PATH + _data.giftItemID + "_" + _data.level.toString() + ".png";
			}
			else
			{
				giftUrl = DataProxy.ImgDomain +DataProxy.GIFT_PATH + _data.giftItemID + ".png";
			}
			
			if(giftUrl && giftUrl.length > 0)
			{
				giftIcon = new Bitmap();
				if(overrideBulkLoader.hasItem(giftUrl))
				{
					addGiftIcon();
				}
				else
				{
					overrideBulkLoader.add(giftUrl,null,addGiftIcon,onError);
				}
				show.addChild(giftIcon);
			}
			
			numText =new TextField();
			numText.text = num;
			numText.selectable = false;
			var textFormat3:TextFormat = new TextFormat();
			textFormat3.font = "微软雅黑";
			textFormat3.size = 22;
			
			if(DataProxy.isCaveolaeBo)
			{
				if(DataProxy.isSkinOpened)
				{
					textFormat3.color = 0xffd557;
				}
				else
				{
					textFormat3.color = 0xfcff00;
				}
			}
			else
			{
				textFormat3.color = 0xffd557;
			}
			
			numText.setTextFormat(textFormat3);
			numText.width = numText.textWidth+5;
			numText.height = 28;
			if (giftIcon != null) {
				numText.y = (giftIcon.height - numText.textHeight) / 2 - 2;
			} else {
				numText.y = -3;
			}
			show.addChild(numText);
			updatePosition();
		}
		
		private function alertUser(e:MouseEvent):void
		{
			ExternalInterface.call("MGC_CommRequest.getPlayerInfo",_data.senderName,_data.zoneName,DataProxy.videoGift.mouseX,DataProxy.videoGift.mouseY);
		}
		
		private function addGuardIcon(data:Object=null):void
		{
			var iconBitmapData:BitmapData = overrideBulkLoader.getBitmap(guardIconUrl).bitmapData;
			guardIcon.bitmapData = iconBitmapData;
			guardIcon.width = 24;
			guardIcon.height = 24;
			updatePosition();
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
			var w:Number = 0;
			
			if(show.numChildren > 0)
			{
				show.getChildAt(0).y = (30 - this.getChildAt(0).height+4)/2;
				w += show.getChildAt(0).width;
			}
			
			while(i < show.numChildren)
			{
				//Cc.log("更新坐标" + show.getChildAt(i-1).width + "   " + show.getChildAt(i-1).x)
				show.getChildAt(i).x = show.getChildAt(i-1).x + show.getChildAt(i-1).width;
				
				
				w += show.getChildAt(i).width;
				
				if((i + 1) == show.numChildren)
				{
					show.getChildAt(i).y = (30 - show.getChildAt(i).height - 9)/2;
				}
				else
				{
					show.getChildAt(i).y = (30 - show.getChildAt(i).height-2)/2;
				}
				
				i++;
			}
			bg.width = 476;//212 + show.width;
			show.x = (bg.width - show.width)/2;
			bg.y = 3;
			if(numText)
			{
//				numText.y = 0;
				if (giftIcon != null) {
					numText.y = (giftIcon.height - numText.textHeight) / 2 - 2;
				} else {
					numText.y = -3;
				}
			}
		}
		
	}
}