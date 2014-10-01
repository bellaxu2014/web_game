package com.bellaxu.skin
{
	import com.bellaxu.IClearable;
	import com.bellaxu.ObjectPool;
	import com.bellaxu.lang.Lang;
	import com.bellaxu.res.ResLoader;
	import com.bellaxu.util.HtmlUtil;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	import flash.utils.getQualifiedClassName;
	import game.core.GameColor;
	import game.core.GameFile;
	import game.core.GameResLoader;
	import game.core.GameResize;
	

	/**
	 * 加载条
	 * <br/>不继承BX组件，避免引入太多关键类至GameLoader
	 * @author BellaXu
	 */
	public class BXLoadBar extends Sprite implements IClearable
	{
		private var _imgBack:Sprite;
		private var _imgFore:Sprite;
		private var _imgLoad:Bitmap;
		private var _lbPercent:TextField;
		private var _lbLoading:TextField;
		private var _lbFState:TextField;
		private var _lbGState:TextField;
		
		private var _loader:ResLoader;
		
		public function BXLoadBar()
		{
			_imgBack = GameResLoader.getBasicSkin("BXLoadbar1");
			addChild(_imgBack);
			
			_imgFore = GameResLoader.getBasicSkin("BXLoadbar1_1");
			_imgFore.x = 17;
			addChild(_imgFore);
			
			_imgLoad = new Bitmap();
			addChild(_imgLoad);
			
			_loader = new ResLoader();
			_loader.load(GameFile.getLoadImage(), onImgLoaded);
			
			_lbPercent = new TextField();
			addChild(_lbPercent);
			
			_lbLoading = new TextField();
			_lbLoading.y = _imgBack.height + 4;
			addChild(_lbLoading);
			
			_lbFState = new TextField();
			_lbFState.htmlText = HtmlUtil.getHtmlText(Lang.getLocalString("load_first_state"));
			_lbFState.width = _lbFState.textWidth + 5;
			_lbFState.x = _imgBack.width - _lbFState.width >> 1;
			_lbFState.y = _imgBack.height + 26;
			addChild(_lbFState);
			
			_lbGState = new TextField();
			_lbGState.htmlText = HtmlUtil.getHtmlText(Lang.getLocalString("load_game_state"), GameColor.STR_GRAY);
			_lbGState.width = _lbGState.textWidth + 5;
			_lbGState.x = _imgBack.width - _lbGState.width >> 1;
			_lbGState.y = _imgBack.height + 66;
			addChild(_lbGState);
			
			mouseEnabled = false;
			
			progress = 0;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private var _progress:int;
		/**
		 * 进度(0~100)
		 */
		public function set progress(value:int):void
		{
			if(value < 0)
				value = 0;
			if(value > 100)
				value = 100;
			_progress = value;
			_lbPercent.htmlText = HtmlUtil.getHtmlText(Lang.getLocalString("load_cur_percent") + " " + _progress + "%");
			_lbPercent.width = _lbPercent.textWidth + 5;
			_lbPercent.height = _lbPercent.textHeight + 5;
			_lbPercent.x = _imgBack.width - _lbPercent.width >> 1;
			_lbPercent.y = (_imgBack.height - _lbPercent.height >> 1);
			
			_imgFore.y = _imgBack.height - _imgFore.height >> 1;
			_imgFore.width = (_imgBack.width - 32) * _progress / 100;
		}
		
		public function get progress():int
		{
			return _progress;
		}
		
		/**
		 * 正在加载的项提示
		 */
		public function set loading(value:String):void
		{
			_lbLoading.htmlText = HtmlUtil.getHtmlText(value);
			_lbLoading.width = _lbLoading.textWidth + 5;
			_lbLoading.x = _imgBack.width - _lbLoading.width >> 1;
		}
		
		public function clear():void
		{
			var cls:Class;
			var name:String = getQualifiedClassName(this).replace("::", ".");
			if(ApplicationDomain.currentDomain.hasDefinition(name))
				cls = ApplicationDomain.currentDomain.getDefinition(name) as Class;
			ObjectPool.put(cls, this);
			
			_progress = 0;
			mouseEnabled = false;
		}
		
		private function onAddedToStage(e:Event):void
		{
			GameResize.add(onResized);
		}
		
		private function onRemovedFromStage(e:Event):void
		{
			GameResize.del(onResized);
		}
		
		private function onResized():void
		{
			x = stage.stageWidth - _imgBack.width >> 1;
			y = (stage.stageHeight - _imgBack.height >> 1) + 120;
		}
		
		private function onImgLoaded(url:String):void
		{
			_imgLoad.bitmapData = _loader.getBmd(url);
			_imgLoad.x = _imgBack.width - _imgLoad.width >> 1;
			_imgLoad.y = -_imgLoad.height;
		}
	}
}