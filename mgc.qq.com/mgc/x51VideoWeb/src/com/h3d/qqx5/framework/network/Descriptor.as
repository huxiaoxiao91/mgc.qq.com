package com.h3d.qqx5.framework.network
{
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import flashx.textLayout.elements.BreakElement;

	/**
	 * @author liuchui
	 */
	public class Descriptor
	{
		//Descriptor Types
		static public const NotSupported:int = 0;
		static public const Int32:int        = 1;
		static public const UInt32:int	     = 2;
		static public const Int64:int        = 3;
		static public const Float32:int      = 4;
		static public const Float64:int      = 5;
		static public const TypeString:int   = 6;
		static public const TypeByteArray:int= 7;
		static public const List:int         = 8;
		static public const TypeDictionary:int= 9;
		static public const Compound:int     = 10;
		static public const TypeNetBuffer:int= 11;
		static public const TypeBoolean:int  = 12;
		
		public var fieldName:String;  // 字段名
		public var fieldNumber:int;   // 字段index
		public var type:int; 		   // 字段类型	
		public var className:String; // 类型名
		public var typeSecond:int;   
		public var classNameSecond:String;
		public var typeThird:int;   
		public var classNameThird:String;
		public var condition:Function;
		
		public function Descriptor(name:String, className:String, type:int, fieldNumber:int, condition:Function) : void
		{
			this.fieldName = name;
			this.className = className;
			this.type = type;
			this.fieldNumber = fieldNumber;
			this.condition = condition;
			if(this.className.length > 0)
			{
				return;
			}
			this.className = ToClassName(type);
		}	
		
		public function initOther(classNameSec:String, typeSec:int, classNameThird:String, typeThird:int) : Descriptor
		{
			this.typeSecond = typeSec;
			this.classNameSecond = classNameSec;			
			this.typeThird = typeThird;
			this.classNameThird = classNameThird;
			
			if(this.classNameSecond.length <= 0)
			{
				this.classNameSecond = ToClassName(typeSec);
			}
			if(this.classNameThird.length <= 0)
			{
				this.classNameThird = ToClassName(typeThird);
			}
			return this;
		}
		
		private function ToClassName(type:int):String
		{
			var className:String = "";
			switch(type)
			{
				case Int32:
				{
					className = getQualifiedClassName(int);
					break;
				}
				case UInt32:
				{
					className = getQualifiedClassName(uint);
					break;
				}
				case Int64:
				{
					className = getQualifiedClassName(com.h3d.qqx5.util.Int64);
					break;
				}
				case Float32:
				case Float64:
				{
					className = getQualifiedClassName(Number);
					break;
				}
				case TypeString:
				{
					className = getQualifiedClassName(String);
					break;
				}
				case TypeByteArray:
				{
					className = getQualifiedClassName(ByteArray);
					break;
				}
				case List:
				{
					className = getQualifiedClassName(Array);
					break;
				}
				case TypeDictionary:
				{
					className = getQualifiedClassName(Dictionary);
					break;
				}
				case TypeNetBuffer:
				{
					className = getQualifiedClassName(NetBuffer);
					break;
				}
				case TypeBoolean:
				{
					className = getQualifiedClassName(Boolean);
					break;
				}
				default:
				{
					break;
				}
			}
			return className;
		}
	}	
}