package
{
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class GameMathUtil
	{
		/**某弧度转成角度, 比如 60度 乘以这个值, 得到60度对应的弧度**/
		public static const RADIANS_TO_ANGLE:Number = 180/Math.PI;
		
		/**某角度转成弧度, 比如 60度 乘以这个值, 得到60度对应的弧度**/
		public static const ANGLE_TO_RADIANS:Number = Math.PI/180;
		
		/**某点是否在给点矢量的右边**/
		public static function pointAtLineRight(lineStartPoint:Object,lineEndPoint:Object,thePoint:Object):Boolean{
			var y1:int = lineStartPoint.y;
			var x1:int = lineStartPoint.x;
			var x2:int = lineEndPoint.x;
			var y2:int = lineEndPoint.y;
			var x:int = thePoint.x;
			var y:int = thePoint.y;
			var n:Number = (y1-y2)*x+(x2-x1)*y+x1*y2-x2*y1;
			return n<0;//小于零, 则点在线的右边
		}
		public static function dot(v1:Point,v2:Point):Number{   
			return v1.x * v2.x + v1.y * v2.y;
		}
		
		/**旋转给定矢量**/
		public static function rot(p:Point,angle:Number):Point{   
			return new Point(p.x * Math.cos(angle) - p.y * Math.sin(angle), p.x * Math.sin(angle) + p.y * Math.cos(angle));
		}
		
		public static function getAngle2D(p:Point):Number{
			return Math.atan2(p.y,p.x);
		}
		public static function getAngle3D(p:Vector3D):Number{
			return Math.atan2(p.z,p.x);
		}
		
		public static function getRotation2D(p1:Point, p2:Point):Number{
			var deltaY:Number  = p2.y - p1.y;
			var deltaX:Number  = p2.x - p1.x;
			var angle:Number = Math.atan2(deltaY, deltaX);
			
			return angle;
		}
		public static function getRotationWithCenter2D(p1:Point,p2:Point,center:Point):Number 
		{ 
			var dx1:Number = p1.x - center.x;
			var dy1:Number = p1.y - center.y;
			var dx2:Number = p2.x - center.x;
			var dy2:Number = p2.y - center.y;
			var c:Number = Math.sqrt(dx1 * dx1 + dy1 * dy1) * Math.sqrt(dx2 * dx2 + dy2 * dy2); 
			if (c == 0) return -1;
			var angle:Number = Math.acos((dx1 * dx2 + dy1 * dy2) / c); 
			return angle*MathConsts.RADIANS_TO_DEGREES;
		} 
		

		public static var tmp1:Vector3D = new Vector3D;
		public static var tmp2:Vector3D = new Vector3D;
		public static function getRotationWithCenter3D(p1:Vector3D, p2:Vector3D, center:Vector3D):Number{
			var dx1:Number = p1.x - center.x;
			var dy1:Number = p1.z - center.z;
			var dx2:Number = p2.x - center.x;
			var dy2:Number = p2.z - center.z;
			var c:Number = Math.sqrt(dx1 * dx1 + dy1 * dy1) * Math.sqrt(dx2 * dx2 + dy2 * dy2); 
			if (c == 0) return -1;
			var angle:Number = Math.acos((dx1 * dx2 + dy1 * dy2) / c);
			if(isNaN(angle)) return 0;
			return angle*MathConsts.RADIANS_TO_DEGREES;
		}
		
		public static function reverse(p:Point):Point{
			var p2:Point = p.clone();
			p2.x=-p2.x;
			p2.y=-p2.y;
			return p2;
		}
		/**逆时针转90度**/
		public static function rot_90_counterclockwise(p:Point):Point{
			var tmp:Number = p.x;
			p.x = -p.y;
			p.y = tmp;
			return p;
		}
		/**顺时针转90度**/
		public static function rot_90_clockwise(p:Point):Point{
			var tmp:Number = p.x;
			p.x = p.y;
			p.y = -tmp;
			return p;
		}
		/**转180度**/
		public static function rot_180(p:Point):Point{
			p.x = -p.x;
			p.y = -p.y;
			return p;
		}
	}
}