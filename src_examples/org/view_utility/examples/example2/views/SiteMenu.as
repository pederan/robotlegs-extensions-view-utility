package org.view_utility.examples.example2.views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import fl.controls.Button;
	import org.robotlegs.mvcs.ComponentView;
	import org.view_utility.examples.example2.views.start.StartView;
	import org.view_utility.examples.example2.views.view1.View1;
	import org.view_utility.examples.example2.views.view2.View2;



	/**
	 * @author Peder A. Nielsen
	 */
	public class SiteMenu extends ComponentView
	{
		private var swapToView1Btn:Button;
		private var swapToView2Btn:Button;
		
		public function SiteMenu()
		{
			super();
		}

		override protected function initialize():void
		{
			this.y = -100; //position off stage
			//add menu buttons
			swapToView1Btn = new Button();
			swapToView1Btn.label = "Go to view 1";
			swapToView1Btn.setSize(120, 20);
			addChild(swapToView1Btn);
			mapButtonToView(swapToView1Btn, View1, onButtonClicked);
			
			swapToView2Btn = new Button();
			swapToView2Btn.label = "Go to view 2";
			swapToView2Btn.x = 140;
			swapToView2Btn.setSize(120, 20);
			addChild(swapToView2Btn);
			mapButtonToView(swapToView2Btn, View2, onButtonClicked, true, true); //pass true to constructor for adding sub content
		}

		override public function animateIn():void
		{
			TweenLite.to(this, 1, {y:20, ease:Expo.easeOut});
		}

		override public function onViewAdded(viewInstance:Object):void
		{
			if(viewInstance is View1)
			{
				swapToView1Btn.enabled = false;
				swapToView2Btn.enabled = true;
			} else if(viewInstance is View2)
			{
				swapToView2Btn.enabled = false;
				swapToView1Btn.enabled = true;
			} else if(viewInstance is StartView)
			{
				swapToView1Btn.enabled = true;
				swapToView2Btn.enabled = true;
			}
		}

		override public function onStageResized():void
		{
			this.x = (stage.stageWidth - this.width) * .5;
		}
	}
}
