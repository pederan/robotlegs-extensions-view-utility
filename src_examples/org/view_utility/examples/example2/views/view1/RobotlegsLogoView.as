package org.view_utility.examples.example2.views.view1
{

	/**
	 * @author Peder A. Nielsen
	 */
	public class RobotlegsLogoView extends LogoView
	{
		[Embed(source="/../bin/examples/assets/rl-header-logo.jpg")]
		private var RobotlegsLogo:Class;
		
		public function RobotlegsLogoView()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			addChild(new RobotlegsLogo());
		}
	}
}
