package game
{
	import com.bellaxu.lib.Lib;
	import com.bellaxu.net.Net;
	import com.bellaxu.scene.Scene;
	import com.bellaxu.view.View;
	import com.bellaxu.view.ViewBase;
	
	import flash.utils.ByteArray;

	/**
	 * 通用游戏主程序
	 * @author BellaXu
	 */
	public class Game extends ViewBase
	{
		private var _scene:Scene;
		private var _view:View;
		
		public function Game()
		{
			_scene = new Scene();
			_view = new View();
		}
		
		/**
		 * 载入游戏配置
		 */
		public function initLib(bytes:ByteArray):void
		{
			Lib.init(bytes);
		}
		
		/**
		 * 初始化世界
		 */
		public function initWorld():void
		{
			//连接服务器
			Net.connect();
		}
		
		override protected function afterAddedToStage():void
		{
			stage.addChild(_scene);	//添加场景
			stage.addChild(_view);	//添加视图
		}
	}
}