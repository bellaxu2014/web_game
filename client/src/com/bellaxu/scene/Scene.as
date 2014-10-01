package com.bellaxu.scene
{
	import game.core.GameConf;
	import com.bellaxu.view.ViewBase;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	/**
	 * 场景综合
	 * @author BellaXu
	 */
	public class Scene extends ViewBase
	{
		public static var grid:Sprite = new Sprite(); //格子
		public static var face:Sprite = new Sprite(); //地表
		public static var foot:Sprite = new Sprite(); //脚底
		public static var mold:Sprite = new Sprite(); //形象
		
		public function Scene()
		{
			
		}
		
		override public function get container():DisplayObjectContainer
		{
			return GameConf.stage;
		}
		
		override protected function afterAddedToStage():void
		{
			//添加各层次
			addChild(grid);
			addChild(face);
			addChild(foot);
			addChild(mold);
		}
		
		override protected function afterResized():void
		{
			updateGrid();
			updateFace();
			updateFoot();
			updateMold();
		}
		
		private function updateGrid():void
		{
			
		}
		
		private function updateFace():void
		{
			
		}
		
		private function updateFoot():void
		{
			
		}
		
		private function updateMold():void
		{
			
		}
	}
}