package 
{
	import away3d.cameras.HoverCamera3D;
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
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
    import flash.geom.Point;
	import away3d.containers.ObjectContainer3D;
	import flash.geom.Vector3D;
	import away3d.core.render.Renderer;
	import away3d.primitives.Trident;
	import flash.display.Stage;
	import flash.filters.BlurFilter;
	import org.flintparticles.twoD.emitters.Emitter2D;
    import org.flintparticles.twoD.renderers.BitmapRenderer;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
	import flash.geom.Matrix3D;
	import flash.geom.Utils3D;
	[SWF(width = '1000', height = '700', frameRate = '60', backgroundColor = '#000000')] 
	
	public class popUP extends AwayTemplate
	{
		[Embed(source = 'assets/vsyo.png')]
		protected var image_sunset:Class;
		[Embed(source = "assets/PuzzleTile.png")] 
		protected var Skyup:Class;
		public var hero_mc:MovieClip=new Hero();
		public var leftArrow:LeftArrow = new LeftArrow();
		public var rightArrow:RightArrow = new RightArrow();
		private var newJpgMat:BitmapMaterial;
		private var newJpgMat2:BitmapMaterial;
	    private	var face:MovieClip;
		public var plane1:Plane;
		public var plane2:Plane;
		public var plane3:Plane;
		private var _movieMat1:MovieMaterial;
		private var _mouseDownPoint : Point;
		protected var container:ObjectContainer3D;
		protected var FiltG:GlowFilter;
		private var smoke:Emitter2D;
		 private var _spriteX:Number;
        private var _spriteY:Number;
		private var _screenVertex:Vector3D;
		public function popUP()
		{
			super();
			
		}
		override protected function initMaterials() : void {
			_movieMat1 = new MovieMaterial(new Hero());
			newJpgMat = new BitmapMaterial(Cast.bitmap(image_sunset));
			newJpgMat2 = new BitmapMaterial(Cast.bitmap(Skyup));
		}
		override protected function initGeometry() : void {
			
			plane1 = new Plane( { width:150, height:100,z:0, yUp:false, material:newJpgMat2 } );
			plane2 = new Plane( { width:150, height:100, z:3, yUp:false, material:newJpgMat } );
			plane3 = new Plane( { width:50, height:50,x:-75,y:25,z:2, yUp:false, material:_movieMat1 } );
			plane1.bothsides = true;
			plane2.bothsides = true;
			plane3.bothsides = true;
			plane1.pivotPoint = new Vector3D(0, -50, 0);
			plane2.pivotPoint = new Vector3D(0, -50, 0);
			plane3.pivotPoint = new Vector3D(-25, 0, 0);
			container = new ObjectContainer3D(
				plane1,plane2,plane3,
				{
			    //z:20
				}
			);
			container.ownCanvas = true;
			
			
			//>>......................INIT   SMOKE
			smoke = new Smoke();
            
            var renderer:BitmapRenderer = new BitmapRenderer( new Rectangle(1, 50,1000,800 ) );	
		    renderer.addEmitter( smoke );
			addChild(renderer);
            
			
			_view.scene.addChild(container);
			_view.renderer = Renderer.INTERSECTING_OBJECTS;
			
			FiltG = new GlowFilter();
            FiltG.color = 0x0000FF;
			FiltG.alpha = 50;
			FiltG.blurX = 12;
			FiltG.blurY = 19;
			FiltG.inner = false;
			FiltG.knockout = true;
			FiltG.strength = 5;
			
			}

		override protected function onEnterFrame(e:Event) : void{
			super.onEnterFrame(e);

		}
			override protected function initUI() : void {
			leftArrow.x = 100;
			leftArrow.y = 100;
			addChild(leftArrow);
			rightArrow.x = 150;
			rightArrow.y = 100;
			addChild(rightArrow);

		}
		override protected function initListeners():void {
			leftArrow.addEventListener(MouseEvent.MOUSE_DOWN, LeftButtonActive); 
			rightArrow.addEventListener(MouseEvent.MOUSE_DOWN, RightButtonActive); 
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			
		}

		private function LeftButtonActive(e:Event):void {
			container.filters = [];
            TweenLite.to(plane1, 2, { rotationX:0, ease:Bounce.easeIn } );
			TweenLite.to(plane2, 1, { rotationX:0, ease:Bounce.easeIn } );
			TweenLite.to(plane3, 1, {scaleY:.5,scaleY:1,rotationY:0, ease:Bounce.easeOut});
			smoke.stop();
		}
		private function RightButtonActive(e:MouseEvent):void {
			container.filters = [new GlowFilter(0xFFFF80, 0.1, 100, 100, 5, 1, false, false ), 
			new BevelFilter(4, 45, 0xFF0006, 1, 0, 1, 4, 4, 1, 1, "inner", false),
			new DropShadowFilter(15, 44, 0, 4, 12, 1, 1, 1, false, false, false)];
			
        //TweenLite.to(plane1, 1, { rotationX:90, ease:Bounce.easeOut } );
		TweenLite.to(_cam, 1, {x:40,y:50,z:-250});
		//_cam.lookAt(new Vector3D(100,100,100));
		//trace(_cam.x,_cam.y,_cam.z);
		//_cam.pivotPoint = new Vector3D(0,0,0);
		//TweenLite.to(_cam, 1, {x:100,y:90,z:50, ease:Bounce.easeIn});
			TweenLite.to(plane1 , 1, { rotationX:97, ease:Bounce.easeOut } );
			TweenLite.to(plane2 , 1, { rotationX:-83, ease:Bounce.easeOut } );
			TweenLite.to(plane3, 1, {scaleY:1,rotationY:90, ease:Bounce.easeIn});
			//TweenLite.to(_cam, 1, {x:100,y:100,z:100});
			//trace("P1="+plane1.z,"P2="+plane2.z,"P3="+plane3.z);
			smoke.start();
        }
		
			private function onMouseDown( e:MouseEvent ):void {
                //msg.visible = false;
				leftArrow.filters = [FiltG];
                _mouseDownPoint = new Point( e.stageX, e.stageY );
                addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
                stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
				
            }
            
            private function onMouseMove( e:MouseEvent ):void {
                //_cam.panAngle -= ( _mouseDownPoint.x - e.stageX ) / 4;
                _view.scene.rotationX += ( _mouseDownPoint.y - e.stageY ) / 2;
				_view.scene.rotationY += ( _mouseDownPoint.x - e.stageX ) / 1;
				//_view.scene.rotationY += ( _mouseDownPoint.y - e.stageY ) / 4;
                _mouseDownPoint = new Point( e.stageX, e.stageY );
				_screenVertex=_cam.screen(plane3,plane3.vertices[3])
				/*_spriteX=plane1.vertices[2]["x"]+_view.width*.5;
				_spriteY = plane1.vertices[2]["y"] +_view.height * .5;*/
				_spriteX=_screenVertex.x+_view.width*.5-100;
				_spriteY=_screenVertex.y +_view.height*.5;
				smoke.x=_spriteX;
				smoke.y = _spriteY;
				
			//	plane3.vertices[3].x++;
            }
            
            private function onMouseUp( e:MouseEvent ):void {
                this.removeEventListener( MouseEvent.MOUSE_MOVE,onMouseMove );
                this.removeEventListener( MouseEvent.MOUSE_UP,onMouseUp );
                _mouseDownPoint = null;
				leftArrow.filters = [];
            }
	}
}