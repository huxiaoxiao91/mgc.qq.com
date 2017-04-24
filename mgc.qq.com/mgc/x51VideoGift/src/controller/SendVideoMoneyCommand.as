package controller
{	
	import flash.external.ExternalInterface;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class SendVideoMoneyCommand extends SimpleCommand {
		override public function execute(notification:INotification):void {
			var o:Object = new Object();
			o.op_type = 154;
			//var json:String = JSON.stringify(o);
			//ExternalInterface.call("gift_send",json);
			ExternalInterface.call("gift_send", o);
		}
	}
}
