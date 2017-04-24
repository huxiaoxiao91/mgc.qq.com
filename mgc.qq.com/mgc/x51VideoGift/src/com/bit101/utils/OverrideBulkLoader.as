package com.bit101.utils
{
	import flash.display.Bitmap;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	public class OverrideBulkLoader extends  EventDispatcher
	{
		public function OverrideBulkLoader()
		{
			if (instance) {  
				throw new Error("只能用getInstance()来获取实例");  
			}
		}
		
		private static var instance:OverrideBulkLoader;  /* 单例类实例 */
		
		private var errorCallBack:Function;
		
		public static function getInstance():OverrideBulkLoader
		{
			if (!instance) 
				instance = new OverrideBulkLoader();
			
			return instance;
		}
		
		private var loaderData:Object = {};
		
		public var tryAgainMax:uint = 3;
		
		public function hasItem(url:String):Boolean
		{
			var obj:Object;
			if(loaderData.hasOwnProperty(url))
			{
				obj = loaderData[url];
				
				if(obj.hasOwnProperty("loader") && obj.loader != null)
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function add(url:String, props:Object=null,complete:Function = null,error:Function = null):void
		{
			var obj:Object;
			if(loaderData.hasOwnProperty(url))
			{
				obj = loaderData[url];
				
				if(complete != null)
				{
					complete(props);
				}
			}
			else
			{
				load(url,props,complete,0,error);
			}
		}
		
		private function load(url:String, props:Object=null,complete:Function = null,count:uint = 0,error:Function = null):void
		{
			var loader:LoaderData = new LoaderData();
			loader.data = {"url":url,"data":props,"complete":complete,"error":error};
			loader.tryAgainCount = count;
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteLoad);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressLoad);
			loader.load(new URLRequest(url));
		}
		private function onIOError ( e:IOErrorEvent ):void
		{
			var loader:LoaderData = (e.currentTarget as LoaderInfo).loader as LoaderData;
			removeEventListenerAll(loader);
			//errorFunction(loader);
			if(loader.data.error != null)
			{
				loader.data.error();
			}
		}
		
		
		private function onCompleteLoad ( e:Event ):void
		{
			var loader:LoaderData = (e.currentTarget as LoaderInfo).loader as LoaderData;
			removeEventListenerAll(loader);
			
			var obj:Object = loader.data;
			obj.loader = loader;
			
			loaderData[obj.url] = obj;
			
			if(obj.complete != null)
			{
				obj.complete(obj.data);
				
				//优化：清除对外部对象的引用。
				obj.complete = null;
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onProgressLoad(e:ProgressEvent):void
		{
			
		}
		
		private function removeEventListenerAll(loader:LoaderData):void
		{
			if(loader)
			{
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteLoad);
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressLoad);
			}
		}
		
		private function errorFunction(loader:LoaderData):void
		{
			loader.tryAgainCount +=1;
			
			if(loader.tryAgainCount < tryAgainMax)
			{
				load(loader.data.url,loader.data.data,loader.data.complete,loader.tryAgainCount);
			}
			
			//弃用的loader清除管理数据。
			loader.data = null;
			loader.unloadAndStop(true);
			loader = null;
		}
		
		public function getMovieClip(url:String):MovieClip
		{
			if(hasItem(url))
			{
				return (loaderData[url].loader as LoaderData).content as MovieClip;
			}
			
			return null;
		}
		
		public function getBitmap(url:String):Bitmap
		{
			if(hasItem(url))
			{
				return (loaderData[url].loader as LoaderData).content as Bitmap;
			}
			
			return null;
		}
	}
}