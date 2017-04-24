package controller
{	
	import flash.external.ExternalInterface;
	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	public class SendBalanceCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			var o:Object = new Object();
			o.op_type = 130;
			o.save_num = 0;
			
			//var json:String = JSON.stringify(o);
			
			//ExternalInterface.call("gift_send",json);
			
			ExternalInterface.call("gift_send",o);
		}
	}
}