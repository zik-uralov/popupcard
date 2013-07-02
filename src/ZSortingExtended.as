package
{
	import away3d.core.base.Object3D;
	import away3d.primitives.Triangle;
	import flash.events.KeyboardEvent;
	
	public class ZSortingExtended extends Away3DTemplate
	{
		public function ZSortingExtended()
		{
			super();
		}
		
		protected override function initScene():void
		{
			super.initScene();
			camera.z = 0;
			defaultScene();
		}
		
		protected override function initListeners():void
		{
			super.initListeners();
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			clearScene();
			
			switch (event.keyCode)
			{
				case 49:
					defaultScene();
					break;
				case 50:
					pushbackTest();
					break;
				case 51:
					pushfrontTest();
					break;
				case 52:
					screenZOffsetTest1();
					break;
				case 53:
					screenZOffsetTest2();
					break;
				case 54:
					ownCanvasTest();
					break;
				default:
					defaultScene();
					break;
			}
		}
		
		protected function clearScene():void 
		{
			var removeList:Vector.<Object3D> = new Vector.<Object3D>();
			for each(var child:Object3D in scene.children)
			{
				if (child != camera)
					removeList.push(child);
			}
			
			for each (var sceneObject:Object3D in removeList)
				scene.removeChild(sceneObject);
		}
		
		protected function defaultScene():void
		{
			var triangleA:Triangle = new Triangle(
				{
					x: -30,
					y: 0,
					z: 500,
					rotationY: -5,
					yUp: false,
					bothsides: true
				}
			);
		
			var triangleB:Triangle = new Triangle(
				{
					x: 30,
					y: 0,
					z: 499,
					rotationY: 60,
					yUp: false,	
					bothsides: true
				}
			);
					
			scene.addChild(triangleA);
			scene.addChild(triangleB);
		}
		
		protected function pushbackTest():void
		{
			var triangleA:Object3D = new Triangle(
				{
					x: -30,
					y: 0,
					z: 500,
					rotationY: -5,
					yUp: false,
					bothsides: true,
					pushfront: true
				}
			);

		
			var triangleB:Triangle = new Triangle(
				{
					x: 30,
					y: 0,
					z: 499,
					rotationY: 60,
					yUp: false,	
					bothsides: true
				}
			);
					
			scene.addChild(triangleA);
			scene.addChild(triangleB);
		}
		
		protected function pushfrontTest():void
		{
			var triangleA:Triangle = new Triangle(
				{
					x: -30,
					y: 0,
					z: 500,
					rotationY: -5,
					yUp: false,
					bothsides: true
				}
			);
		
			var triangleB:Object3D = new Triangle(
				{
					x: 30,
					y: 0,
					z: 499,
					rotationY: 60,
					yUp: false,
					bothsides: true,
					pushback: true
				}
			);

					
			scene.addChild(triangleA);
			scene.addChild(triangleB);
		}
		
		protected function screenZOffsetTest1():void
		{
			var triangleA:Object3D = new Triangle(
				{
					x: -30,
					y: 0,
					z: 500,
					rotationY: -5,
					yUp: false,
					bothsides: true,
					screenZOffset: -10
				}
			);
			
			var triangleB:Object3D = new Triangle(
				{
					x: 30,
					y: 0,
					z: 499,
					rotationY: 60,
					yUp: false,
					bothsides: true
				}
			);

					
			scene.addChild(triangleA);
			scene.addChild(triangleB);
		}
		
		protected function screenZOffsetTest2():void
		{
			var triangleA:Object3D = new Triangle(
				{
					x: -30,
					y: 0,
					z: 500,
					rotationY: -5,
					yUp: false,
					bothsides: true
				}
			);
			
			var triangleB:Object3D = new Triangle(
				{
					x: 30,
					y: 0,
					z: 499,
					rotationY: 60,
					yUp: false,
					bothsides: true,
					screenZOffset: 10
				}
			);			

			scene.addChild(triangleA);
			scene.addChild(triangleB);
		}
		
		protected function ownCanvasTest():void
		{
			var triangleA:Object3D = new Triangle(
				{
					x: -30,
					y: 0,
					z: 500,
					rotationY: -5,
					yUp: false,
					bothsides: true
				}
			);
			
			var triangleB:Object3D = new Triangle(
				{
					x: 30,
					y: 0,
					z: 499,
					rotationY: 60,
					yUp: false,
					bothsides: true,
					ownCanvas: true
				}
			);	
			triangleB.ownSession.screenZ = 510;

			scene.addChild(triangleA);
			scene.addChild(triangleB);
		}
	}
}