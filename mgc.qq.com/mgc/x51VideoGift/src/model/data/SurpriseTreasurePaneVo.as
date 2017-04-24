package model.data
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class SurpriseTreasurePaneVo extends EventDispatcher
	{
		private var _visible:Boolean = false;
		
		private var _active:Boolean = false;
		private var _activity_id:uint;
		private var _percent:int = -1;
		private var _left_open_box_times:uint;
		private var _cd_seconds:int = -1;
		private var _need_flower_count:uint;
		private var timer:Timer;
		private var _isOpen:Boolean = false;
		private var _total_cd_seconds:uint = 0;
		private var _updateTime:Number = 0;
		
		public function SurpriseTreasurePaneVo()
		{
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			//免费礼物数量为20时不倒计时
			if(_cd_seconds && _cd_seconds > 0)
			{
				_cd_seconds--;
			}
			else
			{
				_cd_seconds  = 0;
				timer.stop();
				checkIsOpen();
			}
			
			dispatchEvent(new Event("upadteCDSeconds"));
		}
		
		private function checkIsOpen():void
		{
			if(cd_seconds == 0 && active && percent == 100)
			{
				isOpen = true;
			}
			else
			{
				isOpen = false;
			}
		}

		public function get visible():Boolean
		{
			return _visible;
		}

		public function set visible(value:Boolean):void
		{
			_visible = value;
			
			dispatchEvent(new Event("visible"));
		}

		/**
		 *当前送的百分比 
		 */
		public function get percent():int
		{
			return _percent;
		}

		/**
		 * @private
		 */
		public function set percent(value:int):void
		{
			if(_percent == value)
				return;
			_percent = value;
			checkIsOpen();
			dispatchEvent(new Event("upadtePercent"));
		}

		/**
		 * 剩余宝箱的打开时间
		 */
		public function get left_open_box_times():uint
		{
			return _left_open_box_times;
		}

		/**
		 * @private
		 */
		public function set left_open_box_times(value:uint):void
		{
			if(_left_open_box_times == value)
				return;
			_left_open_box_times = value;
			dispatchEvent(new Event("upadteOpenBoxTimes"));
		}

		/**
		 * cd时间 
		 */
		public function get cd_seconds():int
		{
			return _cd_seconds;
		}

		/**
		 * @private
		 */
		public function set cd_seconds(value:int):void
		{
			if(value < 0)
				value = 0;
			
			if(_cd_seconds == value)
				return;
			
			_cd_seconds = value;
			checkIsOpen();
			dispatchEvent(new Event("upadteCDSeconds"));
			if(timer.running)
			{
				timer.reset();
				timer.start();
			}
			else
			{
				timer.start();
			}
		}

		/**
		 * 需要的免费花数量
		 */
		public function get need_flower_count():uint
		{
			return _need_flower_count;
		}

		/**
		 * @private
		 */
		public function set need_flower_count(value:uint):void
		{
			if(_need_flower_count == value)
				return;
			_need_flower_count = value;
			dispatchEvent(new Event("upadteFlowerCount"));
		}

		public function get active():Boolean
		{
			return _active;
		}

		public function set active(value:Boolean):void
		{
			if(_active == value)
				return;
			
			_active = value;
			dispatchEvent(new Event("upadteActiv"));
		}

		public function get activity_id():uint
		{
			return _activity_id;
		}

		public function set activity_id(value:uint):void
		{
			_activity_id = value;
		}

		public function get isOpen():Boolean
		{
			return _isOpen;
		}

		public function set isOpen(value:Boolean):void
		{
			if(_isOpen == value)
				return;
			_isOpen = value;
			dispatchEvent(new Event("isOpen"));
		}

		public function get total_cd_seconds():uint
		{
			return _total_cd_seconds;
		}

		public function set total_cd_seconds(value:uint):void
		{
			_total_cd_seconds = value;
		}

		public function get updateTime():Number
		{
			return _updateTime;
		}

		public function set updateTime(value:Number):void
		{
			_updateTime = value;
		}


	}
}