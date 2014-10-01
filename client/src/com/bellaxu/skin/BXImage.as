package com.bellaxu.skin
{
	import com.bellaxu.res.ResLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;

	/**
	 * 图片组件
	 * @author BellaXu
	 */
	public class BXImage extends BXDisplayObject
	{
		private static var _loader:ResLoader = new ResLoader(3);
		private var _bitmap:Bitmap;
		private var _source:String;
		private var _callback:Function;
		
		public function BXImage()
		{
			_bitmap = new Bitmap();
			addChild(_bitmap);
			
			mouseEnabled = false;
		}
		
		/**
		 * 直接设置位图
		 */
		public function set bitmapData(value:BitmapData):void
		{
			if(_source)
				_loader.clear(_source, onLoaded);
			_bitmap.bitmapData = value;
		}
		
		/**
		 * 设置加载完回调
		 */
		public function set callback(value:Function):void
		{
			_callback = value;
		}
		
		/**
		 * 图片地址
		 */
		public function set source(value:String):void
		{
			_source = value;
			if(_source)
				_loader.load(source, onLoaded);
			else
				_bitmap.bitmapData = null;
		}
		
		public function get source():String
		{
			return _source;
		}
		
		override public function clear():void
		{
			super.clear();
			
			mouseEnabled = false;
			
			_bitmap.bitmapData = null;
			_source = null;
			_callback = null;
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);
			if(_source)
				_loader.load(_source, onLoaded);
		}
		
		private function onLoaded(url:String):void
		{
			if(url == _source)
			{
				_bitmap.bitmapData = _loader.getBmd(url);
				
				if(_callback != null)
					_callback.apply();
			}
		}
	}
}