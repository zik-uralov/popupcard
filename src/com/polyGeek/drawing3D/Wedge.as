package com.polyGeek.drawing3D {
	import away3d.core.base.Face;
	import away3d.core.base.Mesh;
	import away3d.materials.Material;
	import away3d.materials.WireframeMaterial;
	
	
	public class Wedge extends Mesh {
		
		private var _radiusOuter			: int;
		private var _radiusInner			: int;
		private var _degrees				: int;
		private var _startAngle				: int;
		
		private var _material				: Material;
		private var _face					: Face;
		
		public function Wedge( 	radiusOuter:int=200, 
								radiusInner:int=175, 
								degrees:int=45, 
								startAngle:int=0,
								material:Material=null ) {
			
			_radiusOuter 		= radiusOuter;
			_radiusInner		= radiusInner;
			_startAngle			= startAngle
			_degrees 			= ( degrees == 0 ) ? 1 : degrees;
			
			if( material == null ) {
				_material = new WireframeMaterial( 0xFFFFFF * Math.random() );
			} else {
				_material = material;
			}
			
			this.bothsides = true;
			this.material = _material;
			
			
			/*var mat : WireColorMaterial = new WireColorMaterial();
			mat.wireColor = 0x0000CC;
			mat.wireAlpha = 0.5;
			mat.color = 0x000066;
			mat.alpha = 0.9;
			
			
			var sphere : Sphere = new Sphere();
			sphere.radius = 190;
			sphere.segmentsH = 15;
			sphere.segmentsW = 25;
			sphere.material = mat;
			this.addChild( sphere );
			*/
			draw();
		}
		
		private function draw():void {
			
			this.removeFace( _face );
			_face = new Face();
			this.addFace( _face );
			
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
			
			// OUTER RADIUS
			// draw the curve in segments no larger than 45 degrees.
			
			if ( segs > 0 ) {
				ax = Math.cos( _startAngle / 180 * Math.PI ) * _radiusOuter;
				ay = Math.sin( -_startAngle / 180 * Math.PI ) * _radiusOuter;
				
				_face.moveTo( ax, ay, 0 );
				
				// Loop for drawing curve segments
				for( var i1:int = 0; i1 < segs; i1++ ) {
					angle 		+= theta;
					angleMid 	= angle - ( theta / 2 );
					bx 			= Math.cos( angle ) * _radiusOuter;
					by 			= Math.sin( angle ) * _radiusOuter;
					cx 			= Math.cos( angleMid ) * ( _radiusOuter / Math.cos( theta / 2 ) );
					cy 			= Math.sin( angleMid ) * ( _radiusOuter / Math.cos( theta / 2 ) );
					_face.curveTo( cx, cy, 0, bx, by, 0 );
				}
				
			
				// INNER RADIUS
				angle = -( ( _startAngle + degrees ) / 180 ) * Math.PI;
				ax = Math.cos( ( _startAngle + degrees ) / 180 * Math.PI ) * _radiusInner;
				ay = Math.sin( -( _startAngle + degrees ) / 180 * Math.PI ) * _radiusInner;
				
				// Loop for drawing curve segments
				for( var i2:int = segs - 1; i2 >= 0; i2-- ) {
					angle 		-= theta;
					angleMid 	= angle + ( theta / 2 );
					bx 			= Math.cos( angle ) * _radiusInner;
					by 			= Math.sin( angle ) * _radiusInner;
					cx 			= Math.cos( angleMid ) * ( _radiusInner / Math.cos( theta / 2 ) );
					cy 			= Math.sin( angleMid ) * ( _radiusInner / Math.cos( theta / 2 ) );
					
					if( i2 == segs - 1 ) {
						_face.lineTo( ax, ay, 0 );
					}
					
					_face.curveTo( cx, cy, 0, bx, by, 0 );
				}
			}
		}
		
		
		public function set radiusOuter( value:int ):void {
			if( _radiusOuter == value ) {
				return;
			}
			_radiusOuter = value;
			draw();
		}


		public function set radiusInner( value:int ):void {
			if( _radiusInner == value ) {
				return;
			}
			_radiusInner = value;
			draw();
		}


		public function set degrees( value:int ):void {
			if( _degrees == value ) {
				return;
			}
			
			_degrees = ( value == 0 ) ? 1 : value;
			draw();
		}

		public function set startAngle( value:int ):void {
			if( _startAngle == value ) {
				return;
			}
			_startAngle = value;
			draw();
		}

		public function get radiusOuter()		: int { return _radiusOuter; }
		public function get radiusInner()		: int { return _radiusInner; }
		public function get degrees()			: int { return _degrees; }
		public function get startAngle()		: int { return _startAngle; }
	}
}