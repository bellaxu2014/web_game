package com.bellaxu.view
{
	import game.core.GameConf;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	/**
	 * 视图综合
	 * @author BellaXu
	 */
	public class View extends ViewBase
	{
		public static var climate:Sprite = new Sprite();//天气
		public static var baseUi:Sprite = new Sprite();	//基础
		public static var userUi:Sprite = new Sprite();	//弹出
		public static var prompt:Sprite = new Sprite();	//提示
		public static var loader:Sprite = new Sprite();	//加载
		public static var script:Sprite = new Sprite();	//剧情
		
		public function View()
		{
			
		}
		
		override public function get container():DisplayObjectContainer
		{
			return GameConf.stage;
		}
		
		override protected function afterAddedToStage():void
		{
			//添加各层次
			addChild(climate);
			addChild(baseUi);
			addChild(userUi);
			addChild(prompt);
			addChild(loader);
			addChild(script);
		}
		
		override protected function afterResized():void
		{
			updateClimate();
			updateBaseUi();
			updateUserUi();
			updatePrompt();
			updateLoader();
			updateScript();
		}
		
		private function updateClimate():void
		{
			
		}
		
		private function updateBaseUi():void
		{
			
		}
		
		private function updateUserUi():void
		{
			
		}
		
		private function updatePrompt():void
		{
			
		}
		
		private function updateLoader():void
		{
			
		}
		
		private function updateScript():void
		{
			
		}
	}
}