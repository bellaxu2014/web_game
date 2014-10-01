package game
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.lang.Lang;
	import com.bellaxu.res.ResPath;
	import com.bellaxu.res.ResVer;
	import com.bellaxu.skin.BXLoadBar;
	import com.bellaxu.util.HtmlUtil;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Security;
	import flash.text.TextField;
	
	import game.core.GameConf;
	import game.core.GameCursor;
	import game.core.GameFile;
	import game.core.GameFrame;
	import game.core.GameResLoader;
	import game.core.GameResize;
	
	/**
	 * 通用游戏加载器
	 * @author BellaXu
	 */
	public class GameLoader extends Sprite
	{
		private var _welcomeTxt:TextField;
		
		public function GameLoader()
		{
			super();
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			stage ? onAddedToStage() : stage.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event = null):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.HIGH;
			stage.stageFocusRect = false;
			stage.color = GameConf.BG_COLOR;
			stage.frameRate = GameConf.FPS;
			
			//保存舞台
			GameConf.stage = stage;
			GameFrame.regist(stage);
			GameResize.regist(stage);
			
			_welcomeTxt = new TextField();
			_welcomeTxt.htmlText = HtmlUtil.getHtmlText("init...", null, 14, true);
			_welcomeTxt.width = _welcomeTxt.textWidth + 5;
			addChild(_welcomeTxt);
			
			GameResize.add(onResized);
			
			GameResLoader.load(loadComplete, loadProgress);
		}
		
		private function onResized(e:Event = null):void
		{
			_welcomeTxt.x = stage.stageWidth - _welcomeTxt.width >> 1;
			_welcomeTxt.y = stage.stageHeight - _welcomeTxt.height >> 1;
		}
		
		private function loadProgress(bytesLoaded:uint, bytesTotal:uint):void
		{
			if(_welcomeTxt)
			{
				_welcomeTxt.htmlText = HtmlUtil.getHtmlText("init..." + int((GameResLoader.loadedNum + bytesLoaded / bytesTotal) * 100 / 3) + "%", null, 14, true);
				_welcomeTxt.width = _welcomeTxt.textWidth + 5;
			}
			if(loaderbar != null)
			{
				loaderbar.loading = Lang.getLocalString("load_cur_load") + GameResLoader.queue[GameResLoader.loadedNum];
				loaderbar.progress = int((GameResLoader.loadedNum + bytesLoaded / bytesTotal) * 100 / GameResLoader.totalNum);
			}
		}
		
		private static var loaderbar:BXLoadBar;
		private static var gameMain:*;
		
		private function loadComplete(url:String):void
		{
			var i:int = 0;
			switch(url)
			{
				case ResPath.VERSION:
					ResVer.init(GameResLoader.getBytes(url));
					break;
				case GameFile.getLang():
					Lang.init(GameResLoader.getBytes(url));
					break;
				case ResPath.SKIN_BASIC:
					GameCursor.init();
					GameResize.del(onResized);
					removeChild(_welcomeTxt);
					_welcomeTxt = null;
					loaderbar = ObjectPool.get(BXLoadBar);
					GameConf.stage.addChild(loaderbar);
					break;
				case ResPath.GAME:
				case ResPath.GAME_TEST:
					gameMain = GameResLoader.getContent(url);
					GameConf.stage.addChildAt(gameMain, 1);
					break;
				case ResPath.CONFIG:
					gameMain.initLib(GameResLoader.getBytes(url));
					break;
				case ResPath.SKIN_EXTEND:
					loaderbar.loading = Lang.getLocalString("load_enter_scene");
					gameMain.initWorld();
//					GameTest.testSkin();
					break;
			}
		}
	}
}