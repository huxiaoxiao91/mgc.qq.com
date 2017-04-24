package
{
	import controller.*;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade
	{

		/**
		 * 初始化程序
		 */
		public static const STARTUP:String = "startup";
		
		/**
		 * 单例
		 */
		public static function getInstance():ApplicationFacade
		{
			if ( instance == null )
			{
				instance = new ApplicationFacade();
			}
			
			return instance as ApplicationFacade;
		}
		
		/**
		 * 初始化控制器
		 */
		override protected function initializeController():void
		{
			super.initializeController();
			
			registerCommand(ApplicationFacade.STARTUP, StartupCommand);
		}
	
	
	}
}