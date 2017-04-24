/*
Copyright (c)2011 Hook L.L.C

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package h3d.x51 
{//Package
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
	public class PlaybackManager extends EventDispatcher
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
			
			for (var i:int = 0; i < NUM_SAMPLES; i++)
			{//feed sound
				if (_playBackBytes.bytesAvailable < 8)
				{//loop
					_playBackBytes.position = 0;
				}//loop
				
				//feed data
				e.data.writeFloat(_playBackBytes.readFloat());		//Left Channel
				e.data.writeFloat(_playBackBytes.readFloat());		//Right Channel
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

}//Package