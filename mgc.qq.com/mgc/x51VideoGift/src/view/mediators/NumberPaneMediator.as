 package view.mediators
{	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.*;
	import view.mediators.*;
	
	public class NumberPaneMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "NumberPaneMediator";

		private var dataProxy:DataProxy;
		
		public function NumberPaneMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
			
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			dataProxy.numberPaneVO.addEventListener("numList",numListHandler);
			dataProxy.numberPaneVO.addEventListener("visible",visibleHandler);
			
			component.addEventListener(Event.SELECT,selectHandler);
			
//			component.addEventListener(MouseEvent.ROLL_OVER,numberFrameOver);
//			component.addEventListener(MouseEvent.ROLL_OUT,numberFrameOut);
		}
		
		/**
		 * 数量选择
		 */		
		private function selectHandler(e:Event):void
		{
			dataProxy.numberPaneVO.selectCount = component.selectedItem.count;
			trace("选中数量：",dataProxy.numberPaneVO.selectCount);
			
			//dataProxy.numberPaneVO.visible = false;
			dataProxy.bottomPaneVO.num = dataProxy.numberPaneVO.selectCount;
		}
		
		/**
		 * 数量选择列表数据更新
		 */		
		private function numListHandler(e:Event):void
		{
			component.items = dataProxy.numberPaneVO.numList;
			component.setSize(100,dataProxy.numberPaneVO.numList.length*20);
		}
		
		/**
		 * 界面是否显示
		 */		
		private function visibleHandler(e:Event):void
		{
			component.visible = dataProxy.numberPaneVO.visible;
		}
		
		override public function listNotificationInterests():Array
		{
			return new Array();
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
		}
		
		public function get component():NumberPane
		{
			return viewComponent as NumberPane;
		}
		
		private function numberFrameOver(e:MouseEvent):void
		{
			dataProxy.bottomPaneVO.isNumberFrame = true;
		}
		
		private function numberFrameOut(e:MouseEvent):void
		{
			dataProxy.bottomPaneVO.isNumberFrame = false;
		}
		
	}
}