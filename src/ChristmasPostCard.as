package 
{
	

	import away3d.materials.ColorMaterial;
	import com.bit101.components.PushButton;
	import com.bit101.components.VUISlider;
	import flash.display.Bitmap;
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.net.navigateToURL;
	//import flash.display.Bitmap;
	import away3d.core.utils.Cast;
	import away3d.materials.BitmapMaterial;

	import away3d.primitives.Plane;
	
	
	import com.greensock.*;
	import com.greensock.easing.*;

	
	

	import flash.events.Event;
	import flash.events.MouseEvent;

    import flash.geom.Point;
	import away3d.containers.ObjectContainer3D;
	import flash.geom.Vector3D;
	import away3d.core.render.Renderer;

    import flash.display.Sprite;

	import flash.ui.MouseCursor;
	
    [SWF(width = '600', height = '450', frameRate = '30', backgroundColor = '#ffffff')] 
	
	public class ChristmasPostCard extends AwayTemplate
	{  
		[Embed(source='assets/uniqodd.png')]
		private var Uniqodd:Class;
		private var uqLogo:Bitmap = new Uniqodd ();
		[Embed(source = 'assets/background.jpg')]
		protected var VSYOtv:Class;

		[Embed(source = 'assets/SANTA.png')]
		protected var santa_img:Class;
		 
		[Embed(source = "assets/cover01.png")] 
		protected var Skyup:Class;
        [Embed(source = 'assets/present.JPG')]
		protected var present_img:Class;
		
		public var MySlider:VUISlider = new VUISlider(stage, 10, 10, "ANIMATE", SliderChange);
        public var StartButton:PushButton  = new PushButton(stage, 260, 180, "PUSH ME!", RightButtonActive );
		private var newJpgMat2:BitmapMaterial;
		private var santa_mat:BitmapMaterial;
        private var present_mat:BitmapMaterial;
		private var VSYOtv01:BitmapMaterial;

		public var plane1:Plane;
		public var plane2:Plane;

		public var SantaPlane:Plane;
		public var PresenPlane:Plane;

		private var _mouseDownPoint : Point;
		protected var container:ObjectContainer3D;

		private var _screenVertex:Vector3D;
		
		public var planeToAdd:Plane;
	    public var myMenu:ContextMenu = new ContextMenu();
		public function ChristmasPostCard()
		{
			super();
		}
		override protected function initMaterials() : void {
			
			santa_mat = new BitmapMaterial(Cast.bitmap(santa_img));
			present_mat = new BitmapMaterial(Cast.bitmap(present_img));
			newJpgMat2 = new BitmapMaterial(Cast.bitmap(Skyup));
		
			VSYOtv01 = new BitmapMaterial(Cast.bitmap(VSYOtv));
		}
		override protected function initGeometry() : void {
			var ColMat:ColorMaterial = new ColorMaterial();
			ColMat.color = 0xfff0f0;
			plane1 = new Plane( { width:150, height:100,z:0, yUp:false, material:VSYOtv01,back:newJpgMat2 } );
			plane2 = new Plane( { width:150, height:100, z:0, yUp:false, material:ColMat } );
			
			SantaPlane = new Plane( { width:70, height:50, x:25, y:20, z:0, yUp:false, bothsides:false, material:santa_mat } );
			PresenPlane = new Plane( { width:40, height:40, x:-40, y:40, z:0, yUp:false, bothsides:false, material:present_mat } );
			plane1.bothsides = true;
			plane2.bothsides = true;
			plane1.pivotPoint = new Vector3D(0, -50, 0);
			plane2.pivotPoint = new Vector3D(0, -50, 0);
			SantaPlane.pivotPoint = new Vector3D(0, -50, 0);
			PresenPlane.pivotPoint = new Vector3D(0, -20, 0);


					
			container = new ObjectContainer3D(
				plane1, plane2, SantaPlane,PresenPlane,
				{
			    rotationX:90
				}
			);
			
		

            
			
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

		
		}
			override protected function initUI() : void {

			//rightArrow.x = 300;
			//rightArrow.y = 225;
			MySlider.minimum = 0;
			MySlider.maximum = 90;
			MySlider.value = 90;
			MySlider.alpha = 0;
			MySlider.height = 10
            addChild(uqLogo);
			uqLogo.x = 450;
			uqLogo.y = 420;
			//addChild(rightArrow);
            myMenu.hideBuiltInItems();
			var menuItem1:ContextMenuItem = new ContextMenuItem("Ask Me How You Can By That Item");
			var menuItem2:ContextMenuItem = new ContextMenuItem("Go To Developr's Web page!");
            menuItem2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, doSomething);
			myMenu.customItems.push(menuItem1);
			myMenu.customItems.push(menuItem2);
			this.contextMenu = myMenu;
		}
		public function doSomething(e:ContextMenuEvent):void {
		var url:String = "http://www.vsyostudio.com";
		var request:URLRequest= new URLRequest(url);
		navigateToURL(request, '_blank');
		}
		override protected function initListeners():void {
			
			//rightArrow.addEventListener(MouseEvent.MOUSE_DOWN, RightButtonActive); 
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			
		}


		private function RightButtonActive(e:MouseEvent):void {
     
      
		TweenLite.to(_cam, 1, { x:40, y:189, z: -350 } );
		TweenLite.to(MySlider, 3, {height:200,alpha:100});
	   // TweenLite.to(MySlider, 10, {ease:Elastic.easeInOut});
			TweenLite.to(plane1, 2, { rotationX: -90 } );
			
			TweenLite.to(SantaPlane, 2, { rotationX: -90 } );
			TweenLite.to(PresenPlane, 2, { rotationX:-90} );
			StartButton.visible = false;
		  //  removeChild(StartButton);
        }
		
			private function onMouseDown( e:MouseEvent ):void {
               
                _mouseDownPoint = new Point( e.stageX, e.stageY );
                addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
                stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
				
            }
            
            private function onMouseMove( e:MouseEvent ):void {
                //_cam.panAngle -= ( _mouseDownPoint.x - e.stageX ) / 4;
               // _view.scene.rotationX += ( _mouseDownPoint.y - e.stageY ) / 2;
				_view.scene.rotationY += ( _mouseDownPoint.x - e.stageX ) / 1;
				
                _mouseDownPoint = new Point( e.stageX, e.stageY );

				
            }
            private function SliderChange(e:Event):void {
				plane1.rotationX = -Number(MySlider.value);
				if(MySlider.maximum == 90){
			
				}
				if(MySlider.maximum == 180){
			
				}
				SantaPlane.rotationX = -Number(MySlider.value);
				PresenPlane.rotationX = -Number(MySlider.value);
			
		     if (MySlider.value< 2) {
				
				plane2.visible = false;
			}else{
		
				plane2.visible = true;
			}
			
			}
            private function onMouseUp( e:MouseEvent ):void {
                this.removeEventListener( MouseEvent.MOUSE_MOVE,onMouseMove );
                this.removeEventListener( MouseEvent.MOUSE_UP,onMouseUp );
                _mouseDownPoint = null;
		
			
            }
			

			
			
	}
}