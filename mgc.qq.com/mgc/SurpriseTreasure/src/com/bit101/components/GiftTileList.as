package com.bit101.components
{
	import com.bit101.utils.SelectFreeEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	public class GiftTileList extends TileList
	{
		public function GiftTileList(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, items:Array=null, listItemHeight:Number=0, listItemWidth:Number=0, columnCount:int=0, rowCount:int=0)
		{
			super(parent, xpos, ypos, items, listItemHeight, listItemWidth, columnCount, rowCount);
		}
		
		override protected function onSelect(event:Event):void
		{
			if(! (event.target is ListItem)) return;
			
			//var numItems:int = columnCount * rowCount;
			var offset:int = _scrollbar.value;
			//var offset:int = _scrollbar.value * numItems;
			
			for(var i:int = 0; i < _itemHolder.numChildren; i++)
			{
				if(_itemHolder.getChildAt(i) == event.target) 
				{
					
					if(_items[i + offset].type == 1)
					{
						var e:SelectFreeEvent = new SelectFreeEvent(SelectFreeEvent.SELECT_FREE);
						e.data = _items[i + offset];
						dispatchEvent(e);
						return;
					}
					_selectedIndex = i + offset;
				}
				
				ListItem(_itemHolder.getChildAt(i)).selected = false;
			}
			ListItem(event.target).selected = true;
			dispatchEvent(new Event(Event.SELECT));
		}
	}
}