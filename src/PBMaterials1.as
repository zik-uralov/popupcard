package
{

	import away3d.cameras.HoverCamera3D;
	import away3d.core.utils.Cast;
	import away3d.lights.DirectionalLight3D;
	import away3d.lights.PointLight3D;
	import away3d.materials.FresnelPBMaterial;
	import away3d.materials.PhongMultiPassMaterial;
	import away3d.materials.PhongPBMaterial;
	import away3d.materials.utils.TangentToObjectMapper;
	import away3d.primitives.Sphere;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;

	[SWF(backgroundColor="#677999", frameRate="30", quality="HIGH", width="800", height="600")]
	public class PBMaterials1 extends AwayTemplate
	{
		[Embed(source="assets/SimpleBitmap1.png")]
		private var SimpleTexture:Class;
		[Embed(source="assets/NormalMapPthshop.png")]
		private var NormalReady:Class;
		[Embed(source="assets/HeightMap.png")]
		private var HeightMap:Class;
		[Embed(source="assets/Sunset.jpg")]
		private var EnvMap:Class;

		private var _dirLight:DirectionalLight3D;
		private var _pbmat:PhongPBMaterial;
		private var _fresnel:FresnelPBMaterial;
		private var _normalMap:BitmapData;
		private var _defaultMap:BitmapData;
		private var _envMap:BitmapData;
		private var _pointLight:PointLight3D;
		private var _sp:Sphere;
		private var _canRotate:Boolean=false;
		private var _pointLight1:PointLight3D;
		private var _pointLight2:PointLight3D;
		private var _multiPass:PhongMultiPassMaterial;
		private static const DIST:Number=200;
		private var _angle:Number=0;
		private static const  DEGR_TO_RADS:Number=Math.PI/180;
		////////
		private var _hoverCam:HoverCamera3D;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;
		private var _canRotateCam:Boolean=false;
		public function PBMaterials1()
		{
			super();
			initSceneLights();
			setHoverCam();
			
		}
		override protected function initListeners() : void{
			super.initListeners();
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		override protected function initMaterials() : void{
			_sp=new Sphere({radius:50,segmentsH:22,segmentsW:22});
			_defaultMap=Cast.bitmap(new SimpleTexture());
			_normalMap=Cast.bitmap(new NormalReady());
			_envMap=Cast.bitmap(new EnvMap());
			////////////materials/////////uncomment each of the materials in order to use//////////////////
			
			/////////////PhongPBMaterial////////////
			/*_pbmat=new PhongPBMaterial(_defaultMap,TangentToObjectMapper.transform(_normalMap,_sp,true),_sp);///
			_pbmat.smooth=true;
			_pbmat.gloss=3;
			_pbmat.specular=5;*/
			
			//////////Fresnel///////////////
			/*_fresnel=new FresnelPBMaterial(_defaultMap,TangentToObjectMapper.transform(_normalMap,_sp,true),_envMap,_sp);
			_fresnel.envMapAlpha=0.9;
			_fresnel.exponent=10;*/
			
	
			
			//////////DiffusePBMaterial////////////////
			//var diff:DiffusePBMaterial=new DiffusePBMaterial(_defaultMap,TangentToObjectMapper.transform(_normalMap,_sp,true),_sp);///
			//diff.color=0x220023;
			//diff.smooth=true;
			
			///////////////SpecularPBMaterial////////////////////
			//var spec:SpecularPBMaterial=new SpecularPBMaterial(_defaultMap,TangentToObjectMapper.transform(_normalMap,_sp,true),_sp);
			//spec.gloss=0.24;
			
			/////////PhongMultiPassMaterial//////////
			_multiPass=new PhongMultiPassMaterial(_defaultMap,TangentToObjectMapper.transform(_normalMap,_sp,true),_sp);
			_multiPass.smooth=true;
			_multiPass.gloss=3;
			
			_canRotate=true;
		}
		override protected function initGeometry():void{
			_sp.material=_multiPass;
			_view.scene.addChild(_sp);
			_sp.z=500;
		}
		private function initSceneLights():void{
			_dirLight=new DirectionalLight3D();
			_dirLight.color=0xAAF7FF;
			
			_dirLight.diffuse=2;
			_dirLight.brightness=0.02;
			_dirLight.specular=1;
			_view.scene.addLight(_dirLight);
			//-------------------------------------
			_pointLight=new PointLight3D();
			_pointLight.radius=120;
			_pointLight.brightness=1.4;
			_view.scene.addLight(_pointLight);
			_pointLight.x=-50;
			_pointLight.y=60;
			_pointLight.z=470;
			//--------------------------------
			_pointLight1=new PointLight3D();
			_view.scene.addLight(_pointLight1);
			_pointLight1.brightness=1.4;
			_pointLight1.x=30;
			_pointLight1.y=0;
			_pointLight1.z=430;
			_pointLight1.radius=120;
			//-------------------------------------
			_pointLight2=new PointLight3D();
		    _view.scene.addLight(_pointLight2);
			_pointLight2.brightness=1.3;
			_pointLight2.x=68;
			_pointLight2.y=20;
			_pointLight2.z=440;
			_pointLight2.radius=120;
			_dirLight.direction=new Vector3D(_sp.position.x-100,_sp.position.y,_sp.position.z-200);
			
			
		}
		override protected function onEnterFrame(e:Event) : void{
			super.onEnterFrame(e);
			if(_canRotate){	
				_sp.rotationY++;
				_angle++;
				_pointLight2.x = _sp.position.x+ Math.sin(_angle*DEGR_TO_RADS)*DIST;
				_pointLight2.y = 0;
				_pointLight2.z = _sp.position.z+Math.cos(_angle*DEGR_TO_RADS)*DIST;
			}
			if (_hoverCam) {
				if(_canRotateCam){
					_hoverCam.panAngle = 0.5 * (stage.mouseX- _lastMouseX) + _lastPanAngle;
					_hoverCam.tiltAngle = 0.5 * (stage.mouseY - _lastMouseY) + _lastTiltAngle;
				}
				
				_hoverCam.hover();
			}	
			
		}
		private function onMouseDown(e:MouseEvent):void{
			_canRotateCam=true;
			_lastPanAngle = _hoverCam.panAngle;
			_lastTiltAngle = _hoverCam.tiltAngle;
			_lastMouseX = stage.mouseX;
			_lastMouseY = stage.mouseY;
		}
		private function onMouseUp(e:MouseEvent):void{
			
			_canRotateCam=false;
		}
		private function setHoverCam():void{
			_hoverCam=new HoverCamera3D();
			
			_hoverCam.minTiltAngle = -80;
			_hoverCam.maxTiltAngle = 20;
			_hoverCam.panAngle = 90;
			_hoverCam.tiltAngle = 0;
			_hoverCam.distance=500;
			_view.camera=_hoverCam;
			_hoverCam.target=_sp;
		}
	}
}