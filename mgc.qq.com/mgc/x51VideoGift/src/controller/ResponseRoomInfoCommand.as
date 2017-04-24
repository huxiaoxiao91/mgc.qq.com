package controller
{	
	import flash.external.ExternalInterface;
	
	import model.DataProxy;
	import model.data.GiftVO;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	/**
	 * 房间信息回调
	 */	
	public class ResponseRoomInfoCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			//status:房间状态 0无效，1等待，2直播中 3已关闭
			var o:Object = notification.getBody() as Object;
			
			var vo:GiftVO = dataProxy.giftPaneVO.getFreeGift();
			
			DataProxy.AnchorName = o.data.anchorName;
			
			switch(o.data.status)
			{	
				//直播中
				case 2:
					dataProxy.bottomPaneVO.giftEnabled = true;
					if(vo)
					{
						dataProxy.giftPaneVO.getFreeGift().enabled = true;
					}
					
					break;
				
				default:
					dataProxy.bottomPaneVO.giftEnabled = false;
					if(vo)
					{
						dataProxy.giftPaneVO.getFreeGift().enabled = false;
					}
					
					break;
			}
		}
	}
}