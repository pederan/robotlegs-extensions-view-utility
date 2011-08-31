package org.view_utility.examples.example1.views
{
	import fl.controls.Button;

	import org.robotlegs.mvcs.ComponentView;

	/**
	 * @author Peder A. Nielsen
	 */
	public class Example1Menu extends ComponentView
	{
		public function Example1Menu(xValue:uint, yValue:uint)
		{
			super();
			autoRemove = false; //do not remove this view even though a remove signal is received
			this.x = xValue;
			this.y = yValue;
		}

		override protected function initialize():void
		{
			//add menu buttons
			var swapToView1Btn:Button = new Button();
			swapToView1Btn.label = "Go to view 1";
			swapToView1Btn.setSize(120, 20);
			addChild(swapToView1Btn);
			//swap to view 1 when clicking swapToView1Btn. 
			//The button click listener will automatically be removed when this view is removed from stage
			mapButtonToView(swapToView1Btn, Example1View1, onButtonClicked);
			
			var swapToView2Btn:Button = new Button();
			swapToView2Btn.label = "Go to view 2";
			swapToView2Btn.y = 30;
			swapToView2Btn.setSize(120, 20);
			addChild(swapToView2Btn);
			mapButtonToView(swapToView2Btn, Example1View2, onButtonClicked); //swap to view 2 when clicking swapToView2Btn 
		}
	}
}
