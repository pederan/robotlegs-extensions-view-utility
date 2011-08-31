package org.view_utility.examples.example2.views.start
{
	import fl.controls.Button;
	import flash.events.MouseEvent;
	import org.view_utility.examples.example2.views.ContainerView;
	import org.view_utility.examples.example2.views.FooterView;
	import org.view_utility.examples.example2.views.SiteMenu;
	import org.view_utility.examples.example2.views.view1.AS3SignalsLogoView;
	import org.view_utility.examples.example2.views.view1.RobotlegsLogoView;
	import org.view_utility.examples.example2.views.view1.View1;
	import org.view_utility.examples.example2.views.view2.View2;
	import org.view_utility.examples.example2.views.view2.View2SubContent1;



	/**
	 * @author Peder A. Nielsen
	 */
	public class StartView extends ContainerView
	{
		private var addMenuBtn:Button;
		private var addFooterBtn:Button;
		private var swapToView1AndCreateRLAndSignalsLogoBtn:Button;

		public function StartView()
		{
			super();
		}

		override protected function initialize():void
		{
			super.initialize();

			description.width = 620;			
			description.text = "All buttons you see in this view are added directly to this view (StartView). " +
			"The buttons on the top row will add an instance of the main menu and an instance of the footer view to the contextView (parent view of this view). " +
			"The menu view is added using the mapButtonToView method and the footer view is added with the addView convenience method from a mouse event listener. " +
			"This to demonstrate the different approaches. " + 
			"The swap buttons on row 2 will call the animateOut method of this view and swap (without animation) to View 1 or 2. " +
			"The buttons on the bottom row will deeplink to views nested within View 1 and 2. " +
			"\nAll main views in this example is center aligned to stage.";
			addChild(description);
			
			//add site menu using the mapButtonToView method for making a button click create a view
			addMenuBtn = new Button();
			addMenuBtn.label = "Add main menu";
			addMenuBtn.y = 180;
			addMenuBtn.setSize(120, 20);
			addChild(addMenuBtn);
			mapButtonToView(addMenuBtn, SiteMenu, onAddMenuBtnClicked, false);
			
			//add a footer using the ordinary mouseevent listener for click and calling the addView convenience method from the listener
			addFooterBtn = new Button();
			addFooterBtn.label = "Add footer";
			addFooterBtn.x = 130;
			addFooterBtn.y = 180;
			addFooterBtn.setSize(120, 20);
			addChild(addFooterBtn);
			addFooterBtn.addEventListener(MouseEvent.CLICK, onAddFooterClicked);
			//or
//			mapButtonToView(addFooterBtn, FooterView, onButtonClicked);

			//swap view on same context
			var swapToView1Btn:Button = new Button();
			swapToView1Btn.label = "Go to view 1";
			swapToView1Btn.y = 210;
			swapToView1Btn.setSize(120, 20);
			addChild(swapToView1Btn);
			mapButtonToView(swapToView1Btn, View1, onButtonClicked);
			
			//swap view on same context
			var swapToView2Btn:Button = new Button();
			swapToView2Btn.label = "Go to view 2";
			swapToView2Btn.x = 130;
			swapToView2Btn.y = 210;
			swapToView2Btn.setSize(120, 20);
			addChild(swapToView2Btn);
			mapButtonToView(swapToView2Btn, View2, onButtonClicked, true, true); //pass as constructor parameter

			//deep linking
			var swapToView1AndCreateRLLogoBtn:Button = new Button();
			swapToView1AndCreateRLLogoBtn.label = "Go to View 1 and add a RL logo";
			swapToView1AndCreateRLLogoBtn.y = 240;
			swapToView1AndCreateRLLogoBtn.setSize(180, 20);
			addChild(swapToView1AndCreateRLLogoBtn);
			mapButtonToView(swapToView1AndCreateRLLogoBtn, RobotlegsLogoView, onButtonClicked);

			//create rl and signals logos
			swapToView1AndCreateRLAndSignalsLogoBtn = new Button();
			swapToView1AndCreateRLAndSignalsLogoBtn.label = "Go to View 1 and add a RL and a Signals logo";
			swapToView1AndCreateRLAndSignalsLogoBtn.x = 190;
			swapToView1AndCreateRLAndSignalsLogoBtn.y = 240;
			swapToView1AndCreateRLAndSignalsLogoBtn.setSize(250, 20);
			addChild(swapToView1AndCreateRLAndSignalsLogoBtn);
			swapToView1AndCreateRLAndSignalsLogoBtn.addEventListener(MouseEvent.CLICK, onCreateLogos);
			
			//deep linking
			var swapToView2SubContentBtn:Button = new Button();
			swapToView2SubContentBtn.label = "Go to Subcontent 1 in View 2";
			swapToView2SubContentBtn.x = 450;
			swapToView2SubContentBtn.y = 240;
			swapToView2SubContentBtn.setSize(170, 20);
			addChild(swapToView2SubContentBtn);
			mapButtonToView(swapToView2SubContentBtn, View2SubContent1, onButtonClicked);
		}

		//override autoAlpha:1 in super view
		override public function animateIn():void
		{
			this.alpha = 1;
			this.visible = true;
		}
		
		//override autoAlpha:0 in super view and just dispatch animation out completed which makes sure the new view is added and removes this one
		override public function animateOut():void
		{
			onAnimationOutCompleted(true);
		}

		private function onCreateLogos(event:MouseEvent):void
		{
			swapView(RobotlegsLogoView);
			addView(AS3SignalsLogoView);
		}

		private function onAddMenuBtnClicked(event:MouseEvent):void
		{
			super.onButtonClicked(event);
			// disable the add menu button - we only allow one menu instance on stage
			addMenuBtn.enabled = false;
		}
			
		private function onAddFooterClicked(event:MouseEvent):void
		{
			addFooterBtn.enabled = false;
			addView(FooterView);
		}
			
		override public function destroy():void
		{
			super.destroy();
			addFooterBtn.removeEventListener(MouseEvent.CLICK, onAddFooterClicked);
			swapToView1AndCreateRLAndSignalsLogoBtn.removeEventListener(MouseEvent.CLICK, onCreateLogos);
		}
	}
}
