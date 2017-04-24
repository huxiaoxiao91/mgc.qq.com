package model.data
{	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * 
	 * 礼物数量选择框数据模型
	 */
	public class NumberPaneVO extends EventDispatcher
	{
		/**
		 * 选中的数量
		 */
		public var selectCount:int;
		
		private var _numList:Array;
		
		private var _visible:Boolean = false;
		
		private var _maxGiftNumber:Number = 1;
		
		public function NumberPaneVO()
		{
			
		}


		/**
		 *  送礼的最大数量
		 */
		public function get maxGiftNumber():Number
		{
			return _maxGiftNumber;
		}

		/**
		 * @private
		 */
		public function set maxGiftNumber(value:Number):void
		{
			_maxGiftNumber = value;
		}

		/**
		 * 数量列表
		 */
		public function get numList():Array
		{
			return _numList;
		}

		/**
		 * @private
		 */
		public function set numList(value:Array):void
		{
			_numList = value;
			
			dispatchEvent(new Event("numList"));
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