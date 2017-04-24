 package view.mediators
{	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.EffectPane;
	
	public class EffectPaneMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "EffectPaneMediator";

		private var dataProxy:DataProxy;
		
		public function EffectPaneMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
			
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			component.vo = dataProxy.effectPaneVO;
			
			dataProxy.effectPaneVO.addEventListener("path",pathHandler);
			
			dataProxy.effectPaneVO.addEventListener("clear",clearHandler);
		}
		
		
		private function pathHandler(e:Event):void
		{
			//Cc.log("显示礼物特效地址   "+dataProxy.effectPaneVO.path);
			component.play(dataProxy.effectPaneVO.path);
		}
		
		private function clearHandler(e:Event):void
		{
			//这个方法会把名片所在清除掉。。。再次开播后不会自动加载到显示列表上。
//			while(component.numChildren > 1)
//			{
//				var disObj:DisplayObject = component.removeChildAt(1);
//				disObj = null;
//			}
			
			component.clearEffect();
			
			//全屏动画允许播放完毕。
			//隐藏皮鞭页面的礼物效果
			//ExternalInterface.call("MGC_Comm.hideGiftEffect");
		}
		
		private function getGuardIcon(guardIcon:String):String
		{
			guardIcon = DataProxy.ImgDomain + "/css_img/flash/icon/identity_" + guardIcon + ".png";
			
			return guardIcon;
		}
		
		private function getVipIcon(vipIcon:String):String
		{
			vipIcon = DataProxy.ImgDomain + "/css_img/flash/icon/identity_" + vipIcon + ".png";
			
			return vipIcon;
		}
		
		override public function listNotificationInterests():Array
		{
			return new Array();
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
		}
		
		public function get component():EffectPane
		{
			return viewComponent as EffectPane;
		}
		
		
	}
}