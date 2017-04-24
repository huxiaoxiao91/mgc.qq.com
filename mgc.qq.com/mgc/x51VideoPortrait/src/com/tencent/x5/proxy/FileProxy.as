package com.tencent.x5.proxy
{
	import com.tencent.x5.utils.BMPDecoder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	public class FileProxy extends EventDispatcher
	{
		private var _file:FileReference
		private var _fileType:FileFilter
		private var _bitmapData:BitmapData
		public function FileProxy(target:IEventDispatcher=null)
		{
			super(target);
			init()
		}

		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}

		public function set bitmapData(value:BitmapData):void
		{
			_bitmapData = value;
		}

		protected function init():void
		{
			_file = new FileReference();
			_file.addEventListener(Event.OPEN,onOpen);
			_file.addEventListener(Event.CANCEL,onCancel);
			_file.addEventListener(Event.SELECT,onSelect);
			_file.addEventListener(Event.COMPLETE,onComplete);
			_fileType = new FileFilter("Images", "*.jpg;*.gif;*.png;*.bmp");
		}
		private function getFileType(fileData : ByteArray) : String {
			var b0 : int = fileData.readUnsignedByte();
			var b1 : int = fileData.readUnsignedByte();
			fileData.position = 0;
			var fileType : String = "unknown";
			if(b0 == 66 && b1 == 77) {
				fileType = "BMP";
			}else if(b0 == 255 && b1 == 216) {
				fileType = "JPG";
			}else if(b0 == 137 && b1 == 80) {
				fileType = "PNG";
			}else if(b0 == 71 && b1 == 73) {
				fileType = "GIF";
			}
			return fileType;
		}
		protected function onComplete(event:Event):void
		{
			// TODO Auto-generated method stub
//			trace (_file.data.bytesAvailable)
			
			if(_file.size > (1024*1024*2))
			{
				//打开的上传图片大小不允许超过2M
				var obj:Object = {};
				obj.Type = 1;
				obj.Title = "提示信息";
				obj.BtnName = "确定";
				obj.BtnNum = 1;
				obj.Note = "上传图片不允许大于2MB！";
				ExternalInterface.call("MGC_Comm.CommonDialog",obj);
				return;
			}
			
			var byte:ByteArray = new ByteArray();
			_file.data.readBytes(byte);
			_file.data.clear()
			var type:String = getFileType(byte);
		
			switch(type)
			{
				case "JPG":
					toJPG(byte);
				break;
				case "PNG":
					toJPG(byte);
					break;
				case "GIF":
					toJPG(byte);
					break;
				case "BMP":
					toBMP(byte)
					break;
			}
			
		}
		protected function toBMP(byte:ByteArray):void
		{
		
			var p: BMPDecoder =new BMPDecoder();
			bitmapData = p.decode(byte);
			dispatchEvent(new Event(Event.COMPLETE))
			
		}
		protected function toJPG(byte:ByteArray):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteData);
			loader.loadBytes(byte);
			
		}
		
		protected function onCompleteData(event:Event):void
		{
			// TODO Auto-generated method stub
			event.currentTarget.removeEventListener(Event.COMPLETE,onCompleteData);
			if (event.currentTarget.content as Bitmap)
			{
				bitmapData = event.currentTarget.content.bitmapData
				dispatchEvent(new Event(Event.COMPLETE))
			}
			
			
		}
		public function open():void
		{
			_file.browse([_fileType])
		}
		protected function onSelect(event:Event):void
		{
			// TODO Auto-generated method stub
			var  pattern:RegExp = /.gif|.bpm|.png|.JPG|.GIF|.BPM|.PNG|.jpg/;
			if(pattern.test(_file.type))
			{
				_file.load();
			}
			else
			{
				var obj:Object = {};
				obj.Type = 1;
				obj.Title = "提示信息";
				obj.BtnName = "确定";
				obj.BtnNum = 1;
				obj.Note = "上传图片格式不对请重新选择！";
				ExternalInterface.call("MGC_Comm.CommonDialog",obj);
			}
			
			
		}
		
		protected function onCancel(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onOpen(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
	}
}