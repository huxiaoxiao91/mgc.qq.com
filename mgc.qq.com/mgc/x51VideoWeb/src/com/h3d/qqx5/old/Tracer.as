package com.h3d.qqx5.old
{
	import com.carlcalderon.arthropod.Debug;
	
	public class Tracer
	{
		public static const ERROR:uint = 1;
		public static const WARNNING:uint = 2;
		public static const INFO:uint = 3;
		
		public static var logAble:Boolean = true;
		public static var callb:Function = null;
		public static var priority:int = INFO;
		
		public function Tracer() {
			//callb = 
		}
		
		public static function setLogFunction(param1:Function) : void {
			callb = param1;
			
			// 输出到 console.log
			// 输出到trace
			// 输出到工具
		}
		
		public static function log(msg:String): void {
			if (logAble && priority >= INFO) {
				Debug.log(msg);
			}
			trace(msg);
		}
		
		public static function warning(msg:String):void {
			if (logAble && priority >= WARNNING) {
				Debug.warning(msg);
			}
			trace(msg);
		}
		
		public static function error(msg:String):void {
			if (logAble && priority >= ERROR) {
				Debug.error(msg);
			}
			trace(msg);
		}
	}
}