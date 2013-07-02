package
{
	import away3d.materials.MovieMaterial;
	import away3d.primitives.Plane;
	import mx.core.UIComponent;
	import away3d.containers.View3D;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import away3d.core.utils.Cast;
	import away3d.materials.BitmapMaterial;
	
	
	
	import utils.ButtonGraphics;
	
	[SWF(backgroundColor = "#677999", frameRate = "30", quality = "LOW", width = "800", height = "600")]
	
	public class MovieClipControl extends AwayTemplate
	{
		[Embed(source="assets/earthmap1k.jpg")]
	    private var img:Class;
		
		private var _movieClip:MovieClip;
		private var _movieClip2:MovieClip;
		private var buttton1:SimpleButton;
		private var buttton2:SimpleButton;
		private var buttton3:SimpleButton;
		private var _movieMat:MovieMaterial;
		private var _movieMat2:MovieMaterial;
		private var _plane1:Plane; 
		private var _plane2:Plane;
		private var _plane3:Plane;
		public function MovieClipControl()
		{
			super();
			_cam.z=-500;
			initControls();
		}
		override protected function initMaterials() : void{
			_movieMat = new MovieMaterial(new TweenedTexture());
			_movieMat2=new MovieMaterial(new SplitMovie());
			_movieClip = _movieMat.movie as MovieClip;
			_movieClip2=_movieMat2.movie as MovieClip;
			_movieMat.smooth = true;
			_movieMat2.smooth=true;
		}
		override protected function initGeometry() : void{
			_plane1=new Plane({width:200,height:200,yUp:false,material:_movieMat});
			_plane1.bothsides = false;
			_view.scene.addChild(_plane1);
			_plane2=new Plane({width:200,height:200,yUp:false,material:_movieMat2});
			_plane2.bothsides = false;
			_plane2.rotationY += 180;
			_view.scene.addChild(_plane2);
			_plane3 = new Plane( { width:20, height:20,x:-100, yUp:false, material:new img() } );
			_plane3.bothsides = false;
			_view.scene.addChild(_plane3);
			
		}
		override protected function onEnterFrame(e:Event) : void{
			super.onEnterFrame(e);
			if(_plane1){
				_plane1.rotationY++;
				_plane2.rotationY++;
			}
			
		}
		private function initControls():void{
			var buttonGraphics1:ButtonGraphics=new ButtonGraphics(0x747755,"Animation 1");
			var buttonGraphics2:ButtonGraphics=new ButtonGraphics(0x742255,"Animation 2");
			var buttonGraphics3:ButtonGraphics = new ButtonGraphics(0x747788, "Animation 3");
			buttton1=new SimpleButton(buttonGraphics1,buttonGraphics1,buttonGraphics1,buttonGraphics1);
			buttton2=new SimpleButton(buttonGraphics2,buttonGraphics2,buttonGraphics2,buttonGraphics2);
			buttton3=new SimpleButton(buttonGraphics3,buttonGraphics3,buttonGraphics3,buttonGraphics3);
			this.addChild(buttton1);buttton1.y=80;buttton2.y=80;buttton3.y=80;
			this.addChild(buttton2);buttton2.x=buttton1.height+5;
			this.addChild(buttton3);buttton3.x=buttton2.x+buttton2.height+5;
			buttton1.addEventListener(MouseEvent.CLICK,onMouseClick);
			buttton2.addEventListener(MouseEvent.CLICK,onMouseClick);
			buttton3.addEventListener(MouseEvent.CLICK, onMouseClick);			
		}
		private function onRollOver(e:MouseEvent):void {
		        trace("gotcha");
		}
		private function onMouseClick(e:MouseEvent):void{
			switch(e.target){
				case buttton1:
					_movieClip.gotoAndStop(1);
					_movieClip.play();
					break;
				case buttton2:
					_movieClip.gotoAndStop(20);
					_movieClip.play();
					break;
				case buttton3:
					_movieClip.gotoAndStop(40);
					_movieClip.play();
					break;
				   
					
			}
		}
	}
}