package controller
{	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	/**
	 * 免费飞屏数量回调
	 */	
	public class ResponseFreeMessageCountCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			var o:Object = notification.getBody() as Object;
			
			//更新免费飞屏数量
			dataProxy.flyInputPaneVO.count = o.count;
		}
	}
}