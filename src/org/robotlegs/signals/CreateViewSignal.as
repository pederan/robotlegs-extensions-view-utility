package org.robotlegs.signals
{
	import org.osflash.signals.Signal;

	/**
	 * Mediator, command or context dispatches this signal which instantiate the <code>ViewController</code>
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 */
	public class CreateViewSignal extends Signal
	{
		public function CreateViewSignal()
		{
			super(Class, Array);
		}
	}
}
