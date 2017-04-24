package com.h3d.qqx5.util
{
	import flash.utils.ByteArray;

	/**
	 * @author liuchui
	 */
	public class StringCodeConverter
	{
		public function StringCodeConverter()
		{
			
		}
		
		public static function encodeGB18030(str:String):String
		{
			var result:String ="";
			var byte:ByteArray = new ByteArray();
			byte.writeMultiByte(str,"gb18030"); 
			for(var i:int; i < byte.length; i++)
			{
				result += String.fromCharCode(byte[i]);
			}
			return result;
		}
		
		public static function decodeGB18030(str:String):String
		{
			var result:String = "";   
			var byte:ByteArray = new ByteArray();
			for(var i:int; i < str.length; i++)
			{
				byte[i] = str.charCodeAt(i);
			}
			result = byte.readMultiByte(byte.length, "gb18030");
			return result;
		}
		
		public static function encodeUTF8(str:String):String
		{
			var result:String ="";
			var byte:ByteArray = new ByteArray();
			byte.writeUTFBytes(str);
			for(var i:int; i < byte.length; i++)
			{
				result += String.fromCharCode(byte[i]);
			}
			return result;
		}
		
		public static function decodeUTF8(str:String):String
		{
			var result:String = "";   
			var byte:ByteArray = new ByteArray();
			for(var i:int; i < str.length; i++)
			{
				byte[i] = str.charCodeAt(i);
			}
			result = byte.readUTFBytes(byte.length);
			return result;
		}
	}	
}