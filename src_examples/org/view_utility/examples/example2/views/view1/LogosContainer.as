package org.view_utility.examples.example2.views.view1
{
	import org.view_utility.examples.example2.views.ContainerView;
	
	/**
	 * @author Peder A. Nielsen
	 */
	public class LogosContainer extends ContainerView
	{
		private var logoCount:uint;
		private var logosOnEachLine:uint = 4;
		
		public function LogosContainer()
		{
			super();
		}

		override protected function initialize():void
		{
			super.initialize();
			this.x = 400;
			this.y = 10;
		}

		override public function onViewAdded(viewInstance:Object):void
		{
			super.onViewAdded(viewInstance);
			//listener for new views added. Check for new logo and position it
			if(viewInstance is LogoView)
			{
				viewInstance.x = (logoCount % logosOnEachLine) * (viewInstance.width + 10);
				viewInstance.y = Math.floor(logoCount / logosOnEachLine) * (viewInstance.height + 10) + 30;
				logoCount++;
			}
		}
		
		override public function onStageResized():void
		{
			//do not center this container view
		}
	
	}
}
