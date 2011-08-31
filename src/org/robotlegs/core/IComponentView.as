package org.robotlegs.core
{
	import org.osflash.signals.Signal;

	import flash.display.DisplayObject;
	
	/**
	 * The utility's ComponentView contract
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 */	
	public interface IComponentView
	{

		/**
		 * Abstract method called from <code>ComponentViewMediator</code>'s onRegister method. 
		 * The view is added to stage and has a reference to the stage object.
		 * 
		 * <p>Override and use for adding functionality when the view has been added to stage.</p>
		 * 
		 */
		function addedToStage():void;
		
		/**
		 * Abstract method called from <code>ComponentViewMediator</code>'s onRegister method and when stage resizes.
		 * <code>ComponentViewMediator</code> listens to Event.RESIZE on stage and calls this method.
		 * 
		 * <p>Override and move your view according to the stage width and height.</p>
		 */
		function onStageResized():void;
		
		/**
		 * Abstract method called from <code>ComponentViewMediator</code>'s onRegister method.
		 * 
		 * <p>Calls <code>ComponentView</code>'s onAnimationInStarted and onAnimationInCompleted as default</p>
		 * 
		 * <p>Override and implement animation in effect</p>
		 */
		function animateIn():void;
		
		/**
		 * Method called from <code>ComponentViewMediator</code> when a remove signal is received.
		 * 
		 * <p>Calls <code>ComponentView</code>'s onAnimationOutStarted and onAnimationOutCompleted as default</p>
		 * 
		 * <p>Override and implement animation out effect</p>
		 * 
		 * <p>NOTE: To add the new view pass true either to method onAnimationOutStarted or onAnimationOutCompleted in <code>ComponentView</code></p>
		 */
		function animateOut():void;
		
		/** 
		 * Overriden method in an IComponentView to help adding children to a holderclip
		 */
		function addChild(child:DisplayObject):DisplayObject;
		
		/**
		 * Convenience method to remove this view
		 * 
		 * <p>Called from <code>ComponentViewMediator</code>'s convenience method for removing it's injected view.</p>
		 * 
		 */
		function removeMe():void;
		
		/**
		 * Abstract method called from mediator when a new view is requested (mediator listens to CreateViewSignal). 
		 * 
		 * @param viewClass The class type of the new view
		 * @param args The parameters for the constructor (optional)
		 */
		function onCreateView(viewClass:Class, ...args):void;

		/**
		 * Abstract method called from the mediator when a new view is added to the stage (listens to ViewAddedSignal). 
		 * 
		 * @param viewInstance A reference to the newly created object
		 */
		function onViewAdded(viewInstance:Object):void;
		
		/**
		 * Abstract method called from the mediator when any view is removed from the stage (mediator listens to ViewRemovedSignal).
		 * 
		 * @param viewInstance A reference to the removed object
		 */
		function onViewRemoved(viewInstance:Object):void;
		
		/**
		 * Signal which <code>ComponentViewMediator</code> listens to.
		 * 
		 * <p>Dispatches this signal when a button that is hooked up to method <code>onButtonClicked</code> is clicked.</p>
		 * 
		 * @return The button clicked signal
		 */
		function get viewButtonClicked():Signal;
		
		/**
		 * Signal which <code>ComponentViewMediator</code> listens to.
		 * 
		 * <p>Dispatches this signal when a new view should replace another view. Results in a new view being created and added to the [mapped] context.</p>
		 * 
		 * @return The swap request signal
		 */
		function get swapViewRequested():Signal;
		
		/**
		 * Signal which <code>ComponentViewMediator</code> listens to.
		 * 
		 * <p>Dispatches this signal when a new view should be added.
		 *  Results in adding the new view to the [mapped] context.</p>
		 * 
		 * @return The add request signal
		 */
		function get addViewRequested():Signal;
		
		/**
		 * Signal which <code>ComponentViewMediator</code> listens to.
		 * 
		 * <p>Dispatches this signal when a view of a spesific class type should be removed.</p>
		 * 
		 * @return The remove view request signal
		 */
		function get removeViewRequested():Signal;
		
		/**
		 * Signal which <code>ComponentViewMediator</code> listens to.
		 * 
		 * <p>Dispatches this signal when all removable views on the requested view container's context should be removed.</p>
		 * 
		 * @return The remove context request signal
		 */
		function get removeViewsInContainerRequested():Signal;
		
		/**
		 * Signal which <code>ComponentViewMediator</code> listens to. 
		 *  
		 * <p>Dispatches this signal when the view starts animating in. 
		 * Use this method to tell the mediator that the animation in has started.</p>
		 * 
		 * @return The signal dispatched on animation in started
		 * 
		 * @private
		 */
		function get animationInStarted():Signal;
		
		/**
		 * Signal which <code>ComponentViewMediator</code> listens to.
		 * 
		 * <p>This signal is dispatched when the view has completed animating in. 
		 * Use this method to tell the mediator that the animation in has completed.</p>
		 * 
		 * @return The signal dispatched on animation in completed
		 */
		function get animationInCompleted():Signal;
		
		/**
		 * Signal which <code>ComponentViewMediator</code> listens to.
		 * 
		 * <p>Dispatches this signal when the view starts animating out. 
		 * Use this method to tell the mediator that the animation out has started.</p>
		 * 
		 * @return The signal dispatched on animation out started
		 */
		function get animationOutStarted():Signal;
		
		/**
		 * Signal which <code>ComponentViewMediator</code> listens to. 
		 * 
		 * <p>Dispatches this signal when the view has completed animating out. 
		 * Use this method to tell the mediator that the animation out has completed.</p>
		 * 
		 * @return The signal dispatched on animation out completed
		 */
		function get animationOutCompleted():Signal;
		
		/**
		 * Check if the view should be automatically removed when a context remove signal is dispatched on this view's context 
		 * 
		 * @return Whether or not the view should be removed on swap view
		 */
		function get autoRemove():Boolean;
		
		/**
		 * Set if the view should be automatically removed when a context remove signal is dispatched on this view's context
		 * 
		 * <p>Set to true as default</p>
		 */
		function set autoRemove(value:Boolean):void;
		
		/**
		 * The value for the new class type, which in turn <code>ComponentViewMediator</code> relays
		 * 
		 * @return The class type of the new object
		 */
		function get viewClassRequest():Class;
		
		/**
		 * The parameters that should be passed to the constructor of the new view - passed as an array
		 */
		function get viewParameters():Array
		
		/**
		 * Abstract method called from <code>ComponentViewMediator</code>'s when the view is told to step away (at animate out).
		 * 
		 * <p>This method is designed for disabling/removing listeners before the animation out starts</p>
		 */
		function preDestroy():void;
		
		/**
		 * Abstract method called when the view is removed from stage.
		 * 
		 * <p>Called from <code>ComponentViewMediator</code>'s onRemove method.</p>
		 * 
		 * <p>Override and place your cleanup code here (release your listeners for garbage collection).</p>
		 */
		function destroy():void;

	}
}
