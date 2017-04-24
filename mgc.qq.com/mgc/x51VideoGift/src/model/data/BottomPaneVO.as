package model.data
{	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * 
	 * 操作界面数据模型
	 */
	public class BottomPaneVO extends EventDispatcher
	{
		private var _money:int;
		
		private var _videomoney:int;
		
		private var _num:int = 1;
		
		private var _tempObj:Object = {};
		
		/**
		 * 送礼花费  炫豆
		 */
		public var cost:Number = 0;
		
		private var _giftEnabled:Boolean = true;
		
		private var _isNumberFrame:Boolean = false;
		
		private var _isConcert:Boolean = false;
		
		public function BottomPaneVO()
		{
			
		}
		
		/**
		 * 是否是演唱会
		 */
		public function get isConcert():Boolean
		{
			return _isConcert;
		}

		/**
		 * @private
		 */
		public function set isConcert(value:Boolean):void
		{
			_isConcert = value;
			
			dispatchEvent(new Event("isConcert"));
		}

		/**
		 * 是否在数量选择框内
		 */
		public function get isNumberFrame():Boolean
		{
			return _isNumberFrame;
		}

		/**
		 * @private
		 */
		public function set isNumberFrame(value:Boolean):void
		{
			_isNumberFrame = value;
		}

		public function get tempObj():Object
		{
			return _tempObj;
		}

		public function set tempObj(value:Object):void
		{
			_tempObj = value;
		}

		/**
		 * 送礼按钮是否处于活动状态
		 */
		public function get giftEnabled():Boolean
		{
			return _giftEnabled;
		}

		/**
		 * @private
		 */
		public function set giftEnabled(value:Boolean):void
		{
			_giftEnabled = value;
			
			dispatchEvent(new Event("giftEnabled"));
		}

		/**
		 * 要赠送的礼物数量
		 */
		public function get num():int
		{
			return _num;
		}

		/**
		 * @private
		 */
		public function set num(value:int):void
		{
			_num = value;
			
			dispatchEvent(new Event("num"));
		}

		/**
		 * 炫豆余额
		 */
		public function get money():int
		{
			return _money;
		}

		/**
		 * @private
		 */
		public function set money(value:int):void
		{
			_money = value;
			
			dispatchEvent(new Event("money"));
		}
		
		/**
		 * 梦幻币余额
		 */
		public function get videomoney():int
		{
			return _videomoney;
		}
		
		private var _numSelected:Boolean = false;
		
		public function get numSelected():Boolean
		{
			return _numSelected;
		}
		
		public function set numSelected(value:Boolean):void
		{
			_numSelected = value;
			//Cc.log("调用改变按钮1" + _numSelected);
			dispatchEvent(new Event("numSelected"));
		}
		
		/**
		 * @private
		 */
		public function set videomoney(value:int):void
		{
			_videomoney = value;
			
			dispatchEvent(new Event("videomoney"));
		}

	}
}