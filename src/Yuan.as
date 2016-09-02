package
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Yuan extends Sprite
	{
		public static var container:Sprite;
		private var w:uint;
		public var color:uint;
		public function Yuan(xx,yy,color:uint=0x990000,w:uint=5)
		{
			super();
			this.color = color;
			this.w = w;
			var g:Graphics = graphics;
			g.beginFill(color,1);
			g.drawCircle(0,0,w);
			g.endFill();
			x = xx;
			y = yy;
			container.addChild(this);
			buttonMode = true;
		}
		public function get pos():Point
		{
			return new Point(x,y);
		}
		
		public function change(color:uint,w:uint):void
		{
			this.w = w;
			this.color = color;
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(color,1);
			g.drawCircle(0,0,w);
			g.endFill();
		}
	}
}