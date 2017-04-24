package controller
{	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	
	public class ShowFacePaneCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			var facePaneMediator:FacePaneMediator = facade.retrieveMediator(FacePaneMediator.NAME) as FacePaneMediator;
				
			var o:Object = notification.getBody() as Object;
			
			//位置 是否显示
			dataProxy.facePaneVO.visible = dataProxy.facePaneVO.visible;
			
			//默认显示第一类
			dataProxy.facePaneVO.type = 1;
			
			facePaneMediator.component.x = 20;
			facePaneMediator.component.y = facePaneMediator.component.stage.stageHeight - facePaneMediator.component.height - 5;
			
		}
	}
}