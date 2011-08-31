package org.robotlegs.base
{
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IComponentView;
	import org.robotlegs.core.IViewContextMap;

	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Mapping class for mapping views to containers, adding unique remove signals and link them to containers. 
	 * Saves a reference to the mapped container instances and the unique remove signal for each container context.
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 */
	public class ViewContextMap implements IViewContextMap
	{	
		/** The container view instances currently on the display list */
		protected var mappedContainers:Dictionary;
		/** The unique remove signal for each context */
		protected var contextRemoveSignals:Dictionary;
		/** The classes that are mapped as containers for the views */		
		protected var viewContainerClasses:Dictionary;
		/** @private */
		protected var mainContextClass:Class;
		
		public function ViewContextMap(contextView:DisplayObjectContainer) 
		{
			mappedContainers 		= new Dictionary();
			contextRemoveSignals 	= new Dictionary();
			viewContainerClasses 	= new Dictionary();
			mainContextClass 		= getDefinitionByName(getQualifiedClassName(contextView)) as Class;
			mapSignalToContext(mainContextClass);
		}

		public function mapContainerClassToView(containerClass:Class, ...args):void
		{
			for each (var viewClass:Class in args) 
			{
				viewContainerClasses[viewClass] = containerClass;
				//map a new unique signal to this container class
				mapSignalToContext(containerClass);
			}
		}
		
		public function mapContainerInstanceToView(containerInstance:Object, ...args):void
		{
			var containerClass:Class = getDefinitionByName(getQualifiedClassName(containerInstance)) as Class;
			if(!mappedContainers[containerClass])
				mappedContainers[containerClass] = containerInstance;
			for each (var viewClass:Class in args) 
				mapContainerClassToView(containerClass, viewClass);
		}
		
		private function mapSignalToContext(contextClass:Class):void
		{	
			//map a new signal to the contextClass if it isn't mapped
			if(!contextRemoveSignals[contextClass])
			{
				var removeSignal:Signal = new Signal(Boolean);
				contextRemoveSignals[contextClass] = removeSignal;
			}
		}
		
		public function mapContainerByView(viewComponent:Object):Boolean
		{
			var viewClass:Class = getDefinitionByName(getQualifiedClassName(viewComponent)) as Class;
			if(contextRemoveSignals[viewClass] && !mappedContainers[viewClass])
			{
				mappedContainers[viewClass] = viewComponent;
				return true;
			}
			return false;
		}
		
		public function unMapContainerByView(viewComponent:Object):void
		{
			var viewClass:Class = getDefinitionByName(getQualifiedClassName(viewComponent)) as Class;
			if(mappedContainers[viewClass])
			{
				delete mappedContainers[getDefinitionByName(getQualifiedClassName(viewComponent))];
			}
		}
		
		public function getMappedContainerInstance(containerClass:Class):DisplayObjectContainer
		{
			return mappedContainers[containerClass];
		}
		
		public function containerInstanceIsMapped(containerInstance:Object):Boolean
		{
			return getMappedContainerInstance(getDefinitionByName(getQualifiedClassName(containerInstance)) as Class) ? true : false;	
		}
		
		public function getContainerClassByView(viewComponent:Object):Class
		{
			var viewClass:Class = getDefinitionByName(getQualifiedClassName(viewComponent)) as Class;
			return viewContainerClasses[viewClass];
		}
		
		public function getContextRemoveSignalByClass(viewClass:Class):Signal
		{
			//return the signal for this context or the parent context on stage so that the existing view will get removed
			var containerClass:Class = getContainerByClass(viewClass);
			//if the container is not mapped - then no one will listen, so loop until a context exists
			while(!getMappedContainerInstance(containerClass))
			{
				if(containerClass)
				{
					containerClass = getContainerByClass(containerClass);
				} else
				{
					containerClass = mainContextClass;
					break;
				}
			}
			return contextRemoveSignals[containerClass];
		}

		public function getContextRemoveSignalByView(viewComponent:Object):Signal
		{
			var contextClass:Class = getContainerByClass(getDefinitionByName(getQualifiedClassName(viewComponent)) as Class) || mainContextClass;
			return contextRemoveSignals[contextClass];
		}
		
		public function getContextRemoveSignalByContainerClass(containerClass:Class):Signal
		{
			return contextRemoveSignals[containerClass];
		}
	
		public function verifyViewClass(viewClass:Class, showWarning:Boolean = true):Boolean
		{
			//control that the mapped view implements IComponentView
			if(describeType(viewClass).factory.implementsInterface.(@type == getQualifiedClassName(IComponentView)).length() != 0)
			{
				return true;
			} else
			{
				if(showWarning)
				{
					trace("\n*************************WARNING**************************************************");
					trace("The view of type '" + viewClass + "' will not be added!");
					trace("The view needs to implement IComponentView.");
					trace("*************************WARNING**************************************************\n");
				}
				return false;
			}
		}
		
		protected function getContainerByClass(viewClass:Class):Class
		{
			return viewContainerClasses[viewClass];
		}
		
	}
}
