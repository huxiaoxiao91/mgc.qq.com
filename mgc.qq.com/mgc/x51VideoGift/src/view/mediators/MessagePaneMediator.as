 package view.mediators
{	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.*;
	import view.mediators.*;
	
	public class MessagePaneMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "MessagePaneMediator";

		private var dataProxy:DataProxy;
		
		public function MessagePaneMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
			
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			component.vo = dataProxy.messagePaneVO;
			
			component.initUI();
			
		}
		
		override public function listNotificationInterests():Array
		{
			return new Array();
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
		}
		
		public function get component():MessagePane
		{
			return viewComponent as MessagePane;
		}
		
		
	}
}