package org.view_utility.examples.example2.views.view2
{

	/**
	 * @author Peder A. Nielsen
	 */
	public class View2SubContent2 extends View2SubContent
	{
		public function View2SubContent2()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			headText.text = "View 2 Subcontent";
			addChild(headText);
			
			dummyLipsumText.text = "This view is purely here make it two sub views so a menu could be added. " +
			"Donec mattis iaculis augue, vel bibendum arcu convallis at. Praesent a magna tellus.";
			addChild(dummyLipsumText);
		}
	}
}
