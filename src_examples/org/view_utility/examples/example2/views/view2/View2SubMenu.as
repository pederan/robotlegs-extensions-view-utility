package org.view_utility.examples.example2.views.view2
{
	import fl.controls.Button;
	import org.robotlegs.mvcs.ComponentView;

	/**
	 * @author Peder A. Nielsen
	 */
	public class View2SubMenu extends ComponentView
	{
		public function View2SubMenu()
		{
			super();
			autoRemove = false; //do not remove the menu when dispatching remove signal on the parent container's context
		}
		
		override protected function initialize():void
		{
			super.initialize();
			//add menu buttons
			var swapToView1Btn:Button = new Button();
			swapToView1Btn.label = "Sub view 1";
			swapToView1Btn.y = 30;
			swapToView1Btn.setSize(90, 20);
			addChild(swapToView1Btn);
			mapButtonToView(swapToView1Btn, View2SubContent1, onButtonClicked); //swap to view 1 when clicking swapToView1Btn 
			
			var swapToView2Btn:Button = new Button();
			swapToView2Btn.label = "Sub view 2";
			swapToView2Btn.y = 60;
			swapToView2Btn.setSize(90, 20);
			addChild(swapToView2Btn);
			mapButtonToView(swapToView2Btn, View2SubContent2, onButtonClicked); //swap to view 2 when clicking swapToView2Btn 
		}
	}
}
