package org.view_utility.examples.example3
{
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	import org.robotlegs.mvcs.ComponentView;

	/**
	 * @author Peder A. Nielsen
	 */
	public class Example3View extends ComponentView
	{
		public function Example3View()
		{
			super();
		}

		public function displayMessage(message:String):void
		{
			var messageTxtField:TextField = new TextField();
			messageTxtField.autoSize = TextFieldAutoSize.LEFT;
			messageTxtField.text = message;
			addChild(messageTxtField);
		}
	}
}
