package org.robotlegs.mvcs
{
	import org.robotlegs.signals.RemoveViewSignal;
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IViewContextMap;
	import org.robotlegs.signals.AddViewSignal;
	import org.robotlegs.signals.CreateViewSignal;

	/**
	 * Abstract MVCS SignalCommand implementation.
	 * 
	 * <p>Let your command classes extend ViewSignalCommand to access the convenience methods for adding, swapping and removing views. 
	 * This command class also has access to the ViewContextMap, by which it can link view classes to container classes.</p> 
	 * 
	 * @see https://github.com/destroytoday/signals-extensions-CommandSignal SignalCommand
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 */
	public class ViewSignalCommand extends SignalCommand
	{

		[Inject]
		public var viewContextMap:IViewContextMap;
		
		[Inject]
		public var createViewSignal:CreateViewSignal;
		
		[Inject]
		public var addViewSignal:AddViewSignal;
		
		[Inject]
		public var removeViewSignal:RemoveViewSignal;
		
		/**  Convenience method for swapping an existing view with a new one */
		protected function swapView(viewClass:Class, ...args):void
		{
			if(viewContextMap.verifyViewClass(viewClass))
			{
				createViewSignal.dispatch(viewClass, args);
				Signal(viewContextMap.getContextRemoveSignalByClass(viewClass)).dispatch(true);
			}
		}
		
		/** Convenience method for adding a new view to the context */
		protected function addView(viewClass:Class, ...args):void
		{
			if(viewContextMap.verifyViewClass(viewClass))
			{
				createViewSignal.dispatch(viewClass, args);
				addViewSignal.dispatch();
			}
		}
		
		/**
		 * Convenience method for removing a view by class
		 * 
		 * @param viewClass The class type of the view to remove
		 * @param animateOut If the view should animate out or be removed directly (optional)
		 */
		protected function removeView(viewClass:Class, animateOut:Boolean = true):void
		{
			removeViewSignal.dispatch(viewClass, animateOut);
		}
		
		/**
		 * Convenience method for removing all (IComponent)views in a container.
		 * 
		 * @param containerClass The class type of the container which contains all the views that should be removed
		 * @param animateOut Whether the view(s) should animate out before removal
		 */
		protected function removeViewsInContainer(containerClass:Class, animateOut:Boolean = true):void
		{
			//get remove view signal for the passed context class
			var contextClassRemoveSignal:Signal = viewContextMap.getContextRemoveSignalByContainerClass(containerClass);
			contextClassRemoveSignal.dispatch(animateOut);
		}
	}
}
