package model {

	import br.com.stimuli.loading.BulkLoader;
	
	import com.bit101.utils.GeneralEventDispatcher;
	import com.junkbyte.console.Cc;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.SecurityErrorEvent;
	import flash.external.ExternalInterface;
	import flash.globalization.DateTimeFormatter;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import model.data.BottomPaneVO;
	import model.data.EffectPaneVO;
	import model.data.FacePaneVO;
	import model.data.FlyInputPaneVO;
	import model.data.GiftData;
	import model.data.GiftPaneVO;
	import model.data.GiftTipPaneVO;
	import model.data.MessagePaneVO;
	import model.data.NumberPaneVO;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import view.mediators.ApplicationMediator;


	public class DataProxy extends Proxy implements IProxy {

		public static const NAME:String                  = "DataProxy";

		/**
		 * 礼物资源地址
		 * <li>/css_img/flash/gift/gift_</li>
		 */
		public static const GIFT_PATH:String             = "/css_img/flash/gift/gift_";

		/**
		 * flash所在域
		 */
		public static var Domain:String;

		/**
		 * 图片所在域
		 */
//		public static var ImgDomain:String = "http://ossweb-img.qq.com/images/mgc";
		//发外网时使用
		public static var ImgDomain:String               = "";

		/**
		 * 礼物配置文件地址
		 */
		public static var GiftConfig:String = "http://ossweb-img.qq.com/images/mgc/css_img/config/gift.xml";
		
		/**
		 * 加载礼物配置CD时间 毫秒
		 */
		public var GiftConfigCD:Number = 10*1000;
		
		/**
		 * 上一次加载礼物配置的时间 毫秒
		 */
		public var lastGiftConfigTime:Number = 0;

		public static var videoGift:x51VideoGift;

		public static var isCaveolaeBo:Boolean;

		/**
		 * 专属皮肤1——迷情舞台
		 */
		public static const SKIN_ID_1_STAGE:uint         = 1;
		/**
		 * 专属皮肤2——海底世界
		 */
		public static const SKIN_ID_2_SEA:uint           = 2;
		/**
		 * 专属皮肤3——游乐园
		 */
		public static const SKIN_ID_3_PARK:uint          = 3;

		private static const MAX_SKIN_COUNT:int          = 3;
		private static var _skinId:int;

		public static function get skinId():int {
			return _skinId;
		}

		public static function set skinId(value:int):void {
			if (value < 0) {
				value = 0;
			} else if (value > MAX_SKIN_COUNT) {
				value = 0;
			}
			_skinId = value;
		}

		public static var skinLevel:int;

		/**
		 * 皮肤已经开启
		 * @return
		 *
		 */
		public static function get isSkinOpened():Boolean {
			return skinId > 0 && skinLevel > 0;
		}

		/**
		 * 皮肤文本背景颜色
		 */
		public static var skinTextBgColor:int;
		public static const SKIN_1_TEXT_BG_COLOR:uint    = 0x7D3EE7;
		public static const SKIN_2_TEXT_BG_COLOR:uint    = 0X4E9CF8;
		public static const SKIN_3_TEXT_BG_COLOR:uint    = 0XEF54AC;

		public static const SKIN_2_NUM_BG_COLOR:uint     = 0X0064dc;

		//alpha 66
		public static const SKIN_1_MESSAGE_BG_COLOR:uint = 0x7821fc; //0x5f0091;
		//alpha 45
		public static const SKIN_2_MESSAGE_BG_COLOR:uint = 0X02389B;
		//alpha 60
		public static const SKIN_3_MESSAGE_BG_COLOR:uint = 0XB42D60;

		/**
		 * 自己昵称
		 */
		public static var UserName:String;

		/**
		 * 主播昵称
		 */
		public static var AnchorName:String;

		/**
		 * 自己守护等级
		 */
		public static var GuardLevel:int                 = 0;

		private var isReceive:Boolean                    = false;

		/**
		 * 是否游客
		 */
		public var isVisitor:Boolean                     = false;

		/**
		 * 演唱会是否有门票
		 */
		public static var isHasTicket:Boolean            = false;

		/**
		 * 是否是演唱会
		 */
		public static var isConcert:Boolean              = false;

		/**
		 * 房间状态
		 * 2 直播
		 */
		public var roomStatus:int                        = 0;

		/**
		 * 用于整个项目的XML,SWF,图片等数据加载
		 */
		private var bulkLoader:BulkLoader                = new BulkLoader("gift");


		/**
		 * 礼物界面
		 */
		public var giftPaneVO:GiftPaneVO                 = new GiftPaneVO();

		/**
		 * 表情界面
		 */
		public var facePaneVO:FacePaneVO                 = new FacePaneVO();

		/**
		 * 礼物提示界面
		 */
		public var giftTipPaneVO:GiftTipPaneVO           = new GiftTipPaneVO();

		/**
		 * 操作界面
		 */
		public var bottomPaneVO:BottomPaneVO             = new BottomPaneVO();

		/**
		 * 礼物消息界面
		 */
		public var messagePaneVO:MessagePaneVO           = new MessagePaneVO();

		/**
		 * 礼物数量选择界面
		 */
		public var numberPaneVO:NumberPaneVO             = new NumberPaneVO();

		/**
		 * 飞屏输入界面
		 */
		public var flyInputPaneVO:FlyInputPaneVO         = new FlyInputPaneVO();

		/**
		 * 礼物效果界面
		 */
		public var effectPaneVO:EffectPaneVO             = new EffectPaneVO();

		private var surpriseTreasureObj:Object           = null;

		public static var userId:String                  = "";

		public var isFirstGetDreamGiftNum:Boolean        = true;

		private var isOfficialRoom:Boolean               = false;

		public function DataProxy() {
			super(NAME);

			bulkLoader.addEventListener(BulkLoader.ERROR, onError);
			bulkLoader.addEventListener(BulkLoader.SECURITY_ERROR, onSecurityError);
			//bulkLoader.addEventListener(BulkLoader.COMPLETE, onComplete);
			bulkLoader.addEventListener("XMLComplete", onXMLComplete);

			//Js调用Flash
			ExternalInterface.addCallback("request_as", request_as);

			//Js调用Flash快捷购买
			ExternalInterface.addCallback("fastPurchase", fastPurchase);
			
			//Js调用Flash设置圣诞礼物id
			ExternalInterface.addCallback("setActivityGift", setActivityGift);

			//Js调用Flash 全屏礼物效果播放完毕。
			ExternalInterface.addCallback("fullGiftEffectPlayOver", jsCallFullGiftEffectPlayOver);

			//礼物列表初始化完成
			giftPaneVO.addEventListener("giftList", giftListHandler);

			//刷新礼物消息排序
			//messagePaneVO.addEventListener("MessagePaneVO.sortMessage",sortMessageHandler);
		}

		private function giftListHandler(e:Event):void {
			//更新高级守护礼物加锁
			giftPaneVO.updataGuardLevel(GuardLevel);
		}

		/**
		 * 加载失败
		 */
		private function onSecurityError(e:SecurityErrorEvent):void {
//			Cc.log("加载失败", e.text);
			bulkLoader.removeFailedItems();
		}

		/**
		 * 加载失败
		 */
		private function onError(e:ErrorEvent):void {
//			Cc.log("加载失败", e.text);
			bulkLoader.removeFailedItems();
		}

		private function onXMLComplete(event:Event):void {
			bulkLoader.removeEventListener("XMLComplete", onXMLComplete);
			onComplete(null);
		}

		/**
		 * 加载成功
		 */
		private function onComplete(e:Event):void {
			//礼物配置文件加载成功   初始化完成
			if (bulkLoader.hasItem(GiftConfig) || e == null) {
				bulkLoader.removeEventListener(BulkLoader.COMPLETE, onComplete);

				//先将状态置成未直播
				var params:Object = {data: {status: 3}};
				//params.data.status = 3;
				sendNotification(ApplicationFacade.ResponseRoomInfo, params);


				//通知页面flash初始化成功
				var tojson:Object = new Object();
				tojson.op_type = -6;
//				var str:String = JSON.stringify(tojson);
				ExternalInterface.call("response_as", tojson);

				//查询服务器连接状态
				var o:Object = new Object();
				o.op_type = 178;
				ExternalInterface.call("gift_send", o);
				
				//查询PK礼物
				o = new Object();
				o.op_type = 326;
				ExternalInterface.call("gift_send", o);
			}
		}

		/**
		 * 请求一些初始化数据
		 */
		private function request():void {
			//获取免费飞屏数量
			sendNotification(ApplicationFacade.SendFreeMessageCount);

			//查询余额
			sendNotification(ApplicationFacade.SendBalance);

			//查询梦幻币余额
			sendNotification(ApplicationFacade.SendVideoMoney);

			var tojson:Object = new Object();
			tojson.op_type = 183; //请求梦幻币礼物数量
			ExternalInterface.call("gift_send", tojson);

			/*var tojson1:Object = new Object();
			tojson1.op_type = 147;
			ExternalInterface.call("gift_send",tojson1);
			Cc.warn("请求183和147 187接口");*/

			//请求动态礼物配置

			var tojson2:Object = new Object();
			tojson2.op_type = 187; //礼物数量对应的特效
			ExternalInterface.call("gift_send", tojson2);


			//请求是否游客
			var tojson3:Object = new Object();
			tojson3.op_type = 203; //是否为游客登录状态
			ExternalInterface.call("gift_send", tojson3);

//			//查询服务器连接状态
//			var o:Object = new Object();
//			o.op_type = 178;
//			ExternalInterface.call("gift_send",o);
		}

		/**
		 * JS回调接口
		 */
		private function request_as(jsonparam:*):void {
			//Cc.log(jsonparam);
			var params:Object;

			//判断obj str
			if (jsonparam is String) {
				try {
					params = JSON.parse(jsonparam);
				} catch (e:SyntaxError) {
					return;
				}
			} else {
				params = jsonparam;
			}

			if (params == null) {
				return;
			}

			var dtf:DateTimeFormatter = new DateTimeFormatter("zh-CN");
			dtf.setDateTimePattern("yyyy-MM-dd HH:mm:ss:SSSSS");
			//Cc.warn("登录回调：",JSON.stringify(jsonparam) + dtf.format(new Date()));
			switch (params.op_type as int) {
				//登录回调
				case -2:
//					Cc.warn("登录回调：", JSON.stringify(jsonparam));
					if (params.res == 0) {
						request();
					}
					break;

				//服务器连接状态回调
				case 178:
//					Cc.warn("服务器连接状态回调：", JSON.stringify(jsonparam));
					if (params.res) {
						request();
					}

					break;

				//玩家守护等级回调
				case 236:
//					Cc.warn("玩家守护等级回调：", JSON.stringify(jsonparam));

					GuardLevel = params.guard_level;

					giftPaneVO.updataGuardLevel(GuardLevel);

					break;

				//送礼回调
				case 19:
//					Cc.warn("送礼回调：", JSON.stringify(jsonparam));
					sendNotification(ApplicationFacade.ResponseGift, params);

					var tojson:Object = new Object();
					tojson.op_type = 183;
					ExternalInterface.call("gift_send", tojson);
					break;

				//飞屏回调
				case 24:
//					Cc.warn("飞屏回调：", JSON.stringify(jsonparam));
					sendNotification(ApplicationFacade.ResponseMessage, params);
					break;

				//免费飞屏数量回调
				case 26:
//					Cc.warn("免费飞屏数量回调1111：", JSON.stringify(jsonparam));
					if (isOfficialRoom) {
						return;
					}
					sendNotification(ApplicationFacade.ResponseFreeMessageCount, params);
					break;

				//房间信息回调
				case 30:
//					Cc.warn("房间信息回调111：", JSON.stringify(jsonparam));
					sendNotification(ApplicationFacade.ResponseRoomInfo, params);

					var tojson2:Object = new Object();
					tojson2.op_type = 35;
					ExternalInterface.call("gift_send", tojson2);

					request();
					break;

				//房间状态更新回调
				case 35:
//					Cc.warn("房间状态更新回调111：", JSON.stringify(jsonparam));
					sendNotification(ApplicationFacade.ResponseRoomStatus, params);

					if (params.isSpecialRoom && !isOfficialRoom) {
						isOfficialRoom = true;
						sendNotification(ApplicationFacade.ResponseFreeMessageCount, {"count": 0});
					}

					if (params.status != 2) {
						//sendNotification(ApplicationFacade.ResponseGiftMessage,{"isClose":true});
						messagePaneVO.clear();
						effectPaneVO.clear();

						//非小窝情况，停播后清除守护礼物状态。
						if (!isCaveolaeBo) {
							GuardLevel = 0;
							giftPaneVO.updataGuardLevel(GuardLevel);
						}
					} else {
						//开播状态下判断礼物消息数量为0时显示提示
						if (messagePaneVO.content.numChildren == 0) {
							if (isConcert) {
								videoGift.messageTip.visible = true;
							} else {
								videoGift.messageTip.visible = false;
							}
						}
					}


					if (params.isConcert) {
						if (!isReceive) {
							var tojson3:Object = new Object();
							tojson3.op_type = 197;
							ExternalInterface.call("gift_send", tojson3);
						}


						facePaneVO.isShowGuardFace = !params.isConcert;
						giftPaneVO.isShowGuardFace = params.isConcert;


						//Cc.log("params.isHideGift   =   " + params.isHideGift);
						//GeneralEventDispatcher.getInstance().isConcertPlay = !params.isHideGift;
						var isHideGift:Boolean = !params.isHasTicket || !(params.status == 2);
						GeneralEventDispatcher.getInstance().isConcertPlay = !isHideGift;
						GeneralEventDispatcher.getInstance().isConcert = true;
						//GeneralEventDispatcher.getInstance().dispatchEvent(new Event("isConcertPlay"));

						if (!isHideGift) {
							bottomPaneVO.giftEnabled = true;
//							giftPaneVO.getFreeGift().enabled = true;
						} else {
							bottomPaneVO.giftEnabled = false;
//							giftPaneVO.getFreeGift().enabled = false;
						}
					} else if (!isReceive) {
						isReceive = true;
						giftPaneVO.isCall = true;
					}

					//演唱会无门票时不请求183
					if (!params.isConcert || params.isHasTicket) {
						var tojson183:Object = new Object();
						tojson183.op_type = 183;
						ExternalInterface.call("gift_send", tojson183);
					}

					isConcert = params.isConcert;
					roomStatus = params.status;

					//请求刷新周星礼物列表/冠名接口消息
					var tojson4:Object = new Object();
					tojson4.op_type = 274;
					ExternalInterface.call("gift_send", tojson4);

					if (DataProxy.isConcert) {
						showStarGift(false);
						if (roomStatus == 2) {
							if (messagePaneVO.content.numChildren == 0) {
								videoGift.messageTip.visible = true;
							} else {
								videoGift.messageTip.visible = false;
							}
						}
					}

					isHasTicket = params.isHasTicket;
					break;

				//礼物消息广播回调
				case 36:
//					Cc.warn("礼物消息广播回调111：", JSON.stringify(jsonparam));
					sendNotification(ApplicationFacade.ResponseGiftMessage, params);

					/*
					for each(var giftVO:GiftVO in giftPaneVO.giftList)
					{
						if( params.gift.giftItemID == giftVO.id && giftVO.type == 6)
						{
							var tojson1:Object = new Object();
							tojson1.op_type = 183;
							var str:String = JSON.stringify(tojson1);
							ExternalInterface.call("gift_send",str);
						}
					}
					*/
					break;

				//查询余额回调
				case 130:
//					Cc.warn("查询余额回调1111：", JSON.stringify(jsonparam));
					sendNotification(ApplicationFacade.ResponseBalance, params);
					break;

				//查询梦幻币回调
				case 154:
//					Cc.warn("查询梦幻币余额回调111：", JSON.stringify(jsonparam));
					sendNotification(ApplicationFacade.ResponseVideoMoney, params);
					break;
				//梦幻币和炫豆变更回调
				case 182:
//					Cc.warn("梦幻币和炫豆变更回调：", JSON.stringify(jsonparam));
					if (params.balance >= 0) {
						bottomPaneVO.money = params.balance;
					}
					if (params.dream_money >= 0) {
						bottomPaneVO.videomoney = params.dream_money;
					}
					break;

				//个人信息回调
				case 147:
//					Cc.warn("个人信息回调：", JSON.stringify(params));
					DataProxy.userId = params.playerinfo.pstid;
					DataProxy.UserName = params.playerinfo.nick;
					break;
				//完成主播任务
				case 143:
//					Cc.warn("完成主播任务回调：", JSON.stringify(params));
					var tojson143:Object = new Object();
					tojson143.op_type = 183;
					ExternalInterface.call("gift_send", tojson143);
					break;
				//获得宝箱奖励回调
				case 12:
//					Cc.warn("回调：", JSON.stringify(params));
					/*var tojson:Object = new Object();
					tojson.op_type = 183;
					ExternalInterface.call("gift_send",tojson);*/
					break;
				case 142:
					var tojson142:Object = new Object();
					tojson142.op_type = 183;
					ExternalInterface.call("gift_send", tojson142);
					break;
				//进入房间回调
				//梦幻币礼物数量变更回调
				case 183:
//					Cc.warn("梦幻币礼物数量变更回调：", JSON.stringify(params));
					giftPaneVO.updataGiftNum(params);
					break;

				//修改礼物配置回调
				case 187:
					//Cc.warn("修改礼物配置回调：", JSON.stringify(jsonparam));
					giftPaneVO.initEffectList();
					giftPaneVO.changeGiftConfig(params.giftdata);
					break;

				case 197:
					isReceive = true;
//					var ar:Array = [];
//					for each(var ii:uint in params.giftIdArray)
//					{
//						if(ii != 35 && ii != 36 && ii != 1 && ii != 100 && ii != 101 && ii != 102)
//							ar.push(ii);
//					}
					giftPaneVO.giftIdArray = params.giftIdArray;
					break;

				//是否游客
				case 203:
					isVisitor = params.isVisitor;
					if (isVisitor) {
					} else {
						var tojson1:Object = new Object();
						tojson1.op_type = 147;
						ExternalInterface.call("gift_send",tojson1);
							//ExternalInterface.call("mgc.callcenter.query_player_info");
					}
//					Cc.debug("203 params.isVisitor :" + params.isVisitor);
					break;
				//返回后援团判断
				case 205:
					giftPaneVO.canInvite = params.isSupport;
					break;
				//被开除后援团
				case 87:
					giftPaneVO.canInvite = false;
					break;

				//刷新周星礼物列表/冠名接口消息
				case 274:
//					Cc.warn("刷新周星礼物列表/冠名接口消息回调：", JSON.stringify(jsonparam));
					giftPaneVO.updataGiftStar(params);
					if (isConcert || roomStatus != 2 || params.cur_star_gifts.length == 0) {
						showStarGift(false);
					} else {
						showStarGift(true);
					}
					break;
				
				//刷新pk礼物，pk的角标
				case 326:
					giftPaneVO.updataPKGift(params.gift_list);
					break;
			}
		}

		private function showStarGift(b:Boolean):void {
			if (!b) {
				//屏蔽周星礼物
				giftPaneVO.isConcert = true;
				bottomPaneVO.isConcert = true;
				(ApplicationFacade.getInstance().retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator).component.weekStar.visible = false;
				ExternalInterface.call("GiftRankPane.show", false);
				ExternalInterface.call("GiftQuickPane.show", false);
				ExternalInterface.call("MGC_CommResponse.roomGiftAuto", false);
			} else {
				giftPaneVO.isConcert = false;
				bottomPaneVO.isConcert = false;
				(ApplicationFacade.getInstance().retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator).component.weekStar.visible = true;
				ExternalInterface.call("MGC_CommResponse.roomGiftAuto", true);
			}
		}

		/**
		 *
		 * Js调用Flash快捷购买
		 */
		private function fastPurchase():void {
			var url:URLRequest = new URLRequest("http://www.baidu.com");
			navigateToURL(url, "_blank");
		}
		
		/**
		 *
		 * Js调用Flash设置圣诞礼物id
		 */
		private function setActivityGift(id:int):void {
			GiftData.activity_gift_id = id;
		}

		private function jsCallFullGiftEffectPlayOver():void {
			if (effectPaneVO != null && effectPaneVO.giftData != null) {
				if (effectPaneVO.giftData.isFullScreenGfit) {

					effectPaneVO.fullEffectOver = true;
				}
			}
		}

		static public function getWordNum(text:String):int {
			var num:int = 0;
			for (var i:uint = 0; i < text.length; i++) {
				var chat_code:Number = text.charCodeAt(i); //获得一个字符的ASCII编码 
				if ((chat_code >= 19968 && chat_code <= 40869)) {
					num += 2;
				} else {
					num += 1;
				}
			}

			return num;
		}

	}
}

