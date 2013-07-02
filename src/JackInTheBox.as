package
{
	import away3d.primitives.Cube;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import away3d.core.render.Renderer;
	
	public class JackInTheBox extends AwayTemplate
	{
		private var _mouseDownPoint :Point;
		public function JackInTheBox()
		{
			super();
		}
		
		protected override function initGeometry():void
		{
	
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown );
			//_cam.panAngle -= 10;
			var MyCube:Cube = new Cube();
			
			MyCube.rotationY = -90;
			//MyCube.z = -300;
			MyCube.width = 10;
			MyCube.height = 10;
			_view.scene.addChild(MyCube);
			_view.renderer = Renderer.INTERSECTING_OBJECTS;
			
			//MyCube.moveForward(50);
		}
		override protected function initListeners():void {

			addEventListener(Event.ENTER_FRAME, onEnterFrame);

		}
		private function onMouseDown( e:MouseEvent ):void {
                //msg.visible = false;
                _mouseDownPoint = new Point( e.stageX, e.stageY );
                addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
                stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
				
        }
            
        private function onMouseMove( e:MouseEvent ):void {
               // _cam.panAngle -= ( _mouseDownPoint.x - e.stageX ) / 4;
               //scene.rotationX += ( _mouseDownPoint.y - e.stageY ) / 2;
				_view.scene.rotationY += ( _mouseDownPoint.x - e.stageX ) / 1;
				//scene.rotationY += ( _mouseDownPoint.y - e.stageY ) / 4;
                _mouseDownPoint = new Point( e.stageX, e.stageY );

				
        }
		private function onMouseUp( e:MouseEvent ):void {
                this.removeEventListener( MouseEvent.MOUSE_MOVE,onMouseMove );
                this.removeEventListener( MouseEvent.MOUSE_UP,onMouseUp );
                _mouseDownPoint = null;
			//	planeToAdd.vertices[0].position  = new Vector3D( -30, -40, 0);
			
        }
		override protected function onEnterFrame(e:Event) : void{
			super.onEnterFrame(e);

		
		}
		
	}
}