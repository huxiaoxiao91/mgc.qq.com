package controller {

	import flash.external.ExternalInterface;
	
	import model.DataProxy;
	import model.data.GiftVO;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ShowGiftTipPaneCommand extends SimpleCommand implements ICommand {
		private var dataProxy:DataProxy;

		override public function execute(notification:INotification):void {
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;

			var vo:GiftVO = dataProxy.giftPaneVO.getGiftById(dataProxy.giftPaneVO.overid);
			//Cc.warn("json   "+ JSON.stringify(vo));
			if (!vo) {
				return;
			}

			dataProxy.giftTipPaneVO.name = vo.name;
			dataProxy.giftTipPaneVO.icon = vo.icon;
			dataProxy.giftTipPaneVO.price = vo.price;
			dataProxy.giftTipPaneVO.intro = vo.intro;
			dataProxy.giftTipPaneVO.type = vo.type;
			dataProxy.giftTipPaneVO.num = vo.num;
			//免费礼物数量为20时不倒计时
			if (vo.num == 20 && vo.type == 1) {
				dataProxy.giftTipPaneVO.leftTime = 600;
			} else {
				dataProxy.giftTipPaneVO.leftTime = vo.leftTime;
			}

			var o:Object = notification.getBody() as Object;

			vo.mouseX = o.x;
			vo.mouseY = o.y;
			vo.visible = o.visible;
			ExternalInterface.call("GiftTip2.show", vo);
		}
	}
}
