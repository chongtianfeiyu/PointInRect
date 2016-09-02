package
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.ui.Mouse;

	[SWF(width="999",height="666")]
	public class PointInRect extends Sprite
	{
		private var offx:int = 44;
		private var offy:int = 33;
		public function PointInRect()
		{
			//坐标系
			root = new Sprite();
			Yuan.container = root;
			addChild(root);
			root.x = d*2;
			root.y = d*2;
			var g:Graphics = root.graphics;
			g.lineStyle(0.5);
			g.moveTo(-d*9,0);
			g.lineTo(d*9,0);
			g.moveTo(0,-d*9);
			g.lineTo(0,d*9);
			
			//隐藏鼠标
			Mouse.hide();
			
			//圆
			yuan = new Yuan(0,0);
			yuan.change(0x009900,3);
			
			//矩形
			w = 100;
			h = 50;
			p1 = new Point(0,h*-0.5);
			p2 = new Point(w,h*-0.5);
			p3 = new Point(w,h*0.5);
			p4 = new Point(0,h*0.5);
			
			//旋转
			var du:Number = 210*MathConsts.DEGREES_TO_RADIANS;
			
			p1 = GameMathUtil.rot(p1,du);
			p2 = GameMathUtil.rot(p2,du);
			p3 = GameMathUtil.rot(p3,du);
			p4 = GameMathUtil.rot(p4,du);
			
			offset(p1,offx,offy);
			offset(p2,offx,offy);
			offset(p3,offx,offy);
			offset(p4,offx,offy);
			
			//求中心线段
			m1 = Point.interpolate(p1,p4,0.5);
			m2 = Point.interpolate(p2,p3,0.5);
			n1 = Point.interpolate(p1,p2,0.5);
			n2 = Point.interpolate(p4,p3,0.5);
			
			//绘画中心线段的端点
			new Yuan(m1.x,m1.y,0x990000,3);
			new Yuan(m2.x,m2.y,0x990000,3);
//			new Yuan(n1.x,n1.y,0x000055,3);
//			new Yuan(n2.x,n2.y,0x000055,3);
			
			rect = new Sprite();
			var g2:Graphics = rect.graphics;
			g2.lineStyle(0.5,0,0.3);
			g2.beginFill(0xff0000,0.1);
			g2.moveTo(p1.x,p1.y);
			g2.lineTo(p2.x,p2.y);
			g2.lineTo(p3.x,p3.y);
			g2.lineTo(p4.x,p4.y);
			g2.endFill();
			root.addChild(rect);
			
			//事件
			addEventListener(Event.ENTER_FRAME,tick);
		}
		
		private function offset(p1:Point, xx:int, yy:int):void
		{
			p1.x += xx;
			p1.y += yy;
		}
		
		private var d:int = 100;
		private var m1:Point;
		private var m2:Point;
		private var n1:Point;
		private var n2:Point;
		private var p1:Point;
		private var p2:Point;
		private var p3:Point;
		private var p4:Point;
		private var rect:Sprite;
		private var root:Sprite;
		private var xy:Point = new Point;
		private var yuan:Yuan;

		private var w:int;

		private var h:int;

		protected function tick(e:Event):void
		{
			//定位圆
			if(!stage)return;
			xy.x = stage.mouseX;
			xy.y = stage.mouseY;
			var local:Point = root.globalToLocal(xy);
			yuan.x = local.x;
			yuan.y = local.y;
			
			var inSide:Boolean = pointInRect(w,h,210,offx,offy,yuan.pos);
			if(inSide){
				if(yuan.color!=0x990000){
					yuan.change(0x990000,6);
				}
			}else{
				if(yuan.color!=0x009900){
					yuan.change(0x009900,3);
				}
			}
		}
		private function pointInRect(w:int, h:int, angle:Number, myX:int, myY:int, targetPos:Point):Boolean
		{
			p1 = new Point(0,h*-0.5);
			p2 = new Point(w,h*-0.5);
			p3 = new Point(w,h*0.5);
			p4 = new Point(0,h*0.5);
			//旋转
			var du:Number = angle*MathConsts.DEGREES_TO_RADIANS;
			
			p1 = GameMathUtil.rot(p1,du);
			p2 = GameMathUtil.rot(p2,du);
			p3 = GameMathUtil.rot(p3,du);
			p4 = GameMathUtil.rot(p4,du);
			
			offset(p1,myX,myY);
			offset(p2,myX,myY);
			offset(p3,myX,myY);
			offset(p4,myX,myY);
			
			//求中心线段
			m1 = Point.interpolate(p1,p4,0.5);
			m2 = Point.interpolate(p2,p3,0.5);
			n1 = Point.interpolate(p1,p2,0.5);
			n2 = Point.interpolate(p4,p3,0.5);
			
			//判断点是否在矩形内
			var d1:Number = point2Line(targetPos,m1,m2);
			var d2:Number = point2Line(targetPos,n1,n2);
			if(d2<w*0.5 && d1<h*0.5){
				return true;
			}
			return false;
		}
		/**
		 * 点到直接线的距离
		 * @param p1	线外的点
		 * @param lp1	线的起点
		 * @param lp2	线的终点
		 */
		public static function point2Line(p1:Point, lp1:Point, lp2:Point):Number
		{
			var a:Number, b:Number, c:Number;
			a = lp2.y - lp1.y;
			b = lp1.x - lp2.x;
			c = lp2.x * lp1.y - lp1.x * lp2.y;
			var d:Number = Math.abs(a * p1.x + b * p1.y + c) / Math.sqrt(a * a + b * b);
			return d;
		};
	}
}