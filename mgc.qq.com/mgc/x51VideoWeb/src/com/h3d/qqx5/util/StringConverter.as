package com.h3d.qqx5.util
{
	import flash.utils.ByteArray;
	public class StringConverter
	{
		public function StringConverter()
		{
		}
		
		public static function convertStringToByteArray(string:String):ByteArray
		{
			var bytes:ByteArray;
			if ( string) {
				bytes = new ByteArray();
				bytes.writeUTFBytes(string);// writeUTFBytes(value:String) 将 UTF-8 字符串写入字节流;
			}
			return bytes;
		}
		
		public static function convertByteArrayToString(bytes:ByteArray):String
		{
			var str:String;
			if ( bytes ) {
				bytes.position = 0; // 在将 ByteArray 转换成 String中应注意将 bytes 的 position 设置为 0，切记；
				str = bytes.readUTFBytes(bytes.length); // readUTFBytes(length:uint):从字节流中读取一个由 length 参数指定的 UTF-8 字节序列，并返回一个字符串;
			}
			return str;
		}
	}
}