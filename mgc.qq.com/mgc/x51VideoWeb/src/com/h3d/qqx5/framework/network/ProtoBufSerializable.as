package com.h3d.qqx5.framework.network
{
	/**
	 * 可序列化对象基类
	 * @author liuchui
	 */
	public class ProtoBufSerializable
	{
		protected var fieldDescriptors:Vector.<Descriptor>;
		
		public function ProtoBufSerializable()
		{
			if(fieldDescriptors == null)
			{
				fieldDescriptors = new Vector.<Descriptor>();
			}
		}		
		
		public function getDescriptors():Vector.<Descriptor>
		{
			return fieldDescriptors;
		}
		
		//function原形定义参考,function(obj:Object):Boolean{return obj.has_avatar;}
		protected function registerField(field:String, compoundClass:String, type:int, fieldNumber:int, condition:Function = null):void
		{
			fieldDescriptors.push(new Descriptor(field, compoundClass, type, fieldNumber, condition));
		}
		
		protected function registerFieldForList(field:String, classNameSec:String, typeSec:int, fieldNumber:int, condition:Function = null):void
		{
			var f:Descriptor = new Descriptor(field, "", Descriptor.List, fieldNumber,condition);
			f.initOther(classNameSec, typeSec, "", Descriptor.NotSupported);
			fieldDescriptors.push(f);
		}
		
		protected function registerFieldForDict(field:String, classNameSec:String, typeSec:int, classNameThird:String, typeThird:int, fieldNumber:int, condition:Function = null):void
		{
			var f:Descriptor = new Descriptor(field, "", Descriptor.TypeDictionary, fieldNumber,condition);
			f.initOther(classNameSec, typeSec, classNameThird, typeThird);
			fieldDescriptors.push(f);
		}
		
//		protected function registerFieldPair(field:String, compoundClass:String, type:int, fieldNumber:int, condition:Function = null):void
//		{
//			var f:Descriptor = new Descriptor(field, "", Descriptor.TypeDictionary, fieldNumber,condition);
//			f.initOther(classNameSec, typeSec, classNameThird, typeThird);
//		}
		
		public function getDescriptorByFieldNumber(fieldNum:int):Descriptor
		{
			for(var i : int = 0; i < fieldDescriptors.length; ++i)
			{
				if(fieldDescriptors[i].fieldNumber == fieldNum)
				{
					return fieldDescriptors[i];
				}
			}
			return null;
		}
		
		public function getDescriptor(field:String):Descriptor
		{
			for(var i : int = 0; i < fieldDescriptors.length; ++i)
			{
				if(fieldDescriptors[i].fieldName == field)
				{
					return fieldDescriptors[i];
				}
			}
			return null;
		}
		
		public function getDescriptorByIndex(index:int):Descriptor
		{
			if(index >= 0 && index < fieldDescriptors.length)
			{
				return fieldDescriptors[index];
			}		
			return null;
		}
		
		public function isPureContainerWrapper():Boolean
		{
			return false;
		}
		
		//加一个是否包含char的函数，因为as不支持char类型的解析，如果最后一个字节是char的话，会不再解析。
		public function isPureContainChar():Boolean
		{
			return false;
		}

//		public function clearData():void {
//			if (fieldDescriptors != null) {
//				while (fieldDescriptors.length > 0) {
//					fieldDescriptors.pop();
//				}
//				fieldDescriptors = null;
//			}
//		}
	}	
}