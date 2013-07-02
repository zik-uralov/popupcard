package 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	/**
	 * ...
	 * @author zzz
	 */
	public class LoadHere extends MovieClip
	{
		public function LoadHere():void {
		var request:URLRequest = new URLRequest("Content.swf");
		var loader:Loader = new Loader();

        loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
		loader.load(request);
        this.addChild(loader);
		}
		function loadProgress(event:ProgressEvent):void
		{
			var percentLoaded:Number = event.bytesLoaded / event.bytesTotal;
			percentLoaded = Math.round(percentLoaded * 100);
            
			//this.percentLoaded.text = String(uint(percentLoaded)) + "%";
		}

		function loadComplete(event:Event):void
		{
			trace("Load Complete");
		}
	}
	
}