package com.h3d.qqx5.framework.network
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.util.Byte2Hex;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.util.NumberUtil;
	
	import flash.errors.IOError;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 序列化对象
	 * @author Administrator
	 */
	public class ProtoBufSerializer
	{
		public function ProtoBufSerializer()
		{
			
		}
		
		private static const LengthDelimited : int = 0;
		private static const VarInt : int = 1;
		private static const Data32 : int = 2;
		private static const Data64 : int = 3;
		private static const SecurityFlag:int = 0xacabdeaf;
		
		public static function FromStream(obj:INetMessage, from:NetBuffer) : void
		{
			var security_flag:int = from.getInt();
			if (security_flag != SecurityFlag)
			{
				throw new IOError("security error");
			}
			
			var checksum:int = from.getInt();
			
			var buff:NetBuffer = from.getNetBuffer();
			//var c:int = QuickCRC32.GetCRC32Sec(buff.buffer(), 0, buff.length());
			/*
			if (checksum != c)
			{
				Globals.s_logger.debug("checksum error" +from.buffer().position);

				Globals.s_logger.debug("checksum error" +"checksum."+ checksum +" c: "+ c);
				Decrypt(12345678, buff.buffer(), buff.length());
				LoadStream(obj, buff);
				
				Globals.s_logger.debug("checksum error id: " +obj.CLSID());
				
				throw new IOError("checksum error" +"checksum."+ checksum +" c: "+ c);
			}
			*/
			//else
//			{
				Decrypt(12345678, buff.buffer(), buff.length());
				LoadStream(obj, buff);
//			}
		}

		
		public static function ToStream(obj:INetMessage, out:NetBuffer) : void
		{
			var buff:NetBuffer = new NetBuffer;
			SaveStream(obj, buff);
			
			Encrypt(12345678, buff.buffer(), buff.length());
			
			var checksum:int =  0;//QuickCRC32.GetCRC32Sec(buff.buffer(), 0, buff.length());
			out.putInt(SecurityFlag);
			out.putInt(checksum);
			out.putNetBuffer(buff);
		}
		
		public static function Encrypt(key : int, bytes : ByteArray, length : int) : void
		{
			for(var offset : int = 0; offset < length; offset += 4)
			{
				bytes[offset + 0] ^= (int) (key);
				bytes[offset + 1] ^= (int) (key >> 8);
				bytes[offset + 2] ^= (int) (key >> 16);
				bytes[offset + 3] ^= (int) (key >> 24);
				
				key = QuickCRC32.GetCRC32Sec(bytes, offset, 4);
			}
		}
		
		public static function Decrypt(key : int, bytes : ByteArray, length : int) : void
		{
			for(var offset : int = 0; offset < length; offset += 4)
			{
				var newkey : int = QuickCRC32.GetCRC32Sec(bytes, offset, 4);
				bytes[offset + 0] ^= (int) (key);
				bytes[offset + 1] ^= (int) (key >> 8);
				bytes[offset + 2] ^= (int) (key >> 16);
				bytes[offset + 3] ^= (int) (key >> 24);
				
				key = newkey;
			}
		}
		
		private static function make_field_desc(fsindex : int, wire_type : int) : int
		{
			var desc:int = ((fsindex << 3) | wire_type);
			return desc;
		}
		
		private static function parse_field_index(desc : int) : int
		{
			return desc >> 3;
		}
		
		private static function parse_wire_type(desc : int) : int
		{
			return desc & 0x0007;
		}
		
		private static function save_field_desc(fsindex:int, wire_type:int, to:NetBuffer) : void
		{
			if (fsindex != -1)
			{
				var desc:int = make_field_desc(fsindex, wire_type);
				to.putShort(desc);
			}
		}			
		
		public static function SaveStream(msg:INetMessage, to:NetBuffer) : void
		{
			save_protobuf_compound(-1, msg, to);
		}
		
		public static function LoadStream(msg:INetMessage, from:NetBuffer) : void
		{
//			var byteArray:ByteArray = new ByteArray();
//			byteArray.writeObject(from.buffer());
//			byteArray.position = 0;
//			Byte2Hex.Trace(byteArray);
			
//			Globals.s_logger.debug("LoadStream() " + JSON.stringify(msg));
			Globals.s_logger.debug("LoadStream() SLSID:" + msg.CLSID());
			load_protobuf_compound(msg, from);
		}

		private static function save_protobuf_lenth_delimited(fsindex:int, buff:NetBuffer, to:NetBuffer) : void
	    {
	        save_field_desc(fsindex, LengthDelimited, to);
	        to.putNetBuffer(buff);
	    }

	    private static function load_protobuf_lenth_delimited(from:NetBuffer) : NetBuffer
	    {
	        return from.getNetBuffer();
	    }

	    private static function save_protobuf_string(fsindex:int, val:String, to:NetBuffer) : void
	    {
	        var buff:NetBuffer = new NetBuffer;
	        buff.putString(val);
	        save_protobuf_lenth_delimited(fsindex, buff, to);
	    }

		private static function load_protobuf_string(from:NetBuffer, wire_type:int) : String
	    {
	        if (wire_type == LengthDelimited)
	        {
	            var val:String = "";
	            var tempins:NetBuffer = load_protobuf_lenth_delimited(from);

	            val = tempins.getString();
	            return val;
	        }
	        return null;
	    }

	    private static function save_protobuf_array(fsindex:int, val:ByteArray, to:NetBuffer) : void
	    {
			var buff:NetBuffer  = new NetBuffer;
			buff.putBytes(val);
	        save_protobuf_lenth_delimited(fsindex, buff, to);
	    }

	    private static function load_protobuf_array(from:NetBuffer, wire_type:int) : ByteArray
	    {
	        if (wire_type == LengthDelimited)
	        {
	            var tempins:NetBuffer = load_protobuf_lenth_delimited(from);
	            return tempins.getBytes();
	        }
	        return null;
	    }

	    private static function save_protobuf_int32(fsindex:int, val:int, to:NetBuffer, wire_type:int) : void
	    {
	        if (wire_type == VarInt)
	        {
	            save_field_desc(fsindex, VarInt, to);
	            to_var_int(val, to);
	        }
//	        else
//	        {
//	            save_field_desc(fsindex, Data32, to);
//	            to.putInt(val);
//	        }
	    }

	 	private static function load_protobuf_int32(from:NetBuffer, wire_type:int) : int
	    {
	        if (wire_type == VarInt)
	        {
	            var v:Number = from_var_int(from);
	            return v;
	        }
//	        else if (wire_type == Data32)
//	        {
//	            return from.getInt();
//	        }
	        return 0;
	    }
		

	    private static function save_protobuf_int64(fsindex:int, val:Int64, to:NetBuffer, wire_type:int) : void
	    {
	        if (wire_type == VarInt)
	        {
	            save_field_desc(fsindex, VarInt, to);
	            int64_to_var_int(val, to);
	        }
//	        else
//	        {
//	            save_field_desc(fsindex, Data64, to);
//	            to.putLong(val);
//	        }
	    }

	    private static function load_protobuf_int64(from:NetBuffer, wire_type:int) : Int64
	    {
	        if (wire_type == VarInt)
	        {
	            return int64_from_var_int(from);
	        }
//	        else if (wire_type == Data64)
//	        {
//	            return from.getLong();
//	        }
	        return Int64.fromNumber(0);
	    }

	    private static function save_protobuf_float32(fsindex:int, val:Number, to:NetBuffer) : void
	    {
	        save_field_desc(fsindex, Data32, to);
	        to.putFloat(val);
	    }

		private static function load_protobuf_float32(from:NetBuffer, wire_type:int) : Number
	    {
	        if (wire_type == Data32)
	        {
	            return from.getFloat();
	        }
	        return 0;
	    }

	    private static function save_protobuf_float64(fsindex:int, val:Number, to:NetBuffer) : void
	    {
	        save_field_desc(fsindex, Data64, to);
	        to.putDouble(val);
	    }

		private static function load_protobuf_float64(from:NetBuffer, wire_type:int) : Number
	    {
	        if (wire_type == Data64)
	        {
	            return from.getDouble();
	        }
	        return 0;
	    }

	    private static function save_protobuf_compound(fsindex:int, obj:ProtoBufSerializable, to:NetBuffer) : void
	    {
	        var buff:NetBuffer = new NetBuffer;
	        encode_compound_to_stream(obj, buff);
	        save_protobuf_lenth_delimited(fsindex, buff, to);
	    }
		
		public static function load_protobuf_compound(obj:ProtoBufSerializable, from:NetBuffer) : void
	    {
	        var tempin:NetBuffer = load_protobuf_lenth_delimited(from);
	        decode_compound_from_stream(obj, tempin,obj.isPureContainChar() );
	    }

	    private static function encode_compound_to_stream(obj:ProtoBufSerializable, to:NetBuffer) : void
	    {
	        var Descriptors:Vector.<Descriptor> = obj.getDescriptors();
			for(var i : int = 0; i < Descriptors.length; ++i)
	        {
				var f:Descriptor = Descriptors[i];
	            var val:* = obj[f.fieldName];
	            if(val == null)
				{
					if(f.className == getQualifiedClassName(Int64))
					{
						val = Int64.fromNumber(0);
					}
					else
					{
						throw new IOError("filed not set:"+f.fieldName);
					}
				}
				if(f.condition != null && !f.condition(obj))
				{
					Globals.s_logger.info("field not have to save:" + f.fieldName);
				}
				else
				{
					encode_item_to_stream(f, val, to);	
				}
	        }
	    }

		private static function decode_compound_from_stream(obj:ProtoBufSerializable, from:NetBuffer,isPureContainChar:Boolean) : void
	    {
			var temp:int = 0;
			var remain_cnt:int = isPureContainChar ? 1:2;
			while(from.remaining() >= remain_cnt)//
			{
				var pureContainerWrapper:Boolean = obj.isPureContainerWrapper();
				var f:Descriptor = null;
				var wire_type:int = 0;
				var index:int = 0;
				if(pureContainerWrapper)
				{
					f = obj.getDescriptorByIndex(temp);
				}
				else
				{
					var field_desc:int = from.getShort();
					index = parse_field_index(field_desc);
					wire_type = parse_wire_type(field_desc);
					f = obj.getDescriptorByFieldNumber(index);
				}
				for(var ii:String in f)
				{
//					Globals.s_logger.debug("decode_compound_from_stream f["+ ii +"]  = " + f[ii]);
				}
				
				var res:Boolean = false;
				if(f != null)
				{
					var classRef:Class = getDefinitionByName(f.className) as Class;
					var val:* = new classRef();
					if(f.condition != null && !f.condition(obj))
					{
						Globals.s_logger.info("field not have to load:" + f.fieldName);
						obj[f.fieldName] = val;
					}
					else
					{
						res = true;
						obj[f.fieldName] = decode_item_from_stream(f, val, from, pureContainerWrapper);					
					}
				}
				else
				{
					//服务器有的字段web丢弃掉了
//					Globals.s_logger.warn("decode_compound_from_stream obj:" + obj + " index " + index+" f=null");
				}
				if(!res && !pureContainerWrapper)
				{
					skip_buffer(wire_type, from);
				}
				temp += 1;
			}
	    }

		private static function encode_item_to_stream(f:Descriptor, val:*, to:NetBuffer) : void
	    {
			encode_item_to_stream_impl(f, f.type, f.fieldNumber, val, to);
	    }

		private static function encode_item_to_stream_impl(f:Descriptor, vt:int, index:int, val:*, to:NetBuffer) : void
		{
			var wt:int = get_wire_type(vt);	        
			if (vt == Descriptor.Int32)
			{
				save_protobuf_int32(index, val as int, to, wt);
			}
			else if (vt == Descriptor.UInt32)
			{
				save_protobuf_int32(index, (int)(val as uint), to, wt);
			}
			else if (vt == Descriptor.Int64)
			{
				save_protobuf_int64(index, val as Int64, to, wt);
			}
			else if (vt == Descriptor.Float32)
			{
				save_protobuf_float32(index, val as Number, to);
			}
			else if (vt == Descriptor.Float64)
			{
				save_protobuf_float64(index, val as Number, to);
			}
			else if (vt == Descriptor.TypeString)
			{
				save_protobuf_string(index, val as String, to);
			}
			else if (vt == Descriptor.TypeByteArray)
			{
				save_protobuf_array(index, val as ByteArray, to);
			}
			else if (vt == Descriptor.List)
			{
				save_protobuf_list(f, val as Array, to);
			}
			else if (vt == Descriptor.TypeDictionary)
			{
				save_protobuf_dictionary(f, val as Dictionary, to);
			}
			else if (vt == Descriptor.TypeNetBuffer)
			{
				save_protobuf_netbuffer(f, val as NetBuffer, to);
			}
			else if (vt == Descriptor.TypeBoolean)
			{
				save_protobuf_int32(index, (val as Boolean) ? 1 : 0, to, wt);
			}
			else
			{
				save_protobuf_compound(index, val, to);
			}
		}
		
		private static function decode_item_from_stream(f:Descriptor, val:*, from:NetBuffer, pureContainerWrapper:Boolean = false) : *
	    {
			return decode_item_from_stream_impl(f, f.type, val, from, pureContainerWrapper);
	    }

		private static function decode_item_from_stream_impl(f:Descriptor, vt:int, val:*, from:NetBuffer, pureContainerWrapper:Boolean = false) : *
		{
			var wt:int = get_wire_type(vt);	
			if (vt == Descriptor.Int32)
			{
				val = load_protobuf_int32(from, wt);
			}
			else if (vt == Descriptor.UInt32)
			{
				var t:int = 0;
				t = load_protobuf_int32(from, wt);
				val = t;
			}
			else if (vt == Descriptor.Int64)
			{
				val = load_protobuf_int64(from, wt);
			}
			else if (vt == Descriptor.Float32)
			{
				val = load_protobuf_float32(from, wt);
			}
			else if (vt == Descriptor.Float64)
			{
				val = load_protobuf_float64(from, wt);
			}
			else if (vt == Descriptor.TypeString)
			{
				val = load_protobuf_string(from, wt);
			}
			else if (vt == Descriptor.TypeByteArray)
			{
				val = load_protobuf_array(from, wt);
			}
			else if (vt == Descriptor.List)
			{
				val = load_protobuf_list(f, from, wt, pureContainerWrapper);
			}
			else if (vt == Descriptor.TypeDictionary)
			{
				val = load_protobuf_dictionary(f, from, wt, pureContainerWrapper);
			}
			else if (vt == Descriptor.TypeNetBuffer)
			{
				val = load_protobuf_netbuffer(from, wt);
			}
			else if (vt == Descriptor.TypeBoolean)
			{
				var temp:int = load_protobuf_int32(from, wt);
				val = (Boolean)(temp == 0 ? false : true);
			}
			else
			{
//				Globals.s_logger.debug("decode_item_from_stream_impl() " + JSON.stringify(val));
				load_protobuf_compound(val, from);
			}
			return val;
		}
		
		private static function save_protobuf_list(f:Descriptor, val:Array, to:NetBuffer):void
		{
			var buff:NetBuffer = new NetBuffer();
			var count:int = val.length;
			buff.putInt(count);
			if (count > 0)
			{
				save_type(f.typeSecond, buff);
				for (var i:int = 0; i < count; ++i)
				{
					encode_item_to_stream_impl(f, f.typeSecond, -1, val[i], buff);
				}
			}
			save_protobuf_lenth_delimited(f.fieldNumber, buff, to);
		}
		
		private static function load_protobuf_list(f:Descriptor, from:NetBuffer, wire_type:int, pureContainerWrapper:Boolean = false):Array
		{
			var buff:NetBuffer = null;
			if(pureContainerWrapper)
			{
				buff = from;
			}
			else
			{
				buff = load_protobuf_lenth_delimited(from);
			}
			var count:int = buff.getInt();
			var list:Array = new Array;
			if (count > 0)
			{
				var wire_type:int = read_type(buff);
				var classRef:Class = getDefinitionByName(f.classNameSecond) as Class;				
				for (var i:int = 0; i < count; ++i)
				{
					var item:* = new classRef();
					item = decode_item_from_stream_impl(f, f.typeSecond, item, buff);
					list.push(item);
				}
			}
			return list;
		}
		
		public static function getDictSize(dict : Dictionary) : int
		{
			var n:int = 0;
			for(var key:* in dict) 
			{
				n++;
			}
			return n;
		}
		
		private static function save_protobuf_dictionary(f:Descriptor, val:Dictionary, to:NetBuffer):void
		{
			var buff:NetBuffer = new NetBuffer();
			var count:int = ProtoBufSerializer.getDictSize(val);
			buff.putInt(count);
			if (count > 0)
			{
				save_type(f.typeSecond, buff);
				save_type(f.typeThird, buff);
				for(var key:* in val)
				{
					encode_item_to_stream_impl(f, f.typeSecond, -1, key, buff);
					encode_item_to_stream_impl(f, f.typeThird, -1, val[key], buff);
				}
			}
			save_protobuf_lenth_delimited(f.fieldNumber, buff, to);
		}
		
		private static function load_protobuf_dictionary(f:Descriptor, from:NetBuffer, wire_type:int, pureContainerWrapper:Boolean = false):Dictionary
		{
			var buff:NetBuffer = null;
			if(pureContainerWrapper)
			{
				buff = from;
			}
			else
			{
				buff = load_protobuf_lenth_delimited(from);
			}
			var count:int = buff.getInt();
			var dict:Dictionary = new Dictionary;
			if (count > 0)
			{
				var wire_k:int = read_type(buff);
				var wire_v:int = read_type(buff);
				
				var keyClassRef:Class = getDefinitionByName(f.classNameSecond) as Class;
				var valClassRef:Class = getDefinitionByName(f.classNameThird) as Class;
				for (var i:int = 0; i < count; ++i)
				{
					var key:* = new keyClassRef();
					var val:* = new valClassRef();
					key = decode_item_from_stream_impl(f, f.typeSecond, key, buff);
					val = decode_item_from_stream_impl(f, f.typeThird, val, buff);
					dict[key] = val;
				}
			}
			return dict;
		}
		
		private static function save_protobuf_netbuffer(f:Descriptor, val:NetBuffer, to:NetBuffer):void
		{
			var tmp:NetBuffer = new NetBuffer();
			tmp.putNetBuffer(val);
			save_protobuf_lenth_delimited(f.fieldNumber, tmp, to);
		}
		
		private static function load_protobuf_netbuffer(from:NetBuffer, wire_type:int):NetBuffer
		{
			if (wire_type == LengthDelimited)
			{
				var tmp:NetBuffer  = load_protobuf_lenth_delimited(from);
				return tmp.getNetBuffer();
			}
			return null;
		}
		
	    private static function save_type(type:int, to:NetBuffer) : void
	    {
	        var wt:int = get_wire_type(type);
	        to.putByte(wt);
	    }

	    private static function read_type(from:NetBuffer) : int
	    {
	        return from.getByte();
	    }

	    private static function get_wire_type(vt:int) : int
	    {
	        if (vt == Descriptor.Int32  || vt == Descriptor.UInt32 || vt == Descriptor.Int64 || vt == Descriptor.TypeBoolean)
	        {
	            return VarInt;
	        }
	        if (vt == Descriptor.Float32)
	        {
	            return Data32;
	        }
	        else if (vt == Descriptor.Float64)
	        {
	            return Data64;
	        }
	        else
	        {
	            return LengthDelimited;
	        }
	    }
		
		private static function write$TYPE_UINT32(value:uint, out:NetBuffer):void
		{
			for (;;)
			{
				if (value < 0x80)
				{
					out.putByte(value);
					return;
				} else {
					out.putByte((value & 0x7F) | 0x80);
					value >>>= 7;
				}
			}
		}
		
		public static function to_var_int(n:Number, out:NetBuffer) : void
		{
			var h:uint = NumberUtil.GetHigh(n);;
			var l:uint = NumberUtil.GetLow(n);
			to_var_int_impl(l, h, out);
		}
		
		private static function to_var_int_impl(l:uint, h:uint, out:NetBuffer):void
		{
			var low:uint = Zigzag.encode64low(l, h);
			var high:uint = Zigzag.encode64high(l, h);
			if (high == 0)
			{
				write$TYPE_UINT32(low, out);
			}
			else
			{
				for (var i:uint = 0; i < 4; ++i)
				{
					out.putByte((low & 0x7F) | 0x80);
					low >>>= 7;
				}
				if ((high & (0xFFFFFFF << 3)) == 0)
				{
					out.putByte((high << 4) | low);
				}
				else
				{
					out.putByte((((high << 4) | low) & 0x7F) | 0x80);
					write$TYPE_UINT32(high >>> 3, out);
				}
			}
		}
		public static function int64_to_var_int(n:Int64, out:NetBuffer):void
		{
			to_var_int_impl(n.low, n.high, out);
		}
		
		public static function from_var_int(from:NetBuffer) : Number
		{
			var res:Int64 = int64_from_var_int(from);
			return res.toNumber();
		}
		
		public static function int64_from_var_int(from:NetBuffer) : Int64
		{
			var b:uint = 0;
			var i:uint = 0;
			var low:uint = 0;
			var high:int = 0;
			var finish:Boolean = false;
			for(;; i += 7)
			{
				b = from.getByte();
				if(i == 28)
				{
					break;
				}
				else
				{
					if (b >= 0x80)
					{
						low |= ((b & 0x7f) << i);
					}
					else
					{
						low |= (b << i);
						finish = true;
						break;
					}
				}
			}
			if(!finish)
			{
				if(b >= 0x80)
				{
					b &= 0x7f;
					low |= (b << i);
					high = b >>> 4;
				}
				else
				{
					low |= (b << i);
					high = b >>> 4;
					finish = true;
				}
			}
			
			if(!finish)
			{
				for (i = 3;; i += 7)
				{
					b = from.getByte();
					if (i < 32) 
					{
						if (b >= 0x80) 
						{
							high |= ((b & 0x7f) << i);
						} 
						else
						{
							high |= (b << i);
							break
						}
					}
				}
			}
			
			const l:uint = low;
			const h:uint = high;
			var res:Int64 = new Int64;
			res.low = Zigzag.decode64low(low, high);
			res.high = Zigzag.decode64high(low, high);
			return res;
		}
		
		private static function skip_buffer(wire_type:int, from:NetBuffer):void
		{
			var len:int = 0;
			switch(wire_type)
			{
				case LengthDelimited:
					len = from.getInt();
					from.skip(len);
					break;
				case VarInt:
					from_var_int(from);
					break;
				case Data32:
					from.skip(4);
					break;
				case Data64:
					from.skip(8);
					break;
				default:
					break;
			}
		}
	}	
}