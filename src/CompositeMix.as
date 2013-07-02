package
{
	import away3d.core.utils.Cast;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.CompositeMaterial;
	import away3d.primitives.TorusKnot;
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.events.Event;

	[SWF(backgroundColor="#677999", frameRate="30", quality="LOW", width="800", height="600")]
	public class CompositeMix extends AwayTemplate
	{
		[Embed(source="assets/PuzzleTile.png")]
		private var PuzzleTile:Class;
		private var _compose:CompositeMaterial;
		private var _bitMat:BitmapMaterial;
		private var _bitMat1:BitmapMaterial;
		private var _knot:TorusKnot;
		public function CompositeMix()
		{
			super();
			_cam.z=-500;
		}
		private function createPerlinMap():BitmapData{
			var bdata:BitmapData=new BitmapData(128,128);
			bdata.perlinNoise(128,128,18,12,true,true,7,false);
			return bdata;
		}
		override protected function initMaterials() : void{
			_compose=new CompositeMaterial();
			_bitMat=new BitmapMaterial(createPerlinMap());
			_bitMat.smooth=true;
			_bitMat1=new BitmapMaterial(Cast.bitmap(new PuzzleTile()));
			
			_bitMat1.smooth=true;
			_bitMat1.alpha=0.9;
			
			_compose.addMaterial(_bitMat);
			_compose.addMaterial(_bitMat1);
			_bitMat.blendMode=BlendMode.HARDLIGHT;
			
			
			
		}
		override protected function initGeometry() : void{
			_knot=new TorusKnot({material:_compose});
			_knot.segmentsR=45;
			_knot.segmentsT=9;
			_knot.radius=60;
			_knot.tube=25;
			_view.scene.addChild(_knot);
		}
		override protected function onEnterFrame(e:Event) : void{
			super.onEnterFrame(e);
			if(_knot){
				_knot.rotationX++;
			}
		}
	}
}