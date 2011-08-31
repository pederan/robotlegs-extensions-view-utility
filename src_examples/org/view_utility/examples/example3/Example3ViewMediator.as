package org.view_utility.examples.example3
{
	import org.robotlegs.mvcs.ComponentViewMediator;

	/**
	 * @author Peder A. Nielsen
	 */
	public class Example3ViewMediator extends ComponentViewMediator
	{
		override public function onRegister():void
		{
			super.onRegister();
		}
		
		//eksample : override two of the abstract methods to implement custom behavior
		override protected function onViewAnimationInStarted():void
		{
			trace("Example3ViewMediator.as @ onViewAnimationInStarted()");
		}

		override protected function onViewAnimationInCompleted():void
		{
			trace("Example3ViewMediator.as @ onViewAnimationInCompleted()");
			//cast to Example3View since view is injected as IComponentView
			Example3View(view).displayMessage("Hello from Example3ViewMediator");
		}
		

	}
}
