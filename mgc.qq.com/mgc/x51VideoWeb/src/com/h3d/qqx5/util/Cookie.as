package com.h3d.qqx5.util
{
	import com.h3d.qqx5.common.Globals;
	
	import flash.net.SharedObject;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	public class Cookie
	{
		private var so:SharedObject;
		private var _name:String
		
		public function Cookie(file_name:String)
		{
			// constructor code
			so = SharedObject.getLocal(file_name,"/");
			_name=file_name
		}
		
		public function flushData(key:String,value:Object):void
		{
			//添加数据
			if (so.data.cookie == null)
			{
				var obj:Object = {};
				obj[key] = value;
				so.data.cookie = obj;
			}
			else
			{
				so.data.cookie[key] = value;

			}
//			Globals.s_logger.debug("Cookie flushData,Key:" + key+ ",Value:" +so.data.cookie[key]);
			flush();
		}
		
		public function deleteData(key:String):void
		{
			//删除数据值
			if (judge(key))
			{
				delete so.data.cookie[key];
				flush();
			}
		}
		
		public function getName():String
		{
			//获取数据名
			return _name
		}
		
		public function getData(key:String):*
		{
			//获取数据值
			if (judge(key))
			{
				return so.data.cookie[key];
			}
			else
			{
				return null;
			}
		}

		public function clearData(removeflags:Array):void {
			//清除缓存
			//so.clear(); 
			if (removeflags == null || removeflags.length == 0) {
				Globals.s_logger.debug("clear cookie! - all");
				CookieLog.addCookieChangeLog("clear cookie! - all");
				so.data.cookie = null;
			} else {
				Globals.s_logger.debug("clear cookie! - " + removeflags);
				CookieLog.addCookieChangeLog("clear cookie! - " + removeflags);
				var cookieKeyList:Array = [];
				for (var key:String in so.data.cookie) {
					cookieKeyList.push(key);
				}
				for each (var removeFlag:String in removeflags) {
					for each (var cookieKey:String in cookieKeyList) {
						if (cookieKey.indexOf(removeFlag) == 0) {
							Globals.s_logger.debug("clear cookie  key = " + cookieKey + "  value = " + so.data.cookie[cookieKey]);
							delete so.data.cookie[cookieKey];
						}
//						if (cookieKey.lastIndexOf(removeFlag) != -1) {
//							if (cookieKey.lastIndexOf(removeFlag) == cookieKey.length - removeFlag.length) {
//								Globals.s_logger.debug("clear cookie  key = " + cookieKey + "  value = " + so.data.cookie[cookieKey]);
//								delete so.data.cookie[cookieKey];
//							}
//						}
					}
				}
			}
			flush();
		}
		
		public function clearQQData(qq:Number):void
		{
			var cookieKeyList:Array = [];
			for (var key:String in so.data.cookie) {
				cookieKeyList.push(key);
			}
			for each (var cookieKey:String in cookieKeyList) {
				if (cookieKey.lastIndexOf(qq.toString()) != -1) {
					Globals.s_logger.debug("clear cookie  key = " + cookieKey + "  value = " + so.data.cookie[cookieKey]);
					delete so.data.cookie[cookieKey];
				}
			}
			flush();
		}
		
		public function judge(key:String):Boolean
		{
			//判断数据是否存在
			return so.data.cookie != undefined && so.data.cookie[key] != undefined
			
		}
		
		public function print():void
		{
			for( var s:String in so.data.cookie)
			{
//				Globals.s_logger.debug("print()  key = " + s + "  value = " +so.data.cookie[s]);
			}
		}
		
		private function flush():void
		{
			//写入
			if (so)
			{
				try
				{
					so.flush();
				}
				catch (e:Error)
				{
					Security.showSettings();
					Security.showSettings( SecurityPanel.LOCAL_STORAGE );
				}
			}
		}

	}

}