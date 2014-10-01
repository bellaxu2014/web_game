package com.bellaxu.skin
{
	import game.core.GameFrameGroup;
	import game.core.GameFrame;
	import com.bellaxu.res.ResLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * 动画组件
	 * @author BellaXu
	 */
	public class BXMovie extends BXDisplayObject
	{
		private static var _loader:ResLoader = new ResLoader(3);
		
		private var _bitmap:Bitmap;
		private var _source:String;
		private var _interval:int = 1;
		private var _totalFrames:int;
		private var _currentFrame:int = 1;
		private var _startFrame:int = 1;
		private var _endFrame:int;
		
		public function BXMovie()
		{
			_bitmap = new Bitmap();
			addChild(_bitmap);
		}
		
		/**
		 * 动画路径
		 */
		public function set source(value:String):void
		{
			_source = value;
			updateSource();
		}
		
		public function get source():String
		{
			return _source;
		}
		
		/**
		 * 播放间隔
		 */
		public function set interval(value:int):void
		{
			_interval = value;
		}
		
		public function get interval():int
		{
			return _interval;
		}
		
		/**
		 * 当前帧
		 */
		public function get currentFrame():int
		{
			return _currentFrame;
		}
		
		/**
		 * 停在某一帧
		 */
		public function gotoAndStop(frame:int):void
		{
			_currentFrame = frame;
			
			stop();
		}
		
		/**
		 * 从某一帧开始播，在endFrame时回到startFrame
		 */
		public function gotoAndPlay(startFrame:int, endFrame:int = -1):void
		{
			_currentFrame = startFrame;
			_startFrame = startFrame;
			_endFrame = endFrame;
			
			play();
		}
		
		/**
		 * 播放
		 */
		public function play():void
		{
			GameFrame.add(render, GameFrameGroup.MOVIE);
		}
		
		/**
		 * 停止播放
		 */
		public function stop():void
		{
			GameFrame.del(render, GameFrameGroup.MOVIE);
		}
		
		private var _count:int;
		
		private function render():void
		{
			if(++_count < _interval)
				return;
			_count = 0;
			if(_currentFrame > _endFrame)
			{
				_currentFrame = _startFrame;
			}
			if(_currentFrame <= _totalFrames)
			{
				_bitmap.bitmapData = _loader.getBmd(_source, "f" + _currentFrame);
				_currentFrame++;
			}
		}
		
		private function updateSource():void
		{
			if(_source)
			{
				if(_loader.isLoaded(_source))
				{
					_currentFrame = 1;
					_startFrame = 1;
					_endFrame = _totalFrames;
				}
				else
				{
					_loader.load(_source, onLoaded);
				}
			}
		}
		
		private function onLoaded(url:String):void
		{
			if(url == _source)
			{
				var i:int;
				var bmd:BitmapData;
				while(++i)
				{
					bmd = _loader.getBmd(url, "f" + i.toString());
					if(!bmd)
						break;
					_totalFrames++;
				}
				updateSource();
			}
		}
		
		override public function clear():void
		{
			super.clear();
			
			stop();
			_bitmap.bitmapData = null;
			_source = null;
			_interval = 1;
			_totalFrames = 0;
			_currentFrame = 1;
			_startFrame = 1;
			_endFrame = 0;
		}
	}
}