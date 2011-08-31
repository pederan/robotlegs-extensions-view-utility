package org.robotlegs.core
{
	import org.osflash.signals.Signal;

	import flash.display.DisplayObjectContainer;
	
	/**
	 * The utility's ViewContextMap contract
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 */
	public interface IViewContextMap
	{
		function mapContainerClassToView(containerClass:Class, ...args):void;
		function mapContainerInstanceToView(containerInstance:Object, ...args):void;
		function mapContainerByView(viewComponent:Object):Boolean;
		function unMapContainerByView(viewComponent:Object):void;
		
		function getMappedContainerInstance(containerClass:Class):DisplayObjectContainer;
		function containerInstanceIsMapped(containerInstance:Object):Boolean;
		function getContainerClassByView(viewComponent:Object):Class;
		
		function getContextRemoveSignalByClass(viewClass:Class):Signal;
		function getContextRemoveSignalByView(viewComponent:Object):Signal;
		function getContextRemoveSignalByContainerClass(containerClass:Class):Signal;
		
		function verifyViewClass(viewClass:Class, showWarning:Boolean = true):Boolean;

		
	}
}
