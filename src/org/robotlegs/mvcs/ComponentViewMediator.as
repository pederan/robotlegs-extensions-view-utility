package org.robotlegs.mvcs
{
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IComponentView;
	import org.robotlegs.core.IViewContextMap;
	import org.robotlegs.signals.AddViewSignal;
	import org.robotlegs.signals.CreateViewSignal;
	import org.robotlegs.signals.RemoveViewSignal;
	import org.robotlegs.signals.StageResized;
	import org.robotlegs.signals.ViewAddedSignal;
	import org.robotlegs.signals.ViewRemovedSignal;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * The utilty's default mediator
	 * 
	 * <ul>
	 * <li>Injects the view as IComponentView, the interface ComponentView conforms to.</li>
	 * <li>Calls abstract methods on the view when the view is added to- and removed from the stage.</li> 
	 * <li>Listens to specific signals dispatched from the view and forward those to the framework.</li>
	 * <li>Listens to signals dispatched from elsewhere in the application (from other mediators and commands) and calls methods on the view as a response to those signals (eg. other views added, other views removed).</li>
	 * <li>Provides some abstract methods that sub classes of the mediator can override.</li>
	 * <li>Provides convenience methods for adding, swapping and removing views.</li>
	 * </ul>
	 * 
	 * <p>Subclass this mediator if you need more functionality, change default implementation or add behaviour to the abstract methods.</p>
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 */
	 
	public class ComponentViewMediator extends SignalMediator
	{
		/**
		 * The view mapped to this mediator
		 */
		[Inject]
		public var view:IComponentView;
		
		[Inject]
		public var viewContextMap:IViewContextMap;
		
		[Inject]
		public var createViewSignal:CreateViewSignal;

		[Inject]
		public var addViewSignal:AddViewSignal;
		
		[Inject]
		public var removeViewSignal:RemoveViewSignal;
		
		[Inject]
		public var viewAddedSignal:ViewAddedSignal;
		
		[Inject]
		public var viewRemovedSignal:ViewRemovedSignal;
	
		[Inject]
		public var stageResized:StageResized;
		
		/** @private */
		protected var contextRemoveSignal:Signal;
		
		/**
		 * Overriding the <code>Mediator</code>'s onRegister method to call initial methods.
		 * 
		 * <p></p>
		 * <ul>
		 * <li>Saves a reference to the container if the view is mapped as a container in setup.</li>
		 * <li>Gets a reference to the remove signal for this context and listens to that signal.</li>
		 * <li>Call addlistener method in this class to add all the listeners.</li>
		 * <li>Dispatches a signal telling the framework about the new view added to the display list.</li>
		 * <li>Calls the abstract methods addListeners and addedToStage in the view.</li>
		 * <li>Calls the onStageResized method on the view for scaling or positioning the view content.</li>
		 * <li>Calls the animateIn method on the view.</li>
		 * </ul>
		 */
		override public function onRegister():void
		{
			super.onRegister();
			//map the view if the view is mapped as a container view and not added via the ViewController
			viewContextMap.mapContainerByView(view);
			//get the signal for this context so that the view can be removed if a remove view signal is dispatched
			contextRemoveSignal = viewContextMap.getContextRemoveSignalByView(view);
			addListeners();
			viewAddedSignal.dispatch(view); //dispatch a reference to the injected view
			view.addedToStage();
			view.onStageResized();
			view.animateIn();
		}
		
		/**
		 * Adds all the listeners to the signals dispatched from the view or the framework.
		 */
        protected function addListeners():void
		{	
			/*****************************************/
			/* Signals dispatched from the framework */
			/*****************************************/
			//add a listener to a signal for removing the injected view.
			//The signal is unique for this mapped context (if not mapped it will listen to top level context).
			//Can be dispatched from either any mediator (including this one) or a command.
			contextRemoveSignal.add(onContextRemoveSignal);
			//signal dispatched from a convenience remove method. Sends the class type of the view to remove as payload.
			//Can be dispatched from either any mediator (including this one) or a command.
			removeViewSignal.add(onRemoveViewSignal);
			//signal from an application tier for adding a new view
			createViewSignal.add(onCreateViewSignal);
			//listen to the stage resize signal (Event.RESIZE) dispatched from the stage
			stageResized.add(onStageResized); 
			//signal from the newly added view's mediator. Passes a reference to the object as payload.
			viewAddedSignal.add(onViewAddedSignal);
			//signal from the mediator of the view that is just removed from stage. Passes a reference to the object as payload.
			viewRemovedSignal.add(onViewRemovedSignal);

			/*********************************************/
			/* Signals dispatched from the injected view */
			/*********************************************/
			/* View manipulation signals */ 	
			//signal dispatched from the injected view, when a button in the view is clicked
			view.viewButtonClicked.add(onViewButtonClicked);	
			//signal dispatched from the injected view when the swapView method is called
			view.swapViewRequested.add(onSwapViewRequested);
			//signal dispatched from the injected view when the addView method is called
			view.addViewRequested.add(onAddViewRequested);
			//signal dispatched from the injected view when the removeView method is called
			view.removeViewRequested.add(onRemoveViewRequested);
			//signal dispatched from the injected view when the removeViewsInContainer method is called
			view.removeViewsInContainerRequested.add(onRemoveViewsInContainerRequested);
						
			/* Animation signals */
			view.animationInStarted.addOnce(onViewAnimationInStarted);
			view.animationInCompleted.addOnce(onViewAnimationInCompleted);
			view.animationOutStarted.addOnce(onViewAnimationOutStarted);
			view.animationOutCompleted.addOnce(onViewAnimationOutCompleted);
		}
		
		/** 
		 * Invoked when a context spesific remove signal has been dispatches, either from this or another mediator. 
		 * 
		 * @param animateOut Whether the view should animate out before removal.
		 */
		protected function onContextRemoveSignal(animateOut:Boolean):void
		{
			onRemoveSignal(animateOut);
		}
		
		/** 
		 * Invoked when a remove view signal has been dispatched. The signal is dispatched from a convenience remove method. 
		 * 
		 * @param viewClass Remove the view if it is of this class type.
		 * @param animateOut Whether the view should animate out before removal.
		 */
		protected function onRemoveViewSignal(viewClass:Class, animateOut:Boolean):void
		{
			if(viewClass == getDefinitionByName(getQualifiedClassName(view)))
				onRemoveSignal(animateOut);
		}
		
		/** @private */
		private function onRemoveSignal(animateOut:Boolean = true):void
		{
			if(view.autoRemove)
			{
				unMapAllChildren(view as DisplayObjectContainer);
				view.preDestroy();
				if(animateOut)
					view.animateOut();
				else
					removeInjectedView();
			} else if(animateOut)
			{
				view.animateOut();
			}
		}
		
		/** @private */
		private function unMapAllChildren(viewInstance:DisplayObjectContainer):void 
		{
		 	viewContextMap.unMapContainerByView(viewInstance);
			var numChildren:uint = viewInstance.numChildren;
			for(var i:uint = 0; i < numChildren; ++i) 
			{
			 	if(viewInstance.getChildAt(i) is DisplayObjectContainer)
	            	unMapAllChildren(viewInstance.getChildAt(i) as DisplayObjectContainer);
			}
		}
		
		/**
		 * Listener method for the signal dispatched when a new view should be created. 
		 * This is the same signal which is mapped to ViewController. 
		 * Calls the abstract view method with possible contructor parameters. (informs the view).  
		 * 
		 * @param viewClass The class type of the new view.
		 * @param args The parameters for the constructor (optional).
		 */
		protected function onCreateViewSignal(viewClass:Class, args:Array):void
		{
			view.onCreateView(viewClass, args);
		}
		
		/**
		 * Listener method for the signal dispatched when a new view is added to stage. 
		 * Call the abstract view method passing the newly created object.
		 * 
		 * @param viewInstance A reference to the newly created object.
		 */
		protected function onViewAddedSignal(viewInstance:Object):void
		{
			view.onViewAdded(viewInstance);
		}
		
		/**
		 * Listener method for the signal dispatched when a view is removed from stage. 
		 * Call the abstract view method passing the removed object.
		 * 
		 * @param viewInstance A reference to the object that is just remived from stage.
		 */
		protected function onViewRemovedSignal(viewInstance:Object):void
		{
			view.onViewRemoved(viewInstance);
		}
		
		/** Listener method for when stage resizes (StageResized signal). */
		protected function onStageResized(event:Event):void
		{
			view.onStageResized();
		}
		
		/** Abstract method invoked when the view dispatches a button clicked signal. */
		protected function onViewButtonClicked():void
		{
		}
		
		/** Invoked when the view dispatches a swap view request signal. 
		 * If the new view class requested passes the test (implements IComponentView), 
		 * then dispatch a create view signal to create a new view and a context remove signal to make space (remove views) for the new view
		 */
		protected function onSwapViewRequested():void 
		{
			if(dispatchCreateViewSignal(view.viewClassRequest, view.viewParameters))
				dispatchContextRemoveSignal(view.viewClassRequest);
		}
		
		/** Invoked when the view dispatches a signal requesting a new view.
		 * 
		 * <p>If the new view class requested passes the test (implements IComponentView), 
		 * then dispatch an add view signal to add the newly created view to the display list.</p>
		 */ 
		protected function onAddViewRequested():void
		{
			if(dispatchCreateViewSignal(view.viewClassRequest, view.viewParameters))
				addViewSignal.dispatch();
		}
		
		/** Invoked when the view dispatches a remove view signal. Relay the signal. 
		 * 
		 * @param viewOrContextClass The class type of the views that should be removed
		 * @param animateOut Whether the view should animate out before removal  
		 */
		protected function onRemoveViewRequested(viewOrContextClass:Class, animateOut:Boolean):void
		{
			removeViewSignal.dispatch(viewOrContextClass, animateOut);
		}
		
		/** Invoked when the view dispatches a signal for removing views in a container. Relay the signal. 
		 * 
		 * @param containerClass The class type of the container which contains all the views that should be removed
		 * @param animateOut Whether the view(s) should animate out before removal
		 */
		protected function onRemoveViewsInContainerRequested(containerClass:Class, animate:Boolean):void
		{
			//get remove view signal for the passed context class
			var contextClassRemoveSignal:Signal = viewContextMap.getContextRemoveSignalByContainerClass(containerClass);
			contextClassRemoveSignal.dispatch(animate);
		}
		
		/**
		 * Abstract method that should be invoked when view starts to animate in.
		 * 
		 * <p>Invoked from the onAnimInStart method in the view.</p>
		 */
		protected function onViewAnimationInStarted():void 
		{
		}
		
		/**
		 * Abstract method invoked when view has finished animation in.
		 * 
		 * <p>Invoked from the onAnimInComplete method in the view.</p>
		 */
		protected function onViewAnimationInCompleted():void 
		{	
		}
		
		/**
		 * Invoked when the view starts to animate out.
		 * 
		 * @param dispatch Whether or not the mediator should dispatch a swap view signal.
		 */
		protected function onViewAnimationOutStarted(dispatch:Boolean):void 
		{
			if(dispatch)
				addViewSignal.dispatch();
		}
		
		/**
		 * Invoked when the view has completed animation out. Remove all views that are marked for removal (default).
		 * 
		 * @param dispatch Whether or not the mediator should dispatch a swap view signal.
		 */
		protected function onViewAnimationOutCompleted(dispatch:Boolean):void
		{
			if(dispatch)
				addViewSignal.dispatch();
			
			if(view.autoRemove) 
				removeInjectedView();
		}
		
		/**
		 * Convenience method for swapping views.
		 * 
		 * @param viewClass The class type of the new view.
		 * @param args The parameters for the constructor (optional).
		 */
		protected function swapView(viewClass:Class, ...args):void
		{
			if(dispatchCreateViewSignal(viewClass, args))
				dispatchContextRemoveSignal(viewClass);
		}

		/**
		 * Convenience method for adding a new view.
		 * 
		 * @param viewClass The class type of the new view.
		 * @param args The parameters for the constructor (optional).
		 */
		protected function addView(viewClass:Class, ...args):void
		{
			if(dispatchCreateViewSignal(viewClass, args))
				addViewSignal.dispatch();
		}
		
		/**
		 * Convenience method for removing a view by class (for removing this view, call removeInjectedView()).
		 * 
		 * @param viewClass The class type of the view to remove.
		 * @param animateOut If the view should animate out or be removed directly (optional).
		 */
		protected function removeView(viewClass:Class, animateOut:Boolean = true):void
		{
			removeViewSignal.dispatch(viewClass, animateOut);
		}
		
		/**
		 * Convenience method for removing all (IComponent)views in a container.
		 * 
		 * @param containerClass The class type of the container which contains all the views that should be removed.
		 * @param animateOut Whether the view(s) should animate out before removal.
		 */
		protected function removeViewsInContainer(containerClass:Class, animateOut:Boolean = true):void
		{
			onRemoveViewsInContainerRequested(containerClass, animateOut);
		}
		
		/** 
		 * Convenience method for for removing the injected view.
		 */
		protected function removeInjectedView():void 
		{
			view.removeMe();
		}
		
		/** @private */
		private function dispatchCreateViewSignal(viewClass:Class, args:Array):Boolean
		{
			if(viewContextMap.verifyViewClass(viewClass))
			{
				createViewSignal.dispatch(viewClass, args);
				return true;
			} else 
			{
				return false;
			}
		}

		/** @private */
		private function dispatchContextRemoveSignal(viewClass:Class):void
		{
			//get remove signal for the context of the view requested and dispatch it with animate out flag
			Signal(viewContextMap.getContextRemoveSignalByClass(viewClass)).dispatch(true);
		}

		/** @inheritDoc */
		override public function preRemove():void
		{	
			contextRemoveSignal.remove(onContextRemoveSignal);
			removeViewSignal.remove(onRemoveViewSignal);
			createViewSignal.remove(onCreateViewSignal);
			viewAddedSignal.remove(onViewAddedSignal);
			viewRemovedSignal.remove(onViewRemovedSignal);
			stageResized.remove(onStageResized);
			
			view.viewButtonClicked.remove(onViewButtonClicked);
			view.swapViewRequested.remove(onSwapViewRequested);
			view.addViewRequested.remove(onAddViewRequested);	
			view.removeViewRequested.remove(onRemoveViewRequested);
			view.removeViewsInContainerRequested.remove(onRemoveViewsInContainerRequested);
			
			view.animationInStarted.remove(onViewAnimationInStarted);
			view.animationInCompleted.remove(onViewAnimationInCompleted);
			view.animationOutStarted.remove(onViewAnimationOutStarted);
			view.animationOutCompleted.remove(onViewAnimationOutCompleted);
			
			viewRemovedSignal.dispatch(view);
			view.destroy();
			
			super.preRemove();
		}
		
	}
}
