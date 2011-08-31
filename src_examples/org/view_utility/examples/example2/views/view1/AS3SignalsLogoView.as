package org.view_utility.examples.example2.views.view1
{

	/**
	 * @author Peder A. Nielsen
	 */
	public class AS3SignalsLogoView extends LogoView
	{
		[Embed(source="/../bin/examples/assets/as3_signals.jpg")]
		private var AS3SignalsLogo:Class;
		
		public function AS3SignalsLogoView()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			addChild(new AS3SignalsLogo());
		}
	}
}
