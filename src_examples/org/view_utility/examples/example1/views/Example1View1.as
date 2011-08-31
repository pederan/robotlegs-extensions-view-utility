package org.view_utility.examples.example1.views
{

	/**
	 * @author Peder A. Nielsen
	 */
	public class Example1View1 extends Example1View
	{
		public function Example1View1()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			headText.text = "View 1";
			addChild(headText);
			
			dummyLipsumText.text = "This example demonstrates swapping between two views using the mapButtonToView method. " +
			"Donec mattis iaculis augue, vel bibendum arcu convallis at. Praesent a magna tellus. " +
			"Fusce ultrices facilisis nisl, nec vulputate mi imperdiet at. Nullam molestie lacus sit amet justo sagittis posuere. " +
			"Nam in purus enim, a rhoncus purus. Suspendisse a interdum magna. In sit amet velit est, at luctus lacus. " +
			"Aenean at venenatis magna. Pellentesque eros mauris, aliquam quis condimentum eget, consectetur ut ipsum?";
			addChild(dummyLipsumText);
		}
		
	}
}
