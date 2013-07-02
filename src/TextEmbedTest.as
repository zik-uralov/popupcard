package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flupie.textanim.*;
	import caurina.transitions.*;
	public class TextEmbedTest extends Sprite
	{
		// Notice that the fontFamily tags are the same for all of these. All I had to do
		// was change the font weight and style and I can use all of them with the same
		// fontFamily.
		[Embed( source = '../lib/Fonts/Action Man.ttf', 
				fontFamily = 'ActionMan', 
				fontWeight = 'normal', 
				fontStyle = 'normal', 
				mimeType = 'application/x-font', 
				advancedAntiAliasing='true', 
				embedAsCFF = 'false')]
		private var actionManFont:Class;
		
		[Embed( source = '../lib/Fonts/Action Man Italic.ttf', 
				fontFamily = 'ActionMan', 
				fontWeight = 'normal', 
				fontStyle = 'italic', 
				mimeType = 'application/x-font', 
				advancedAntiAliasing='true', 
				embedAsCFF = 'false')]
		private var actionManItalicFont:Class;
		
		[Embed( source = '../lib/Fonts/Action Man Bold.ttf', 
				fontFamily = 'ActionMan', 
				fontWeight = 'bold', 
				fontStyle = 'normal', 
				mimeType = 'application/x-font', 
				advancedAntiAliasing='true', 
				embedAsCFF = 'false')]
		private var actionManBoldFont:Class;
		
		[Embed( source = '../lib/Fonts/Action Man Bold Italic.ttf', 
				fontFamily = 'ActionMan', 
				fontWeight = 'bold', 
				fontStyle = 'italic', 
				mimeType = 'application/x-font', 
				advancedAntiAliasing='true', 
				embedAsCFF = 'false')]
		private var actionManBoldItalicFont:Class;
		
		private var t:TextField;
		private var f:TextFormat;
		
		private var counter:int = 0;
		
		public function TextEmbedTest():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			

		}
		
		public function init():void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			// Create the TextField.
			t = new TextField();
			t.antiAliasType = AntiAliasType.ADVANCED;
			t.embedFonts = true;
			t.autoSize = TextFieldAutoSize.CENTER;
			t.htmlText = '<font color="#ff0000\">VSYO!</font>'+"STUDIO";
			t.x = stage.stageWidth / 2;
			t.y = 40;
			t.mouseEnabled = false;
			
			// Create the TextFormat.
			f = new TextFormat();
			f.font = "ActionMan";
			f.align = TextFormatAlign.CENTER;
			//f.color = 0x000000;
			f.size = 30;
			
			t.setTextFormat(f);
			
			addChild(t);
			
			stage.addEventListener(MouseEvent.CLICK, changeFont);
			var txtanim:TextAnim = new TextAnim(t);
			txtanim.mode = TextAnimMode.EDGES_CENTER;
			txtanim.anchorX = TextAnimAnchor.RIGHT;
			txtanim.interval = 105;
			txtanim.blocksVisible = false;
			txtanim.delay = 315;
			txtanim.effects = myEffect;
			txtanim.start();
		}
		
		// This is where we change the font.
		// All that I'm doing is changing the style and weight, but you could just as easily
		// change the font itself by setting f.font to another fontFamily that you embeded at
		// the top.
		
		// I'm not really sure why, but I had to call setTextFormat everytime that I changed
		// the text for it to show up. Maybe because I changed bold and italic, it required it?
		private function changeFont(e:MouseEvent):void {
			switch (counter)
			{
				case 0:
					t.text = "This is Action Man.";
					f.bold = false;
					f.italic = false;
					t.setTextFormat(f);
					break;
				case 1:
					t.text = "This is Action Man Italic.";
					f.bold = false;
					f.italic = true;
					t.setTextFormat(f);
					break;
				case 2:
					t.text = "This is Action Man Bold.";
					f.bold = true;
					f.italic = false;
					t.setTextFormat(f);
					break;
				case 3:
					t.text = "This is Action Man Bold Italic.";
					f.bold = true;
					f.italic = true;
					t.setTextFormat(f);
					break;
				default:
			}
			
			counter++;
			if (counter > 3) counter = 0;
		}

		private function myEffect(block:TextAnimBlock):void {
			block.scaleX = block.scaleY = 0;
			block.rotation = -120;
			Tweener.addTween(block, {rotation:0, scaleX:1, scaleY:1, time:1, transition:"easeoutback"});
		}
	}

}