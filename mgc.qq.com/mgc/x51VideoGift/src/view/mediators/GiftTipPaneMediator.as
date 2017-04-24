 package view.mediators
{	
	import br.com.stimuli.loading.BulkLoader;
	
	import com.bit101.utils.OverrideBulkLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.DataProxy;
	
	import org.osmf.elements.ImageElement;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.*;
	import view.mediators.*;
	
	public class GiftTipPaneMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String="GiftTipPaneMediator";

		private var dataProxy:DataProxy;
		
		
		private var flower:Flower = new Flower();
		private var blueRose:BlueRose = new BlueRose();
		private var sweet:Sweet = new Sweet();
		private var flowerBasket:FlowerBasket = new FlowerBasket();
		private var fireworks:Fireworks = new Fireworks();
		private var firecracker:Firecracker = new Firecracker();
		private var wealthGod:WealthGod = new WealthGod();
		private var heartShapedChocolate:HeartShapedChocolate = new HeartShapedChocolate();
		private var angell:Angell = new Angell();
		private var aprilFoolGift:AprilFoolGift = new AprilFoolGift();
		private var ava:Ava = new Ava();
		private var smallDemon:SmallDemon = new SmallDemon();
		private var loveGift:LoveGift = new LoveGift();
		private var kitty:Kitty = new Kitty();
		private var myLove:MyLove = new MyLove();
		private var loveLetter:LoveLetter = new LoveLetter();
		private var soap:Soap = new Soap();
		private var diamondRing:DiamondRing = new DiamondRing();
		private var displayShell:DisplayShell = new DisplayShell();
		private var takeMedicine:TakeMedicine = new TakeMedicine();
		private var giftTip_40:GiftTip_40 = new GiftTip_40();
		
		private var meMeDa:MeMeDa = new MeMeDa();
		private var namePlate:NamePlate = new NamePlate();
		private var goldenMicrophone:GoldenMicrophone = new GoldenMicrophone();
		
		private var maserati:Maserati = new Maserati();
		private var rolex:Rolex = new Rolex();
		
		private var gloSticks:GloSticks = new GloSticks();
		private var mightyDomineering:MightyDomineering = new MightyDomineering();
		private var applause:Applause = new Applause();
		
		public function GiftTipPaneMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
			
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			dataProxy.giftTipPaneVO.addEventListener("name",nameHandler);
			dataProxy.giftTipPaneVO.addEventListener("icon",iconHandler);
			dataProxy.giftTipPaneVO.addEventListener("price",priceHandler);
			dataProxy.giftTipPaneVO.addEventListener("intro",introHandler);
			
			dataProxy.giftTipPaneVO.addEventListener("leftTime",leftTimeHandler);
			
			dataProxy.giftTipPaneVO.addEventListener("type",typeHandler);
			
			dataProxy.giftTipPaneVO.addEventListener("visible",visibleHandler);
		}
		
		/**
		 * 免费礼物更新剩余时间
		 */		
		private function leftTimeHandler(e:Event):void
		{
			component.text_leftTime.setText(dataProxy.giftTipPaneVO.leftTime.toString());
		}
		
		
		/**
		 * 礼物名称更新
		 */		
		private function nameHandler(e:Event):void
		{
			component.text_name1.text = dataProxy.giftTipPaneVO.name;
			component.text_name2.text = dataProxy.giftTipPaneVO.name;
		}
		
		/**
		 * 礼物价格更新
		 */		
		private function priceHandler(e:Event):void
		{
			component.text_price.text = dataProxy.giftTipPaneVO.price.toString();
		}
		
		/**
		 * 礼物简介更新
		 */		
		private function introHandler(e:Event):void
		{
//			component.text_intro.text = dataProxy.giftTipPaneVO.intro;

			while (component.text_intro.numChildren > 0)
			{
				var disObj:DisplayObject = component.text_intro.removeChildAt(0);
				disObj = null;
			}
			component.text_1.text  = "炫豆";
			component.text_dream_currency.visible = false;
			switch(dataProxy.giftTipPaneVO.intro)
			{
				case "Flower":
					component.text_intro.addChild(flower);
					break;
				case "BlueRose":
					component.text_intro.addChild(blueRose);
					break;
				case "Sweet":
					component.text_intro.addChild(sweet);
					break;
				case "FlowerBasket":
					component.text_intro.addChild(flowerBasket);
					break;
				case "Fireworks":
					component.text_intro.addChild(fireworks);
					break;
				case "Firecracker":
					component.text_intro.addChild(firecracker);
					break;
				case "WealthGod":
					component.text_intro.addChild(wealthGod);
					break;
				case "HeartShapedChocolate":
					component.text_intro.addChild(heartShapedChocolate);
					break;
				case "Angell":
					component.text_intro.addChild(angell);
					break;
				case "AprilFoolGift":
					component.text_intro.addChild(aprilFoolGift);
					break;
				case "Ava":
					component.text_intro.addChild(ava);
					break;
				case "SmallDemon":
					component.text_intro.addChild(smallDemon);
					break;
				case "LoveGift":
					component.text_1.text  = "个人积分";
					component.text_intro.addChild(loveGift);
					break;
				case "Kitty":
					component.text_intro.addChild(kitty);
					break;
				case "MyLove":
					component.text_intro.addChild(myLove);
					break;
				case "LoveLetter":
					component.text_intro.addChild(loveLetter);
					break;
				case "Soap":
					component.text_intro.addChild(soap);
					break;
				case "DiamondRing":
					component.text_intro.addChild(diamondRing);
					break;
				case "DisplayShell":
					component.text_intro.addChild(displayShell);
					break;
				case "TakeMedicine":
					component.text_intro.addChild(takeMedicine);
					break;
				case "MeMeDa":
					component.text_intro.addChild(meMeDa);
					break;
				case "NamePlate":
					component.text_intro.addChild(namePlate);
					break;
				case "GloSticks":
					component.text_1.text  = "梦幻币";
					component.text_dream_currency.visible = true;
					component.text_intro.addChild(gloSticks);
					break;
				case "MightyDomineering":
					component.text_1.text  = "梦幻币";
					component.text_dream_currency.visible = true;
					component.text_intro.addChild(mightyDomineering);
					break;
				case "Applause":
					component.text_1.text  = "梦幻币";
					component.text_dream_currency.visible = true;
					component.text_intro.addChild(applause);
					break;
				case "GoldenMicrophone":
					component.text_intro.addChild(goldenMicrophone);
					break;
				case "Maserati":
					component.text_intro.addChild(maserati);
					break;
				case "Rolex":
					component.text_intro.addChild(rolex);
					break;
				case "GiftTip_40":
					component.text_intro.addChild(giftTip_40);
					break;
			}
		}
		
		/**
		 * 礼物图标更新
		 */		
		private function iconHandler(e:Event):void
		{
			var iconData:BitmapData = OverrideBulkLoader.getInstance().getBitmap(dataProxy.giftTipPaneVO.icon).bitmapData;
			if(iconData)
			{
				var icon:Bitmap = new Bitmap(iconData);
				component.image.source = icon;
			}
		}
		
		/**
		 * 礼物界面是否显示
		 */		
		private function visibleHandler(e:Event):void
		{
			component.visible = dataProxy.giftTipPaneVO.visible;
		}
		
		/**
		 * 礼物类型
		 */		
		private function typeHandler(e:Event):void
		{
			if(dataProxy.giftTipPaneVO.type == 1)
			{
				component.text_leftTime.visible = true;
				component.text_intro.visible = false;
				component.hbox1.visible = false;
				component.hbox2.visible = true;
			}
			else
			{
				component.text_leftTime.visible = false;
				component.text_intro.visible = true;
				component.hbox1.visible = true;
				component.hbox2.visible = false;
			}
			
			component.upateSize();
		}
		
		override public function listNotificationInterests():Array
		{
			return new Array();
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
		}
		
		public function get component():GiftTipPane
		{
			return viewComponent as GiftTipPane;
		}
		
		
	}
}