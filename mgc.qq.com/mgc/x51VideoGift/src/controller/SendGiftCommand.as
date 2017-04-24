package controller
{	
	import flash.external.ExternalInterface;
	
	import model.DataProxy;
	import model.data.GiftVO;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	
	public class SendGiftCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			var o:Object = new Object();
			o.op_type = 19;
			
			var giftVo:GiftVO;
			
			if(notification.getBody())
			{
				var obj:Object = notification.getBody();
				giftVo = dataProxy.giftPaneVO.getGiftById(obj.id);
				o.gift_id = obj.id;
				o.gift_cnt = obj.num;
			}
			else
			{
				//没有选中
				if(dataProxy.giftPaneVO.selectid == -1)
					return;
				giftVo = dataProxy.giftPaneVO.getGiftById(dataProxy.giftPaneVO.selectid);
				o.gift_id = giftVo.id;
				/*if(giftVo.type == 6 && giftVo.num > 0)
				{
					o.gift_cnt = giftVo.num;
				}
				else
				{
					o.gift_cnt = dataProxy.bottomPaneVO.num;
				}*/
				
				o.gift_cnt = dataProxy.bottomPaneVO.num;
				o.star_gift = giftVo.isStar;
			}
			//Cc.log("送礼: ",o.gift_id,"数量： ",o.gift_cnt);
			//var json:String = JSON.stringify(o);

			//ExternalInterface.call("gift_send",json);

			if (giftVo != null && giftVo.skinsubject > 0) {
				if (giftVo.num < o.gift_cnt) {
					ExternalInterface.call("window.mgc.luckyDialog");
					return;
				}
			}
			
			ExternalInterface.call("gift_send",o);
		}
	}
}