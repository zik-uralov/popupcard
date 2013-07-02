package 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.render.Renderer;
	import away3d.materials.WireColorMaterial;
	import away3d.primitives.Cube;
	import away3d.primitives.Triangle;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	
	public class RenderersDemo extends Away3DTemplate
	{
		private var triangle:Triangle;
		private var box:Cube;
		
		public function RenderersDemo():void
		{
			super();		
		}
		
		protected override function initScene():void
		{
			super.initScene();
			this.camera.z = 50;
			triangle = new Triangle(
				{
					edge: 150,
					bothsides: true,
					yUp: false,
					material: new WireColorMaterial(0x224488),
					z: 500
				}		
			);
			scene.addChild(triangle);
			
			box = new Cube(
				{
					z: 500,
					width: 50,
					height: 75,
					depth: 50,
					material: new WireColorMaterial(0x228844)
				}
			);
			scene.addChild(box);
		}
		
		protected override function initListeners():void
		{
			super.initListeners();
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		protected override function initUI():void
		{
			super.initUI();
			var text:TextField = new TextField();
			text.text = "Press 1 to enbale the BASIC renderer.\n" +
				"Press 2 to enable the CORRECT_Z_ORDER renderer.\n" +
				"Press 3 to enable the INTERSECTING_OBJECTS renderer.\n" + 
				"Press 4 to make the box transparent.\n" +
				"Press 5 to make the box opaque.";
			text.x = 10;
			text.y = 10;
			text.width = 300;
			this.addChild(text);
		}
		
		protected override function onEnterFrame(event:Event):void
		{
			super.onEnterFrame(event);
			triangle.rotationY += 3;
			box.rotationY -= 1;
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
				case 49:
					view.renderer = Renderer.BASIC;
					break;
				case 50:
					view.renderer = Renderer.CORRECT_Z_ORDER;
					break;
				case 51:
					view.renderer = Renderer.INTERSECTING_OBJECTS;
					break;
				case 52:
					(box.material as WireColorMaterial).alpha = 0.5;
					break;
				case 53:
					(box.material as WireColorMaterial).alpha = 1;
					break;
			}
		}
	}
}
