package 
{
	import away3d.cameras.HoverCamera3D;
	import away3d.materials.ColorMaterial;
	import away3d.materials.WireColorMaterial;
	import away3d.primitives.TextField3D;
	import com.bit101.components.HSlider;
	import com.bit101.components.HUISlider;
	import com.bit101.components.RadioButton;
	import flash.display.Bitmap;
	import away3d.core.utils.Cast;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.MovieMaterial;
	import away3d.primitives.Plane;
	import away3d.primitives.Torus;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
	[SWF(width = '800', height = '500', frameRate = '60', backgroundColor = '#ffffff')] 
	
	public class wordspuzzle extends AwayTemplate
	{
		[Embed(source = 'assets/vsyo.png')]
		protected var image_sunset:Class;
		 [Embed(source = '../lib/Fonts.swf', mimeType = 'application/octet-stream')]
		 protected var Fonts:Class;
		[Embed(source = "assets/PuzzleTile.png")] 
		protected var Skyup:Class;
		public var hero_mc:MovieClip=new Hero();
		public var leftArrow:LeftArrow = new LeftArrow();
		public var rightArrow:RightArrow = new RightArrow();
		public var MySlider:HUISlider = new HUISlider(stage, 30, 20, "ANIMATE", SliderChange);
		public var Open90:RadioButton = new RadioButton(stage, 30, 40, "ANGLE 90", true, AngleMode90);
		public var Open180:RadioButton = new RadioButton(stage,100, 40, "ANGLE 180", true, AngleMode180);
		private var newJpgMat:BitmapMaterial;
		private var newJpgMat2:BitmapMaterial;
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
		public var VSYOtxt:TextField3D;
		public var extrusion:TextExtrusion;
		public var font:ByteArray;
		public var faceMaterial:WireColorMaterial 
		
		public function wordspuzzle()
		{
			super();
		}
		override protected function initMaterials() : void {
			_movieMat1 = new MovieMaterial(new Hero());
			newJpgMat = new BitmapMaterial(Cast.bitmap(image_sunset));
			newJpgMat2 = new BitmapMaterial(Cast.bitmap(Skyup));
		}
		override protected function initGeometry() : void {
			
			plane1 = new Plane( { width:150, height:100,z:0, yUp:false, material:newJpgMat2,back:newJpgMat } );
			plane2 = new Plane( { width:150, height:100, z:0, yUp:false, material:newJpgMat2 } );
			plane1.bothsides = true;
			plane2.bothsides = true;
			plane1.pivotPoint = new Vector3D(0, -50, 0);
			plane2.pivotPoint = new Vector3D(0, -50, 0);
			
			var font:ByteArray = new Fonts() as ByteArray;
			VectorText.extractFont(font);

			faceMaterial= new WireColorMaterial();
			faceMaterial.color = 0xFFFFFF;
			faceMaterial.wireColor = 0x000000;

			VectorText.extractFont(new Fonts());
            VSYOtxt = new TextField3D("Vera Sans",
				{
					text: "PER",
					align: VectorText.CENTER
				}
			);			
			VSYOtxt.material = faceMaterial;
			var exMaterial : WireColorMaterial = new WireColorMaterial();
			exMaterial.color = 0xFF0000;
			exMaterial.wireColor = 0x000000;

			var extrusion : TextExtrusion = new TextExtrusion( VSYOtxt);
			extrusion.bothsides = true;
			extrusion.material = exMaterial;
			extrusion.back = exMaterial;


			container = new ObjectContainer3D(
				VSYOtxt,
				{
			    rotationX:90
				}
			);
			container.ownCanvas = true;
			//plane1.rotationX = -100;
            
			
			_view.scene.addChild(container);
			_view.renderer = Renderer.INTERSECTING_OBJECTS;
			

			
			}

		override protected function onEnterFrame(e:Event) : void{
			super.onEnterFrame(e);
           
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
			addChild(rightArrow);

		}
		override protected function initListeners():void {
			leftArrow.addEventListener(MouseEvent.MOUSE_DOWN, LeftButtonActive); 
			rightArrow.addEventListener(MouseEvent.MOUSE_DOWN, RightButtonActive); 
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			
		}

		private function LeftButtonActive(e:Event):void {


			TweenLite.to(VSYOtxt, 1, { rotationX: 0, y:0, z:0, ease:Bounce.easeOut} );
			
		}
		private function RightButtonActive(e:MouseEvent):void {

			
        //TweenLite.to(plane1, 1, { rotationX:90, ease:Bounce.easeOut } );
		TweenLite.to(_cam, 1, {x:40,y:189,z:-300});
		//_cam.lookAt(new Vector3D(100,100,100));
		//trace(_cam.x,_cam.y,_cam.z);
		//_cam.pivotPoint = new Vector3D(0,0,0);
		//TweenLite.to(_cam, 1, {x:100,y:90,z:50, ease:Bounce.easeIn});
			//TweenLite.to(plane1 , 1, { rotationX:90, ease:Bounce.easeOut } );
		//	TweenLite.to(plane1, 1, { rotationX: -90, ease:Bounce.easeOut } );
			TweenLite.to(VSYOtxt, 1, { rotationX: -90, y:30, z:45, ease:Bounce.easeOut } );
			//TweenLite.to(VSYOtxt, 1, {y:30, ease:Bounce.easeOut } );
			//TweenLite.to(VSYOtxt, 1, { z:10, ease:Bounce.easeOut } );
			//TweenLite.to(_cam, 1, {x:100,y:100,z:100});
		
        }
		
			private function onMouseDown( e:MouseEvent ):void {
                //msg.visible = false;
                _mouseDownPoint = new Point( e.stageX, e.stageY );
                addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
                stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
				
            }
            
            private function onMouseMove( e:MouseEvent ):void {
                //_cam.panAngle -= ( _mouseDownPoint.x - e.stageX ) / 4;
                //_view.scene.rotationX += ( _mouseDownPoint.y - e.stageY ) / 2;
				_view.scene.rotationY += ( _mouseDownPoint.x - e.stageX ) / 1;
				//_view.scene.rotationY += ( _mouseDownPoint.y - e.stageY ) / 4;
                _mouseDownPoint = new Point( e.stageX, e.stageY );

				
            }
            private function SliderChange(e:Event):void {
				//plane1.rotationX = -Number(MySlider.value);
				VSYOtxt.rotationX = -Number(MySlider.value);
				VSYOtxt.z = Number(MySlider.value) / 2;
		     if (MySlider.value< 2) {
				VSYOtxt.visible = false;
			//	plane2.visible = false;
			}else{
				VSYOtxt.visible = true;
				//plane2.visible = true;
			}
				//plane2.width =Number(MySlider.value);
			}
            private function onMouseUp( e:MouseEvent ):void {
                this.removeEventListener( MouseEvent.MOUSE_MOVE,onMouseMove );
                this.removeEventListener( MouseEvent.MOUSE_UP,onMouseUp );
                _mouseDownPoint = null;
            }
			private function AngleMode90(e:Event):void {
				    MySlider.maximum = 90;
					//plane2.rotationX -=90 ;
				
			}
			private function AngleMode180(e:Event):void {
				    MySlider.maximum = 180;
					//plane2.rotationX -=90 ;
				
			}
	}
}