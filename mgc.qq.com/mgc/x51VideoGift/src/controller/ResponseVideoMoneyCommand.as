package controller
{	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	/**
	 * 查询梦幻币回调
	 */	
	public class ResponseVideoMoneyCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			var o:Object = notification.getBody() as Object;
			
			if(o.res == 0)
			{
				dataProxy.bottomPaneVO.videomoney = o.videomoney;
			}
			
		}
	}
}