package controller
{	
	import flash.external.ExternalInterface;
	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	/**
	 * 飞屏回调
	 */	
	public class ResponseMessageCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			var o:Object = notification.getBody() as Object;
			
			if(o.xuandou != -1)
				dataProxy.bottomPaneVO.money = o.xuandou;
			
			//飞屏成功后更新免费飞屏数量
			if(o.result.result == 0)
			{
				sendNotification(ApplicationFacade.SendFreeMessageCount);
			}
			
			var retrunFunction:String = "";
			
			var obj:Object = {};
			obj.Type = 1;
			obj.Title = "提示信息";
			obj.BtnName = "确定";
			obj.BtnNum = 1;
			
			switch(o.result.result)
			{
				//成功
				case 0:
					sendNotification(ApplicationFacade.SendFreeMessageCount);
					return;
				//禁止公众频道聊天
				case 1:
					obj.Note = "当前房间关闭了公众聊天";
					break;
				//聊天cd中
				case 2:
					obj.Note = "房间管理员限制文字聊天的速度，每"+o.set_cd_time+"秒可发送一次！请"+o.wait_time+"秒后再发送文字";
					break;
				//私聊找不到目标玩家
				case 3:
					obj.Note = "对不起，该玩家不在视频房间中";
					break;
				//直播中才可以发飞屏
				case 4:
					obj.Note = "对不起，只有在直播中才能使用飞屏！";
					break;
				//单房间阈值达到，悄悄地丢弃
				case 5:
					return;
				//禁言状态不能使用飞屏
				case 6:
					obj.Note = "您已被管理员禁言，无法使用飞屏。";
					break;
				//免费飞屏已经用尽
				case 7:
					obj.Note = "免费飞屏已经用完啦~";
					break;
				//不在比赛中，不能发送免费飞屏，主播端使用
				case 8:
					return;
				//失败
				case 9:
					obj.Note = "无法找到该玩家或者该玩家已经下线";
					break;
				//被禁言
				case 10:
					obj.Note = "对不起，您暂时被管理员禁止发言";
					break;
				//永久禁言
				case 11:
					obj.Note = "对不起，您在本房间已被永久禁言。";
					break;
				//没有炫逗
				case 12:
					obj.Note = "您没有足够的炫豆用于发送飞屏，快去充值吧。";
					obj.BtnName = "快捷购买";
					obj.BtnNum = 2;
					obj.url = "http://pay.qq.com/ipay/index.shtml?c=qxwwqp";
					retrunFunction = "fastPurchase"
					
					break;
				//公屏聊天cd时间未到
				case 13:
					obj.Note = "对不起，进入本房间后，在"+o.set_cd_time+"秒内无法在公众频道发言，请稍后再尝试。成为主播的高级或以上的守护，或者拥有骑士或以上的贵族身份，可不受此限制。";
					break;
				//禁言状态不能使用超新星喇叭
				case 14:
					obj.Note = "已被管理员禁言，无法使用超新星喇叭发言。";
					break;
				//被腾讯的消息过滤系统禁止
				case 15:
					obj.Note = "您已被禁言，剩余时间："+ o.wait_time +"分钟";
					break;
				//被全房间禁言
				case 16:
					obj.Note = "当前房价关闭了公众聊天";
					break;
				//由于服务器错误导致飞屏发送失败
				case 18:
					obj.Note = "飞屏发送失败";
					break;
					
				default:
					return;
			}
			
			if(retrunFunction.length > 0){
				ExternalInterface.call("MGC_Comm.CommonDialog",obj,retrunFunction);
			}else{
				ExternalInterface.call("MGC_Comm.CommonDialog",obj);
			}
		}
	}
}