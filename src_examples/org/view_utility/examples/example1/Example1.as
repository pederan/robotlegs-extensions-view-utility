package org.view_utility.examples.example1
{
	import flash.text.Font;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	[SWF(backgroundColor="#FFFFFF", frameRate="30", width="500", height="400")]
	public class Example1 extends Sprite
	{
		private var context:Example1Context;
		
		public function Example1()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Font.registerFont(FontClass_123b6b21bb592550_copperplateGothicBold);
			Font.registerFont(FontClass_123b6b21bb592550_arial);
			
			context = new Example1Context(this);
		}
	}
}
