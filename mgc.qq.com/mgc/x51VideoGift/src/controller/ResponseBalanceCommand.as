package controller
{	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	/**
	 * 查询余额回调
	 */	
	public class ResponseBalanceCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			var o:Object = notification.getBody() as Object;
			
			if(o.res)
			{
				dataProxy.bottomPaneVO.money = o.balance;
			}
			
		}
	}
}