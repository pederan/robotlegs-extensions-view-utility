package org.view_utility.examples.example2.views.view2
{
	import com.greensock.TweenMax;
	import org.view_utility.examples.example2.views.ContainerView;


	/**
	 * @author Peder A. Nielsen
	 */
	public class View2 extends ContainerView
	{
		private var addSubContainer:Boolean;
		
		public function View2(addSubContainer:Boolean = false) //do not add sub container as default
		{
			super();
			this.addSubContainer = addSubContainer;
		}
		
		override protected function initialize():void
		{
			super.initialize();

			description.width = 600;
			description.text = "This view shows a (container)view that contains another container view which again contains views (phuhh!). " +
			"When this view is added to stage an instance of View2SubContainer is added to this view via the addView method (View 2 is mapped " +
			"as the container of View2SubContainer). From the View2SubContainer an instance of View2SubMenu is added to that view. The sub menu " +
			"will not react to a swap view call from the sub content because the autoRemove property is set to false. " +
			"The sub content views are added via the mapButtonToView method and the view controller makes " +
			"sure that they are added to the View2SubContainer instance because that is their mapped container class type.";
			addChild(description);
		}
		
		//put adding of new views when this view is added to stage	
		override public function addedToStage():void
		{
			//adds sub container if only View 2 is asked for, see buttons swapping to View 2 (not deeplinking)
			if(addSubContainer)
				addView(View2SubContainer); 
			//or addChild(new View2SubContainer()); since it will be added to this view anyway. The instance will still be mapped using addChild. 
//			addView(View2SubContent1); //if you want to add content to the sub container
		}
		
		override public function animateOut():void
		{
			TweenMax.to(this, 1, {autoAlpha:0, onComplete:onAnimationOutCompleted, onCompleteParams:[true]});
		}

	}
}
