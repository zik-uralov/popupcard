package
{
	import away3d.core.utils.Cast;
	import away3d.materials.DepthBitmapMaterial;
	import away3d.primitives.Sphere;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	
	import flash.events.Event;

	[SWF(backgroundColor="#677999", frameRate="30", quality="LOW", width="800", height="600")]
	public class DepthMaterialDemo extends AwayTemplate
	{
		[Embed(source="assets/SimpleBitmap1.png")]
		private var SimpleBitmap:Class;
		
		private var _depthMat:DepthBitmapMaterial;
		private var _sp:Sphere;
		public function DepthMaterialDemo()
		{
			super();
			_cam.z=-200;
		    initTween();
		}
		override protected function initMaterials() : void{
			_depthMat=new DepthBitmapMaterial(Cast.bitmap(new SimpleBitmap()));
			_depthMat.smooth=true;
			_depthMat.minZ=0;
			_depthMat.maxZ=1200;
			_depthMat.minColor=0xFF0000;///06C62C
			_depthMat.maxColor=0x0000FF;///C10B0B
			
			
		}
		override protected function initGeometry() : void{
			_sp=new Sphere({radius:60,segmnetsH:30,segmentsW:30,material:_depthMat});
			_view.scene.addChild(_sp);
			_sp.z=0;
			
		}
		override protected function onEnterFrame(e:Event) : void{
			super.onEnterFrame(e);
		}
		private function initTween():void{
			TweenMax.fromTo(_sp,4,{z:0},{z:1200,ease:Bounce.easeIn,onComplete:onTweenComplete});
			
		}
		
		private function onTweenComplete():void{
			initTween();
		}
		
	}
}