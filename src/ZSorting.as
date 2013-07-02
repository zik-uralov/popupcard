package
{
	import away3d.primitives.Triangle;
	
	public class ZSorting extends Away3DTemplate
	{
		public function ZSorting()
		{
			super();
		}
		
		protected override function initScene():void
		{
			super.initScene();
			camera.z = 0;
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
	}
}