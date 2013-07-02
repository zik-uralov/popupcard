package
{
	import away3d.core.render.Renderer;
	import away3d.primitives.Sphere;
	import flash.geom.Vector3D;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;

	public class RenderersPerformanceDemo extends Away3DTemplate
	{
		protected static const SPEED:Number = 0.5;
		protected static const BOXSIZE:Number = 20;
		protected static const NUMBERSPHERS:Number = 10;
		protected var spheres:Vector.<Sphere> = new Vector.<Sphere>();
		protected var directions:Vector.<Vector3D> = new Vector.<Vector3D>();
		
		public function RenderersPerformanceDemo()
		{
			super();
		}
		
		protected override function initScene():void
		{
			super.initScene();
			this.camera.z = 50;
			for (var i:int = 0; i < NUMBERSPHERS; ++i)
			{
				var sphere:Sphere = new Sphere(
					{
						x: Math.random() * BOXSIZE - BOXSIZE/2,
						y: Math.random() * BOXSIZE - BOXSIZE/2,
						z: Math.random() * BOXSIZE - BOXSIZE/2,
						radius: 2
					}
				);
				spheres.push(sphere);
				this.scene.addChild(sphere);
				
				directions.push(new Vector3D(
					Math.random() - 0.5,
					Math.random() - 0.5,
					Math.random() - 0.5)
				);
				directions[i].normalize();
				directions[i].scaleBy(SPEED);
			}
		}
		
		protected override function initListeners():void
		{
			super.initListeners();
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		protected override function initUI():void
		{
			super.initUI();
			var text:TextField = new TextField();
			text.text = "Press 1 to enbale the BASIC renderer.\n" +
				"Press 2 to enable the CORRECT_Z_ORDER renderer.\n" +
				"Press 3 to enable the INTERSECTING_OBJECTS renderer.";
			text.x = 10;
			text.y = 10;
			text.width = 300;
			this.addChild(text);
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
			}
		}
		
		protected override function onEnterFrame(event:Event):void
		{
			super.onEnterFrame(event);
			for (var i:int = 0; i < 10; ++i)
			{
				var newPosition:Vector3D = new Vector3D();
				newPosition = spheres[i].position.add(directions[i]);
				
				for each (var property:String in ["x", "y", "z"])
				{
					if (newPosition[property] < -BOXSIZE/2)
					{
						newPosition[property] = -BOXSIZE/2;
						directions[i][property] *= -1;	
					}
					
					if (newPosition[property] > BOXSIZE/2)
					{
						newPosition[property] = BOXSIZE/2;
						directions[i][property] *= -1;	
					}
				}
				
				spheres[i].position = newPosition;
			}
		}
	}
}