package org.view_utility.examples.example2.views
{
	import com.greensock.TweenMax;

	import org.robotlegs.mvcs.ComponentView;

	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Peder A. Nielsen
	 */
	public class ContainerView extends ComponentView
	{
		protected var description:TextField;
		
		public function ContainerView()
		{
			super();
		}

		override protected function initialize():void
		{
			//set the visibility to false -> the views extending this class will be faded in
			this.alpha = 0;
			this.visible = false;
			
			var descriptionTxtFormat:TextFormat = new TextFormat();
			descriptionTxtFormat.font = "arial";
			descriptionTxtFormat.size = "12";
			descriptionTxtFormat.leading = 6;
			
			var headingTxtFormat:TextFormat = new TextFormat();
			headingTxtFormat.font = "copperplateGothicBold";
			headingTxtFormat.size = "14";
			
			description = new TextField();
			description.defaultTextFormat = descriptionTxtFormat;
			description.embedFonts = true;
			description.antiAliasType = AntiAliasType.ADVANCED;
			description.wordWrap = true;
			description.autoSize = TextFieldAutoSize.LEFT;
			description.y = 30;
			
			var square:Sprite = new Sprite();
			square.graphics.beginFill(0xFF0000, 1);
			square.graphics.drawRect(0, 0, 10, 20);
			square.graphics.endFill();
			addChild(square);

			var nameOfClassField:TextField = new TextField();
			nameOfClassField.defaultTextFormat = headingTxtFormat;
			nameOfClassField.embedFonts = true;
			nameOfClassField.antiAliasType = AntiAliasType.ADVANCED;
			nameOfClassField.text = "Container class : " + getDefinitionByName(getQualifiedClassName(this));
			nameOfClassField.autoSize = TextFieldAutoSize.LEFT;
			nameOfClassField.x = 15;
			addChild(nameOfClassField);
		}
		
		override public function animateIn():void
		{
			TweenMax.to(this, 1, {autoAlpha:1});
		}
		
		override public function animateOut():void
		{
			TweenMax.to(this, 1, {autoAlpha:0, onStart:onAnimationOutStarted, onStartParams:[true], onComplete:removeMe});
		}
		
		//center the content on stage
		override public function onStageResized():void
		{
			this.x = (stage.stageWidth - this.width) * .5;
		}
			
	}
}
