package utils
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ButtonGraphics extends Sprite
	{
		public function ButtonGraphics(color:uint,label:String)
		{
			init(color,label);
		}
		private function init(color:uint,label:String):void{
			var shape:Shape=new Shape();
			shape.graphics.lineStyle(1,0x994488);
			shape.graphics.beginFill(color);///0x747755
			shape.graphics.drawRoundRect(0,0,100,35,5,5);
			shape.graphics.endFill();
			this.addChild(shape);
			var txt:TextField=new TextField();
			var tFormat:TextFormat=new TextFormat();
			tFormat.size=13;
			tFormat.align="center";	
			tFormat.bold=true;
			txt.defaultTextFormat=tFormat;
			txt.text=label;
			this.addChild(txt);
		    txt.y=(shape.height/2)-Number(tFormat.size);
			
		}
	}
}