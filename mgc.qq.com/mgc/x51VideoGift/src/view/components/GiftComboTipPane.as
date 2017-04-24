package view.components
{
	import com.bit101.components.HBox;
	import com.bit101.components.Image;
	import com.bit101.components.Label;
	import com.bit101.utils.OverrideBulkLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import gs.TweenLite;
	
	import model.DataProxy;
	import model.data.GiftData;
	import model.data.MessagePaneVO;
	
	/**
	 * 
	 * 礼物连送时显示的铭牌
	 * @author Jason
	 * 
	 */	
	public class GiftComboTipPane extends Sprite
	{
		private var background:Sprite = new GiftComboTipPane_1();
		
		private var comboNumber:ComboNumber = new ComboNumber();
		
		private var hbox:HBox;
		private var wealthImage:Image;
		private var guardImage:Image;
		private var vipImage:Image;
		private var text_name:Label;
		private var text_zone:Label;
		private var giftImage:Image;
		private var text_num:Label;
		private var text_1:Label;
		
		private var overrideBulkLoader:OverrideBulkLoader = OverrideBulkLoader.getInstance();
		private var giftUrl:String;
		
		private var _data:GiftData;
		
		public function GiftComboTipPane()
		{
			background.x = 222;
			background.y = 25;
			addChild(background);
			
			hbox = new HBox(this,40);
			hbox.spacing = 3;
			hbox.alignment = HBox.MIDDLE;
			hbox.visible = false;
			hbox.setSize(382,37);
			hbox.addEventListener(Event.RESIZE,hboxResizeHandler);
			
			wealthImage = new Image(hbox,0,0);
			wealthImage.setSize(24,24);
			
			guardImage = new Image(hbox,0,0);
			guardImage.setSize(24,24);
			
			vipImage = new Image(hbox,0,0);
			vipImage.setSize(24,24);
			
			text_name = new Label(hbox);
			//原字号13，会产生偏差（chome不会其他浏览器可能会出现）
			var textFormat:TextFormat = new TextFormat("微软雅黑",14,0x6b007b,true);
			//textFormat.align = TextFormatAlign.CENTER;
			text_name.textFormat = textFormat;
			text_name.setSize(10,24);
			
			text_1 = new Label(hbox);	
			textFormat = new TextFormat("微软雅黑",14,0x6b007b,true);
			text_1.text = "送了";
			text_1.textFormat = textFormat;
			text_1.setSize(50,24);
			
			giftImage = new Image(hbox,0,0);
			giftImage.setSize(30,30);
			
			text_num = new Label(hbox);	
			textFormat = new TextFormat("微软雅黑",20,0xffe957,true);
			text_num.textFormat = textFormat;
			text_num.setSize(50,30);
		}
		
		
		public function get data():GiftData
		{
			return _data;
		}

		public function set data(vo:GiftData):void
		{
			_data = vo;
			
			(background as MovieClip).gotoAndPlay(1);
			hbox.visible = false;
			
			//赋值前情况之前的数据。
			hbox.removeChildren();
			
			//1.财富图标
			if(vo.wealth_level > 0)
			{
				var wealthIcon:String = MessagePaneVO.getWealthIcon(vo.wealth_level.toString());
				/*wealthImage = new Image(hbox,0,0,wealthIcon);
				wealthImage.setSize(24,24);*/
				wealthImage.source = wealthIcon;
				hbox.addChild(wealthImage);
			}
			
			//2
			if(vo.guardIcon != "")
			{
				var guardIcon:String = MessagePaneVO.getGuardIcon(vo.guardIcon);
				/*guardImage = new Image(hbox,0,0,guardIcon);
				guardImage.setSize(24,24);*/
				guardImage.source = guardIcon;
				hbox.addChild(guardImage);
			}
			
			//3
			if(vo.vipIcon != "")
			{
				var vipIcon:String = MessagePaneVO.getGuardIcon(vo.vipIcon);
				/*vipImage = new Image(hbox,0,0,vipIcon);
				vipImage.setSize(24,24);*/
				vipImage.source = vipIcon;
				hbox.addChild(vipImage);
			}
			
			//4
			text_name.text = vo.senderName;
//			text_name.draw();
			hbox.addChild(text_name);
			
			//5
			hbox.addChild(text_1);
			
			//内裤显示不同的礼物图标
			if(vo.giftItemID == 50)
			{
				giftUrl = DataProxy.ImgDomain +DataProxy.GIFT_PATH + vo.giftItemID + "_" + vo.level.toString() + ".png";
			}
			else
			{
				giftUrl = DataProxy.ImgDomain +DataProxy.GIFT_PATH + vo.giftItemID + ".png";
			}
			
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
				hbox.addChild(giftImage);
			}
			
			//7
			text_num.text = vo.maxCount.toString();
			text_num.draw();
			hbox.addChild(text_num);
			//hbox.visible = true;

			comboNumber.num = vo.continuous_send_gift_times;
			
			//显示连送数量
			if (vo.continuous_send_gift_times > 1)
			{				
				//comboNumber.x = 485;
				comboNumber.y = 5;
				addChild(comboNumber);
				
				var length:int = vo.continuous_send_gift_times.toString().length;
				if (length == 1)
				{
					comboNumber.x = 378;//515 - 143;
				}
				else if (length == 2)
				{
					comboNumber.x = 378;//370;
				}
				else if (length == 3)
				{
					comboNumber.x = 378;//370;
				}
				else if (length == 4)
				{
					comboNumber.x = 378;//370;
				}
			}
			
			//等名牌展开后显示出来
			TweenLite.to(hbox,0.5,{onComplete:function():void{
				//左右居中
				hbox.x = (382 - hbox.width)/2 - 15;
				hbox.visible = true;}
			});
		}

		private function hboxResizeHandler(e:Event):void
		{
			//hbox.visible = true;
			
			//左右居中
			//hbox.x = (500 - 163 - hbox.width)/2;	
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
			var bitmapData:BitmapData = overrideBulkLoader.getBitmap(giftUrl).bitmapData;
			var bitmap:Bitmap = new Bitmap(bitmapData);
			bitmap.width = bitmap.height = 30;
			giftImage.source = bitmap;
		}
	}
}