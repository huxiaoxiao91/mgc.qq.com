package controller
{	
	import flash.external.ExternalInterface;

	import model.DataProxy;
	import model.data.EffectVO;
	import model.data.GiftData;
	import model.data.GiftVO;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;


	/**
	 * 礼物消息广播
	 */
	public class ResponseGiftMessageCommand extends SimpleCommand {
		private var joinEffect:EffectVO;

		override public function execute(notification:INotification):void {
			var dataProxy:DataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;

			//o示例  {"gift":{"senderName":"mynamesasa","anchorID":"871838309","anchorName":"sasa","male":false,"giftName":"鲜花","senderPlayerID":"7810934898697105","giftIcon":null,"data":{"length":0,"objectEncoding":3,"bytesAvailable":0,"endian":"bigEndian","position":0},"giftItemID":1,"invisible":false,"ceremony":false,"count":1,"popularityChange":0,"occupyIndex":0,"sender_channelid":0,"vip_level":0,"support_degree_add":0,"zoneName":"web大区"},"op_type":36}
			var o:Object            = notification.getBody() as Object;
//			trace("礼物消息：" + JSON.stringify(o));

			if (o && o.hasOwnProperty("isClose")) {
				dataProxy.messagePaneVO.removeAllMessage();
				return;
			}

			var giftData:GiftData = new GiftData(o.gift);
			giftData.zoneName = giftData.zoneName != "" ? (giftData.zoneName == "梦工厂" ? giftData.zoneName : "炫舞-" + giftData.zoneName) : "";
			giftData.isSelf = o.isSelf;
			//giftData.effectLevel = 1;

			var userId:String = DataProxy.userId;
			//显示主播加经验效果  玩家是自己的话
			if (giftData.anchor_exp > 0 && giftData.senderPlayerID == userId) {
				ExternalInterface.call("MGC_Comm.addExpEffect", giftData.anchor_exp);
			}

			//召唤 安可 免费花 不显示
			if (giftData.giftItemID == 1 || giftData.giftItemID == 35 || giftData.giftItemID == 36) {
				return;
			}
			DataProxy.videoGift.messageTip.visible = false;
			
			//检测是否需要重新加载礼物配置
			if(!dataProxy.giftPaneVO.isGifts(giftData.giftItemID))
			{
				sendNotification(ApplicationFacade.LoadGiftConfig);
			}

			var effectVO:EffectVO;
			//捧场卡
			if (giftData.giftItemID == 98) {
				if (!joinEffect) {
					joinEffect = new EffectVO();
					//joinEffect.path = DataProxy.ImgDomain + "/css_img/flash/gift/gift_98_1.swf";
					joinEffect.path = DataProxy.ImgDomain + DataProxy.GIFT_PATH + "98_1.swf";
				}
				//seo②特效过滤
				effectVO = joinEffect;
			} else {
				//发送的礼物
				var vo:GiftVO = dataProxy.giftPaneVO.getGiftById(giftData.giftItemID);
				
				giftData.type = vo.type;
				//seo②特效过滤
				if (vo.type != 1 && vo.type != 5 && vo.type != 8 && vo.type != 6 && giftData.source != 3) {
					//if (vo.price >= GiftVO.SHOW_EFFECT_MIN_UNIT_PRICE) {
						//动画效果
						effectVO = vo.getEffect(giftData.count);
					//}
				} else {
					//周年庆活动大礼物特效特殊处理
					if(giftData.giftItemID == 61){
						effectVO = vo.getEffect(giftData.count);
					}
					//忽略以下礼物类型 免费礼物/后援团礼物/专属皮肤礼物/梦幻币礼物
//					return;
				}
			}

			var tempArray:Array     = [];
			var tempArrayIsMe:Array = [];
			var i:uint              = 0;

			var time:Number         = (new Date()).time;

			if (effectVO) {
				effectVO.giftData = giftData;
				effectVO.isSelf = o.isSelf;
				effectVO.userId = giftData.senderPlayerID;
				effectVO.senderName = giftData.senderName;
				effectVO.createTime = time;
				dataProxy.effectPaneVO.effectList.push(effectVO);
				giftData.createTime = effectVO.createTime;
				giftData.level = effectVO.level;
				/*if(dataProxy.effectPaneVO.effectList.length >= 3)
				{
					for each(var effectVO1:EffectVO in dataProxy.effectPaneVO.effectList)
					{
						Cc.log("添加礼物特效" + i + "   " + effectVO1.userId + "   " + DataProxy.userId + "   " +effectVO1.giftID);
						if(effectVO1.userId == DataProxy.userId)
						{
							Cc.log("登陆用户id" + i + "   " + DataProxy.userId);
//							tempArray.splice(0,0,effectVO1);
							tempArrayIsMe.push(effectVO1);
						}
						else if(i < 3)
						{
							tempArray.push(effectVO1);
							i++;
						}

					}
					tempArray = tempArrayIsMe.concat(tempArray);
					Cc.log("数组长度 " + tempArray.length);
					dataProxy.effectPaneVO.effectList = tempArray;
				}*/
				if (!dataProxy.effectPaneVO.isPlay) {
					//dataProxy.effectPaneVO.isPlay = false;
					dataProxy.effectPaneVO.nextEffect();
				}
			} else {
				giftData.createTime = time;
			}

			giftData.createTime = time;
			dataProxy.messagePaneVO.addMessage(giftData);

			//如果有连送  当前播放的礼物消息也要加速
		/*if(giftData.continuous_send_gift_times > 0)
		{
			dataProxy.messagePaneVO.currentQuick();
		}*/
		}
	}
}
