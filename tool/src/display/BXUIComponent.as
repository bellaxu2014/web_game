package display
{
	import com.bellaxu.IClearable;
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXButton;
	import com.bellaxu.skin.BXDisplayObject;
	import com.bellaxu.skin.BXImage;
	import com.bellaxu.skin.BXLabel;
	
	import flash.system.ApplicationDomain;
	import flash.utils.getQualifiedClassName;
	
	import game.core.GameResLoader;
	
	import mx.core.UIComponent;

	public class BXUIComponent extends UIComponent implements IClearable
	{
		private var _icon:BXImage;
		private var _define:Class;
		private var _label:BXLabel;
		
		public function BXUIComponent(icon:String, label:String, cls:Class)
		{
			var cls:Class = GameResLoader.getClass(icon);
			
			_icon = ObjectPool.get(BXImage);
			_icon.bitmapData = new cls(0, 0);
			_icon.width = 70;
			_icon.height = 30;
			addChild(_icon);
			
			_label = ObjectPool.get(BXLabel);
			_label.text = label;
			_label.textColor = 0x000000;
			_label.bold = true;
			_label.x = _icon.width + 5;
			_label.y = _icon.height - _label.height >> 1;
			addChild(_label);
			
			_define = cls;
		}
		
		public function get define():Class
		{
			return _define;
		}
		
		public function clear():void
		{
			_icon.bitmapData = null;
			_define = null;
			_label.text = "";
		}
	}
}