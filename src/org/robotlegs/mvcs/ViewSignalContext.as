package org.robotlegs.mvcs
{
	import org.robotlegs.base.ViewContextMap;
	import org.robotlegs.base.ViewInterfaceMediatorMap;
	import org.robotlegs.core.IComponentView;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.core.IViewContextMap;
	import org.robotlegs.signals.AddViewSignal;
	import org.robotlegs.signals.CreateViewSignal;
	import org.robotlegs.signals.RemoveViewSignal;
	import org.robotlegs.signals.StageResized;
	import org.robotlegs.signals.ViewAddedSignal;
	import org.robotlegs.signals.ViewRemovedSignal;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	/**
	 * Abstract MVCS SignalContext implementation
	 * 
	 * <p>Extend ViewSignalContext in your main context class to enable automatic view-mediator and to access convenience. 
	 * The context maps the view interface IComponentView to the mediator ComponentViewMediator. This means that every time an instance 
	 * of a class that extends ComponentView is added to the stage an instance of ComponentViewMediator is created automatically. 
	 * In addition, the ViewSignalContext maps some signals that are used for adding, swapping and removing views and provide a convenience 
	 * method for adding views at application startup. The context class extends SignalContext from the SignalCommandMap extension.</p>
	 * @see https://github.com/joelhooks/signals-extensions-CommandSignal SignalCommandMap extension
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 */
	public class ViewSignalContext extends SignalContext
	{
		/** @private */
		protected var _viewContextMap:IViewContextMap;

		protected var createViewSignal:CreateViewSignal;
		protected var addViewSignal:AddViewSignal;
		protected var stageResized:StageResized;
		
		public function ViewSignalContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true)
		{	
			super(contextView, autoStartup);
		}
		
		// Robotlegs-extensions-ViewInterfaceMediatorMap (https://github.com/piercer/robotlegs-extensions-ViewInterfaceMediatorMap)
	    // Override the default mediator map with one that can map to interfaces
	    // Thanks to @piercer
	    //
	    /** @private */
	    override protected function get mediatorMap():IMediatorMap
	    {
	        return _mediatorMap ||= new ViewInterfaceMediatorMap(contextView, createChildInjector(), reflector);
	    }
	    
	    /** @private */
	    override protected function set mediatorMap(value:IMediatorMap):void
	    {
	        _mediatorMap = value;
	    }
		
		override protected function mapInjections():void
        {
            super.mapInjections();
			//stage resize
			stageResized = new StageResized(contextView.stage, Event.RESIZE, Event);
			injector.mapValue(StageResized, stageResized);
 	
			//create and map signals
			createViewSignal = new CreateViewSignal();
			signalCommandMap.mapSignal(createViewSignal, ViewController);		
			injector.mapValue(CreateViewSignal, createViewSignal);
			
			addViewSignal = new AddViewSignal();
			injector.mapValue(AddViewSignal, addViewSignal);
			
			injector.mapSingleton(RemoveViewSignal);
			injector.mapSingleton(ViewAddedSignal);
			injector.mapSingleton(ViewRemovedSignal);

			//view component map
			injector.mapValue(IViewContextMap, viewContextMap);

			//default (interfaced) view interface -> mediator mapping - thanks to @piercer
			mediatorMap.mapView(IComponentView, ComponentViewMediator); 
		}
		
		public function get viewContextMap():IViewContextMap
		{
			return _viewContextMap ||= new ViewContextMap(contextView);
		}

		public function set viewContextMap(value:IViewContextMap):void
		{
			_viewContextMap = value;
		}
		
		/** Convenience method for adding new views from the main context */
		protected function addView(viewClass:Class, ...args):void
		{
			if(viewContextMap.verifyViewClass(viewClass))
			{
				createViewSignal.dispatch(viewClass, args);
				addViewSignal.dispatch();
			}
		}
		
	}
}
