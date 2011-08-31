package org.robotlegs.signals
{
	import org.osflash.signals.Signal;

	/**
	 * The <code>ComponentViewMediator</code> listens for a the remove signal for removing its injected view.
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 */
	public class RemoveViewSignal extends Signal
	{
		public function RemoveViewSignal()
		{
			super(Class, Boolean);
		}
	}
}
