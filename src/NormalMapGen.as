package
{

	import away3d.core.utils.Cast;
	import away3d.events.TraceEvent;
	import away3d.lights.PointLight3D;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.utils.NormalBumpMaker;
	import away3d.materials.utils.NormalMapGenerator;
	import away3d.materials.utils.NormalMapType;
	import away3d.primitives.Sphere;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFormat;

	[SWF(backgroundColor="#677999", frameRate="30", quality="HIGH", width="800", height="600")]
	public class NormalMapGen extends AwayTemplate
	{

		[Embed(source="assets/SimpleBitmap1.png")]
		private var SimpleTexture:Class;
		[Embed(source="assets/HeightMap.png")]
		private var HeightMap:Class;

		private var _normalMap:BitmapData;
		private var _normThumb:Bitmap;
		private var _pointLight:PointLight3D;
		private var _sp:Sphere;
        private var _tField:TextField;
		public function NormalMapGen()
		{
			super();
			setProgressText();
			genNormalMap();////uncomment to use NormalMapGenerator for map generation
			//genNormalViaBump();
		}
		
		override protected function initGeometry():void{
			_sp=new Sphere({radius:50,segmentsH:22,segmentsW:22,material:new BitmapMaterial(Cast.bitmap(new SimpleTexture()))});
			_view.scene.addChild(_sp);
			_sp.z=500;
		}
		private function genNormalViaBump():void{
			var bumpToNorm:NormalBumpMaker=new NormalBumpMaker();
			
			var normMap:BitmapData=bumpToNorm.convertToNormalMap(Cast.bitmap(new HeightMap()),null,0.2);
			_normThumb=new Bitmap(normMap);
			_view.addChild(_normThumb);
			_normThumb.x=-400;
			_normThumb.y=-300;
		}
		private function genNormalMap():void{
			var normalGen:NormalMapGenerator=new NormalMapGenerator(_sp ,256,256,Cast.bitmap(new HeightMap()),0,false,50,NormalMapType.TANGENT_SPACE,false);////Cast.bitmap(new SpyTexture())
		
			normalGen.addEventListener(TraceEvent.TRACE_COMPLETE,onNormalGenReady);
			normalGen.addEventListener(TraceEvent.TRACE_PROGRESS,onTraceWorking);
			normalGen.execute();
		}
		private function setProgressText():void{
			_tField=new TextField();
			var tFormat:TextFormat=new TextFormat();
			tFormat.size=25;
			tFormat.bold=true;
			tFormat.align="center";
			_tField.defaultTextFormat=tFormat;
			_view.addChild(_tField);
			_tField.width=250;
			_tField.x=-(_tField.width/2);
			_tField.y=-280;
		}
		private function onTraceWorking(e:TraceEvent):void{
			trace(e.percent);
			_tField.text=Math.floor(e.percent).toString();
		}
		private function onNormalGenReady(e:TraceEvent):void{
			_tField.text="Normal Map is ready!";
			var normalGen:NormalMapGenerator=e.target as NormalMapGenerator;
			_normalMap=normalGen.normalMap;
			_normThumb=new Bitmap(_normalMap);
			_view.addChild(_normThumb);
			_normThumb.x=-400;
			_normThumb.y=-300;
			
		}
		

	}
}