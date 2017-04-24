package controller
{	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	/**
	 * 房间信息回调
	 */	
	public class ResponseRoomStatusCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			//status:房间状态 0无效，1等待，2直播中 3已关闭
			var o:Object = notification.getBody() as Object;
			
			switch(o.status)
			{	
				//直播中
				case 2:
					dataProxy.bottomPaneVO.giftEnabled = true;
//					dataProxy.giftPaneVO.getFreeGift().enabled = true;
					break;
				
				default:
					dataProxy.bottomPaneVO.giftEnabled = false;
//					dataProxy.giftPaneVO.getFreeGift().enabled = false;
					break;
			}
		}
	}
}