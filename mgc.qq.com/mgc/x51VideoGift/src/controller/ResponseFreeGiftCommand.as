package controller
{	
	import model.DataProxy;
	import model.data.GiftVO;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	/**
	 * 获取免费礼物更新的时间
	 */	
	public class ResponseFreeGiftCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			//o示例 {"leftTime":166,"giftNum":9,"op_type":38}
			var o:Object = notification.getBody() as Object;
			
			//获取免费礼物
			var vo:GiftVO = dataProxy.giftPaneVO.getFreeGift();
			
			//更新免费礼物数量    更新免费礼物更新剩余时间
			if(vo)
			{
				vo.num = o.giftNum;
				vo.leftTime = o.leftTime;
				
				//数量为0时变灰
				/*if(vo.num == 0)
				{
					vo.enabled = false;
				}
				else
				{
					vo.enabled = true;
				}*/
			}
		}
	}
}