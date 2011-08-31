package org.view_utility.examples.example2.commands
{
	import org.robotlegs.mvcs.ViewSignalCommand;
	import org.view_utility.examples.example2.views.MainContentContainer;
	import org.view_utility.examples.example2.views.start.StartView;
	import org.view_utility.examples.example2.views.view1.AS3SignalsLogoView;
	import org.view_utility.examples.example2.views.view1.LogosContainer;
	import org.view_utility.examples.example2.views.view1.RobotlegsLogoView;
	import org.view_utility.examples.example2.views.view1.View1;
	import org.view_utility.examples.example2.views.view2.View2;
	import org.view_utility.examples.example2.views.view2.View2SubContainer;
	import org.view_utility.examples.example2.views.view2.View2SubContent1;
	import org.view_utility.examples.example2.views.view2.View2SubContent2;
	import org.view_utility.examples.example2.views.view2.View2SubMenu;

	/**
	 * @author Peder A. Nielsen
	 */
	public class ProjectSetupCommand extends ViewSignalCommand
	{
		override public function execute():void
		{
			//map container to view -> ensures that the view is added to the container of that type. 
			//If an instance of the container doesn't exists, a new instance will be created
			//The requirements for containers is that they are DisplayObjectContainer, but should be IComponentView if it 
			//should be listening to remove signals etc. MainContentContainer will never be removed so ok to extend Sprite.
			viewContextMap.mapContainerClassToView(MainContentContainer, StartView, View1, View2);
			viewContextMap.mapContainerClassToView(View1, LogosContainer);
			viewContextMap.mapContainerClassToView(LogosContainer, RobotlegsLogoView, AS3SignalsLogoView);
			viewContextMap.mapContainerClassToView(View2, View2SubContainer);
			viewContextMap.mapContainerClassToView(View2SubContainer, View2SubMenu, View2SubContent1, View2SubContent2);
		}
	}
}
