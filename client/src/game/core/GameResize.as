package game.core
{
	import flash.display.Stage;
	import flash.events.Event;

	/**
	 * 缩放管理
	 * @author BellaXu
	 */
	public class GameResize
	{
		private static var vec:Vector.<Function> = new <Function>[];
		
		/**
		 * 注册唯一监听
		 */
		public static function regist(stage:Stage):void
		{
			stage.removeEventListener(Event.RESIZE, onStageResized);
			stage.addEventListener(Event.RESIZE, onStageResized);
		}
		
		/**
		 * 添加方法
		 */
		public static function add(func:Function):void
		{
			if(vec.indexOf(func) < 0)
			{
				func.apply(null, null);
				vec.push(func);
			}
		}
		
		/**
		 * 移除方法
		 */
		public static function del(func:Function):void
		{
			var i:int = vec.indexOf(func);
			if(i > -1)
				vec.splice(i, 1);
		}
		
		private static function onStageResized(e:Event):void
		{
			for each(var func:Function in vec)
			{
				func.apply(null, null);
			}
		}
	}
}