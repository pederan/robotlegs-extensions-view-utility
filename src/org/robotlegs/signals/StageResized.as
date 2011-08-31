package org.robotlegs.signals
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.natives.NativeSignal;
	import flash.events.IEventDispatcher;

	/**
	 * The <code>ComponentViewMediator</code> listens for this stage resize signal and notifies its injected view
	 * 
	 * @author Peder A. Nielsen
	 * @version 1.0
	 */
	public class StageResized extends NativeSignal implements ISignal
	{
		public function StageResized(target:IEventDispatcher = null, eventType:String = "", eventClass:Class = null)
		{
			super(target, eventType, eventClass);
		}
	}
}
