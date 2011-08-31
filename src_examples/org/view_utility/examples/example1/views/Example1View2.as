package org.view_utility.examples.example1.views
{

	/**
	 * @author Peder A. Nielsen
	 */
	public class Example1View2 extends Example1View
	{
		public function Example1View2()
		{
			super();
		}

		override protected function initialize():void
		{
			super.initialize();
			
			headText.text = "View 2";
			addChild(headText);
			
			dummyLipsumText.text = "Morbi vehicula purus id neque dictum nec convallis massa ullamcorper. " +
			"Cras fermentum ante congue est interdum sagittis. Proin commodo dignissim convallis? " +
			"Praesent nibh nunc; bibendum sit amet convallis sit amet, tempor ut enim. " +
			"Morbi lectus felis, adipiscing ut sodales tempor, accumsan at magna. " +
			"Integer eget elit nec nulla aliquet scelerisque suscipit eu ipsum. " +
			"Nam ornare; odio a condimentum ultrices; lectus lorem fermentum mauris, nec congue est urna nec nibh. " +
			"Aliquam dictum, urna sit amet eleifend consequat, odio ligula viverra diam, vel fermentum urna tortor at dolor! " +
			"Maecenas at neque lacus, id auctor quam. Nam id scelerisque ante. Cras sit amet nunc orci, vel rhoncus ante. " +
			"Maecenas at ipsum massa, eget dignissim metus. Etiam nunc sem, euismod at sollicitudin non, dictum sit amet velit?";
			addChild(dummyLipsumText);
		}

		
	}
}
