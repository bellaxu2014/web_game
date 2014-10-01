package com.bellaxu
{
	import flash.utils.Dictionary;

	/**
	 * 对象池
	 * @author BellaXu
	 */
	public class ObjectPool
	{
		private static var _dic:Dictionary = new Dictionary();
		
		/**
		 * 通过类名获取实例
		 */
		public static function get(cls:Class):*
		{
			var ary:Array = _dic[cls];
			if(ary && ary.length)
				return ary.pop();
			return new cls();
		}
		
		/**
		 * 返还实例
		 */
		public static function put(cls:Class, obj:Object):void
		{
			if(!_dic[cls])
				_dic[cls] = [];
			_dic[cls].push(obj);
		}
	}
}