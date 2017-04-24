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
		 * 
		 * 
		 * 显示逻辑
		 * 
		 * 
		 */
		/**
		 * 显示礼物介绍
		 */
		public static const ShowGiftTipPane:String = "ShowGiftTipPane";
		
		/**
		 * 显示礼物数量选择界面
		 */
		public static const ShowNumberPane:String = "ShowNumberPane";
		
		/**
		 * 显示飞屏界面
		 */
		public static const ShowFlyInputPane:String = "ShowFlyInputPane";
		
		/**
		 * 显示表情界面
		 */
		public static const ShowFacePane:String = "ShowFacePane";
		
		/**
		 * 重新加载礼物配置
		 */
		public static const LoadGiftConfig:String = "LoadGiftConfig";
		
		
		/**
		 * 
		 * 
		 * 通讯逻辑
		 * 
		 * 
		 */
		/**
		 * 提交送礼
		 */
		public static const SendGift:String = "SendGift";
		
		/**
		 * 送礼回调
		 */
		public static const ResponseGift:String = "ResponseGift";
		
		
		/**
		 * 提交飞屏
		 */
		public static const SendMessage:String = "SendMessage";
		
		/**
		 * 飞屏回调
		 */
		public static const ResponseMessage:String = "ResponseMessage";
		
		
		/**
		 * 获取免费飞屏数量
		 */
		public static const SendFreeMessageCount:String = "SendFreeMessageCount";
		
		/**
		 * 免费飞屏数量回调
		 */
		public static const ResponseFreeMessageCount:String = "ResponseFreeMessageCount";
		
		
		/**
		 * 查询余额
		 */
		public static const SendBalance:String = "SendBalance";
		
		/**
		 * 查询余额回调
		 */
		public static const ResponseBalance:String = "ResponseBalance";
		
		
		/**
		 * 查询梦幻币余额
		 */
		public static const SendVideoMoney:String = "SendVideoMoney";
		
		/**
		 * 查询梦幻币余额回调
		 */
		public static const ResponseVideoMoney:String = "ResponseVideoMoney";
		
		
		
		
		/**
		 * 免费礼物更新的通知  推送
		 */
		public static const ResponseFreeGift:String = "ResponseFreeGift";
		
		/**
		 * 礼物消息广播 推送
		 */
		public static const ResponseGiftMessage:String = "ResponseGiftMessage";
		
		/**
		 * 房间信息 推送
		 */
		public static const ResponseRoomInfo:String = "ResponseRoomInfo";
		
		/**
		 * 房间状态 推送
		 */
		public static const ResponseRoomStatus:String = "ResponseRoomStatus";
		
		
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
			
			/**
			 * 
			 * 
			 * 注册显示逻辑
			 * 
			 * 
			 */
			registerCommand(ApplicationFacade.ShowGiftTipPane, ShowGiftTipPaneCommand);
			registerCommand(ApplicationFacade.ShowNumberPane, ShowNumberPaneCommand);
			registerCommand(ApplicationFacade.ShowFlyInputPane, ShowFlyInputPaneCommand);
			registerCommand(ApplicationFacade.ShowFacePane, ShowFacePaneCommand);
			registerCommand(ApplicationFacade.LoadGiftConfig, LoadGiftConfigCommand);
			
			/**
			 * 
			 * 
			 * 注册通讯逻辑
			 * 
			 * 
			 */
			registerCommand(ApplicationFacade.SendGift, SendGiftCommand);
			registerCommand(ApplicationFacade.ResponseGift, ResponseGiftCommand);
				
			registerCommand(ApplicationFacade.SendMessage, SendMessageCommand);
			registerCommand(ApplicationFacade.ResponseMessage, ResponseMessageCommand);
			
			registerCommand(ApplicationFacade.SendFreeMessageCount, SendFreeMessageCountCommand);
			registerCommand(ApplicationFacade.ResponseFreeMessageCount, ResponseFreeMessageCountCommand);
			
			registerCommand(ApplicationFacade.SendBalance, SendBalanceCommand);
			registerCommand(ApplicationFacade.ResponseBalance, ResponseBalanceCommand);
			
			registerCommand(ApplicationFacade.SendVideoMoney, SendVideoMoneyCommand);
			registerCommand(ApplicationFacade.ResponseVideoMoney, ResponseVideoMoneyCommand);
			
			
			registerCommand(ApplicationFacade.ResponseGiftMessage, ResponseGiftMessageCommand);
			registerCommand(ApplicationFacade.ResponseFreeGift, ResponseFreeGiftCommand);
			registerCommand(ApplicationFacade.ResponseRoomInfo, ResponseRoomInfoCommand);
			registerCommand(ApplicationFacade.ResponseRoomStatus, ResponseRoomStatusCommand);
				
		}
	
	
	}
}