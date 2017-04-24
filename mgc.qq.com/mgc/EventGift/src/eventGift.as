package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	[SWF(width="200", height="315", frameRate="30", backgroundColor="#FFFFFF")]
	public class eventGift extends Sprite
	{
		
		private var uiList:Array = [MC_0,MC_1,MC_2,MC_3,MC_4,MC_0_2,MC_1_2,MC_2_2,MC_3_2,MC_4_2];
		/**
		 * 单个礼物队列 
		 */
		private var list:Array = [];
		
		/**
		 * N个礼物队列 
		 */
		private var nlist:Array = [];
		
		/**
		 * 玩家id 
		 */
		public var playerID:String = "";
		
		/**
		 * 最大送礼数 服务器下发 
		 */
		private var maxNum:uint = 1314;
		
		/**
		 * 最大显示对象数
		 */
		static private var MAX_GIFT:uint = 30;
		
		/**
		 * 当前播放的礼物图片样式
		 */
		private var effectid:int = 1;
		
		private var timer:Timer;
		
		public function eventGift()
		{
			init();
		}
		
		private function init():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//this.addEventListener(Event.ENTER_FRAME,ef);
			//stage.addEventListener(MouseEvent.CLICK,click);
			//stage.addEventListener(Event.RESIZE, resizeHandler);
			
			timer = new Timer(200);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
			
			ExternalInterface.addCallback("request_as", request_as);
			ExternalInterface.addCallback("setMaxNum", setMaxNum);
			
			this.addEventListener(Event.ENTER_FRAME,ef);
		}
		
		private function ef(e:Event):void
		{
			this.graphics.clear();
			this.graphics.beginFill(0xff0000,0);
			this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			this.graphics.endFill();
		}
		
		private function setMaxNum(num:int):void 
		{
			maxNum = num;
		}
		
		private function resizeHandler(e:Event):void 
		{
				
		}
		
		private function click(e:MouseEvent):void
		{
			var o:Object = new Object();
			o.count = Math.floor(Math.random() * 10 + 1);
			o.senderPlayerID = "1";
			add(o);
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			//1个礼物队列
			if(this.numChildren < MAX_GIFT && list.length > 0)
			{
				var gift:Gift = list.shift();
				gift.effectid = effectid;
				effectid = (effectid + 1)>4?1:(effectid + 1);
				this.addChild(gift);	
				gift.start();
			}
			
			//n个礼物队列
			if(!isChristmas() && nlist.length > 0)
			{
				var gift:Gift = nlist.shift();
				gift.effectid = 0;
				this.addChild(gift);	
				gift.start();
			}
			
			/*for(var i:int = 0;i<this.numChildren;i++)
			{
				var displayObject:DisplayObject = this.getChildAt(i);
				if(displayObject is Gift)
				{
					(displayObject as Gift).updata();
				}
			}*/
		}
		
		/**
		 * 是否有圣诞老人 
		 */
		private function isChristmas():Boolean
		{
			for(var i:int = 0;i<this.numChildren;i++)
			{
				var displayObject:DisplayObject = this.getChildAt(i);
				if(displayObject is Gift)
				{
					if((displayObject as Gift).type == 0)return true;
				}
			}
			
			return false;
		}
		
		/**
		 * 活动结束  清除队列
		 */		
		private function remove():void
		{
			list = [];
			nlist = [];
		}
		
		/**
		 * 添加一条礼物消息
		 * @param o 礼物消息数据
		 */		
		public function add(o:Object):void
		{
			var gift:Gift;
			
			//送N个
			if(o.count >= maxNum)
			{
				if(nlist.length > 100)return;
				
				gift = new Gift();
				gift.type = 0;
				if(o.senderPlayerID == playerID)
				{
					gift.isSelf = true;
					nlist.unshift(gift);
				}
				else
				{
					nlist.push(gift);
				}
			}
			else//送1个
			{
				for(var i:int = 0;i<o.count;i++)
				{
					gift = new Gift();
					gift.type = 1;
					if(o.senderPlayerID == playerID)
					{
						gift.isSelf = true;
						list.unshift(gift);
					}
					else
					{
						if(getNum() < 100)
						{
							list.push(gift);
						}	
					}
				}
			}
		}
		
		/**
		 * 返回别人送的1个礼物的队列数量
		 * @return 
		 */		
		private function getNum():int
		{
			var num:int = 0;
			for(var i:int = 0;i<list.length;i++)
			{
				if(!list[i].isSelf)
				{
					num ++;
				}
			}
			return num;
		}
		
		/**
		 * JS回调接口
		 */
		private function request_as(jsonparam:*):void {
			var params:Object;
			
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
			
			switch (params.op_type as int) {
				//礼物消息
				case 36:
					add(params.gift);
					break;
				
				//个人信息
				case 147:
					playerID = params.playerinfo.pstid;
					break;
				
				//房间信息回调
				case 30:
					/*var tojson1:Object = new Object();
					tojson1.op_type = 147;
					ExternalInterface.call("gift_send",tojson1);*/
					break;
				
				//房间状态更新回调
				case 35:
					if (params.status != 2) {
						remove();
					}
					break;
			}
		}
	}
}