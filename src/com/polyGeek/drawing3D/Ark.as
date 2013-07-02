package com.polyGeek.drawing3D {
	import away3d.core.base.Face;
	
	import flash.geom.Vector3D;
	
	
	public class Ark extends Face {
		
		private var _degrees			: int;
		private var _radius				: int;
		private var _startAngle			: int;
		private var _face				: Face;

		private var _startPoint			: Vector3D;
		private var _endPoint			: Vector3D;
		private var _lineFromV3D		: Vector3D;
		
		public function Ark( degrees:int, radius:int, startAngle:int, lineFromV3D:Vector3D=null ) {
			_degrees 		= ( degrees == 0 ) ? 1 : degrees; // cannot be zero
			_radius			= radius;
			_startAngle		= startAngle;
			_lineFromV3D 	= lineFromV3D;
			
			drawArc();
		}
		
		private function drawArc():void {
			// set vars
			var theta		: Number;
			var angleMid	: Number;
			var segs		: Number;
			var ax			: Number;
			var ay			: Number;
			var bx			: Number;
			var by			: Number
			var cx			: Number;
			var cy			: Number;
			
			// Flash uses 8 segments per circle, to match that, we draw in a maximum
			// of 45 degree segments. First we calculate how many segments are needed
			// for our arc.
			segs = Math.ceil( Math.abs( _degrees ) / 45 );
			
			// Now calculate the sweep of each segment.
			var segAngle:Number = _degrees / segs;
			
			// The math requires radians rather than degrees. To convert from degrees
			// use the formula (degrees/180)*Math.PI to get radians.
			theta = -( segAngle / 180 ) * Math.PI;
			
			// convert angle startAngle to radians
			var angle:Number = -( _startAngle / 180 ) * Math.PI;
			
			// draw the curve in segments no larger than 45 degrees.
			if ( segs > 0 ) {
				// draw a line from the center to the start of the curve
				ax = Math.cos( _startAngle / 180 * Math.PI ) * _radius;
				ay = Math.sin( -_startAngle / 180 * Math.PI ) * _radius;
				
				if( _lineFromV3D != null ) {
					this.moveTo( _lineFromV3D.x, _lineFromV3D.y, _lineFromV3D.z );
					this.lineTo( ax, ay, 0 );
				} else {
					this.moveTo( ax, ay, 0 );
				}
				
				_startPoint = new Vector3D( ax, ay, 0 );
				
				// Loop for drawing curve segments
				for( var i:int = 0; i < segs; i++ ) {
					angle 		+= theta;
					angleMid 	= angle - ( theta / 2 );
					bx 			= Math.cos( angle ) * _radius;
					by 			= Math.sin( angle ) * _radius;
					cx 			= Math.cos( angleMid ) * ( _radius / Math.cos( theta / 2 ) );
					cy 			= Math.sin( angleMid ) * ( _radius / Math.cos( theta / 2 ) );
					this.curveTo( cx, cy, 0, bx, by, 0 );
				}
				_endPoint = new Vector3D( bx, by, 0 );
			}
		}

		public function get startPoint():Vector3D { return _startPoint; }
		public function get endPoint():Vector3D { return _endPoint; }
		
	}
}