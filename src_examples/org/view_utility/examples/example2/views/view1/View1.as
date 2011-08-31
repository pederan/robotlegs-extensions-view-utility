package org.view_utility.examples.example2.views.view1
{
	import fl.controls.Button;
	import flash.events.MouseEvent;
	import org.view_utility.examples.example2.views.ContainerView;
	import org.view_utility.examples.example2.views.start.StartView;
	import org.view_utility.examples.example2.views.view2.View2;



	/**
	 * @author Peder A. Nielsen
	 */
	public class View1 extends ContainerView
	{
		private var removeRobotlegsLogoBtn:Button;
		private var removeSignalsLogoBtn:Button;
		private var removeAllLogosBtn:Button;
		private var removeLogosContainerBtn:Button;

		public function View1()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();

			description.width = 385;
			description.text = 
			"All buttons you see in this view are added directly to this view (View1). The logo add buttons will add logos on the " +
			"right side of this page. The logos are mapped to container view LogosContainer, which means that the first time a logo " +
			"is added a new instance of LogosContainer is created and added to View 1 (View1 is the mapped container to LogosContaoner). " +
			"The logo is then added to LogosContainer. The next time a logo is created it is added to the current LogosContainer instance. " +
			"The remove buttons will either remove all instances of a class type, remove all logos, or remove the logos container including " +
			"all existing logos. The buttons on the bottom rows are there so you're not lost if you didn't add the menu from the start page";
			addChild(description);
			
			//Add action buttons
			var addRobotlegsLogoBtn:Button = new Button();
			addRobotlegsLogoBtn.label = "Add Robotlegs logo";
			addRobotlegsLogoBtn.y = 270;
			addRobotlegsLogoBtn.setSize(120, 20);
			mapButtonToView(addRobotlegsLogoBtn, RobotlegsLogoView, onButtonClicked, false);
			addChild(addRobotlegsLogoBtn);
			
			var addSignalsLogoBtn:Button = new Button();
			addSignalsLogoBtn.label = "Add Signals Logo";
			addSignalsLogoBtn.y = 300;
			addSignalsLogoBtn.setSize(120, 20);
			mapButtonToView(addSignalsLogoBtn, AS3SignalsLogoView, onButtonClicked, false);
			addChild(addSignalsLogoBtn);
			
			//remove action buttons
			removeRobotlegsLogoBtn = new Button();
			removeRobotlegsLogoBtn.label = "Remove Robotlegs Logos";
			removeRobotlegsLogoBtn.x = 130;
			removeRobotlegsLogoBtn.y = 270;
			removeRobotlegsLogoBtn.setSize(150, 20);
			removeRobotlegsLogoBtn.addEventListener(MouseEvent.CLICK, onRemoveRobotlegsLogos);
			addChild(removeRobotlegsLogoBtn);
			
			removeSignalsLogoBtn = new Button();
			removeSignalsLogoBtn.label = "Remove Signals Logos";
			removeSignalsLogoBtn.x = 130;
			removeSignalsLogoBtn.y = 300;
			removeSignalsLogoBtn.setSize(150, 20);
			removeSignalsLogoBtn.addEventListener(MouseEvent.CLICK, onRemoveSignalsLogos);
			addChild(removeSignalsLogoBtn);
			
			removeAllLogosBtn = new Button();
			removeAllLogosBtn.label = "Remove All Logos";
			removeAllLogosBtn.x = 130;
			removeAllLogosBtn.y = 330;
			removeAllLogosBtn.setSize(150, 20);
			removeAllLogosBtn.addEventListener(MouseEvent.CLICK, onRemoveAllLogos);
			addChild(removeAllLogosBtn);
			
			removeLogosContainerBtn = new Button();
			removeLogosContainerBtn.label = "Remove Logos Container";
			removeLogosContainerBtn.x = 130;
			removeLogosContainerBtn.y = 360;
			removeLogosContainerBtn.setSize(150, 20);
			removeLogosContainerBtn.addEventListener(MouseEvent.CLICK, onRemoveLogosContainer);
			addChild(removeLogosContainerBtn);

			//Back / Swap view
			var backToStartBtn:Button = new Button();
			backToStartBtn.label = "<- Back to start";
			backToStartBtn.y = 390;
			backToStartBtn.setSize(120, 20);
			mapButtonToView(backToStartBtn, StartView, onButtonClicked, true);
			addChild(backToStartBtn);
			
			var swapToView2Btn:Button = new Button();
			swapToView2Btn.label = "Swap to View 2 ->";
			swapToView2Btn.x = 130;
			swapToView2Btn.y = 390;
			swapToView2Btn.setSize(150, 20);
			mapButtonToView(swapToView2Btn, View2, onButtonClicked, true, true);
			addChild(swapToView2Btn);
			
		}

		private function onRemoveSignalsLogos(event:MouseEvent):void
		{
			removeView(AS3SignalsLogoView);
		}
		
		private function onRemoveRobotlegsLogos(event:MouseEvent):void
		{
			removeView(RobotlegsLogoView);
		}
		
		private function onRemoveAllLogos(event:MouseEvent):void
		{
			removeViewsInContainer(LogosContainer); //set false as second arg to remove immediately
		}
		
		private function onRemoveLogosContainer(event:MouseEvent):void
		{
			removeView(LogosContainer);
		}
		
		//reposition content if content size changes
		override public function onViewAdded(viewInstance:Object):void
		{
			onStageResized();
		}
		
		//reposition content if content size changes
		override public function onViewRemoved(viewInstance:Object):void
		{
			try
			{	
				onStageResized();
			} catch(error:Error) { }
		}
		
		override public function destroy():void
		{
			super.destroy();
			//release for gc
			removeRobotlegsLogoBtn.removeEventListener(MouseEvent.CLICK, onRemoveRobotlegsLogos);
			removeSignalsLogoBtn.removeEventListener(MouseEvent.CLICK, onRemoveSignalsLogos);
			removeAllLogosBtn.removeEventListener(MouseEvent.CLICK, onRemoveAllLogos);
			removeLogosContainerBtn.removeEventListener(MouseEvent.CLICK, onRemoveLogosContainer);
		}
		
	}
}
