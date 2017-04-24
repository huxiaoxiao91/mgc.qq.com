 package view.mediators
{	
	import br.com.stimuli.loading.BulkLoader;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import model.DataProxy;
	import model.data.GiftVO;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.BottomPane;
	import view.components.CostTip;
	
	public class BottomPaneMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "BottomPaneMediator";
		
		public static const GIFT_BUTTON:String = "gift_button";
		
		private var bulkLoader:BulkLoader = BulkLoader.getLoader("gift");

		private var dataProxy:DataProxy;
		
		private var tempObj:Object = {};
		
		public function BottomPaneMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
			
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			component.vo = dataProxy.bottomPaneVO;
			
			dataProxy.giftPaneVO.addEventListener("selectIdChange",change_text_num);
			
			component.vo.addEventListener("money",moneyHandler);
			component.vo.addEventListener("videomoney",videomoneyHandler);
			component.vo.addEventListener("num",numHandler);
			component.vo.addEventListener("giftEnabled",giftEnabledHandler);
			component.vo.addEventListener("numSelected",numSelectedHandler);
			component.vo.addEventListener("isConcert",isConcertHandler);
			
			component.text_num.addEventListener(Event.CHANGE,text_num_change);
			component.text_num.addEventListener(FocusEvent.FOCUS_OUT,focusOut);
			component.numberFrame.addEventListener(MouseEvent.ROLL_OVER,numberFrameOver);
			component.numberFrame.addEventListener(MouseEvent.ROLL_OUT,numberFrameOut);
			
			component.btn_pay.addEventListener(MouseEvent.CLICK,btn_pay_Click);
			component.btn_num.face.addEventListener(MouseEvent.CLICK,btn_num_Click);
			component.btn_gift.addEventListener(MouseEvent.CLICK,btn_gift_Click);
			component.btn_message.addEventListener(MouseEvent.CLICK,btn_message_Click);
			
			component.btn_gift.addEventListener(MouseEvent.ROLL_OVER,btn_gift_Over);
			component.btn_gift.addEventListener(MouseEvent.ROLL_OUT,btn_gift_Out);
			
			component.stage.addEventListener(MouseEvent.CLICK,stageClick);
			
			component.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			
			bulkLoader.addEventListener("XMLComplete", onXMLComplete);
		}
		
		/**
		 * 当选择的礼物ID发生更改时改变礼物数量（以前如果选择过数量更改到以前选择的数量，未选择过为1）
		 * @param e
		 * 
		 */		
		private function change_text_num(e:Event):void
		{
			var num:uint = 1;
			
			if(dataProxy.bottomPaneVO.tempObj.hasOwnProperty(dataProxy.giftPaneVO.selectid.toString()))
			{
				num = dataProxy.bottomPaneVO.tempObj[dataProxy.giftPaneVO.selectid.toString()];
			}
			
			component.vo.num = num;
		}
		/**
		 * 点击舞台  数量选择框消失
		 */		
		private function stageClick(e:Event):void
		{
			trace("点击舞台");
			dataProxy.numberPaneVO.visible = false;
			component.btn_num.selected = false;
			
			/*dataProxy.flyInputPaneVO.visible = false;
			component.btn_message.selected = false;*/
			sendNotification(ApplicationFacade.ShowFlyInputPane,{visible:false});
			
			dataProxy.facePaneVO.visible = false;
		}
		
		/**
		 * 回车
		 */		
		private function keyDownHandler(e:KeyboardEvent):void
		{
			if (e.keyCode == 13)
			{
				
			}
		}
		
		/**
		 * 数量输入框更新时
		 */		
		private function text_num_change(e:Event):void
		{
			var num:int = int(component.text_num.text);
			
			if(num == 0)
			{
				component.text_num.text = "1";
				return;
			}
			
			
			if(dataProxy.numberPaneVO.maxGiftNumber < num)
			{
				dataProxy.bottomPaneVO.tempObj[dataProxy.giftPaneVO.selectid.toString()] = dataProxy.numberPaneVO.maxGiftNumber;
				component.vo.num = dataProxy.numberPaneVO.maxGiftNumber;
			}
			else
			{
				dataProxy.bottomPaneVO.tempObj[dataProxy.giftPaneVO.selectid.toString()] = num;
				component.vo.num = num;
			}
		}
		
		
		private function focusOut(e:FocusEvent):void
		{
			var num:int = int(component.text_num.text);
			
			//最小值为1
			if(num == 0)
				num = 1;
			
			dataProxy.bottomPaneVO.tempObj[dataProxy.giftPaneVO.selectid.toString()] = num;
			
			component.vo.num = num;
		}
		
		/**
		 * 炫豆余额数据更新
		 */		
		private function moneyHandler(e:Event):void
		{
			component.text_money.text = component.vo.money.toString();
		}
		
		/**
		 * 梦幻币余额数据更新
		 */		
		private function videomoneyHandler(e:Event):void
		{
			component.text_money2.text = component.vo.videomoney.toString();
		}
		
		/**
		 * 礼物数量数据更新
		 */		
		private function numHandler(e:Event):void
		{
			dataProxy.bottomPaneVO.tempObj[dataProxy.giftPaneVO.selectid.toString()] = component.vo.num;;
			component.text_num.text = component.vo.num.toString();	
			component.text_num.setSelection(0,0);
			component.text_num.setSelection(4,4);
			component.text_num.setTextFormat(component.textFormat);
		}
		
		private function numSelectedHandler(e:Event):void
		{
			//Cc.log("调用改变按钮" + dataProxy.bottomPaneVO.numSelected);
			if(!dataProxy.bottomPaneVO.numSelected)
			{
				component.btn_num.defaultSkin();
			}
			
		}
		
		
		private function isConcertHandler(e:Event):void
		{
			if(component.vo.isConcert)
			{
//				if(component.contains(component.blank))
//				{
//					component.removeChild(component.blank);
//				}
			}
			else{
//				component.addChildAt(component.blank,0);
			}
		}
		
		/**
		 * 赠送按钮是否置灰
		 */		
		private function giftEnabledHandler(e:Event):void
		{
			component.btn_gift.enabled = component.vo.giftEnabled;
			component.btn_message.enabled = component.vo.giftEnabled;
		}
		
		private function btn_pay_Click(e:MouseEvent):void
		{
			//DTK74718
			var ps:String = ExternalInterface.call("mgc.tools.getPageSource");
			if(ps == "QGame" || ps == "X52")
			{
				ExternalInterface.call("mgc.minipay.show")
			}
			else
			{
				var url:URLRequest = new URLRequest("http://pay.qq.com/ipay/index.shtml?c=qxwwqp");
				navigateToURL(url,"_blank");
			}
		}
		
		private function btn_num_Click(e:MouseEvent):void
		{
			trace(dataProxy.giftPaneVO.selectid.toString());
			
			if(dataProxy.giftPaneVO.selectid == -1)
			{
				component.btn_num.defaultSkin();
				return 
			}
			
			sendNotification(ApplicationFacade.ShowNumberPane,{visible:component.btn_num.selected});
			
			e.stopImmediatePropagation();
		}
		
		private function btn_gift_Click(e:MouseEvent):void
		{
			if(dataProxy.isVisitor)
			{
				ExternalInterface.call("MGC_Comm.CheckGuestStatus");
				return;
			}
			
			sendNotification(ApplicationFacade.SendGift);
			//component.vo.giftEnabled = false;
			//dataProxy.giftPaneVO.getFreeGift().enabled = !dataProxy.giftPaneVO.getFreeGift().enabled;
		}
		
		private function numberFrameOver(e:MouseEvent):void
		{
			dataProxy.bottomPaneVO.isNumberFrame = true;
		}
		
		private function numberFrameOut(e:MouseEvent):void
		{
			dataProxy.bottomPaneVO.isNumberFrame = false;
		}
		
		private function btn_gift_Over(e:MouseEvent):void
		{
			//更新礼物花费
			var vo:GiftVO = dataProxy.giftPaneVO.getGiftById(dataProxy.giftPaneVO.selectid);

			if (vo != null && vo.type != 8) {
				var cost:Number = (vo.type == 5 ? vo.costmemberscore : vo.price) * dataProxy.bottomPaneVO.num;
				dataProxy.bottomPaneVO.cost = cost;

				var p:Point  = new Point(component.btn_gift.x, component.btn_gift.y);
				var p1:Point = component.localToGlobal(p);
				CostTip.getInstance().show(dataProxy.bottomPaneVO.cost.toString(), vo.type, p1.x, p1.y);
			}
//			dataProxy.bottomPaneVO.isNumberFrame = true;
		}
		
		private function btn_gift_Out(e:MouseEvent):void
		{
			CostTip.getInstance().hide();
			
//			dataProxy.bottomPaneVO.isNumberFrame = false;
		}
		
		private function btn_message_Click(e:MouseEvent):void
		{
			//Cc.log("btn_message_Click    " + dataProxy.flyInputPaneVO.visible);
			
			ExternalInterface.call("flashClick");
			
			sendNotification(ApplicationFacade.ShowFlyInputPane,{visible:!dataProxy.flyInputPaneVO.visible})
			
			e.stopImmediatePropagation();
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(notification:INotification):void
		{
//			switch (notification.getName())
//			{
//				case BottomPaneMediator.GIFT_BUTTON:
//					
//					component.btn_gift.enabled = notification.getBody() as Boolean;
//					break;
//			}
		}
		
		private function onXMLComplete(event:Event):void{
			bulkLoader.removeEventListener("XMLComplete", onXMLComplete);
			component.showContent();
		}
		
		public function get component():BottomPane
		{
			return viewComponent as BottomPane;
		}
	}
}