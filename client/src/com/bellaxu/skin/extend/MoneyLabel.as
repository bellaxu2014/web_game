package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXDisplayObject;
	import com.bellaxu.skin.BXLabel;
	import com.bellaxu.util.MathUtil;
	
	import flash.display.Bitmap;
	
	import game.core.GameResLoader;

	/**
	 * 游戏币控件
	 * @author BellaXu
	 */
	public class MoneyLabel extends BXDisplayObject
	{
		private var _icon:Bitmap;
		private var _label:BXLabel;
		
		public function MoneyLabel()
		{
			_icon = new Bitmap();
			addChild(_icon);
			
			_label = ObjectPool.get(BXLabel);
			_label.text = "0";
			addChild(_label);
		}
		
		private var _type:int;
		
		/**
		 * 类型
		 */
		public function set type(value:int):void
		{
			_icon.bitmapData = GameResLoader.getExtendBitmapData("Money" + value);
			_icon.y = _label.textHeight - _icon.height + 4 >> 1;
			
			_label.x = _icon.width + 2;
		}
		
		public function get type():int
		{
			return _type;
		}
		
		private var _value:int;
		
		/**
		 * 值
		 */
		public function set value(val:int):void
		{
			_value = val;
			
			_label.text = MathUtil.getIntString(val);
		}
		
		public function get value():int
		{
			return _value;
		}
		
		private var _playAsChinese:Boolean;
		
		/**
		 * 显示为中文
		 */
		public function set playAsChinese(value:Boolean):void
		{
			_playAsChinese = value;
			
			_label.text = value ? MathUtil.getChineseString(_value) : MathUtil.getIntString(_value);
		}
		
		override public function clear():void
		{
			super.clear();
			
			_type = 0;
			_value = 0;
			_label.x = 0;
			_label.text = "0";
			_icon.bitmapData = null;
			_playAsChinese = false;
		}
	}
}