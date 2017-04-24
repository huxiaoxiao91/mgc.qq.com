package controller
{	
	import flash.external.ExternalInterface;
	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	/**
	 * 送礼回调
	 */	
	public class ResponseGiftCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			//o示例  {"ret":0,"result":{"result":3,"reason_ext":"","result_ext":0},"qq":"87969730659675328","op_type":19}
			var o:Object = notification.getBody() as Object;
			
//			return;
			
			if(o.xuandou != -1)
				dataProxy.bottomPaneVO.money = o.xuandou;
			
			dataProxy.bottomPaneVO.videomoney = o.video_money;
			
			//Cc.log("xuandou" + o.xuandou + "    " + "video_money" + o.video_money);
			
			var obj:Object = {};
			obj.Type = 1;
			obj.Title = "提示信息";
			obj.BtnName = "确定";
			obj.BtnNum = 1;
			
			var retrunFunction:String = "";
			
			switch(o.result.result)
			{
//				//成功
//				case 0:
//					return;
				//无效
				case 1:
					obj.Note = "送礼物，无效。";
					break;
				//失败
				case 2:
					obj.Note = "送礼物，失败。";
					break;
				//内部错误
				case 3:
					obj.Note = "送礼物，内部错误。";
					break;
				//礼物不存在
				case 4:
					//忽略主播经验礼物
//					if (o.gift_id == 300) {
//						return;
//					}
					obj.Note = "送礼物，礼物不存在。";
					break;
				//代币数量不足
				case 5:
					obj.Note = "您没有足够的炫豆用于送出该礼物，快去充值吧。";
					obj.BtnName = "快捷购买";
					obj.BtnNum = 2;
					obj.url = "http://pay.qq.com/ipay/index.shtml?c=qxwwqp";
					retrunFunction = "fastPurchase"
					break;
				//献花数量不足
				case 6:
					obj.Note = "送礼物失败，您没有足够的花朵了。";
					break;
				//不在直播中
				case 7:
					//obj.Note = "房间还未开播，不能送礼哦。";
					obj.Note = "赠送礼物失败！";
					break;
				//房间不存在
				case 8:
					obj.Note = "送礼物失败，视频房间不存在。";
					break;
				//房间中没找到送礼人
				case 9:
					obj.Note = "送礼物失败，没有找到收礼物的人。";
					break;
				//房间中没找到主播
				case 10:
					obj.Note = "送礼物失败，房间内没有主播。";
					break;
				//房间中没找到礼物数据配置
				case 11:
					obj.Note = "礼物已经下架了，请选择其他的礼物。";
					break;
				//守护等级不够
				case 12:
					obj.Note = "对不起，只有成为高级守护或者更高级别的守护，才能使用这个礼物。";
					break;
				//积分不够
				case 13:
					obj.Note = "您的个人积分不足，无法送礼物。";
					break;
				//找不到后援团
				case 14:
					obj.Note = "找不到后援团。";
					break;
				//找不到后援团成员
				case 15:
					obj.Note = "找不到后援团成员。";
					break;
				//错误的主播对象
				case 16:
					obj.Note = "送礼物失败，未找到礼物数据。";
					break;
				//不在主播小窝中，不能送超级捧场卡
				case 17:
					obj.Note = "不在主播个人直播间中，不能送超级捧场卡。";
					break;
				//不在主播小窝中，不能送超级捧场卡
				case 18:
					obj.Note = "您没有足够的梦幻币。您可以通过领取每日工资和完成任务获得梦幻币。";
					break;
				
				case 20:
					ExternalInterface.call("GiftQuickPane.showSendAgainTip",o);
					return;
					break;
				
				case 22:
					obj.Note = "本次活动已经结束";
					ExternalInterface.call("fa.resp.recvCommonActivityInfoEndCallback");
					break;
				
				case 23:
					obj.Note = "赠送礼物失败！";
					break;
				
				case 24:
					obj.Note = "赠送礼物失败！";
					break;
				
				default:
					return;
			}
			if(retrunFunction.length > 0)
				ExternalInterface.call("MGC_Comm.CommonDialog",obj,retrunFunction);
			else
				ExternalInterface.call("MGC_Comm.CommonDialog",obj);
		}
	}
}