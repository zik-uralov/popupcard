package
{
	import away3d.containers.ObjectContainer3D;
	import away3d.materials.MovieMaterial;
	import away3d.primitives.Plane;
	
	import flash.display.MovieClip;

	[SWF(backgroundColor="#677999", frameRate="30", quality="LOW", width="800", height="600")]
	public class MovieMaterialControl extends AwayTemplate
	{
		private var _movie:MovieClip=new SplitMovie();
		private var _movieMat1:MovieMaterial;
		private var _movieMat2:MovieMaterial;
		private var _movieMat3:MovieMaterial;
		private var _movieMat4:MovieMaterial;
		private var _plane1:Plane;
		private var _plane2:Plane;
		private var _plane3:Plane;
		private var _plane4:Plane;
		private var _planeContainer:ObjectContainer3D;
		public function MovieMaterialControl()
		{
			super();

		}
		override protected function initMaterials() : void{
			_movieMat1=new MovieMaterial(_movie);_movieMat1.smooth=true;
			_movieMat2=new MovieMaterial(_movie);_movieMat2.smooth=true;
			_movieMat3=new MovieMaterial(_movie);_movieMat3.smooth=true;
			_movieMat4=new MovieMaterial(_movie);_movieMat4.smooth=true;
			_movieMat1.lockH=128;
			_movieMat1.lockW=128;
			_movieMat2.scaleX=2;
			_movieMat2.scaleY=2;
			
			_movieMat2.offsetX=-256;
			_movieMat3.scaleX=2;
			_movieMat3.scaleY=2;
			_movieMat3.offsetY=-256;
			_movieMat4.scaleX=2;
			_movieMat4.scaleY=2;
			_movieMat4.offsetY=-256;
			_movieMat4.offsetX=-256;
			
		}
		override protected function initGeometry() : void{
			_planeContainer=new ObjectContainer3D();
			_plane1=new Plane({width:200,height:200,x:-110,y:105,yUp:false});
			_plane2=new Plane({width:200,height:200,x:110,y:105,yUp:false});
			_plane3=new Plane({width:200,height:200,x:-110,y:-105,yUp:false});
			_plane4=new Plane({width:200,height:200,x:110,y:-105,yUp:false});
			_plane1.material=_movieMat1;
			
			_planeContainer.addChild(_plane1);
			_plane2.material=_movieMat2;
			_planeContainer.addChild(_plane2);
			_plane3.material=_movieMat3;
			_planeContainer.addChild(_plane3);
			_plane4.material=_movieMat4;
			_planeContainer.addChild(_plane4);
			_view.scene.addChild(_planeContainer);
			_cam.z=-1000;
			
			
		}
	}
}