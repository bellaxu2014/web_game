package game.core
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXLabel;
	import com.bellaxu.util.HtmlUtil;
	import com.bellaxu.view.View;
	import com.greensock.TweenLite;
	
	import flash.utils.Dictionary;

	/**
	 * 游戏提示信息输出
	 * @author BellaXu
	 */
	public class GameMsg
	{
		private static var _dic:Dictionary = new Dictionary();

		/**
		 * 显示提示信息
		 * @param msg 要显示的信息
		 * @param type 见GameMsgType
		 */
		public static function showMsg(msg:String, type:uint = 0):void
		{
			if(!_dic[type])
				_dic[type] = new <String>[];
			var vec:Vector.<String> = _dic[type];
			switch(type)
			{
				case GameMsgType.POP_UP:
					msg = HtmlUtil.getHtmlText(msg, GameColor.STR_RED, 14, true);
					vec.push(msg);
					if(!GameTimer.has(showPopup))
						GameTimer.add(200, showPopup);
					break;
				case GameMsgType.CORNER:
					if(!GameTimer.has(showCorner))
						GameTimer.add(200, showCorner);
					break;
				case GameMsgType.NOTICE:
					if(!GameTimer.has(showNotice))
						GameTimer.add(200, showNotice);
					break;
				case GameMsgType.HORN:
					if(!GameTimer.has(showHorn))
						GameTimer.add(200, showHorn);
					break;
				case GameMsgType.HORN_BIG:
					if(!GameTimer.has(showHornBig))
						GameTimer.add(200, showHornBig);
					break;
			}
		}
		
		private static function showPopup():void
		{
			var vec:Vector.<String> = _dic[GameMsgType.POP_UP];
			var msg:String = vec.pop();
			if(!vec.length)
				GameTimer.del(showPopup);
			
			var lb:BXLabel = ObjectPool.get(BXLabel);
			lb.htmlText = msg;
			lb.alpha = 1;
			lb.x = GameConf.stage.stageWidth - lb.width >> 1;
			lb.y = (GameConf.stage.stageHeight - lb.height >> 1) + lb.height;
			View.prompt.addChild(lb);
			TweenLite.to(lb, 2.5, {alpha: 0, y: lb.y - lb.height, delay: 1, onComplete: removePopup, onCompleteParams: [lb]});
		}
		
		private static function removePopup(lb:BXLabel):void
		{
			TweenLite.killTweensOf(lb, true);
			lb.clear();
			if(lb.parent)
				lb.parent.removeChild(lb);
		}
		
		private static function showCorner():void
		{
			var vec:Vector.<String> = _dic[GameMsgType.CORNER];
			var msg:String = vec.pop();
			if(!vec.length)
				GameTimer.del(showCorner);
		}
		
		private static function showNotice():void
		{
			var vec:Vector.<String> = _dic[GameMsgType.NOTICE];
			var msg:String = vec.pop();
			if(!vec.length)
				GameTimer.del(showNotice);
		}
		
		private static function showHorn():void
		{
			var vec:Vector.<String> = _dic[GameMsgType.HORN];
			var msg:String = vec.pop();
			if(!vec.length)
				GameTimer.del(showHorn);
		}
		
		private static function showHornBig():void
		{
			var vec:Vector.<String> = _dic[GameMsgType.HORN_BIG];
			var msg:String = vec.pop();
			if(!vec.length)
				GameTimer.del(showHornBig);
		}
	}
}