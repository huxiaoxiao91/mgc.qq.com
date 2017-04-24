package com.bit101.utils
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public class LoaderData extends Loader
	{
		public function LoaderData()
		{
			super();
		}
		
		private var _data:Object;
		
		private var _url:String;
		
		private var _tryAgainCount:uint = 0;
		
		/**
		 * 
		 * @return 重试次数
		 * 
		 */		
		public function get tryAgainCount():uint
		{
			return _tryAgainCount;
		}

		public function set tryAgainCount(value:uint):void
		{
			_tryAgainCount = value;
		}

		/**
		 * 
		 * @return 相关数据
		 * 
		 */		
		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

		/**
		 * 
		 * @return 加载的url路径
		 * 
		 */		
		public function get url():String
		{
			return _url;
		}
		
		override public function load(request:URLRequest, context:LoaderContext=null):void
		{
			_url = request.url;
			super.load(request,context);
		}
	}
}