package org.robotlegs.signals
{
	import org.osflash.signals.Signal;

	/**
	 * Dispatched from the <code>ComponentViewMediator</code>'s onRemove method when the view is removed from the stage.
	 * The <code>ComponentViewMediator</code> listens for this signal and notifies its injected view
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 */
	public class ViewRemovedSignal extends Signal
	{
		public function ViewRemovedSignal()
		{
			super(Object);
		}
	}
}
