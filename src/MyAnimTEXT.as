package 
{
	import flash.display.MovieClip;
	import flash.text.*;
	import flupie.textanim.*;
    import caurina.transitions.*;

	/**
	 * ...
	 * @author zzz
	 */
	public class MyAnimTEXT extends MovieClip
	{
		protected var myTextField:TextField;
		public function MyAnimTEXT() {
			super();
    //Creating the textfield object and naming it "myTextField"  
		var myTextField:TextField = new TextField();  
		  
		//Here we add the new textfield instance to the stage with addchild()  
		  
		  
		//Here we define some properties for our text field, starting with giving it some text to contain.  
		//A width, x and y coordinates.  
		myTextField.text = "some text here!";  
		myTextField.width = 250;  
		myTextField.x = 25;  
		myTextField.y = 25;  
		  
		//Here are some great properties to define, first one is to make sure the text is not selectable, then adding a border.  
		myTextField.selectable = false;  
		myTextField.border = true;  
		  
		//This last property for our textfield is to make it autosize with the text, aligning to the left.  
		myTextField.autoSize = TextFieldAutoSize.LEFT;  
		  
		//This is the section for our text styling, first we create a TextFormat instance naming it myFormat  
		var myFormat:TextFormat = new TextFormat();  
		  
		//Giving the format a hex decimal color code  
		myFormat.color = 0xAA0000;   
		  
		//Adding some bigger text size  
		myFormat.size = 24;  
		  
		//Last text style is to make it italic.  
		myFormat.italic = true;  
		  
		//Now the most important thing for the textformat, we need to add it to the myTextField with setTextFormat.  
		myTextField.setTextFormat(myFormat);  
		addChild(myTextField);
			var txtanim:TextAnim = new TextAnim(myTextField);
			txtanim.mode = TextAnimMode.EDGES_CENTER;
			txtanim.interval = 105;
			txtanim.blocksVisible = true;
			txtanim.delay = 315;
			txtanim.effects = myEffect;
			txtanim.start();
		}

		private function myEffect(block:TextAnimBlock):void {
			block.scaleX = block.scaleY = 0;
			block.rotation = -120;
			Tweener.addTween(block, {rotation:0, scaleX:1, scaleY:1, time:.5, transition:"easeoutback"});
		}

		//create effect using the tween engine that you prefer
	}
	
}