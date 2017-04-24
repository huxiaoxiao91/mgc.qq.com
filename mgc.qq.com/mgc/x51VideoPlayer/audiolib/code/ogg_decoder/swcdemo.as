// Copyright (c) 2013 Adobe Systems Inc

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

package
{
  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
  import h3d.x51.web.ogg_decoder.*;
  
	
  public class swcdemo extends Sprite
  {
	private var decoder:uint;
	private var _playbackManager:PlaybackManager;
	private var _fileManager:FileManager;
	private var ogg_data:ByteArray;
	private var tf:TextField
	
    public function swcdemo()
    {
      addEventListener(Event.ADDED_TO_STAGE, initCode);
    }
 
    public function initCode(e:Event):void
    {
	 CModule.startAsync(this)
	removeEventListener(Event.ADDED_TO_STAGE, init);
		_playbackManager = new PlaybackManager();
		_fileManager = new FileManager();
		
		 tf = new TextField
      tf.multiline = true
      tf.width = 20;
      tf.height = 20;
	  tf.addEventListener(MouseEvent.CLICK, handleClick, false, 0, true);
      addChild(tf)
	  decoder = 0;
	  decoder = CreateCppOggDecoder();

  
        tf.appendText( "test\n")
	trace( "test\n")
	trace( decoder.toString());
	 
	 
	tf.appendText( "test\n")
    }
	
	private function handleClick(e:MouseEvent):void 
		{//handleLoadClick
			_fileManager.addEventListener(FileManagerEvent.LOAD_COMPLETE, handleFileLoaded, false, 0, true);
	 tf.appendText( "test\n")
	_fileManager.load();
		}//handleLoadClick
	
	public function handleFileLoaded(e:FileManagerEvent):void 
		{//handleFileLoaded
			_fileManager.removeEventListener(FileManagerEvent.LOAD_COMPLETE, handleFileLoaded, false);
			ogg_data = ByteArray(e.data);
			
			var buffer_ptr:int = CModule.malloc(ogg_data.length);
			var buffer_ptr1:int = CModule.malloc(6700000);
			CModule.writeBytes(buffer_ptr, ogg_data.length, ogg_data);
			trace(ogg_data.length.toString());
			var ptr1_len:int = 0;
			ptr1_len = Ogg2Pcm(decoder, buffer_ptr, ogg_data.length, buffer_ptr1)
			trace("decode complete\n")
			trace(ptr1_len.toString());
			var pcm_data:ByteArray = new ByteArray();
			CModule.readBytes(buffer_ptr1, ptr1_len, pcm_data);
			trace(pcm_data.length.toString())
			_playbackManager.loadBytes(pcm_data);
			_playbackManager.startPlay();
			CModule.free(buffer_ptr);
			CModule.free(buffer_ptr1);
		}//handleFileLoaded
  }
}

import flash.events.Event;
	
	/**
	 * ...
	 * @author Jake Callery
	 */
	class FileManagerEvent extends Event 
	{//FileManagerEvent Class
	
		static public const LOAD_COMPLETE:String = "fileManagerLoadComplete";
		static public const SAVE_COMPLETE:String = "fileManagerSaveComplete";
		
		private var _data:Object;
	
		public function FileManagerEvent(type:String, $data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{//FileManagerEvent 
			super(type, bubbles, cancelable);
			_data = $data;
		}//FileManagerEvent
		
		public override function clone():Event 
		{ 
			return new FileManagerEvent(type, data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FileManagerEvent", "type", "data", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get data():Object { return _data; }
		
	}//FileManagerEvent Class
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Jake Callery
	 */
	class FileManager extends EventDispatcher
	{//FileManager Class
	
		private var _fileRef:FileReference;
		
		public function FileManager() 
		{//FileManager
		}//FileManager
		
		public function load():void
		{//load
			_fileRef = new FileReference();
			_fileRef.addEventListener(Event.SELECT, handleBrowseComplete, false, 0, true);
			_fileRef.browse([new FileFilter("tmp", "*.tmp")]);
		}//load
		
		private function handleBrowseComplete(e:Event):void 
		{//handleBrowseComplete
			_fileRef.removeEventListener(Event.SELECT, handleBrowseComplete, false);
			_fileRef.addEventListener(Event.COMPLETE, handleLoadComplete, false, 0, true);
			_fileRef.load();
		}//handleBrowseComplete
		
		private function handleLoadComplete(e:Event):void 
		{//handleLoadComplete
			_fileRef.removeEventListener(Event.COMPLETE, handleLoadComplete);
			trace("Load Complete");
			dispatchEvent(new FileManagerEvent(FileManagerEvent.LOAD_COMPLETE, e.target.data));
		}//handleLoadComplete
		
	}//FileManager Class
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Jake Callery
	 */
	class PlaybackManager extends EventDispatcher
	{//PlaybackManager Class
	
		private const BYTES_PER_SAMPLE:Number = 8; 	//8 for stereo
		private const NUM_SAMPLES:int = 2048;
		
		private var _newMicData:Boolean;
		private var _newBytes:Boolean;
		private var _playBackBytes:ByteArray;
		private var _isPlaying:Boolean;
		private var _sound:Sound;
		private var _soundChannel:SoundChannel;
		
		
		public function PlaybackManager() 
		{//PlaybackManager
			_playBackBytes = new ByteArray;
			_newMicData = false;
			_isPlaying = false;
			_newBytes = false;
			
			_sound = new Sound();
			_sound.addEventListener(SampleDataEvent.SAMPLE_DATA, handleSampleData, false, 0, true);
			
		}//PlaybackManager
		
		private function handleSampleData(e:SampleDataEvent):void 
		{//handleSampleData
			//var _div:Number = 32767.0;
			for (var i:int = 0; i < NUM_SAMPLES; i++)
			{//feed sound
				if (_playBackBytes.bytesAvailable < 8)
				{//loop
					_playBackBytes.position = 0;
					//stopPlay();
				}//loop
				
				//feed data
				var pcm:Number = (_playBackBytes.readByte() + _playBackBytes.readByte() * 256) / 32768;
				//var pcm:Number = _playBackBytes.readShort() / 32767;
				//trace(pcm);
				e.data.writeFloat(pcm);		//Left Channel
				
				e.data.writeFloat(pcm);		//Right Channel
				//pcm = (_playBackBytes.readByte() + _playBackBytes.readByte() * 256) / 32767;
			}//feed sound
			
		}//handleSampleData
		
		public function togglePlay():void
		{//togglePlay
			if (_isPlaying)
			{//stop
				stopPlay();
			}//stop
			else
			{//play
				startPlay();
			}//play
		}//togglePlay
		
		public function startPlay():void
		{//startPlay
			_isPlaying = true;
			_soundChannel = _sound.play();
			
			dispatchEvent(new Event(Event.CHANGE));
		}//startPlay
		
		public function stopPlay():void
		{//stopPlay
			_isPlaying = false;
			_soundChannel.stop();
			
			dispatchEvent(new Event(Event.CHANGE));
		}//stopPlay
		
		public function loadBytes($bytes:ByteArray):void
		{//loadBytes
			_newBytes = true;
			_playBackBytes.length = 0;
			_playBackBytes.writeBytes($bytes);
			trace("Loaded New Bytes");
			trace(_playBackBytes.length.toString());
			trace("Loaded New Bytes1");
			dispatchEvent(new Event(Event.CHANGE));
			_newBytes = false;
		}//loadBytes
		
		private function reset():void
		{//reset
			_playBackBytes.length = 0;
		}//reset
		
		public function get isPlaying():Boolean { return _isPlaying; }
		public function get playBackBytes():ByteArray { return _playBackBytes; }
		public function get newBytes():Boolean { return _newBytes; }
		
	}//PlaybackManager Class
