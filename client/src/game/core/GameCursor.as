package game.core
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;

	/**
	 * 游戏指针
	 * @author BellaXu
	 */
	public class GameCursor
	{
		/**
		 * 默认
		 */
		public static const DEFAULT:String = "GameCursor1";
		/**
		 * 点击
		 */
		public static const DOWN:String = "GameCursor2";
		/**
		 * 不可走
		 */
		public static const UNABLE:String = "GameCursor3";
		/**
		 * 攻击
		 */
		public static const ATTACK:String = "GameCursor4";
		/**
		 * 采集
		 */
		public static const PICK:String = "GameCursor5";
		/**
		 * 售卖
		 */
		public static const SELL:String = "GameCursor6";
		/**
		 * 聊天
		 */
		public static const CHAT:String = "GameCursor7";
		
		/**
		 * 初始化
		 */
		public static function init():void
		{
			registCursor(DEFAULT);
			registCursor(DOWN);
			registCursor(UNABLE);
			registCursor(ATTACK);
			registCursor(PICK);
			registCursor(SELL);
			registCursor(CHAT);
			
			cursor = DEFAULT;
			if(GameConf.stage)
			{
				GameConf.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseHandler);
				GameConf.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseHandler);
			}
		}
		
		private static function registCursor(type:String):void
		{
			var m_CursorData:MouseCursorData = new MouseCursorData();
			var data:Vector.<BitmapData> = new <BitmapData>[];
			data.push(GameResLoader.getBasicBitmapData(type));
			m_CursorData.data = data;
			m_CursorData.frameRate = data.length;
			m_CursorData.hotSpot = new Point(0, 0);
			Mouse.registerCursor(type, m_CursorData);
		}
		
		private static function onMouseHandler(e:MouseEvent):void
		{
			if(e.type == MouseEvent.MOUSE_DOWN)
			{
				if(cursor == DEFAULT)
					cursor = DOWN;
			}
			else
			{
				if(cursor == DOWN)
					cursor = DEFAULT;
			}
		}
		
		public static function set cursor(value:String):void
		{
			if (Mouse.cursor == value)
				return;
			Mouse.cursor = value;
		}
		
		public static function get cursor():String
		{
			return Mouse.cursor;
		}
	}
}