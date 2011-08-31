package org.view_utility.examples.example2.views.view1
{
	import com.greensock.TweenLite;

	import org.robotlegs.mvcs.ComponentView;

	/**
	 * @author Peder A. Nielsen
	 */
	public class LogoView extends ComponentView
	{
		
		public function LogoView()
		{
			super();
		}

		override protected function initialize():void
		{
			this.alpha = 0;
		}
			
		override public function animateIn():void
		{
			TweenLite.to(this, 1, {alpha:1});
		}

		override public function animateOut():void
		{
			TweenLite.to(this, 1, {alpha:0, onComplete:onAnimationOutCompleted});
		}
		
	}
}
