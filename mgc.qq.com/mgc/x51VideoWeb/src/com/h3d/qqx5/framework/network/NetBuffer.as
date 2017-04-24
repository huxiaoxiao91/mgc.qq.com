package com.h3d.qqx5.framework.network
{
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.util.NumberUtil;
	import com.h3d.qqx5.util.StringCodeConverter;
	
	import flash.errors.IOError;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * @author Administrator
	 */
	public class NetBuffer
	{		
		public function NetBuffer()
		{
			_buffer = new ByteArray();
			_buffer.endian = Endian.LITTLE_ENDIAN;
		}
		
		public function putBytes(val : ByteArray) :void
		{
			putInt(val.length);
			_buffer.writeBytes(val);
		}
		//写入指定长度
		public function writeSpecBytes(val : ByteArray,offset:int, length : int) :void
		{
//			putInt(length);
			_buffer.writeBytes(val,offset,length);
		}
		//读出指定长度
		public function readSpecBytes(res:ByteArray,offset:int, length : int) : ByteArray
		{
//			var res:ByteArray = new ByteArray;
//			var iLen : int = getSpecInt(offset);
//			if(length != iLen)
//				return res;
			if(length > 0)
			{
				_buffer.readBytes(res, offset, length);
			}
			return _buffer;
		}
		
		public function getBytes() : ByteArray
		{
			var length : int = getInt();
			var res:ByteArray = new ByteArray;
			if(length > 0)
			{
				_buffer.readBytes(res, 0, length);
			}
			return res;
		}
		
		public function putBoolean(val : Boolean) : void
		{
			_buffer.writeByte(val ? 1: 0);
		}
		
		public function getBoolean() : Boolean
		{
			return _buffer.readByte() != 0 ? true : false;
		}
		
		public function putDouble(val:Number):void
		{
			_buffer.writeDouble(val);
		}
		
		public function getDouble():Number
		{
			return _buffer.readDouble();
		}
		
		public function putShort(val:int):void
		{
			_buffer.writeShort(val & 0xFFFF);
		}
		
		public function getShort() : int
		{
			return _buffer.readShort() & 0xFFFF;
		}
		
		public function putInt(val : int): void
		{
			_buffer.writeInt(val);
		}
		
		public function getInt() : int
		{
			return _buffer.readInt();
		}
//		public function getSpecInt(offset:int) : int
//		{
//			_buffer.position = offset;
//			return _buffer.readInt();
//		}
		
		public function putLong(value : Int64):void
		{
			putLong2(value.low, value.high);
		}		
		
		public function putLong2(low : uint, high:int):void
		{
			_buffer.writeUnsignedInt(low);
			_buffer.writeInt(high);
		}
		
		public function getLong() : Int64
		{
			var low:uint = _buffer.readUnsignedInt();
			var high:int = _buffer.readInt();
			return new Int64(low, high);
		}
		
		public function putByte(val : int) : void
		{
			_buffer.writeByte(val & 0xFF);
		}
		
		public function getByte() : int
		{
			return _buffer.readByte() & 0xFF;
		}
		
		public function putFloat(val : Number) : void
		{
			_buffer.writeFloat(val);
		}
		
		public function getFloat() : Number
		{
			return _buffer.readFloat();
		}
		
		public function putNetBuffer(val : NetBuffer) : void
		{
			putBytes(val.buffer());
		}
		
		public function getNetBuffer() : NetBuffer
		{
			var res : NetBuffer = new NetBuffer;
			res._buffer = getBytes();
			res._buffer.endian = Endian.LITTLE_ENDIAN;
			return res;
		}
		
		public function putString(val : String) : void
		{
			var str:String = StringCodeConverter.encodeGB18030(val);
			putInt(str.length);
			for(var i:int; i < str.length; i++)
			{
				putByte(str.charCodeAt(i));
			}
			putByte(0);
		}
		
		public function getString(): String
		{
			var len:int = getInt();
			var res:String = new String;
			for(var i : int = 0; i < len; ++i)
			{
				res += String.fromCharCode(getByte());
			}
			getByte();
			
			return StringCodeConverter.decodeGB18030(res);
		}
		
		public function buffer() : ByteArray
		{
			return _buffer;
		}
		
		public function length() : uint
		{
			return _buffer.length;
		}
		
		public function remaining() : uint
		{
			return _buffer.bytesAvailable
		}
		
		public function resetPosition() : void
		{
			_buffer.position = 0;	
		}
		
		public function skip(n:int) : void
		{
			if( n > _buffer.bytesAvailable)
			{
				throw new IOError("stream out of range in Skip(" + n + ")");
			}
			_buffer.position += n;
		}
		
		private var _buffer:ByteArray;
	}
}