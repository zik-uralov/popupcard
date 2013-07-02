package 
{
	import away3d.animators.VertexAnimator;
	import away3d.cameras.HoverCamera3D;
	import away3d.core.base.Face;
	import away3d.core.base.Mesh;
	import away3d.core.base.Segment;
	import away3d.core.base.UV;
	import away3d.core.base.Vertex;
	import away3d.core.vos.SegmentVO;
	import away3d.loaders.data.GeometryData;
	import away3d.materials.ColorMaterial;
	import away3d.materials.WireColorMaterial;
	import away3d.materials.WireframeMaterial;
	import away3d.primitives.Cube;
	import away3d.primitives.CurveLineSegment;
	import away3d.primitives.LineSegment;
	import away3d.primitives.TextField3D;
	import com.bit101.components.HSlider;
	import com.bit101.components.HUISlider;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import flash.display.Bitmap;
	import away3d.core.utils.Cast;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.MovieMaterial;
	import away3d.primitives.Plane;
	import away3d.primitives.Torus;
	import away3d.events.MouseEvent3D;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
    import flash.geom.Point;
	import away3d.containers.ObjectContainer3D;
	import flash.geom.Vector3D;
	import away3d.core.render.Renderer;
	import away3d.primitives.Trident;
	import flash.display.Stage;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
	import flash.geom.Matrix3D;
	import flash.geom.Utils3D;
	import flash.utils.ByteArray;
	import wumedia.vector.VectorText;
	import away3d.extrusions.TextExtrusion;
	import com.polyGeek.drawing3D.Wedge;
	[SWF(width = '800', height = '500', frameRate = '60', backgroundColor = '#ffffff')] 
	
	public class popUPmain extends AwayTemplate
	{  
		[Embed(source = 'assets/vsyotv.png')]
		protected var VSYOtv:Class;
		[Embed(source = 'assets/12344.png')]
	    protected var PerAspera:Class;
		[Embed(source = 'assets/cover.png')]
		protected var image_sunset:Class;
		 [Embed(source = '../lib/Fonts.swf', mimeType = 'application/octet-stream')]
		 protected var Fonts:Class;
		[Embed(source = "assets/PuzzleTile.png")] 
		protected var Skyup:Class;
		public var hero_mc:MovieClip=new Hero();
		public var leftArrow:LeftArrow = new LeftArrow();
		public var rightArrow:RightArrow = new RightArrow();
		public var MySlider:HUISlider = new HUISlider(stage, 30, 20, "ANIMATE", SliderChange);
		public var MySliderX:HUISlider = new HUISlider(stage, 30, 100, "X", SliderChangePos);
		public var MySliderY:HUISlider = new HUISlider(stage, 30, 120, "Y", SliderChangePos);
		public var MySliderZ:HUISlider = new HUISlider(stage, 30, 140, "Z", SliderChangePos);
		public var MySliderRotX:HUISlider = new HUISlider(stage, 30, 190, "Rot X", SliderChangeRotation);
		public var MySliderRotY:HUISlider = new HUISlider(stage, 30, 210, "Rot Y", SliderChangeRotation);
		public var MySliderRotZ:HUISlider = new HUISlider(stage, 30, 230, "Rot Z", SliderChangeRotation);
		public var Open90:RadioButton = new RadioButton(stage, 30, 40, "ANGLE 90", true, AngleMode90);
		public var Open180:RadioButton = new RadioButton(stage, 100, 40, "ANGLE 180", true, AngleMode180);
		public var MyCube:Cube = new Cube();
		private var newJpgMat:BitmapMaterial;
		private var newJpgMat2:BitmapMaterial;
		private var PerAspera01:BitmapMaterial;
		private var VSYOtv01:BitmapMaterial;
	    private	var face:MovieClip;
		public var plane1:Plane;
		public var plane2:Plane;
		public var plane3:Plane;
		private var _movieMat1:MovieMaterial;
		private var _mouseDownPoint : Point;
		protected var container:ObjectContainer3D;
		 private var _spriteX:Number;
        private var _spriteY:Number;
		private var _screenVertex:Vector3D;
		//public var VSYOtxt:TextField3D;
		public var extrusion:TextExtrusion;
		public var font:ByteArray;
		public var faceMaterial:WireColorMaterial;
		public var AddPlane:PushButton;
		public var planeToAdd:Plane;
		public var FaceMe:Face;
		public var x3:Number;
		public var l:Number;
		public var d:Number;
		public var j:Number;
		public var k:Number;
		public var y2:Number;
		public function popUPmain()
		{
			super();
		}
		override protected function initMaterials() : void {
			_movieMat1 = new MovieMaterial(new Hero());
			newJpgMat = new BitmapMaterial(Cast.bitmap(image_sunset));
			newJpgMat2 = new BitmapMaterial(Cast.bitmap(Skyup));
			PerAspera01 = new BitmapMaterial(Cast.bitmap(PerAspera));
			VSYOtv01 = new BitmapMaterial(Cast.bitmap(VSYOtv));
		}
		override protected function initGeometry() : void {
			
			plane1 = new Plane( { width:150, height:100,z:0, yUp:false, material:newJpgMat2,back:newJpgMat } );
			plane2 = new Plane( { width:150, height:100, z:0, yUp:false, material:newJpgMat2 } );
			plane3 = new Plane( { width:50, height:45,x:25,y:12, z:0, yUp:false,bothsides:false,material:_movieMat1 } );
			plane1.bothsides = true;
			plane2.bothsides = true;
			plane1.pivotPoint = new Vector3D(0, -50, 0);
			plane2.pivotPoint = new Vector3D(0, -50, 0);
			plane3.pivotPoint = new Vector3D(0, -50, 0);
			planeToAdd = new Plane( { width:60, height:80, z:0, x:30-Number(plane2.width/2),rotationZ:-45, y:45, yUp:false, material:PerAspera01, bothsides:true, back:newJpgMat} );
		    planeToAdd.pivotPoint = new Vector3D(0, -40, 0);
					//ls1.filters = filters;
                    
			container = new ObjectContainer3D(
				plane1, plane2, plane3,planeToAdd,
				{
			    rotationX:90
				}
			);
			container.ownCanvas = false;
			//plane1.rotationX = -100;
            
			
			_view.scene.addChild(container);
			_view.renderer = Renderer.INTERSECTING_OBJECTS;
			
			
			
			}

		override protected function onEnterFrame(e:Event) : void{
			super.onEnterFrame(e);
            if (plane1.rotationX>-2) {
				
				plane2.visible = false;
			}else{
				
				plane2.visible = true;
			}
		//MySliderX.value= planeToAdd.x;
	    MySliderY.value  = planeToAdd.y;
		//MySliderZ.value = planeToAdd.z;
		//MySliderRotX.value = Number(planeToAdd.rotationX);
		//MySliderRotY.value = Number(planeToAdd.rotationY);
		//MySliderRotZ.value =Number(planeToAdd.rotationZ);
		//MySlider.value = Number(MySliderRotX.value);
		MySliderRotX.value = Number(MySlider.value);
		
		}
			override protected function initUI() : void {
			leftArrow.x = 35;
			leftArrow.y = 70;
			addChild(leftArrow);
			rightArrow.x = 90;
			rightArrow.y = 70;
			MySlider.minimum = 0;
			MySlider.maximum = 180;
			MySlider.labelPrecision = 0;
			MySliderX.minimum = 0;
			MySliderX.maximum = 180;
			MySliderX.labelPrecision = 0;
			MySliderY.minimum = 0;
			MySliderY.maximum = 180;
			MySliderY.labelPrecision = 0;
			MySliderZ.minimum = 0;
			MySliderZ.maximum = 180;
			MySliderZ.labelPrecision = 0;
			MySliderRotX.minimum = 0;
			MySliderRotX.maximum = 180;
			MySliderRotX.labelPrecision = 0;
			MySliderRotY.minimum = 0;
			MySliderRotY.maximum = 180;
			MySliderRotY.labelPrecision = 0;
			MySliderRotZ.minimum = -45;
			MySliderRotZ.maximum =0;
			MySliderRotZ.labelPrecision = 45;

			AddPlane = new PushButton(stage, 30, 160, "ADD PLANE", AddNewPlane);
			addChild(rightArrow);

		}
		override protected function initListeners():void {
			leftArrow.addEventListener(MouseEvent.MOUSE_DOWN, LeftButtonActive); 
			rightArrow.addEventListener(MouseEvent.MOUSE_DOWN, RightButtonActive); 
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			plane3.addEventListener(MouseEvent3D.MOUSE_DOWN, getToStage);
		}
        private function getToStage(e:MouseEvent3D):void {
			stage.addChild(hero_mc);
			hero_mc.x = 400;
/*			plane3.filters = [new GlowFilter(0x000000, 0.4, 15, 15, 2, 1, false, false)];
			plane3.ownCanvas = true;
			plane1.ownCanvas = true;
			plane2.ownCanvas = true;
			*/
		}
		private function LeftButtonActive(e:Event):void {

            TweenLite.to(plane1, 2, { rotationX:0} );
			TweenLite.to(plane2, 2, { rotationX:0} );
			TweenLite.to(plane3, 2, { rotationX:0} );
			TweenLite.to(planeToAdd, 2, { rotationX:0} );
			//TweenLite.to(VSYOtxt, 1, { rotationX: 0, y:0, z:0, ease:Bounce.easeOut} );

			
		}
		private function RightButtonActive(e:MouseEvent):void {
        trace(planeToAdd.x, planeToAdd.y, planeToAdd.z);
        trace("RotationY"+planeToAdd.rotationY,"RotationZ"+planeToAdd.rotationZ);
			
        //TweenLite.to(plane1, 1, { rotationX:90, ease:Bounce.easeOut } );
		TweenLite.to(_cam, 1, {x:40,y:189,z:-300});
		//_cam.lookAt(new Vector3D(100,100,100));
		//trace(_cam.x,_cam.y,_cam.z);
		//_cam.pivotPoint = new Vector3D(0,0,0);
		//TweenLite.to(_cam, 1, {x:100,y:90,z:50, ease:Bounce.easeIn});
			//TweenLite.to(plane1 , 1, { rotationX:90, ease:Bounce.easeOut } );
			TweenLite.to(plane1, 2, { rotationX: -90 } );
			//TweenLite.to(plane2, 2, { rotationX:-90} );
			TweenLite.to(plane3, 2, { rotationX:-90} );
			TweenLite.to(planeToAdd, 2, { rotationX:-90} );
			//TweenLite.to(VSYOtxt, 1, { rotationX: -90, y:30, z:45, ease:Bounce.easeOut } );
			//TweenLite.to(VSYOtxt, 1, {y:30, ease:Bounce.easeOut } );
			//TweenLite.to(VSYOtxt, 1, { z:10, ease:Bounce.easeOut } );
			//TweenLite.to(_cam, 1, {x:100,y:100,z:100});
			var l:Number = (planeToAdd.width / 2) / Math.tan(-45* Math.PI/180);
			var d:Number =l/ Math.cos( -45* Math.PI/180);
			var j:Number = plane2.height - planeToAdd.y ;
			var k:Number = d*Math.tan(-45* Math.PI/180)*Math.sin(-45* Math.PI/180);
			//var x3:Number = planeToAdd.y +l +k;
			trace("var k:Number:" + k);
			trace("var l:Number:" + l);
			trace("var d:Number:" + d);
			trace("var j:Number:"+j);
			     x3 = d * Math.tan(-45)* Math.PI/180;
				y2 =k-l;
				trace("x3:" + x3);
				trace("y2:"+y2);
				FaceMe = new Face(
				new Vertex(x3, planeToAdd.vertices[2].y, 0), 
				new Vertex( planeToAdd.vertices[2].x,  y2, 0), 
				new Vertex(planeToAdd.vertices[2].x,planeToAdd.vertices[2].y, 0), 
				newJpgMat, new UV(0, 0), 
				new UV(300, 0), new UV(300, 225));
				
				trace("planeToAdd.vertices[2].y:" + planeToAdd.vertices[3].y);
				trace("planeToAdd.vertices[2].x:" + planeToAdd.vertices[3].x);
				trace("planeToAdd.vertices[2].z:"+planeToAdd.vertices[2].z);
			
				planeToAdd.addFace(FaceMe);
			   
		
        }
		
			private function onMouseDown( e:MouseEvent ):void {
                //msg.visible = false;
                _mouseDownPoint = new Point( e.stageX, e.stageY );
                addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
                stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
				
            }
            
            private function onMouseMove( e:MouseEvent ):void {
                //_cam.panAngle -= ( _mouseDownPoint.x - e.stageX ) / 4;
               // _view.scene.rotationX += ( _mouseDownPoint.y - e.stageY ) / 2;
				_view.scene.rotationY += ( _mouseDownPoint.x - e.stageX ) / 1;
				//_view.scene.rotationY += ( _mouseDownPoint.y - e.stageY ) / 4;
                _mouseDownPoint = new Point( e.stageX, e.stageY );

				
            }
            private function SliderChange(e:Event):void {
				plane1.rotationX = -Number(MySlider.value);
				if(MySlider.maximum == 90){
				planeToAdd.rotationX = -Number(MySlider.value);
				}
				if(MySlider.maximum == 180){
				planeToAdd.rotationX = -Number(MySlider.value)/2;
				}
				plane3.rotationX = -Number(MySlider.value);
				//planeToAdd.z=Number(MySlider.value)/2;
			//	VSYOtxt.rotationX = -Number(MySlider.value);
			//	VSYOtxt.z = Number(MySlider.value) / 2;
		     if (MySlider.value< 2) {
				//VSYOtxt.visible = false;
				plane2.visible = false;
			}else{
			//	VSYOtxt.visible = true;
				plane2.visible = true;
			}
				//plane2.width =Number(MySlider.value);
			}
            private function onMouseUp( e:MouseEvent ):void {
                this.removeEventListener( MouseEvent.MOUSE_MOVE,onMouseMove );
                this.removeEventListener( MouseEvent.MOUSE_UP,onMouseUp );
                _mouseDownPoint = null;
			//	planeToAdd.vertices[0].position  = new Vector3D( -30, -40, 0);
			
            }
			private function AngleMode90(e:Event):void {
				    MySlider.maximum = 90;
					//plane2.rotationX -=90 ;
				
			}
			private function AngleMode180(e:Event):void {
				    MySlider.maximum = 180;
					//plane2.rotationX -=90 ;
				
			}
			public function AddNewPlane(e:MouseEvent):void {
               	planeToAdd = new Plane( { width:60, height:80, z:0, x:0, y:45, rotationX: -90, yUp:false, material:PerAspera01, bothsides:false} );
				planeToAdd.pivotPoint = new Vector3D(30, -40, 0);
				container.addChild(planeToAdd);
			};
			private function SliderChangePos(e:Event):void {
				planeToAdd.x = Number(MySliderX.value)-Number(plane2.width/2);
				planeToAdd.y = Number(MySliderY.value);
				planeToAdd.z = Number(MySliderZ.value);
			}
			private function SliderChangeRotation(e:Event):void {
				//planeToAdd.rotationX = Number(MySliderRotX.value);
				//planeToAdd.rotationY = Number(MySliderRotY.value);
				planeToAdd.rotationZ = Number(MySliderRotZ.value);
			//var x3:Number = planeToAdd.y +l +k;
			
			k = ((plane1.height - planeToAdd.y) /(Math.cos(Number(MySliderRotZ.value) * Math.PI / 180)));
			trace("var k:Number:" +k);
		
			l = ((planeToAdd.width / 2) *((Math.tan(Number(MySliderRotZ.value) * Math.PI / 180))));
				trace("var l:Number:" + l);
			trace("planeToAdd.rotation" + planeToAdd.rotationZ);
			trace("planeToAdd.y:"+planeToAdd.y);
			y2 =-l+planeToAdd.height-k;
			    x3 =-y2 / Math.tan(Number(MySliderRotZ.value) * Math.PI / 180) ;
				trace("var x3:Number:" + x3);
			trace("var y2:Number:" + y2);
				FaceMe.vertices[0].x = x3-30;
				FaceMe.vertices[1].y = planeToAdd.height-y2-40;
			}
	}
}