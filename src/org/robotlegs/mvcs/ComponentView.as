package org.robotlegs.mvcs
{
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IComponentView;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	/**
	 * Abstract <code>IComponentView</code> implementation
	 * 
	 * <p>Subclass this view class and a <code>ComponentViewMediator</code> will automatically be created.</p>
	 * <ul>
	 * <li>Override the methods to add animation to the start and end phase of the view.</li>
	 * <li>Call the convenience methods to add, swap or remove views.</li>
	 * <li>Get notified when other views are created.</li>
	 * <li>Release your listeners for garbage collection in the preDestroy or destroy method.</li>
	 * </ul>
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 * 
	 */
	public class ComponentView extends MovieClip implements IComponentView
	{
		/** Set this property to false to avoid auto removal. */
		protected var _autoRemove:Boolean = true;
		/**  @private */
		protected var _viewButtonClicked:Signal;
		/**  @private */
		protected var _swapViewRequested:Signal;
		/**  @private */
		protected var _addViewRequested:Signal;		
		/**  @private */
		protected var _removeViewRequested:Signal;
		/**  @private */
		protected var _removeViewsInContainerRequested:Signal;
		/**  @private */
		protected var _animationInStarted:Signal;
		/**  @private */
		protected var _animationInCompleted:Signal;
		/**  @private */
		protected var _animationOutStarted:Signal;
		/**  @private */
		protected var _animationOutCompleted:Signal;
		/**  @private */
		protected var _viewClassRequest:Class;
		/**  @private */
		protected var _viewParameters:Array;
		/**  @private */
		protected var holderClip:DisplayObjectContainer;
		/** Dictionary holding mapped buttons to views */
		protected var buttons:Dictionary;
		
		//---------------------------------------------------------------------
		//  Constructor
		//---------------------------------------------------------------------
		
		/**
		 * Abstract <code>ComponentView</code> implementation
		 * 
		 * <p>Instantiates the signals and button dictionary and calls the initialize method of the view</p>
		 * 
		 */
		public function ComponentView()
		{
			super();
			_viewButtonClicked 					= new Signal();
			_swapViewRequested 					= new Signal();
			_addViewRequested 					= new Signal();
			_removeViewRequested 				= new Signal(Class, Boolean);
			_removeViewsInContainerRequested 	= new Signal(Class, Boolean);
			_animationInStarted 				= new Signal();
			_animationInCompleted 				= new Signal();
			_animationOutStarted 				= new Signal(Boolean);
			_animationOutCompleted 				= new Signal(Boolean);
			buttons 							= new Dictionary();
			initialize();
		}
				
		/**
		 * Abstract method called from the constructor when the view is created.
		 * 
		 * <p>Override and use for initializing the view before it has been added to stage.</p>
		 * 
		 */
		protected function initialize():void
		{
		}
		
		/** @inheritDoc */
		public function addedToStage():void 
		{
		}
		
		/** @inheritDoc */
		public function addListeners():void
		{	
		}
		
		/** @inheritDoc */
		public function onStageResized():void
		{
		}
		
		/** @inheritDoc */
		public function animateIn():void
		{
			onAnimationInStarted();
			onAnimationInCompleted();
		}
		
		/** @inheritDoc */
		public function animateOut():void
		{
			onAnimationOutStarted();
			onAnimationOutCompleted(true);
		}
		
		/** @inheritDoc */
		public function removeMe():void
		{
			try
			{
				this.parent.removeChild(this);
			} catch(error:Error) {  }
		}
		
		/** @inheritDoc */
		public function onCreateView(viewClass:Class, ...args):void
		{
		}
		
		/** @inheritDoc */
		public function onViewAdded(viewInstance:Object):void
		{
		}
		
		/** @inheritDoc */
		public function onViewRemoved(viewInstance:Object):void
		{
		}
		
		/** Dispatches the animation in started signal which <code>ComponentViewMediator</code> listens to. */
		protected function onAnimationInStarted():void 
		{
			_animationInStarted.dispatch();
		}
		
		/** Dispatches the animation in completed signal which <code>ComponentViewMediator</code> listens to.*/
		protected function onAnimationInCompleted():void 
		{
			_animationInCompleted.dispatch();
		}
		
		/**
		* Dispatches the animation out started signal which <code>ComponentViewMediator</code> listens to.
		* 
		* @param add Whether an add view signal should be dispatched from the mediator
		*/
		protected function onAnimationOutStarted(add:Boolean = false):void 
		{
			_animationOutStarted.dispatch(add);
		}
		
		/**
		* Dispatches the animation out completed signal which <code>ComponentViewMediator</code> listens to.
		* 
		* @param add Whether an add view signal should be dispatched from the mediator
		*/
		protected function onAnimationOutCompleted(add:Boolean = false):void 
		{
			_animationOutCompleted.dispatch(add);
		}
		
		/**
		 * As default this method dispatches a button clicked signal to <code>ComponentViewMediator</code>, which calls its abstract button clicked listener.
		 * 
		 * <p>If a button is mapped to a view class the _viewClassRequest and _viewParameters properties are set 
		 * The mediator will ask the injected view for these values before dispatching a create view signal.</p>
		 * 
		 * @param event Native flash MouseEvent
		 */
		protected function onButtonClicked(event:MouseEvent):void 
		{
			if(buttons[event.currentTarget])
			{
				_viewClassRequest = buttons[event.currentTarget].viewClass;
				_viewParameters = buttons[event.currentTarget].viewParameters;
				if(buttons[event.currentTarget].swapView)
					_swapViewRequested.dispatch();
				else
					_addViewRequested.dispatch();
			}
			_viewButtonClicked.dispatch();
		}
		
		/**
		 * Convenience method for adding a new view
		 * 
		 *  @param viewClass The new view to be added.
		 *  @param args The parameters for the constructor (optional)
		 */
		protected function addView(viewClass:Class, ...args):void
		{
			_viewClassRequest = viewClass;
			_viewParameters = args;
			_addViewRequested.dispatch();
		}
		
		/**
		 * Convenience method for swapping views
		 * 
		 *  @param viewClass The class type of the new view
		 *  @param args The parameters for the constructor (optional)
		 */
		protected function swapView(viewClass:Class, ...args):void
		{
			_viewClassRequest = viewClass;
			_viewParameters = args;
			_swapViewRequested.dispatch();
		}
		
		/**
		 * Convenience method for removing a view by class
		 * 
		 *  @param viewOrContextClass The class type of the instance to remove.
		 *  @param animateOut Remove straight away or call the view's animate out method
		 */
		protected function removeView(viewOrContextClass:Class, animateOut:Boolean = true):void
		{
			_removeViewRequested.dispatch(viewOrContextClass, animateOut);
		}
		
		/**
		 * Convenience method for removing all (IComponent)views in a container.
		 * 
		 * @param containerClass The class type of the container which contains all the views that should be removed
		 * @param animateOut Whether the view(s) should animate out before removal
		 */
		protected function removeViewsInContainer(containerClass:Class, animateOut:Boolean = true):void
		{
			_removeViewsInContainerRequested.dispatch(containerClass, animateOut);
		}
		
		/**
		 * Map a button to a create a new view class. The onButtonClicked method will check if the clicked button 
		 * exists in the buttons dictionary, set the class and parameters properties and dispatch a swap- or addview signal.
		 * 
		 * <p>The listener will be realeased for garbage collection when the view is removed from the stage</p>
		 * 
		 * @param button The button
		 * @param viewClass The class for the new instance
		 * @param listener The listener to be called at mouse click
		 * @param swapView If the view should replace another view or be added
		 * @param ...args Optional parameters passed to the constructor of the new view
		 */
		protected function mapButtonToView(button:Object, viewClass:Class, listener:Function, swapView:Boolean = true, ...args):void
		{
			if(!buttons[button])
			{
				buttons[button] = {viewClass:viewClass, viewParameters:args, swapView:swapView, listener:listener};
				if(listener != null)
					button.addEventListener(MouseEvent.CLICK, listener);
			}
		}
		
		/**
		 * Unmap a mapped button-to-view button
		 */
		protected function unmapButtonToView(button:Object):void
		{
			if(buttons[button])
			{
				if(buttons[button].listener != null)
					button.removeEventListener(MouseEvent.CLICK, buttons[button].listener);
				delete buttons[button];
			}
		}
		
		/** @inheritDoc */
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if(holderClip)
				return holderClip.addChild(child);
			else
				return super.addChild(child);
		}
		
		/** @inheritDoc */
		public function get viewButtonClicked():Signal
		{
			return _viewButtonClicked;
		}
		
		/** @private */
		public function get swapViewRequested():Signal
		{
			return _swapViewRequested;
		}
		
		/** @private */
		public function get addViewRequested():Signal
		{
			return _addViewRequested;
		}
		
		/** @private */
		public function get removeViewRequested():Signal
		{
			return _removeViewRequested;
		}
		
		/** @private */
		public function get removeViewsInContainerRequested():Signal
		{
			return _removeViewsInContainerRequested;
		}
		
		/** @private */
		public function get animationInStarted():Signal
		{
			return _animationInStarted;
		}
		
		/** @private  */
		public function get animationInCompleted():Signal
		{
			return _animationInCompleted;
		}
		
		/** @private */
		public function get animationOutStarted():Signal
		{
			return _animationOutStarted;
		}
		
		/** @private */
		public function get animationOutCompleted():Signal
		{
			return _animationOutCompleted;
		}
		
		/** @private */
		public function get autoRemove():Boolean
		{
			return _autoRemove;
		}
		
		/** @private */
		public function set autoRemove(value:Boolean):void
		{
			_autoRemove = value;
		}
		
		/** @inheritDoc */
		public function get viewClassRequest():Class
		{
			return _viewClassRequest;
		}
		
		/** @inheritDoc */
		public function get viewParameters():Array
		{
			return _viewParameters;
		}
		
		/** @inheritDoc */
		public function preDestroy():void
		{
		}
		
		/** @inheritDoc */
		public function destroy():void
		{
			for(var button:Object in buttons)
			{
				if(buttons[button].listener != null)
					button.removeEventListener(MouseEvent.CLICK, buttons[button].listener);	
			}
		}
	
	}
}
