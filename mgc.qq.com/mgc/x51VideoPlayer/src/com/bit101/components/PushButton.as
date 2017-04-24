/**
 * PushButton.as
 * Keith Peters
 * version 0.9.10
 * 
 * A basic button component with a label.
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
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class PushButton extends Component
	{
		protected var _back:Sprite;
		protected var _face:Sprite;
		protected var _label:Label;
		protected var _labelText:String = "";
		protected var _over:Boolean = false;
		protected var _down:Boolean = false;
		protected var _selected:Boolean = false;
		protected var _toggle:Boolean = false;
		
		public var upSkin:DisplayObject;
		public var overSkin:DisplayObject;
		public var downSkin:DisplayObject;
		public var selectUpSkin:DisplayObject;
		public var selectOverSkin:DisplayObject;
		public var selectDownSkin:DisplayObject;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this PushButton.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param label The string to use for the initial label of this component.
 		 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
		 */
		public function PushButton(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, label:String = "", defaultHandler:Function = null)
		{
			super(parent, xpos, ypos);
			if(defaultHandler != null)
			{
				addEventListener(MouseEvent.CLICK, defaultHandler);
			}
			this.text = label;
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			buttonMode = true;
			useHandCursor = true;
			setSize(100, 20);
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_back = new Sprite();
			_back.filters = [getShadow(2, true)];
			_back.mouseEnabled = false;
			addChild(_back);
			
			_face = new Sprite();
			//_face.mouseEnabled = false;
			_face.filters = [getShadow(1)];
			_face.x = 1;
			_face.y = 1;
			addChild(_face);
			
			_label = new Label();
			addChild(_label);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		}
		
		/**
		 * Draws the face of the button, color based on state.
		 */
		protected function drawFace():void
		{
			/*_face.graphics.clear();
			if(_down)
			{
				_face.graphics.beginFill(Style.BUTTON_DOWN);
			}
			else
			{
				_face.graphics.beginFill(Style.BUTTON_FACE);
			}
			_face.graphics.drawRect(0, 0, _width - 2, _height - 2);
			_face.graphics.endFill();*/
			
			/**
			 * 移除全部显示对象
			 */
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
			
			if(_down)
			{
				if(_selected)
				{
					if(selectDownSkin)addChildAt(selectDownSkin,0);
				}else
				{
					if(downSkin)addChildAt(downSkin,0);
				}		
			}
			else if(_over)
			{
				if(_selected)
				{
					if(selectOverSkin)addChildAt(selectOverSkin,0);
				}else
				{
					if(overSkin)addChildAt(overSkin,0);
				}	
			}
			else 
			{
				if(_selected)
				{
					if(selectUpSkin)addChildAt(selectUpSkin,0);
				}else
				{
					if(upSkin)addChildAt(upSkin,0);
				}
			}
			
			//热区
			_face.graphics.clear();
			_face.graphics.beginFill(Style.BUTTON_DOWN,0);
			_face.graphics.drawRect(0, 0, _width, _height);
			_face.graphics.endFill();
			addChild(_face);
			
			//文字
			addChild(_label);
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
			/*_back.graphics.clear();
			_back.graphics.beginFill(Style.BACKGROUND);
			_back.graphics.drawRect(0, 0, _width, _height);
			_back.graphics.endFill();*/
			
			drawFace();
			
			_label.text = _labelText;
			_label.autoSize = true;
			_label.draw();
			if(_label.width > _width - 4)
			{
				_label.autoSize = false;
				_label.width = _width - 4;
			}
			else
			{
				_label.autoSize = true;
			}
			_label.draw();
			_label.move(_width / 2 - _label.width / 2, _height / 2 - _label.height / 2);
			
		}
		
		
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Internal mouseOver handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseOver(event:MouseEvent):void
		{
			_over = true;
			drawFace();
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseOut(event:MouseEvent):void
		{
			_over = false;
			drawFace();
			if(!_down)
			{
				_face.filters = [getShadow(1)];
			}
			removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseGoDown(event:MouseEvent):void
		{
			_down = true;
			drawFace();
			_face.filters = [getShadow(1, true)];
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		/**
		 * Internal mouseUp handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onMouseGoUp(event:MouseEvent):void
		{
			/*if(_toggle  && _over)
			{
				_selected = !_selected;
			}*/
			_down = false;
			drawFace();
			_face.filters = [getShadow(1, _selected)];
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the label text shown on this Pushbutton.
		 */
		public function set text(str:String):void
		{
			_labelText = str;
			draw();
		}
		public function get text():String
		{
			return _labelText;
		}
		
		
		public function get label():Label
		{
			return _label;
		}
		
		public function set selected(value:Boolean):void
		{
			if(!_toggle)
			{
				value = false;
			}
			
			_selected = value;
			//_down = _selected;
			_face.filters = [getShadow(1, _selected)];
			drawFace();
		}
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set toggle(value:Boolean):void
		{
			_toggle = value;
		}
		public function get toggle():Boolean
		{
			return _toggle;
		}
		
		
	}
}