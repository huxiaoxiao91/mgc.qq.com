package com.tencent.x5.components
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class EditBounds extends Sprite
	{
		private var ox:Number;
		private var ratio:Number = 1;
		private var currDir:String;
		public var selectWidth:Number = 100;
		private var constraints:Boolean = false;
		public var selectHeight:Number = 100;
		public var line:Sprite;
		private var outRangle:Boolean = false;
		private var soy:Number;
		private var resizeDir:Object;
		private var cornerWidth:Number = 6;
		public var minHeight:Number = 4.94066e-324;
		public var maxHeight:Number = 1.79769e+308;
		public var minWidth:Number = 4.94066e-324;
		public var maxWidth:Number = 1.79769e+308;
		private var corners:Object;
		private var _target:DisplayObject;
		private var sox:Number;
		private var bounds:Rectangle;
		private var mousedown:Boolean = false;
		private var oh:Number;
		private var rox:Number;
		private var roy:Number;
		private var ow:Number;
		private var oy:Number;
		private var cursorRotations:Object;
		public static var busy:Boolean = false;

		public function EditBounds():void
		{
			corners = {};
			cursorRotations = {lt:135,t:0,rt:45,r:90,rb:135,b:0,lb:45,l:90};
			resizeDir = {lt:resize_lt,t:resize_t,rt:resize_rt,r:resize_r,rb:resize_rb,b:resize_b,lb:resize_lb,l:resize_l};
			selectWidth = 100;
			selectHeight = 100;
			cornerWidth = 6;
			maxWidth = Number.MAX_VALUE;
			maxHeight = Number.MAX_VALUE;
			minWidth = Number.MIN_VALUE;
			minHeight = Number.MIN_VALUE;
			constraints = false;
			ratio = 1;
			mousedown = false;
			bounds = new Rectangle(0,0,100,100);
			outRangle = false;
			line = new Sprite();
			line.x = cornerWidth / 2;
			line.y = cornerWidth / 2;
			line.graphics.beginFill(0x0000FF);
			line.graphics.drawRect(0, 0, (selectWidth - 1), 1);
			line.graphics.drawRect((selectWidth - 1), 0, 1, (selectHeight - 1));
			line.graphics.drawRect(1, (selectHeight - 1), (selectWidth - 1), 1);
			line.graphics.drawRect(0, 1, 1, (selectHeight - 1));
			line.graphics.endFill();
			line.graphics.beginFill(0, 0);
			line.graphics.drawRect(1, 1, selectWidth - 2, selectHeight - 2);
			line.graphics.endFill();
			line.scale9Grid = new Rectangle(2,2,selectWidth - 4,selectHeight - 4);
			corners.lt = createCorner("lt",0,0,cornerWidth);
			corners.t = createCorner("t",0,0,cornerWidth);
			corners.rt = createCorner("rt",0,0,cornerWidth);
			corners.r = createCorner("r",0,0,cornerWidth);
			corners.rb = createCorner("rb",0,0,cornerWidth);
			corners.b = createCorner("b",0,0,cornerWidth);
			corners.lb = createCorner("lb",0,0,cornerWidth);
			corners.l = createCorner("l",0,0,cornerWidth);
			addChild(line);
			addChild(corners.lt);
			addChild(corners.rt);
			addChild(corners.rb);
			addChild(corners.lb);
			constraints = true;
			addChild(corners.t);
			addChild(corners.r);
			addChild(corners.b);
			addChild(corners.l);
			MouseCursor.init(this);
			resetCorner();
			return;
		}
		private function resize_lt(W:Number, H:Number):void
		{
			var num1:Number = 0;
			var num2:Number = 0;
			var num3:Number = 0;
			var num4:Number = 0;
			num1 = ow - W;
			num2 = oh - H;
			if (constraints)
			{
				if (Math.min(num1,num2) == num1)
				{
					num2 = Math.round(num1 / ratio);
				}
				else
				{
					num1 = Math.round(num2 * ratio);
				}
				if (num1 > sox + ow + cornerWidth / 2)
				{
					var num5:* = sox + ow + cornerWidth / 2;
					num1 = sox + ow + cornerWidth / 2;
					num2 = num5;
				}
				if (num2 > soy + oh + cornerWidth / 2)
				{
					var num6:* = soy + oh + cornerWidth / 2;
					num2 = soy + oh + cornerWidth / 2;
					num1 = num6;
				}
			}
			num3 = limitedResizeWidth(num1);
			num4 = limitedResizeHeight(num2);
			limitedMoveX(sox + (ow - num3));
			limitedMoveY(soy + (oh - num4));
			_target.x = this.x;
			_target.y = this.y;
			dispatchEvent(new Event("draw"));
			return;
		}

		private function panelMouseOverHandler(event:MouseEvent):void
		{
			if (mousedown)
			{
				return;
			}
			busy = true;
			MouseCursor.show(MouseCursor.MOUSE_MOVABLE);
			return;
		}

		public function set target(obj:DisplayObject):void
		{
			_target = obj;
			this.x = _target.x;
			this.y = _target.y;
			line.width = _target.width;
			line.height = _target.height;
			this.width = _target.width;
			this.height = _target.height;
			return;
		}

		override public function get height():Number
		{
			return line.height;
		}

		private function limitedMoveX(num:Number):Number
		{
			num = Math.round(Math.max(bounds.x,num));
			num = Math.round(Math.min(bounds.width - this.width,num));
			var num2:* = num;
			super.x = num;
			return num2;
		}

		private function panelMouseUpHandler(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, panelMouseUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, panelMouseMoveHandler);
			mousedown = false;
			this.dispatchEvent(new Event(Event.CHANGE));
			return;
		}

		private function limitedMoveY(num:Number):Number
		{
			num = Math.round(Math.max(bounds.y,num));
			num = Math.round(Math.min(bounds.height - this.height,num));
			var num2:* = num;
			super.y = num;
			return num2;
		}

		override public function set height(num:Number):void
		{
			line.height = num;
			resetCorner();
			return;
		}

		private function mouseMoveHandler(event:MouseEvent):void
		{
			var myx:Number = NaN;
			var myy:Number = NaN;
			if (mousedown)
			{
				myx = stage.mouseX;
				myy = stage.mouseY;
				resizeDir[currDir](Math.round(myx - ox),Math.round(myy - oy));
				resetCorner();
			}
			MouseCursor.setPoint(stage.mouseX, stage.mouseY);
			event.updateAfterEvent();
			return;
		}

		private function cornerMouseOverHandler(event:MouseEvent):void
		{
			if (mousedown)
			{
				return;
			}
			busy = true;
			MouseCursor.show(MouseCursor.MOUSE_RESIZABLE, cursorRotations[event.target.name]);
			MouseCursor.setPoint(stage.mouseX, stage.mouseY);
			return;
		}

		private function createCorner(Name:String, X:Number, Y:Number, WH:Number):Sprite
		{
			var corner:Sprite = null;
			corner = new Sprite();
			corner.name = Name;
			corner.graphics.lineStyle(1, 0xFFFFFF);
			corner.graphics.beginFill(0x0000FF);
			corner.graphics.drawRect(X, Y, WH, WH);
			corner.graphics.endFill();
			corner.addEventListener(MouseEvent.MOUSE_OVER, cornerMouseOverHandler);
			corner.addEventListener(MouseEvent.MOUSE_DOWN, cornerMouseDownHandler);
			corner.addEventListener(MouseEvent.MOUSE_OUT, cornerMouseOutHandler);
			corner.addEventListener(MouseEvent.MOUSE_UP, cornerMouseUpHandler);
			line.addEventListener(MouseEvent.MOUSE_OVER, panelMouseOverHandler);
			line.addEventListener(MouseEvent.MOUSE_DOWN, panelMouseDownHandler);
			line.addEventListener(MouseEvent.MOUSE_OUT, panelMouseOutHandler);
			line.addEventListener(MouseEvent.MOUSE_UP, panelMouseUpHandler);
			return corner;
		}

		public function get changing():Boolean
		{
			return mousedown;
		}

		override public function get x():Number
		{
			return super.x + cornerWidth / 2;
		}

		override public function get y():Number
		{
			return super.y + cornerWidth / 2;
		}

		private function panelMouseMoveHandler(event:MouseEvent):void
		{
			if (mousedown)
			{
				limitedMoveX(sox + (stage.mouseX - ox));
				limitedMoveY(soy + (stage.mouseY - oy));
				_target.x = this.x;
				_target.y = this.y;
				dispatchEvent(new Event("draw"));
			}
			MouseCursor.setPoint(stage.mouseX, stage.mouseY);
			event.updateAfterEvent();
			return;
		}

		private function resetCorner():void
		{
			corners.lt.x = Math.round(line.x - cornerWidth / 2);
			corners.lt.y = Math.round(line.y - cornerWidth / 2);
			corners.t.x = Math.round(line.width / 2);
			corners.t.y = corners.lt.y;
			corners.rt.x = corners.lt.x + line.width;
			corners.rt.y = corners.lt.y;
			corners.r.x = corners.rt.x;
			corners.r.y = Math.round(line.height / 2);
			corners.rb.x = corners.rt.x;
			corners.rb.y = corners.lt.y + line.height;
			corners.b.x = corners.t.x;
			corners.b.y = corners.rb.y;
			corners.lb.x = corners.lt.x;
			corners.lb.y = corners.b.y;
			corners.l.x = corners.lb.x;
			corners.l.y = corners.r.y;
			return;
		}

		private function panelMouseDownHandler(event:MouseEvent):void
		{
			mousedown = true;
			ox = stage.mouseX;
			oy = stage.mouseY;
			sox = super.x;
			soy = super.y;
			stage.addEventListener(MouseEvent.MOUSE_UP, panelMouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, panelMouseMoveHandler);
			return;
		}

		private function limitedResizeWidth(W:Number):Number
		{
			if (W <= minWidth)
			{
				line.width = minWidth;
				_target.width = line.width;
				return minWidth;
			}
			if (W >= maxWidth)
			{
				line.width = maxWidth;
				_target.width = line.width;
				return maxWidth;
			}
			_target.width = W;
			var n:Number = W;
			line.width = W;
			return n;
		}

		public function get target():DisplayObject
		{
			return _target;
		}

		override public function set width(Width:Number):void
		{
			line.width = Width;
			resetCorner();
			return;
		}

		private function resize_b(W:Number, H:Number):void
		{
			var num1:Number = NaN;
			var num2:Number = NaN;
			var num3:Number = NaN;
			if (constraints)
			{
				num1 = ow;
				num2 = Math.round((oh + H) / 2) * 2;
				num1 = Math.round(num2 * ratio);
				if (num2 + soy > bounds.height)
				{
					var n1:Number = bounds.height - soy;
					num2 = bounds.height - soy;
					num1 = n1;
				}
				if (num1 / 2 + (sox + ow / 2) > bounds.width)
				{
					var n2:Number = (bounds.width - (sox + ow / 2)) * 2;
					num1 = (bounds.width - (sox + ow / 2)) * 2;
					num2 = n2;
				}
				if (sox + ow / 2 - num1 / 2 < bounds.x)
				{
					var n3:Number = (sox + ow / 2 + cornerWidth / 2) * 2;
					num1 = (sox + ow / 2 + cornerWidth / 2) * 2;
					num2 = n3;
				}
				num3 = limitedResizeWidth(num1);
				limitedResizeHeight(num2);
				limitedMoveX(sox + (ow - num3) / 2);
				_target.x = this.x;
			}
			else
			{
				limitedResizeHeight(oh + H);
			}
			dispatchEvent(new Event("draw"));
			return;
		}

		private function resize_l(W:Number, H:Number):void
		{
			var num1:Number = NaN;
			var num2:Number = NaN;
			var num3:Number = NaN;
			var num4:Number = NaN;
			if (constraints)
			{
				num3 = Math.round((ow - W) / 2) * 2;
				num4 = oh;
				num4 = Math.round(num3 * ratio);
				if (num3 > sox + ow + cornerWidth / 2)
				{
					var n1:Number = sox + ow + cornerWidth / 2;
					num3 = sox + ow + cornerWidth / 2;
					num4 = n1;
				}
				if (num4 / 2 + (soy + oh / 2) > bounds.height)
				{
					var n2:Number = (bounds.height - (soy + oh / 2)) * 2;
					num4 = (bounds.height - (soy + oh / 2)) * 2;
					num3 = n2;
				}
				if (soy + oh / 2 - num4 / 2 < bounds.y)
				{
					var n3:Number = (soy + oh / 2 + cornerWidth / 2) * 2;
					num4 = (soy + oh / 2 + cornerWidth / 2) * 2;
					num3 = n3;
				}
				num1 = limitedResizeWidth(num3);
				num2 = limitedResizeHeight(num4);
				limitedMoveX(sox + (ow - num1));
				limitedMoveY(soy + (oh - num2) / 2);
				_target.x = this.x;
				_target.y = this.y;
			}
			else
			{
				num1 = limitedResizeWidth(ow - W);
				limitedMoveX(sox + (ow - num1));
				_target.x = this.x;
			}
			dispatchEvent(new Event("draw"));
			return;
		}

		private function cornerMouseOutHandler(event:MouseEvent):void
		{
			if (mousedown)
			{
				return;
			}
			MouseCursor.hide();
			busy = false;
			event.updateAfterEvent();
			return;
		}

		private function resize_r(W:Number, H:Number):void
		{
			var num1:Number = NaN;
			var num2:Number = NaN;
			var num3:Number = NaN;
			if (constraints)
			{
				num1 = Math.round((ow + W) / 2) * 2;
				num2 = oh;
				num2 = Math.round(num1 / ratio);
				if (num1 + sox > bounds.width)
				{
					var n1:Number = bounds.width - sox;
					num1 = bounds.width - sox;
					num2 = n1;
				}
				if (num2 / 2 + (soy + oh / 2) > bounds.height)
				{
					var n2:Number = (bounds.height - (soy + oh / 2)) * 2;
					num2 = (bounds.height - (soy + oh / 2)) * 2;
					num1 = n2;
				}
				if (soy + oh / 2 - num1 / 2 < bounds.y)
				{
					var n3:Number = (soy + oh / 2 + cornerWidth / 2) * 2;
					num2 = (soy + oh / 2 + cornerWidth / 2) * 2;
					num1 = n3;
				}
				limitedResizeWidth(num1);
				num3 = limitedResizeHeight(num2);
				limitedMoveY(soy + (oh - num3) / 2);
				_target.y = this.y;
			}
			else
			{
				limitedResizeWidth(ow + W);
			}
			dispatchEvent(new Event("draw"));
			return;
		}

		private function resize_t(W:Number, H:Number):void
		{
			var num1:Number = 0;
			var num2:Number = 0;
			var num3:Number = 0;
			var num4:Number = 0;
			if (constraints)
			{
				num3 = ow;
				num4 = Math.round((oh - H) / 2) * 2;
				num3 = Math.round(num4 * ratio);
				if (num4 > soy + oh + cornerWidth / 2)
				{
					var n1:Number = soy + oh + cornerWidth / 2;
					num4 = soy + oh + cornerWidth / 2;
					num3 = n1;
				}
				if (num3 / 2 + (sox + ow / 2) > bounds.width)
				{
					var n2:Number = (bounds.width - (sox + ow / 2)) * 2;
					num3 = (bounds.width - (sox + ow / 2)) * 2;
					num4 = n2;
				}
				if (sox + ow / 2 - num3 / 2 < bounds.x)
				{
					var n3:Number = (sox + ow / 2 + cornerWidth / 2) * 2;
					num3 = (sox + ow / 2 + cornerWidth / 2) * 2;
					num4 = n3;
				}
				num1 = limitedResizeWidth(num3);
				num2 = limitedResizeHeight(num4);
				limitedMoveX(sox + (ow - num1) / 2);
				limitedMoveY(soy + (oh - num2));
				_target.x = this.x;
				_target.y = this.y;
			}
			else
			{
				num2 = limitedResizeHeight(oh - H);
				limitedMoveY(soy + (oh - num2));
				_target.y = this.y;
			}
			dispatchEvent(new Event("draw"));
			return;
		}

		private function resize_rt(W:Number, H:Number):void
		{
			var num1:Number = NaN;
			var num2:Number = NaN;
			var num3:Number = NaN;
			num1 = ow + W;
			num2 = oh - H;
			if (constraints)
			{
				if (Math.min(num1,num2) == num1)
				{
					num2 = Math.round(num1 / ratio);
				}
				else
				{
					num1 = Math.round(num2 * ratio);
				}
				if (num2 > soy + oh + cornerWidth / 2)
				{
					var n1:Number = soy + oh + cornerWidth / 2;
					num2 = soy + oh + cornerWidth / 2;
					num1 = n1;
				}
				if (num1 + this.x - cornerWidth / 2 > bounds.width)
				{
					var n2:Number = bounds.width - this.x + cornerWidth / 2;
					num1 = bounds.width - this.x + cornerWidth / 2;
					num2 = n2;
				}
			}
			limitedResizeWidth(num1);
			num3 = limitedResizeHeight(num2);
			limitedMoveY(soy + (oh - num3));
			_target.y = this.y;
			dispatchEvent(new Event("draw"));
			return;
		}

		public function set selectBounds(rectangle:Rectangle):void
		{
			bounds.x = rectangle.x - cornerWidth / 2;
			bounds.y = rectangle.y - cornerWidth / 2;
			bounds.width = rectangle.width - (cornerWidth / 2);
			bounds.height = rectangle.height - (cornerWidth / 2);
			return;
		}

		private function resize_rb(W:Number, H:Number):void
		{
			var num1:Number = NaN;
			var num2:Number = NaN;
			num1 = ow + W;
			num2 = oh + H;
			if (constraints)
			{
				if (Math.min(num1,num2) == num1)
				{
					num2 = Math.round(num1 / ratio);
				}
				else
				{
					num1 = Math.round(num2 * ratio);
				}
				if (num1 + this.x - cornerWidth / 2 > bounds.width)
				{
					var n1:Number = bounds.width - this.x + cornerWidth / 2;
					num1 = bounds.width - this.x + cornerWidth / 2;
					num2 = n1;
				}
				if (num2 + this.y - cornerWidth / 2 > bounds.height)
				{
					var n2:Number = bounds.height - this.y + cornerWidth / 2;
					num2 = bounds.height - this.y + cornerWidth / 2;
					num1 = n2;
				}
			}
			limitedResizeWidth(num1);
			limitedResizeHeight(num2);
			dispatchEvent(new Event("draw"));
			return;
		}

		private function limitedResizeHeight(num:Number):Number
		{
			if (num <= minHeight)
			{
				line.height = minHeight;
				_target.height = line.height;
				return minHeight;
			}
			if (num >= maxHeight)
			{
				line.height = maxHeight;
				_target.height = line.height;
				return maxHeight;
			}
			_target.height = num;
			var H:Number = num;
			line.height = num;
			return H;
		}

		override public function get width():Number
		{
			return line.width;
		}

		private function cornerMouseUpHandler(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, cornerMouseUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			mousedown = false;
			if (! corners[event.target.name] || ! corners[event.target.name].hitTestPoint(stage.mouseX,stage.mouseY))
			{
				cornerMouseOutHandler(event);
			}
			this.dispatchEvent(new Event(Event.CHANGE));
			return;
		}

		private function resize_lb(W:Number, H:Number):void
		{
			var num:Number = NaN;
			var num1:Number = NaN;
			var num2:Number = NaN;
			num = ow - W;
			num1 = oh + H;
			if (constraints)
			{
				if (Math.min(num,num1) == num)
				{
					num1 = Math.round(num / ratio);
				}
				else
				{
					num = Math.round(num1 * ratio);
				}
				if (num > sox + ow + cornerWidth / 2)
				{
					var num3:* = sox + ow + cornerWidth / 2;
					num = sox + ow + cornerWidth / 2;
					num1 = num3;
				}
				if (num1 + this.y - cornerWidth / 2 > bounds.height)
				{
					var num4:* = bounds.height - this.y + cornerWidth / 2;
					num1 = bounds.height - this.y + cornerWidth / 2;
					num = num4;
				}
			}
			num2 = limitedResizeWidth(num);
			limitedResizeHeight(num1);
			limitedMoveX(sox + (ow - num2));
			_target.x = this.x;
			dispatchEvent(new Event("draw"));
			return;
		}

		override public function set x(num:Number):void
		{
			super.x = num - cornerWidth / 2;
			return;
		}

		override public function set y(num:Number):void
		{
			super.y = num - cornerWidth / 2;
			return;
		}

		private function cornerMouseDownHandler(event:MouseEvent):void
		{
			mousedown = true;
			ox = stage.mouseX;
			oy = stage.mouseY;
			ow = line.width;
			oh = line.height;
			sox = super.x;
			soy = super.y;
			rox = event.target.mouseX;
			roy = event.target.mouseY;
			this.setChildIndex(event.target as DisplayObject, (this.numChildren - 1));
			currDir = event.target.name;
			stage.addEventListener(MouseEvent.MOUSE_UP, cornerMouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			return;
		}

		private function panelMouseOutHandler(event:MouseEvent):void
		{
			if (mousedown)
			{
				return;
			}
			MouseCursor.hide();
			busy = false;
			return;
		}

	}
}