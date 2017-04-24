package com.bit101.utils
{
	import flashx.textLayout.elements.SpanElement;
	
	public class MessageSpanElement extends SpanElement
	{
		public function MessageSpanElement()
		{
			super();
		}
		
		private var _data:Object;

		/**
		 * 相关联的数据对象 
		 */
		public function get data():Object
		{
			return _data;
		}

		/**
		 * @private
		 */
		public function set data(value:Object):void
		{
			_data = value;
		}

	}
}