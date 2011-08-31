package org.view_utility.examples.example2.views.view2
{
	import fl.controls.Button;
	import org.view_utility.examples.example2.views.start.StartView;


	/**
	 * @author Peder A. Nielsen
	 */
	public class View2SubContent1 extends View2SubContent
	{
		public function View2SubContent1()
		{
			super();
		}

		override protected function initialize():void
		{
			super.initialize();
			
			headText.text = "View 2 Subcontent 1";
			addChild(headText);
			
			dummyLipsumText.text = "The hierarchical position of this view:\nView2 -> View2SubContainer -> View2SubContent1. " +
			"By clicking the button below View 2 will fade out and bring you back to the start view";
			addChild(dummyLipsumText);
			
			//go to start - deeplinking demo
			var gotoStartBtn:Button = new Button();
			gotoStartBtn.label = "Go back to start";
			gotoStartBtn.y = 130;
			gotoStartBtn.setSize(110, 20);
			addChild(gotoStartBtn);
			mapButtonToView(gotoStartBtn, StartView, onButtonClicked);
		}

	}
}
