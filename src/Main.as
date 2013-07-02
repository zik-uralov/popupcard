package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author zzz
	 */
	public class Main extends MovieClip
	{
		public var hero_mc:Hero = new Hero();
		public function Main():void 
		{   
			hero_mc.x = 100;
			hero_mc.y = 100;
			addChild(hero_mc);
			hero_mc.addEventListener(MouseEvent.MOUSE_DOWN, HeroStop);
			addEventListener(MouseEvent.MOUSE_UP, HeroPlay);
			//hero_mc.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, handleMouseWheel);
			
		}
        private function handleMouseWheel(event:MouseEvent):void 
		{
				if ((event.delta > 0 && hero_mc.y < 400) || (event.delta < 0 && hero_mc.y > 100)) {
				hero_mc.y = hero_mc.y + (event.delta * 3);		
				}
		}
		private function HeroStop(e:MouseEvent):void {
			trace("YES!!!");
			hero_mc.stop();
			hero_mc.startDrag();
		}
		private function HeroPlay(e:MouseEvent):void {
			trace("YES!!!");
			hero_mc.play();
			hero_mc.stopDrag();
		}
	}
	
}