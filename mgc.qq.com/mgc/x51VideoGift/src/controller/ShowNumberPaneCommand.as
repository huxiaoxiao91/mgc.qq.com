package controller
{	
	import flash.geom.Point;
	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	
	public class ShowNumberPaneCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			var bottomPaneMediator:BottomPaneMediator = facade.retrieveMediator(BottomPaneMediator.NAME) as BottomPaneMediator;
	
			var numberPaneMediator:	NumberPaneMediator = facade.retrieveMediator(NumberPaneMediator.NAME) as NumberPaneMediator;
			
			//更新列表数据
			/*var vo:GiftVO = dataProxy.giftPaneVO.getGiftById(dataProxy.giftPaneVO.selectid);	
			dataProxy.numberPaneVO.numList = vo.dropList;*/
			
			//无数据不显示
			if(dataProxy.numberPaneVO.numList == null)return;
				
			var o:Object = notification.getBody() as Object;
			
			//位置 是否显示
			dataProxy.numberPaneVO.visible = o.visible;
			
			var p:Point = new Point(bottomPaneMediator.component.btn_num.x,bottomPaneMediator.component.btn_num.y);
			var p1:Point = bottomPaneMediator.component.btn_num.localToGlobal(p);
			numberPaneMediator.component.x = p1.x - 56;
			numberPaneMediator.component.y = p1.y - dataProxy.numberPaneVO.numList.length*20 -5;
			
		}
	}
}