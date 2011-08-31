package org.robotlegs.signals
{
	import org.osflash.signals.Signal;

	/**
	 * Dispatched from the <code>ComponentViewMediator</code>'s onRegister method when the view is added to the stage.
	 * The <code>ComponentViewMediator</code> also listens for this signal and notifies its injected view
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 */
	public class ViewAddedSignal extends Signal
	{
		public function ViewAddedSignal()
		{
			super(Object);
		}
	}
}
