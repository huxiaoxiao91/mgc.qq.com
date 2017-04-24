package model.data
{
	import br.com.stimuli.loading.BulkLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 
	 * 礼物界面数据模型
	 */
	public class GiftTipPaneVO extends EventDispatcher
	{
		/**
		 * 礼物id
		 */
		public var id:int;
		
		private var _name:String;
		
		private var _icon:String;
		
		private var _price:Number;
		
		private var _intro:String;
		
		
		
		private var _visible:Boolean = false;
		
		private var _leftTime:int;

		private var _type:int;
		
		private var timer:Timer;
		
		public var num:int;
		
		public function GiftTipPaneVO()
		{
//			timer = new Timer(1000);
//			timer.addEventListener(TimerEvent.TIMER,timerHandler);
//			timer.start();
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			//免费礼物数量为20时不倒计时
			if(num == 20 && type == 1)
			{
				leftTime = 600;
			}
			else
			{
				leftTime--;
			}
		}
		
		/**
		 * 礼物类别
		 * 1免费 2普通 3魔法 4尊贵 5后援团礼物
		 */
		public function get type():int
		{
			return _type;
		}
		
		/**
		 * @private
		 */
		public function set type(value:int):void
		{
			_type = value;
			
			dispatchEvent(new Event("type"));
		}
		
		
		/**
		 * 免费礼物下次刷新剩余时间  秒
		 */
		public function get leftTime():int
		{
			return _leftTime;
		}
		
		/**
		 * @private
		 */
		public function set leftTime(value:int):void
		{
			if(value <= 0)
			{
				value = 600;
			}
			
			_leftTime = value;
			
			dispatchEvent(new Event("leftTime"));
		}

		/**
		 * 礼物介绍
		 */
		public function get intro():String
		{
			return _intro;
		}

		/**
		 * @private
		 */
		public function set intro(value:String):void
		{
			_intro = value;
			
			dispatchEvent(new Event("intro"));
		}

		/**
		 * 礼物价格
		 */
		public function get price():Number
		{
			return _price;
		}

		/**
		 * @private
		 */
		public function set price(value:Number):void
		{
			_price = value;
			
			dispatchEvent(new Event("price"));
		}

		/**
		 * 礼物图标地址
		 */
		public function get icon():String
		{
			return _icon;
		}

		/**
		 * @private
		 */
		public function set icon(value:String):void
		{
			_icon = value;
			
			dispatchEvent(new Event("icon"));
		}

		/**
		 * 礼物名称
		 */
		public function get name():String
		{
			return _name;
		}

		/**
		 * @private
		 */
		public function set name(value:String):void
		{
			_name = value;
			
			dispatchEvent(new Event("name"));
		}

		
		/**
		 * 界面是否显示
		 */
		public function get visible():Boolean
		{
			return _visible;
		}
		
		/**
		 * @private
		 */
		public function set visible(value:Boolean):void
		{
			_visible = value;
			
			dispatchEvent(new Event("visible"));
		}
		
	}
}