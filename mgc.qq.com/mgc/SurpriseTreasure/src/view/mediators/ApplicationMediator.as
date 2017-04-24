 package view.mediators
{	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.*;
	import view.mediators.*;
	
	public class ApplicationMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String="ApplicationMediator";

		public function ApplicationMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);

			facade.registerMediator(new SurpriseTreasurePaneMediator(component.surpriseTreasurePane));
		}
		
		override public function listNotificationInterests():Array
		{
			return new Array();
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
		}
		
		public function get component():SurpriseTreasureSwf
		{
			return viewComponent as SurpriseTreasureSwf;
		}
		
		
	}
}