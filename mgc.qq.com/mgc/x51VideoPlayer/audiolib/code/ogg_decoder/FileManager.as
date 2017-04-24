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
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Jake Callery
	 */
	public class FileManager extends EventDispatcher
	{//FileManager Class
	
		private var _fileRef:FileReference;
		
		public function FileManager() 
		{//FileManager
		}//FileManager
		
		public function load():void
		{//load
			_fileRef = new FileReference();
			_fileRef.addEventListener(Event.SELECT, handleBrowseComplete, false, 0, true);
			_fileRef.browse([new FileFilter("ogg", "*.ogg")]);
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

}//Package