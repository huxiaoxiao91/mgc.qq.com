package com.bit101.utils
{
	import org.bytearray.gif.player.GIFPlayer;
	
	public class GIFPlayerData extends GIFPlayer
	{
		public function GIFPlayerData(pAutoPlay:Boolean=true)
		{
			super(pAutoPlay);
		}
		
		private var _data:Object;

		public function get tryAgainCount():uint
		{
			return _tryAgainCount;
		}

		public function set tryAgainCount(value:uint):void
		{
			_tryAgainCount = value;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}
		
		private var _tryAgainCount:uint = 0;

	}
}