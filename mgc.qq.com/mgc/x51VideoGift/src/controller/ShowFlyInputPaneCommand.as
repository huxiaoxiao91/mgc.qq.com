package controller
{	
	import flashx.textLayout.elements.ParagraphElement;
	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	
	public class ShowFlyInputPaneCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			var flyInputPaneMediator:FlyInputPaneMediator = facade.retrieveMediator(FlyInputPaneMediator.NAME) as FlyInputPaneMediator;
				
			var o:Object = notification.getBody() as Object;
			
			//是否隐藏界面
			if(!o.visible)
			{
				dataProxy.flyInputPaneVO.visible = false;
				var bottomPaneMediator:BottomPaneMediator = facade.retrieveMediator(BottomPaneMediator.NAME) as BottomPaneMediator; 
				bottomPaneMediator.component.btn_message.selected = false;
				dataProxy.facePaneVO.visible =  false;
				sendNotification(ApplicationFacade.ShowFacePane,{visible:true});
				return;
			}
			
			var paragraphElement:ParagraphElement = dataProxy.flyInputPaneVO.textFlow.getChildAt(0) as ParagraphElement;
			//判断内容是否为空
			if(paragraphElement.getText() == "")
			{
				//添加一个空字符  使焦点在输入框
				dataProxy.flyInputPaneVO.editManager.selectRange(0,0);
				dataProxy.flyInputPaneVO.editManager.insertText("");
				
				dataProxy.flyInputPaneVO.flyCount = dataProxy.flyInputPaneVO.count;
							
			}
			
			//默认焦点在输入框
			//flyInputPaneMediator.component.stage.focus = flyInputPaneMediator.component.inputContainer;
			dataProxy.flyInputPaneVO.textFlow.interactionManager.setFocus();
			
			//位置 显示
			dataProxy.flyInputPaneVO.visible = true;
			//flyInputPaneMediator.component.x = 0;
			flyInputPaneMediator.component.y = flyInputPaneMediator.component.stage.stageHeight - flyInputPaneMediator.component.height - 5;
			
		}
	}
}