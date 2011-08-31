package org.view_utility.examples.example3
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	[SWF(backgroundColor="#FFFFFF", frameRate="30", width="500", height="400")]
	public class Example3 extends Sprite
	{
		private var context:Example3Context;
		
		public function Example3()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			context = new Example3Context(this);
		}
	}
}
