package gl.fm.view {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	/**
	 * 飞屏背景
	 * @author gaolei
	 *
	 */
	public class FlyItemBackground extends Sprite {
		public function FlyItemBackground() {
			super();
		}

		private var bg_l:Bitmap;
		private var bg_c:Bitmap;
		private var bg_r:Bitmap;

		public function init(bmd_l:BitmapData, bmd_c:BitmapData, bmd_r:BitmapData):void {
			dispose();
			if (bg_l == null) {
				bg_l = new Bitmap(bmd_l, PixelSnapping.ALWAYS, true);
			} else {
				bg_l.bitmapData = bmd_l;
				bg_l.width = bmd_l.width;
			}
			this.addChild(bg_l);

			if (bg_c == null) {
				bg_c = new Bitmap(bmd_c, PixelSnapping.ALWAYS, true);
			} else {
				bg_c.bitmapData = bmd_c;
				bg_c.width = bmd_c.width;
			}
			if (bmd_c.width >= 4 && bmd_c.height >= 4) {
				bg_c.scale9Grid = new Rectangle(1, 1, bmd_c.width - 2, bmd_c.height - 2);
			}
			bg_c.x = int(bg_l.width);
			this.addChild(bg_c);

			if (bg_r == null) {
				bg_r = new Bitmap(bmd_r, PixelSnapping.ALWAYS, true);
			} else {
				bg_r.bitmapData = bmd_r;
				bg_r.width = bmd_r.width;
			}
			bg_r.x = int(bg_c.x + bg_c.width);
			this.addChildAt(bg_r, 0);
		}

		public function setWidth(width:int):void {
			bg_l.scaleX = 1;
			bg_c.scaleX = 1;
			bg_r.scaleX = 1;

			var lw:int = bg_l.width;
			var rw:int = bg_r.width;
			var cw:int = width - lw - rw;

			if (cw <= 0) {
				cw = 4;
			}
			bg_c.width = cw + 2;

			bg_l.x = 0;
			bg_c.x = lw - 1;
			bg_r.x = lw + cw;
		}

		public function getWidth():int {
			if (bg_r != null) {
				return int(bg_r.x + bg_r.width);
			} else {
				return 0;
			}
		}

		public function dispose():void {
			if (bg_l != null) {
				if (bg_l.parent != null) {
					bg_l.parent.removeChild(bg_l);
				}
				bg_l.bitmapData = null;
				bg_l.scaleX = 1;
			}
			if (bg_c != null) {
				if (bg_c.parent != null) {
					bg_c.parent.removeChild(bg_c);
				}
				bg_c.scaleX = 1;
				bg_c.bitmapData = null;
			}
			if (bg_r != null) {
				if (bg_r.parent != null) {
					bg_r.parent.removeChild(bg_r);
				}
				bg_r.scaleX = 1;
				bg_r.bitmapData = null;
			}
		}
	}
}
