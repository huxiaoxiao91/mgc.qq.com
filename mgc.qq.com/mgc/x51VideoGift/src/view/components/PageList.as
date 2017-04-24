/**
 * List.as
 * Keith Peters
 * version 0.9.10
 * 
 * A scrolling list of selectable items. 
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

package view.components
{
	import com.bit101.components.Component;
	import com.bit101.components.ListItem;
	import com.bit101.components.Panel;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[Event(name="select", type="flash.events.Event")]
	public class PageList extends Component
	{
		protected var _items:Array;
		protected var _itemHolder:Sprite;
		protected var _panel:Panel;
		
		/**
		 * 单元高度 
		 */		
		protected var _listItemHeight:Number = 20;
		/**
		 * 单元宽度 
		 */		
		protected var _listItemWidth:Number = 20;
		
		private var _columnCount:int = 10;
		
		/**
		 * 行数
		 */		
		public var rowCount:int = 1;
		
		/**
		 * 鼠标滑过的索引
		 */
		protected var _overIndex:int = -1;
		
		/**
		 * 鼠标选中的索引
		 */
		protected var _selectedIndex:int = -1;
		
		protected var _listItemClass:Class = ListItem;

		
		private var _value:int = 0;
		
		private var _currentPage:int = 1;
		
		public var totalPage:int = 0;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this List.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param items An array of items to display in the list. Either strings or objects with label property.
		 */
		public function PageList(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, items:Array=null, listItemHeight:Number = 0, listItemWidth:Number = 0, columnCount:int = 0, rowCount:int = 0)
		{
			if(items != null)
			{
				_items = items;
			}
			else
			{
				_items = new Array();
			}
			
			_listItemHeight = listItemHeight;
			_listItemWidth = listItemWidth;
			_columnCount = columnCount;
			this.rowCount = rowCount;
			
			super(parent, xpos, ypos);
		}

		/**
		 * Initilizes the component.
		 */
		protected override function init() : void
		{
			super.init();
            makeListItems();
            fillItems();
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		protected override function addChildren() : void
		{
			super.addChildren();
			_panel = new Panel(this, 0, 0);
			//_panel.color = _defaultColor;
			_itemHolder = new Sprite();
			_panel.content.addChild(_itemHolder);
		}
		
		/**
		 * Creates all the list items based on data.
		 */
		protected function makeListItems():void
		{
			/**
			 * 移除全部显示对象
			 */
			var item:ListItem;
			while(_itemHolder.numChildren > 0)
			{
				item = ListItem(_itemHolder.getChildAt(0));
				item.removeEventListener(MouseEvent.CLICK, onSelect);
				item.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
				_itemHolder.removeChildAt(0);
			}
			
			for(var i:int = 0; i < rowCount; i++)
			{
				for(var j:int = 0; j < columnCount; j++)
				{
					item = new _listItemClass(_itemHolder, j * _listItemWidth, i * _listItemHeight);
					item.setSize(_listItemWidth, _listItemHeight);
					//item.defaultColor = _defaultColor;

					//item.selectedColor = _selectedColor;
//					item.rolloverColor = 0x13a0e5;
					item.addEventListener(MouseEvent.CLICK, onSelect);
					item.addEventListener(MouseEvent.MOUSE_OVER, onOver);
				}
			}
		}

        protected function fillItems():void
        {
			/**
			 * 显示的数量
			 */
			var numItems:int = columnCount * rowCount;
			
            for(var i:int = 0; i < numItems; i++)
            {
                var item:ListItem = _itemHolder.getChildAt(i) as ListItem;
				if(value + i < _items.length)
				{
					
					_items[value + i].props = {"priority":(_items.length - (value + i))};
	                item.data = _items[value + i];
				}
				else
				{
					item.data = null;
				}

				
                if(value + i == _selectedIndex)
                {
                    item.selected = true;
                }
                else
                {
                    item.selected = false;
                }
				
            }
        }
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		public override function draw() : void
		{
			super.draw();
			
			_selectedIndex = Math.min(_selectedIndex, _items.length - 1);

			// panel
			_panel.setSize(_width, _height);
			_panel.draw();
			
			fillItems();
		}
		
		/**
		 * Adds an item to the list.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 */
		public function addItem(item:Object):void
		{
			_items.push(item);
			invalidate();
			makeListItems();
            fillItems();
		}
		
		/**
		 * Adds an item to the list at the specified index.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 * @param index The index at which to add the item.
		 */
		public function addItemAt(item:Object, index:int):void
		{
			index = Math.max(0, index);
			index = Math.min(_items.length, index);
			_items.splice(index, 0, item);
			invalidate();
            fillItems();
		}
		
		/**
		 * Removes the referenced item from the list.
		 * @param item The item to remove. If a string, must match the item containing that string. If an object, must be a reference to the exact same object.
		 */
		public function removeItem(item:Object):void
		{
			var index:int = _items.indexOf(item);
			removeItemAt(index);
		}
		
		/**
		 * Removes the item from the list at the specified index
		 * @param index The index of the item to remove.
		 */
		public function removeItemAt(index:int):void
		{
			if(index < 0 || index >= _items.length) return;
			_items.splice(index, 1);
			invalidate();
            fillItems();
		}
		
		/**
		 * Removes all items from the list.
		 */
		public function removeAll():void
		{
			_items.length = 0;
			invalidate();
            fillItems();
		}

		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Called when a user selects an item in the list.
		 */
		protected function onSelect(event:Event):void
		{
			if(! (event.target is ListItem)) return;
			
			for(var i:int = 0; i < _itemHolder.numChildren; i++)
			{
				if(_itemHolder.getChildAt(i) == event.target) _selectedIndex = i + value;
				ListItem(_itemHolder.getChildAt(i)).selected = false;
			}
			ListItem(event.target).selected = true;
			dispatchEvent(new Event(Event.SELECT));
		}
		
		protected function onOver(event:MouseEvent):void
		{
			if(! (event.target is ListItem)) return;
				
			for(var i:int = 0; i < _itemHolder.numChildren; i++)
			{
				if(_itemHolder.getChildAt(i) == event.target) _overIndex = i + value;
			}
			
			dispatchEvent(new Event("OVER"));
		}


        protected function onResize(event:Event):void
        {
            makeListItems();
            fillItems();
        }
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the index of the selected list item.
		 */
		public function set selectedIndex(value:int):void
		{
			if(value >= 0 && value < _items.length)
			{
				_selectedIndex = value;
			}
			else
			{
				_selectedIndex = -1;
			}
			invalidate();
			dispatchEvent(new Event(Event.SELECT));
		}
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		/**
		 * Sets / gets the index of the overIndex list item.
		 */
		public function set overIndex(value:int):void
		{
			if(value >= 0 && value < _items.length)
			{
				_overIndex = value;
			}
			else
			{
				_overIndex = -1;
			}
			invalidate();
		}
		
		public function get overIndex():int
		{
			return _overIndex;
		}
		
		public function get overItem():Object
		{
			if(_overIndex >= 0 && _overIndex < _items.length)
			{
				return _items[_overIndex];
			}
			return null;
		}
		
		/**
		 * Sets / gets the item in the list, if it exists.
		 */
		public function set selectedItem(item:Object):void
		{
			var index:int = _items.indexOf(item);
//			if(index != -1)
//			{
				selectedIndex = index;
				invalidate();
				dispatchEvent(new Event(Event.SELECT));
//			}
		}
		
		public function get selectedItem():Object
		{
			if(_selectedIndex >= 0 && _selectedIndex < _items.length)
			{
				return _items[_selectedIndex];
			}
			return null;
		}

		/**
		 * Sets the height of each list item.
		 */
		public function set listItemHeight(value:Number):void
		{
			_listItemHeight = value;
            makeListItems();
			invalidate();
		}
		public function get listItemHeight():Number
		{
			return _listItemHeight;
		}

		/**
		 * Sets / gets the list of items to be shown.
		 */
		public function set items(value:Array):void
		{
			_items = value;
			
			totalPage = Math.ceil(_items.length/(columnCount * rowCount));
			currentPage = 1;
			
			invalidate();
		}
		public function get items():Array
		{
			return _items;
		}

		/**
		 * Sets / gets the class used to render list items. Must extend ListItem.
		 */
		public function set listItemClass(value:Class):void
		{
			_listItemClass = value;
			makeListItems();
			invalidate();
		}
		public function get listItemClass():Class
		{
			return _listItemClass;
		}
		
		/**
		 * 当前位置
		 */
		public function set value(value:int):void
		{
			_value = value;
			fillItems();
		}
		public function get value():int
		{
			return _value;
		}
		
		
		/**
		 * 列数
		 */
		public function get columnCount():int
		{
			return _columnCount;
		}
		
		/**
		 * @private
		 */
		public function set columnCount(value:int):void
		{
			_columnCount = value;
			
			makeListItems();
			fillItems();
		}
		
		
		/**
		 * 当前页数
		 */
		public function get currentPage():int
		{
			return _currentPage;
		}
		
		public function set currentPage(value:int):void
		{
			if(value > totalPage) return;
			if(value < 1) return;
			
			this.value = (value - 1) * (columnCount * rowCount);
			
			_currentPage = value;
			
			dispatchEvent(new Event("currentPageUpdate"));
		}
	}
}