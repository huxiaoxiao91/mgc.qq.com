 package view.mediators
{	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.*;
	import view.mediators.*;
	
	public class FacePaneMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "FacePaneMediator";

		private var dataProxy:DataProxy;
		
		public function FacePaneMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
			
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			component.vo = dataProxy.facePaneVO;
			
			//component.vo.addEventListener("faceList",faceListHandler);
			component.vo.addEventListener("visible",visibleHandler);
			component.vo.addEventListener("page",pageHandler);
			component.vo.addEventListener("type",typeHandler);
			component.vo.addEventListener("isShowGuardFace",isShowGuardFaceHandler);
			component.addEventListener(MouseEvent.CLICK,clickHandler);
			
			//component.stage.addEventListener(MouseEvent.CLICK,stageClick);
			
			//component.initUI();
			
			component.list.addEventListener(Event.SELECT,faceSelect);
			/*component.list.addEventListener("OVER",giftOver);
			component.list.addEventListener(MouseEvent.MOUSE_OUT,giftOut);*/
		}
		
		/**
		 * 点击自身防止触发stage事件而消失
		 */		
		private function clickHandler(e:MouseEvent):void
		{
			e.stopImmediatePropagation();
		}
		
		private function faceSelect(e:Event):void
		{
			//选中的表情
			trace(component.list.selectedItem.id);
			
			dataProxy.flyInputPaneVO.addFace(component.list.selectedItem.id);
			//添加选中的表情
			//dataProxy.flyInputPaneVO.editManager.insertInlineGraphic(component.list.selectedItem.icon,24,24);
			//焦点设为输入框
			//dataProxy.flyInputPaneVO.textFlow.interactionManager.setFocus();
			//隐藏表情框
			dataProxy.facePaneVO.visible = false;
		}
		
		private function giftOver(e:Event):void
		{
			
		}
		
		private function giftOut(e:Event):void
		{
			
		}
		
		/**
		 * 表情列表数据更新
		 */		
		private function faceListHandler(e:Event):void
		{
			/*component.list.items = component.vo.faceList;
			
			component.vo.currentPage = component.list.currentPage;
			component.vo.totalPage = component.list.totalPage;*/
		}
		
		/**
		 * 表情类型更新
		 */		
		private function typeHandler(e:Event):void
		{
			//更新TAB
			component.tab1.selected = (component.vo.type == 1?true:false);
			component.tab2.selected = (component.vo.type == 2?true:false);
			
			component.tab3.selected = (component.vo.type == 3?true:false);
			component.tab4.selected = (component.vo.type == 4?true:false);
			//更新表情列表
			component.list.items = component.vo.getListByType(component.vo.type);
			component.vo.currentPage = component.list.currentPage;
			component.vo.totalPage = component.list.totalPage;
		}
		
		
		private function isShowGuardFaceHandler(e:Event):void
		{
			component.tab2.visible = component.vo.isShowGuardFace;
			component.tab2.enabled = component.vo.isShowGuardFace;
		}
		
		/**
		 * 页码更新
		 */		
		private function pageHandler(e:Event):void
		{
			component.text_page.text = dataProxy.facePaneVO.currentPage.toString() + "/" + dataProxy.facePaneVO.totalPage.toString();
		}
		
		/**
		 * 界面是否显示
		 */		
		private function visibleHandler(e:Event):void
		{
			component.visible = dataProxy.facePaneVO.visible;
		}
		
		override public function listNotificationInterests():Array
		{
			return new Array();
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
		}
		
		public function get component():FacePane
		{
			return viewComponent as FacePane;
		}
		
		
	}
}