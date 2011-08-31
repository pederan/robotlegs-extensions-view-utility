package org.view_utility.examples.example2
{
	import flash.text.Font;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Sprite;

	[SWF(backgroundColor="#FFFFFF", frameRate="30", width="800", height="500")]
	public class Example2 extends Sprite
	{
		private var context:Example2Context;
		
		public function Example2()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Font.registerFont(FontClass_123b6b21bb592550_copperplateGothicBold);
			Font.registerFont(FontClass_123b6b21bb592550_arial);
			
			context = new Example2Context(this);
		}
	}
}
