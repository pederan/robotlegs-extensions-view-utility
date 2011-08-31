package org.view_utility.examples.example2.views
{
	import flash.display.Sprite;
	import org.robotlegs.mvcs.ComponentView;

	/**
	 * @author Peder A. Nielsen
	 */
	public class BackgroundView extends ComponentView
	{
		private var square:Sprite;
		
		public function BackgroundView()
		{
			super();
		}
		
		override protected function initialize():void
		{
			square = new Sprite();
			square.graphics.beginFill(0xF1F1F1);
			square.graphics.drawRect(0, 0, 100, 100);
			square.graphics.endFill();
			addChild(square);
		}
		
		//resize whenever stage resizes (Event.RESIZE). 
		//This method is also called from mediator onRegister to resize at view added to stage 
		override public function onStageResized():void
		{
			square.width = stage.stageWidth;
			square.height = stage.stageHeight;
		}
	}
}
