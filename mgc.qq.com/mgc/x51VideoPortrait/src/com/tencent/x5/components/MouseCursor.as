package com.tencent.x5.components
{
	import com.ui.MoveCursor;
	import com.ui.ResizeCursor;
	import com.ui.ResizeHCursor;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	public class MouseCursor extends Object
	{
		public static var MOUSE_MOVING:uint = 3;
		public static var MOUSE_RESIZABLE:uint = 1;
		public static var MOUSE_MOVABLE:uint = 2;
		private static var _status:uint = MOUSE_NORMAL;
		public static var MOUSE_NORMAL:uint = 0;
		public static var MOUSE_RESIZABLEH:uint = 4;
		private static var _resizable:Sprite;
		private static var _moving:Sprite;
		private static var _movable:Sprite;
		private static var _resizableh:Sprite;

		public function MouseCursor()
		{
			return;
		}

		public static function hide():void
		{
			show(MOUSE_NORMAL);
			return;
		}

		public static function setPoint(X:Number, Y:Number):void
		{
			_movable.x = Math.round(X);
			_movable.y = Math.round(Y);
			_resizable.x = Math.round(X);
			_resizable.y = Math.round(Y);
			_resizableh.x = Math.round(X);
			_resizableh.y = Math.round(Y);
			_moving.x = Math.round(X);
			_moving.y = Math.round(Y);
			return;
		}

		public static function init(disobjc:DisplayObjectContainer):void
		{
			var bitmap:Bitmap = null;
			if (disobjc.stage == null)
			{
				disobjc.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
				return;
			}
			if (_resizable == null)
			{
				_resizable = new Sprite();
				bitmap = new Bitmap(new ResizeCursor());
				bitmap.x = (-bitmap.width) / 2;
				bitmap.y = (-bitmap.height) / 2;
				_resizable.addChild(bitmap);
				_resizable.visible = false;
				_resizable.mouseChildren = false;
				_resizable.mouseEnabled = false;
				disobjc.stage.addChild(_resizable);
			}
			if (_resizableh == null)
			{
				_resizableh = new Sprite();
				bitmap = new Bitmap(new ResizeHCursor());
				bitmap.x = (-bitmap.width) / 2;
				bitmap.y = (-bitmap.height) / 2;
				_resizableh.addChild(bitmap);
				_resizableh.visible = false;
				_resizableh.mouseChildren = false;
				_resizableh.mouseEnabled = false;
				disobjc.stage.addChild(_resizableh);
			}
			if (_movable == null)
			{
				_movable = new Sprite();
				bitmap = new Bitmap(new MoveCursor());
				bitmap.x = (-bitmap.width) / 2;
				bitmap.y = (-bitmap.height) / 2;
				_movable.addChild(bitmap);
				_movable.visible = false;
				_movable.mouseChildren = false;
				_movable.mouseEnabled = false;
				disobjc.stage.addChild(_movable);
			}
			if (_moving == null)
			{
				_moving = new Sprite();
				bitmap = new Bitmap(new MoveCursor());
				bitmap.x = (-bitmap.width) / 2;
				bitmap.y = (-bitmap.height) / 2;
				_moving.addChild(bitmap);
				_moving.visible = false;
				_moving.mouseChildren = false;
				_moving.mouseEnabled = false;
				disobjc.stage.addChild(_moving);
			}
			disobjc.stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
			disobjc.stage.addEventListener(MouseEvent.CLICK, clickHandler);
			disobjc.stage.addEventListener(Event.MOUSE_LEAVE, leaveHandler);
			return;
		}

		public static function leaveHandler(event:Event):void
		{
			_movable.visible = false;
			_resizable.visible = false;
			_resizableh.visible = false;
			_moving.visible = false;
			return;
		}

		private static function addedHandler(event:Event):void
		{
			event.target.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			MouseCursor.init(event.target as DisplayObjectContainer);
			return;
		}

		public static function clickHandler(event:MouseEvent):void
		{
			if (_status != MOUSE_NORMAL)
			{
				Mouse.hide();
			}
			setPoint(event.stageX, event.stageY);
			return;
		}

		public static function moveHandler(event:MouseEvent):void
		{
			setPoint(event.stageX, event.stageY);
			_movable.visible = _status == MOUSE_MOVABLE;
			_resizable.visible = _status == MOUSE_RESIZABLE;
			_resizableh.visible = _status == MOUSE_RESIZABLEH;
			_moving.visible = _status == MOUSE_MOVING;
			event.updateAfterEvent();
			return;
		}

		public static function show(num1:uint, num2:uint = 0):void
		{
			if (num1 == MOUSE_RESIZABLE)
			{
				if (num2 % 90 == 0)
				{
					num1 = MOUSE_RESIZABLEH;
					_resizableh.rotation = num2 + 90;
				}
				else
				{
					_resizable.rotation = num2 + 45;
				}
			}
			if (_status == num1)
			{
				return;
			}
			_status = num1;
			if (num1 == MOUSE_RESIZABLE)
			{
				Mouse.hide();
				_resizableh.visible = false;
				_movable.visible = false;
				_moving.visible = false;
				_resizable.visible = true;
			}
			else if (num1 == MOUSE_RESIZABLEH)
			{
				Mouse.hide();
				_resizable.visible = false;
				_moving.visible = false;
				_movable.visible = false;
				_resizableh.visible = true;
			}
			else if (num1 == MOUSE_MOVABLE)
			{
				Mouse.hide();
				_resizable.visible = false;
				_resizableh.visible = false;
				_moving.visible = false;
				_movable.visible = true;
			}
			else if (num1 == MOUSE_MOVING)
			{
				Mouse.hide();
				_resizable.visible = false;
				_resizableh.visible = false;
				_movable.visible = false;
				_moving.visible = true;
			}
			else
			{
				_resizable.visible = false;
				_resizableh.visible = false;
				_movable.visible = false;
				_moving.visible = false;
				Mouse.show();
			}
			return;
		}

	}
}