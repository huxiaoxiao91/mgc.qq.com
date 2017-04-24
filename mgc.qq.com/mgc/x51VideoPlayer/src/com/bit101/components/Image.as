/**
 * Label.as
 * Keith Peters
 * version 0.9.10
 * 
 * A Label component for displaying a single line of text.
 * 
 * Copyright (c) 2011 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package com.bit101.components
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	[Event(name="resize", type="flash.events.Event")]
	public class Image extends Component
	{
		protected var _autoSize:Boolean = true;
		protected var _source:Object = null;
		protected var _tf:TextField;
		public var loader:Loader;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this Label.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param source 
		 */
		public function Image(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, source:Object = null)
		{
			this.source = source;
			super(parent, xpos, ypos);
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			draw();
		}
		
		
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			
			/**
			 * 移除全部显示对象
			 */
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
			
			if(source == null)return;
			
			if(source is Sprite)
			{
				source.width = width;
				source.height = height;
				addChild(source as Sprite);
			}
			else if(source is Bitmap)
			{
				source.width = width;
				source.height = height;
				addChild(source as Bitmap);
			}
			else if(source is String)
			{
				if(!loader)
				{
					loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
				}
				
				loader.load(new URLRequest(String(source)));
			}
			
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		private function completeHandler(e:Event):void
		{
			loader.width = width;
			loader.height = height;
			addChild(loader);
			
			dispatchEvent(new Event("Image.COMPLETE"));
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Gets / sets
		 */
		public function set source(t:Object):void
		{
			_source = t;
			invalidate();
		}
		public function get source():Object
		{
			return _source;
		}
		
		/**
		 * Gets / sets whether or not this Label will autosize.
		 */
		public function set autoSize(b:Boolean):void
		{
			_autoSize = b;
		}
		public function get autoSize():Boolean
		{
			return _autoSize;
		}
		
		/**
		 * Gets the internal TextField of the label if you need to do further customization of it.
		 */
		public function get textField():TextField
		{
			return _tf;
		}
	}
}