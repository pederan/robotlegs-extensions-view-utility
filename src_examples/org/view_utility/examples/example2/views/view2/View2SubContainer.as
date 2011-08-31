package org.view_utility.examples.example2.views.view2
{
	import org.view_utility.examples.example2.views.ContainerView;

	/**
	 * @author Peder A. Nielsen
	 */
	public class View2SubContainer extends ContainerView
	{
		public function View2SubContainer()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			this.x = 20; //indent to illustrate hierachy
			this.y = 180;
		}
		
		override public function addedToStage():void
		{
			//add the menu to this view (this view is mapped as the container for the menu)
			addView(View2SubMenu);
			//just to note: you could add the view thee standard as3 way, since View2SubMenu is mapped to this view 
			//and will be added to this view via addView method anyway
//			addChild(new View2SubMenu());
		}
		
		//override centering of content
		override public function onStageResized():void
		{
		}

	}
}
