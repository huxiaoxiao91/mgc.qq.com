package com.bit101.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import org.bytearray.gif.events.FileTypeEvent;
	import org.bytearray.gif.events.GIFPlayerEvent;
	import org.bytearray.gif.events.TimeoutEvent;
	import org.bytearray.gif.player.GIFPlayer;

	public class SingleLoader
	{
		public function SingleLoader()
		{
			if (instance) {  
				throw new Error("只能用getInstance()来获取实例");  
			}
		}
		
		private static var instance:SingleLoader;  /* 单例类实例 */
		
		public static function getInstance():SingleLoader
		{
			if (!instance) 
				instance = new SingleLoader();
			
			return instance;
		}
		
		private var loaderData:Object = {};
		private var loaderArray:Array = [];
		private var tryAgainCount:uint = 0;
		
		public var tryAgainMax:uint = 3;
		
		public var isRun:Boolean = false;
		
		public function add(url:String, props:Object=null,complete:Function = null):void
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
				loaderImage(url,props,complete,0);
			}
		}
		
		private function loaderImage(url:String, props:Object=null,complete:Function = null,count:uint = 0):void
		{
			var myGIFPlayer:GIFPlayerData = new GIFPlayerData();
			myGIFPlayer.data = {"url":url,"data":props,"complete":complete};
			myGIFPlayer.tryAgainCount = count;
			myGIFPlayer.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			myGIFPlayer.addEventListener(GIFPlayerEvent.COMPLETE, onCompleteGIFLoad);
			myGIFPlayer.addEventListener(FileTypeEvent.INVALID, onInvalidFileLoaded);
			myGIFPlayer.addEventListener(TimeoutEvent.TIME_OUT, onTimeoutError);
			myGIFPlayer.load(new URLRequest(url));
		}
		
		
		private function onIOError ( pEvt:IOErrorEvent ):void
		{
			var myGIFPlayer:GIFPlayerData = pEvt.currentTarget as GIFPlayerData;
			removeEventListenerAll(myGIFPlayer);
			errorFunction(myGIFPlayer);
		}
		
		
		private function onCompleteGIFLoad ( pEvt:GIFPlayerEvent ):void
		{
			var myGIFPlayer:GIFPlayerData = pEvt.currentTarget as GIFPlayerData;
			removeEventListenerAll(myGIFPlayer);
			
			var obj:Object = myGIFPlayer.data;
			obj.gifPlayer = myGIFPlayer;
			
			loaderData[obj.url] = obj;
			
			if(obj.complete != null)
			{
				obj.complete(obj.data);
			}
		}
		
		
		private function removeEventListenerAll(myGIFPlayer:GIFPlayerData):void
		{
			if(myGIFPlayer)
			{
				myGIFPlayer.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
				myGIFPlayer.removeEventListener( GIFPlayerEvent.COMPLETE, onCompleteGIFLoad );
				myGIFPlayer.removeEventListener( FileTypeEvent.INVALID, onInvalidFileLoaded );
				myGIFPlayer.removeEventListener( TimeoutEvent.TIME_OUT, onTimeoutError );
			}
		}
		
		private function onInvalidFileLoaded ( pEvt:FileTypeEvent ):void
		{
			var myGIFPlayer:GIFPlayerData = pEvt.currentTarget as GIFPlayerData;
			removeEventListenerAll(myGIFPlayer);
			errorFunction(myGIFPlayer);
		}
		
		private function onTimeoutError ( pEvt:TimeoutEvent ):void
		{
			var myGIFPlayer:GIFPlayerData = pEvt.currentTarget as GIFPlayerData;
			removeEventListenerAll(myGIFPlayer);
			errorFunction(myGIFPlayer);
		}
		
		public function hasItem(url:String):Boolean
		{
			var obj:Object;
			if(loaderData.hasOwnProperty(url))
			{
				obj = loaderData[url];
				
				if(obj.hasOwnProperty("gifPlayer") && obj.gifPlayer != null)
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function getBitmap(url:String):GIFPlayer
		{
			if(hasItem(url))
			{
				return loaderData[url].gifPlayer;
			}
			
			return null;
		}
		
		private function errorFunction(myGIFPlayer:GIFPlayerData):void
		{
			myGIFPlayer.tryAgainCount +=1;
			
			if(myGIFPlayer.tryAgainCount < tryAgainMax)
			{
				loaderImage(myGIFPlayer.data.url,myGIFPlayer.data.data,myGIFPlayer.data.complete,myGIFPlayer.tryAgainCount);
			}
			
			myGIFPlayer = null;
		}
	}
}