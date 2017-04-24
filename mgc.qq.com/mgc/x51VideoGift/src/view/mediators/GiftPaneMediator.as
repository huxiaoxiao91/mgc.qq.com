 package view.mediators
{	
	import com.bit101.utils.SelectFreeEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.DataProxy;
	import model.data.GiftVO;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.GiftCell;
	import view.components.GiftPane;
	
	public class GiftPaneMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String="GiftPaneMediator";

		private var dataProxy:DataProxy;
		
		public function GiftPaneMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
			
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			component.vo = dataProxy.giftPaneVO;
			
			component.vo.addEventListener("giftList",giftListHandler);
			component.vo.addEventListener("isConcert",isConcertHandler);
			//component.vo.addEventListener("selectIdChange",selectIdChangeHandler);
			
			//component.initUI();
			
			component.list.addEventListener(Event.SELECT,giftSelect);
			component.list.addEventListener("OVER",giftOver);
			component.list.addEventListener(MouseEvent.MOUSE_OUT,giftOut);
			component.list.addEventListener(SelectFreeEvent.SELECT_FREE,selectFree);


//			component.addEventListener(MouseEvent.ROLL_OVER,giftListOver);
//			component.addEventListener(MouseEvent.ROLL_OUT,giftListOut);

//			component.stage.addEventListener(MouseEvent.CLICK,stageClick);

			if (component.vo.giftList != null && component.vo.giftList.length > 0) {
				giftListHandler(null);
			}
		}
		
		/**
		 * 
		 * 鼠标在礼物区
		 * 
		 */		
		private function giftListOver(e:MouseEvent):void
		{
			dataProxy.bottomPaneVO.isNumberFrame = true;
		}
		/**
		 * 
		 * 鼠标离开礼物区
		 * 
		 */	
		private function giftListOut(e:MouseEvent):void
		{
			dataProxy.bottomPaneVO.isNumberFrame = false;
		}
		
		private function isConcertHandler(e:Event):void
		{
			if(component.vo.isConcert)
			{
				if(component.contains(component.blank))
				{
					component.removeChild(component.blank);
				}
			}
			else{
				component.addChildAt(component.blank,0);
			}
		}
		
		/**
		 * 点击舞台  取消礼物选择
		 */		
		private function stageClick(e:Event):void
		{
			//trace(e.target,e.currentTarget);
			
			if(!(e.target is GiftCell) && !dataProxy.bottomPaneVO.isNumberFrame)
			{
				component.list.cancelSelection();
				component.vo.selectid = -1;
			}
		}
		
		private function selectFree(e:SelectFreeEvent):void
		{
			//免费礼物直接送出
			if(e.data.type == 1 && e.data.num > 0)
			{
				sendNotification(ApplicationFacade.SendGift,{"id":e.data.id,"num":e.data.num});
			}
		}
		
		private function giftSelect(e:Event):void
		{
			//点击的礼物id
			component.vo.selectid = component.list.selectedItem.id;
			
			//数量选择框赋值
			dataProxy.numberPaneVO.numList = component.list.selectedItem.dropList;
			
			if(dataProxy.numberPaneVO.numList.length > 0)
				dataProxy.numberPaneVO.maxGiftNumber = dataProxy.numberPaneVO.numList[dataProxy.numberPaneVO.numList.length - 1].count;
			else
				dataProxy.numberPaneVO.maxGiftNumber = 1;
			
			
			
			//免费礼物直接送出
			/*
			if(component.list.selectedItem.type == 6 && component.list.selectedItem.num > 0)
			{
				//缓存送礼输入框数量
				var num:int = dataProxy.bottomPaneVO.num;
				
				//全部送出
				dataProxy.bottomPaneVO.num = component.list.selectedItem.num;
				
				sendNotification(ApplicationFacade.SendGift);
				
				//回滚送礼输入框数量
				dataProxy.bottomPaneVO.num = num;
			}
			*/
//			sendNotification(BottomPaneMediator.GIFT_BUTTON,true);
			//trace(component.vo.selectid);
		}
		
		private function giftOver(e:Event):void
		{
			if(component && component.list && component.list.overItem)
				component.vo.overid = component.list.overItem.id;
			facade.sendNotification(ApplicationFacade.ShowGiftTipPane,{x:component.stage.mouseX,y:component.stage.mouseY,visible:true});
		}
		
		private function giftOut(e:Event):void
		{
			sendNotification(ApplicationFacade.ShowGiftTipPane,{x:component.stage.mouseX,y:component.stage.mouseY,visible:false});
		}

		/**
		 * 礼物列表数据更新
		 */
		private function giftListHandler(e:Event):void {
			var tempArr:Array = [];
			for each (var vo:GiftVO in component.vo.giftList) {
				if (vo.isShow) {
					tempArr.push(vo);
				}
			}
			component.list.items = tempArr;
			//Cc.log("selectedIndex 赋值选择0");

			if (tempArr[0].isLock) {
				component.list.selectedIndex = 1;
			} else {
				component.list.selectedIndex = 0;
			}

			if (component.list.columnCount > 0) {
				if (component.list.selectedIndex < component.list.value) {
					component.list.value = int(component.list.selectedIndex / component.list.columnCount) * component.list.columnCount;
				} else if (component.list.selectedIndex > component.list.value) {
					component.list.value = int(component.list.selectedIndex / component.list.columnCount) * component.list.columnCount;
				}
			}
		}

		/**
		 * 礼物列表索引更新
		 */
		private function selectIdChangeHandler(e:Event):void {
			component.list.selectedIndex = component.vo.selectid;
		}

		override public function listNotificationInterests():Array {
			return new Array();
		}

		override public function handleNotification(notification:INotification):void {

		}

		public function get component():GiftPane {
			return viewComponent as GiftPane;
		}
	}
}