package {
	import com.adobe.images.JPGEncoder;
	import com.adobe.webapis.flickr.methodgroups.Upload;
	import flash.geom.Matrix;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	//import PNGEncoder;
	import com.bit101.components.PushButton;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	import flash.net.FileReference;
	//import fl.events.ColorPickerEvent;
    import flash.geom.ColorTransform;
	import flash.events.Event;
	import flash.utils.ByteArray;
    import nl.stroep.utils.*;
	import flash.events.IOErrorEvent;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.net.URLRequestMethod;
	[SWF(width = '800', height = '500', frameRate = '60', backgroundColor = '#ffffff')] 
    
	public class Artist extends MovieClip{
	//Are we drawing or not?
	private var drawing:Boolean;
	public var board:MovieClip = new MovieClip();
	public var pencilDraw:Shape = new Shape();
	public var SaveButton:PushButton;
	public var SaveOnServer:PushButton;
	
   // private var myColorPicker.selectedColor = 0xffffff;
	//myColorPicker.selectedColor = 0xffffff;
	public function Artist() {
        SaveButton = new PushButton(stage, 20, 20, "SAVE IMAGE", save);
		SaveOnServer = new PushButton(stage, 500, 20, "SAVE on server", saveonServer);
		board.x = 30;
		board.y = 100;
		
		
		board.graphics.lineStyle(2, 0x000000, 50, false, "normal");
		/*var fillType:String = GradientType.RADIAL;
        var colors:Array = [0xFF0000, 0x0000FF];
        var alphas:Array = [100, 100];
		var ratios:Array = [0, 255];
		var matr:Matrix = new Matrix();
		matr.createGradientBox(200, 100, 0, -50, 100);
		var spreadMethod:String = SpreadMethod.REFLECT; //REPEATE, PAD, OR REFLECT
 
		board.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
		board.graphics.endFill();*/
		board.graphics.drawRect(0, 0, 600, 300);
		
		pencilDraw.graphics.lineStyle(1,0x000000);
		drawing = false;//to start with
		stage.addChild(board);
		stage.addEventListener(MouseEvent.MOUSE_DOWN, startDrawing);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, draw);
		stage.addEventListener(MouseEvent.MOUSE_UP, stopDrawing);
		//board.addEventListener(MouseEvent.ROLL_OVER, stopDrawing);
	}
	public function startDrawing(event:MouseEvent):void{
		//move to the correct starting position for drawing
		//pencilDraw = new Shape();
		board.addChild(pencilDraw);
		pencilDraw.graphics.lineStyle(1,0x000000);
		pencilDraw.graphics.moveTo( board.mouseX, board.mouseY);
		drawing = true;
		board.addEventListener(MouseEvent.MOUSE_MOVE, draw);
         
	}
	public function draw(event:MouseEvent):void{
		if (drawing) {
			
			pencilDraw.graphics.lineTo(board.mouseX, board.mouseY);
			
		}
	}
	public function stopDrawing(event:MouseEvent):void {
		board.removeEventListener(MouseEvent.MOUSE_MOVE, draw);
		drawing = false;
	}
	private function export():void
		{
			var bmd:BitmapData = new BitmapData(600, 300);
			bmd.draw(board);
			var ba:ByteArray = PNGEncoder.encode(bmd);
			var file:FileReference= new FileReference();
			file.addEventListener(Event.COMPLETE, saveSuccessful);
			file.save(ba, "MyDrawing.png");
            //var encoder:JPGEncoder = new JPGEncoder(50);
            //var photoData:ByteArray = encoder.encode(bmd);
            
		}
		private function ExportToServer():void
		{
			board.visible = false;
			var bmd:BitmapData = new BitmapData(600, 300,true,0);
			bmd.draw(board);
			var ba:ByteArray = PNGEncoder.encode(bmd);
			var file:FileReference= new FileReference();
			file.addEventListener(Event.COMPLETE, saveSuccessful);
			file.save(ba, "MyDrawing.png");
            //var encoder:PNGEncoder= new PNGEncoder();
            var photoData:ByteArray = PNGEncoder.encode(bmd);
            
			
			 var urlLoader:URLLoader = new URLLoader();
			 //Set jpg quality of the image to be export 1-100
			 //var myEncoder:JPGEncoder = new JPGEncoder(80);
			 //Create jpg to be exported
			// var jpgSource:BitmapData = new BitmapData (mcHolder.mcMask.width, mcHolder.mcMask.height);
			 //jpgSource.draw(myCroppedImage, m);
			 //Create byte array to hold jpg data
			 //var byteArray:ByteArray = myEncoder.encode(jpgSource);
			 var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
			 //Send image to the server to be saved
			 var saveJPG:URLRequest = new URLRequest("saveImage.php?r="+"12344.png");
			 saveJPG.requestHeaders.push(header);
			 saveJPG.method = URLRequestMethod.POST;
			 saveJPG.data = photoData;
			 urlLoader.addEventListener(Event.COMPLETE, save);
			 urlLoader.load(saveJPG);
		}
       private function saveSuccessful(e:Event):void
		{
            trace("YOU SAVED IMAGE!!!");
		}
		private function save(e:MouseEvent):void
		{
			export();
		}private function saveonServer(e:MouseEvent):void
		{
			ExportToServer();
		}

  }
}