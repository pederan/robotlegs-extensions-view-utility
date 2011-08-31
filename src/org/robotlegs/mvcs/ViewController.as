package org.robotlegs.mvcs
{
	import org.robotlegs.core.IComponentView;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * View controller for adding new views. 
	 * 
	 * <p>This is the command class which handles the creation and adding of new views. When a create view signal is dispatched a new instance 
	 * of the ViewController is created and injected with the new view class type and potential constructor parameters. The controller listens 
	 * for an add view signal before adding the new view to stage, letting other views be removed first. The controller extends ViewSignalCommand 
	 * which gives it access to the ViewContextMap. Before adding the new view it checks for view-container mapping and adds the new view to the 
	 * container instance currently on stage or to a new one if no one is present.</p>
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 */
	public class ViewController extends ViewSignalCommand
	{
		/**
		 * The class from a new view instance should be created
		 */
		[Inject]
		public var viewClass:Class;
		
		[Inject]
		public var parameters:Array;
		
		/**
		 * The new view instance
		 */
		protected var view:IComponentView;

		override public function execute():void
		{
			try
			{
				view = new_ViewClass();
				addViewSignal.addOnce(onAddViewSignal);
			} catch(error:Error) 
			{ 
				trace("\n*************************WARNING**************************************************");
				trace("The view of type '" + viewClass + "' will not be added!");
				trace("There is a mismatch between the number of arguments passed and the number of parameters the contructor takes.");
				trace("You are passing " + parameters.length + " parameters. Parameters: " + parameters);
				trace("*************************WARNING**************************************************\n");
			}
		}

		/**
		 * Listener method for when a mediator, command or a context dispatches the swap- or add signal
		 */
		protected function onAddViewSignal():void
		{
			addViewSignal.remove(onAddViewSignal);
			var viewComponent:DisplayObject = view as DisplayObject;
			while(viewComponent)
			{
				viewContextMap.mapContainerByView(viewComponent);
				var containerClass:Class = viewContextMap.getContainerClassByView(viewComponent);
				if(containerClass)
				{
					var containerInstance:DisplayObjectContainer = viewContextMap.getMappedContainerInstance(containerClass);
					if(containerInstance)
					{
						containerInstance.addChild(viewComponent);
						break;
					}
					else
					{
						containerInstance = new containerClass();
						containerInstance.addChild(viewComponent);
						viewComponent = containerInstance;
					}
				}
				else
				{
					contextView.addChild(viewComponent);
					break;
				}
			}
		}
		
		/**
		 * @private
		 * 
		 * Since there is no way to make apply work for constructor, I "had" to implement this manual solution.
		 * The other option was to pass the arguments as an array, but that means the constructor can't strong type the arguments.
		 * Had to go with the least worst solution.
		 * PS! I'll buy you two beers if you can make a dynamic solution.
		 */
		private function new_ViewClass():IComponentView
		{

			switch(parameters.length)
			{
				case 0:
					return new viewClass();
				case 1:
					return new viewClass(parameters[0]);
				case 2:
					return new viewClass(parameters[0], parameters[1]);
				case 3:
					return new viewClass(parameters[0], parameters[1], parameters[2]);
				case 4:
					return new viewClass(parameters[0], parameters[1], parameters[2], parameters[3]);
				case 5:
					return new viewClass(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4]);
				case 6:
					return new viewClass(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5]);
				default: throw new ArgumentError("Maximum allowed number of arguments passed to an IComponentView via ViewController is 6!!!");
			}
		}
	}
}
