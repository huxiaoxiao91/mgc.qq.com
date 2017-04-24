package controller
{	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.components.*;
	import view.mediators.*;
	
	public class ViewPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			var client:x51VideoGift = notification.getBody() as x51VideoGift;
			facade.registerMediator(new ApplicationMediator(client));
		}
	}
}