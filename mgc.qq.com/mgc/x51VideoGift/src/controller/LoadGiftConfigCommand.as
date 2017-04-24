package controller
{	
	import com.junkbyte.console.Cc;
	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	
	public class LoadGiftConfigCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			var time:Number = (new Date()).time;
			if((time - dataProxy.lastGiftConfigTime) > dataProxy.GiftConfigCD)
			{
				dataProxy.lastGiftConfigTime = time;
				dataProxy.giftPaneVO.initXML();
				Cc.log("重新加载礼物配置");
			}
				
		}
	}
}