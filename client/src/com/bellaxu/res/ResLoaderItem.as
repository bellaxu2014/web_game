package com.bellaxu.res
{
	import com.bellaxu.IClearable;
	import com.bellaxu.ObjectPool;
	
	import flash.net.URLLoaderDataFormat;

	/**
	 * 加载项
	 * @author BellaXu
	 */
	public class ResLoaderItem implements IClearable
	{
		public var url:String;
		public var ver:String;
		public var format:String;
		public var retryTime:int;
		public var isLoaded:Boolean;
		public var vecCal:Vector.<Function>;
		public var vecPro:Vector.<Function>;
		public var vecErr:Vector.<Function>;
		
		public function ResLoaderItem()
		{
			format = URLLoaderDataFormat.BINARY;
			retryTime = 0;
			
			vecCal = new <Function>[];
			vecPro = new <Function>[];
			vecErr = new <Function>[];
		}
		
		public function clear():void
		{
			url = null;
			ver = null;
			format = URLLoaderDataFormat.BINARY;
			retryTime = 0;
			isLoaded = false;
			vecCal.length = 0;
			vecPro.length = 0;
			vecErr.length = 0;
			
			ObjectPool.put(ResLoaderItem, this);
		}
	}
}