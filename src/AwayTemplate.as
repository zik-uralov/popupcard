package
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.cameras.HoverCamera3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats; 
	import flash.display.Sprite;
	import flash.events.Event;
    
	/**
	 * This is basic template for away3d scene setup
	 * 
	 * */
//	[SWF(backgroundColor='#000000', frameRate='30', width='600', height='450')]
	public class AwayTemplate extends Sprite
	{
		protected var _view:View3D;
		protected var _cam:HoverCamera3D;
		public function AwayTemplate()
		{
			initAway();
			initMaterials();
			initGeometry();
			initListeners();
			initUI();
		}
		private function initAway():void{
		  /// var brenderer:BasicRenderer=new BasicRenderer(new ZDepthFilter(1000));
			_view=new View3D({x:300,y:270,stats:false});
			//_view.width=800;
			//_view.height=600;
			_cam=new HoverCamera3D();
			_cam.lens=new PerspectiveLens();
			_view.camera = _cam;
			addChild(_view);
			buttonMode = true;
			useHandCursor  = true;
			//var aws:AwayStats=new AwayStats(_view);
			//this.addChild(aws);
		}
		protected function initListeners():void{
			
		}
		protected function initMaterials():void{
			
		}
		protected function initGeometry():void{
			
		}
		protected function initUI():void {}
		protected function onEnterFrame(e:Event):void{
			_view.render();
		}
	}
}