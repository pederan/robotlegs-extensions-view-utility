package org.view_utility.examples.example2.views
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import org.robotlegs.mvcs.ComponentView;

	/**
	 * @author Peder A. Nielsen
	 */
	public class FooterView extends ComponentView
	{
		private var distanceFromBottom:uint = 10;
		private var animationCompleted:Boolean;
		
		public function FooterView()
		{
			super();
		}

		override protected function initialize():void
		{
			var footerTxtFormat:TextFormat = new TextFormat();
			footerTxtFormat.font = "arial";
			footerTxtFormat.size = "14";
			
			var footerTxt:TextField = new TextField();
			footerTxt.defaultTextFormat = footerTxtFormat;
			footerTxt.embedFonts = true;
			footerTxt.antiAliasType = AntiAliasType.ADVANCED;
			footerTxt.autoSize = TextFieldAutoSize.LEFT;
			footerTxt.text = "Demo Footer View";
			addChild(footerTxt);
		}
		
		//position the view in this method because we now have a reference to stage (center below stage)
		override public function addedToStage():void
		{
			this.y = stage.height + 50;
			this.x = (stage.stageWidth - this.width) * .5;
		}

		override public function animateIn():void
		{
			TweenLite.to(this, 1, {y:(stage.stageHeight - this.height - distanceFromBottom), ease:Expo.easeOut, 
								   onComplete:function():void{animationCompleted = true;}});
		}

		override public function onStageResized():void
		{
			if(animationCompleted)
			{
				this.y = Math.max(520, (stage.stageHeight - this.height - distanceFromBottom));
				this.x = (stage.stageWidth - this.width) * .5;
			}
		}
	}
}
