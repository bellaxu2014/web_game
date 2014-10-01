package com.bellaxu.res
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.lang.Lang;
	import com.bellaxu.log.Logger;
	import com.bellaxu.util.EncryUtil;
	import com.bellaxu.util.MathUtil;
	import com.bellaxu.util.PathUtil;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import game.core.GameFrame;
	import game.core.GameFrameGroup;

	/**
	 * 加载器
	 * @author BellaXu
	 */
	public class ResLoader
	{
		private var _threadNum:int;
		private var _retryTime:int;
		
		private var _curThreadNum:int;
		private var _curRetryTime:int;
		
		private var _urlVec:Vector.<String>;
		private var _comVec:Vector.<String>;
		
		private var _urlDic:Dictionary;
		private var _resDic:Dictionary;
		private var _paramDic:Dictionary;
		private var _loadingDic:Dictionary;
		
		public function ResLoader(threadNum:int = 10, retryTime:int = 3)
		{
			_threadNum = threadNum;
			_retryTime = retryTime;
			
			_urlVec = new <String>[];
			_comVec = new <String>[];
			
			_urlDic = new Dictionary();
			_resDic = new Dictionary();
			_paramDic = new Dictionary();
			_loadingDic = new Dictionary();
			
			GameFrame.add(delayHandler, GameFrameGroup.LOADER);
		}
		
		public function getBytes(url:String):ByteArray
		{
			if(!_resDic[url])
				return null;
			return _resDic[url] as ByteArray;
		}
		
		public function getBmd(url:String, link:String = null):BitmapData
		{
			if(!_resDic[url])
				return null;
			if(!link)
				return _resDic[url];
			if(!_resDic[url][link])
			{
				var cls:Class = getDefClass(url, link);
				if(cls != null)
				{
					_resDic[url][link] = new cls(0, 0);
				}
			}
			return _resDic[url][link];
		}
		
		public function getMc(url:String, link:String):*
		{
			var cls:Class = getDefClass(url, link);
			if (cls != null)
			{
				var s:* = new cls();
				if (!(s is MovieClip) || (s is MovieClip && MovieClip(s).totalFrames < 2))
				{
					DisplayObject(s).cacheAsBitmap = true;
				}
				return s;
			}
			return null;
		}
		
		public function getContent(url:String):*
		{
			if(_resDic[url] && _resDic[url].content)
				return _resDic[url].content;
			return null;
		}
		
		public function getDefClass(url:String, link:String):Class
		{
			var domain:ApplicationDomain = getDomain(url);
			if (domain.hasDefinition(link))
				return domain.getDefinition(link) as Class;
			return null;
		}
		
		public function getDomain(url:String):ApplicationDomain
		{
			var dic:Dictionary = _resDic[url];
			if(dic && dic.data)
				return dic.data;
			return ApplicationDomain.currentDomain;
		}
		
		/**
		 * 是否已加载
		 */
		public function isLoaded(url:String):Boolean
		{
			return _resDic[url];
		}
		
		/**
		 * 清除回调
		 */
		public function clear(url:String, callback:Function):void
		{
			var item:ResLoaderItem = _paramDic[url];
			if(item)
			{
				for(var i:int = 0;i < item.vecCal.length;i++)
				{
					if(item.vecCal[i] == callback)
						item.vecCal.splice(i, 1);
				}
			}
		}
		
		/**
		 * 加载接口
		 */
		public function load(url:String, callback:Function = null, onProgress:Function = null, onError:Function = null, ver:String = null):void
		{
			var item:ResLoaderItem = _paramDic[url];
			if(!item)
				item = _paramDic[url] = ObjectPool.get(ResLoaderItem);
			item.url = url;
			item.ver = (ver ? ver : ResVer.getVer(url));
			if(callback != null)
				if(item.vecCal.indexOf(callback) < 0)
					item.vecCal.push(callback);
			if(onProgress != null)
				if(item.vecPro.indexOf(onProgress) < 0)
					item.vecPro.push(onProgress);
			if(onError != null)
				if(item.vecErr.indexOf(onError) < 0)
					item.vecErr.push(onError);
			
			if(_loadingDic[url])
				return;
			_loadingDic[url] = true;
			if(_resDic[url])
			{
				if(_comVec.indexOf(url) < 0)
					_comVec.push(url);
				return;
			}
			_urlVec.push(url);
			runQueue();
		}
		
		private function runQueue():void
		{
			if(_curThreadNum >= _threadNum || !_urlVec.length)
				return;
			var url:String = _urlVec.shift();
			var item:ResLoaderItem = _paramDic[url];
			var uld:URLLoader = ObjectPool.get(URLLoader);
			_urlDic[uld] = url;
			_curThreadNum++;
			uld.dataFormat = item.format;
			uld.addEventListener(ProgressEvent.PROGRESS, onUrlProgress);
			uld.addEventListener(IOErrorEvent.IO_ERROR, onUrlError);
			uld.addEventListener(Event.COMPLETE, onUrlLoaded);
			uld.load(new URLRequest(PathUtil.getPath(url) + "?ver=" + item.ver));
		}
		
		private function onUrlLoaded(evt:Event):void
		{
			//正在加载数减1，继续加载下一个
			_curThreadNum--;
			runQueue();
			
			clearULD(evt.target as URLLoader);
			
			var url:String = _urlDic[evt.target];
			var type:String = PathUtil.getType(url);
			delete _urlDic[evt.target];
			var item:ResLoaderItem = _paramDic[url];
			var bytes:ByteArray = evt.target.data as ByteArray;
			var func:Function = null;
			switch(type)
			{
				case ResType.VER:
				case ResType.LAN:
				case ResType.LIB:
					onCompleteCheck(item, bytes);
					break;
				case ResType.AMD:
					bytes = EncryUtil.decodeBytes(bytes);
				default:
					var loader:Loader = ObjectPool.get(Loader);
					_urlDic[loader.contentLoaderInfo] = url;
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
					var lc:LoaderContext = new LoaderContext();
					lc.allowCodeImport = true;
					lc.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
					loader.loadBytes(bytes, lc);
					break;
			}
		}
		
		private function onUrlProgress(evt:ProgressEvent):void
		{
			var url:String = _urlDic[evt.target];
			var item:ResLoaderItem = _paramDic[url];
			item.isLoaded = (evt.bytesLoaded == evt.bytesTotal);
			for each (var func:Function in item.vecPro)
			{
				func(URLLoader(evt.target).bytesLoaded, URLLoader(evt.target).bytesTotal);
			}
		}
		
		private function onUrlError(evt:IOErrorEvent):void
		{
			clearULD(evt.target as URLLoader);
			
			var url:String = _urlDic[evt.target];
			var item:ResLoaderItem = _paramDic[url];
			delete _urlDic[evt.target];
			if (++item.retryTime < _retryTime)
			{
				_urlVec.unshift(url);
			}
			else
			{
				Logger.error(Lang.getLocalString("load_cannot_load") + "(" + item.retryTime + "): " + PathUtil.getPath(url));
				for each (var func:Function in item.vecErr)
				{
					func(url);
				}
				item.clear();
			}
			_curThreadNum--;
			runQueue();
		}
		
		private function clearULD(uld:URLLoader):void
		{
			uld.removeEventListener(Event.COMPLETE, onUrlLoaded);
			uld.removeEventListener(ProgressEvent.PROGRESS, onUrlProgress);
			uld.removeEventListener(IOErrorEvent.IO_ERROR, onUrlError);
			uld.close();
			ObjectPool.put(URLLoader, uld);
		}
		
		private function clearLD(ld:LoaderInfo):void
		{
			ld.removeEventListener(Event.COMPLETE, onComplete);
			ld.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			ObjectPool.put(Loader, ld.loader);
		}
		
		private function onComplete(evt:Event):void
		{
			clearLD(LoaderInfo(evt.target));
			
			var url:String = _urlDic[evt.target];
			var type:String = PathUtil.getType(url);
			var item:ResLoaderItem = _paramDic[url];
			delete _urlDic[evt.target];
			
			switch(type)
			{
				case ResType.PNG:
				case ResType.JPG:
				case ResType.JPEG:
					onCompleteCheck(item, evt.target.content.bitmapData);
					break;
				default:
					var dic:Dictionary = new Dictionary();
					dic.data = LoaderInfo(evt.target).applicationDomain;
					if(url == ResPath.GAME || url == ResPath.GAME_TEST)
						dic.content = LoaderInfo(evt.target).content;
					onCompleteCheck(item, dic);
					break;
			}
		}
		
		private function onCompleteCheck(item:ResLoaderItem, data:*):void
		{
			if(item.isLoaded)
			{
				_resDic[item.url] = data;
				if(item.vecCal.length)
					_comVec.push(item.url);
			}
			else
			{
				item.ver = MathUtil.getRandomInt(uint.MIN_VALUE, uint.MAX_VALUE).toString();
				_urlVec.unshift(item.url);
			}
		}
		
		private function onError(evt:IOErrorEvent):void
		{
			clearLD(LoaderInfo(evt.target));
			
			var url:String = _urlDic[evt.target];
			var item:ResLoaderItem = _paramDic[url];
			delete _urlDic[evt.target];
			delete _paramDic[url];
			delete _loadingDic[url];
			for each (var func:Function in item.vecErr)
			{
				func(url);
			}
			Logger.error(Lang.getLocalString("load_cannot_handle") + url);
			item.clear();
		}
		
		private function delayHandler():void
		{
			if(!_comVec.length)
				return;
			var url:String = _comVec.pop();
			var item:ResLoaderItem = _paramDic[url];
			delete _paramDic[url];
			delete _loadingDic[url];
			var func:Function;
			for each(func in item.vecPro)
			{
				func(100, 100);
			}
			for each(func in item.vecCal)
			{
				func(url);
			}
			item.clear();
		}
	}
}