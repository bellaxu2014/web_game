package com.bellaxu.skin
{
	import com.bellaxu.util.BXUtil;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import game.core.GameResLoader;

	/**
	 * 可交互对象
	 * @author BellaXu
	 */
	public class BXInterativeObject extends BXDisplayObject
	{
		protected var _skinDic:Dictionary;
		protected var _skin:MovieClip;
		protected var _skinOld:MovieClip;
		protected var _style:int = 1;
		
		public function BXInterativeObject()
		{
			_skinDic = new Dictionary();
			updateSkin();
		}
		
		/**
		 * 皮肤样式编号
		 */
		public function set style(value:int):void
		{
			_style = value;
			updateSkin();
		}
		
		public function get style():int
		{
			return _style;
		}
		
		override public function clear():void
		{
			super.clear();
			
			BXUtil.clearDic(_skinDic);
			if(_skin)
				if(contains(_skin))
					removeChild(_skin);
			
			_lightEnabled = true;
			_isOver = false;
			_skin = null;
			_skinOld = null;
			_style = 1;
		}
		
		override public function get width():Number
		{
			return _width ? _width : (_skin ? _skin.width : super.width);
		}
		
		override public function get height():Number
		{
			return _height ? _height : (_skin ? _skin.height : super.height);
		}
		
		private var _lightEnabled:Boolean = true;
		
		/**
		 * 是否对鼠标事件进行light响应
		 */
		protected function set lightEnabled(value:Boolean):void
		{
			_lightEnabled = value;
		}
		
		private var _innerStyle:int;
		
		protected function set innerStyle(value:int):void
		{
			_innerStyle = value;
		}
		
		protected function get innerStyle():int
		{
			return _innerStyle;
		}
		
		final protected function getSkin():MovieClip
		{
			var bn:String = getQualifiedClassName(this);
			var ca:Array = bn.split("::");
			var cn:String = ca[ca.length - 1];
			var sn:String = cn + _style;
			if(_innerStyle)
				sn += "_" + _innerStyle;
			if(_skinDic[sn])
				return _skinDic[sn];
			var mc:MovieClip = GameResLoader.getBasicSkin(sn);
			if(!mc)
				return null;
			_skinDic[sn] = mc;
			_skinDic[sn].mouseEnabled = false;
			return _skinDic[sn];
		}
		
		override protected function repaint():void
		{
			super.repaint();
			if(_skin)
			{
				if(_skin != _skinOld)
				{
					if(_skinOld)
						removeChild(_skinOld);
					if(_skin)
						addChildAt(_skin, 0);
				}
			}
			_skinOld = _skin;
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);
			updateSkin();
		}
		
		private var _isOver:Boolean;
		
		override protected function overHandler(e:MouseEvent):void
		{
			if(_skin)
			{
				_isOver = _lightEnabled;
				BXUtil.setBrightness(_skin, _lightEnabled ? 0.15 : 0);
			}
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			if(_skin)
				BXUtil.setBrightness(_skin, _lightEnabled ? -0.15 : 0);
		}
		
		override protected function outHandler(e:MouseEvent):void
		{
			if(_skin)
			{
				_isOver = false;
				BXUtil.setBrightness(_skin, 0);
			}
		}
		
		override protected function upHandler(e:MouseEvent):void
		{
			if(_skin)
				BXUtil.setBrightness(_skin, _lightEnabled ? (_isOver ? 0.15 : 0) : 0);
		}
		
		protected function updateSkin():void
		{
			_skin = getSkin();
			if(_skin)
			{
				if(_width)
					_skin.width = _width;
				if(_height)
					_skin.height = _height;
			}
			repaintNextFrame();
		}
	}
}