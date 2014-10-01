package com.bellaxu.util
{
	import com.bellaxu.IClearable;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.utils.Dictionary;

	/**
	 * BX工具类
	 */
	public class BXUtil
	{
		private static var disabledFilter:ColorMatrixFilter =
			new ColorMatrixFilter([0.2086, 0.6094, 0.0820, 0, 0, 0.2086, 0.6094, 0.082, 0, 0, 0.2086, 0.6094, 0.082,
				0, 0, 0, 0, 0, 1, 0]);
		
		/**
		 * 清除字典
		 */
		public static function clearDic(dic:Dictionary):void
		{
			for(var k:* in dic)
			{
				delete dic[k];
			}
		}
		
		public static function clearContainer(container:DisplayObjectContainer):void
		{
			while(container.numChildren)
			{
				var dis:DisplayObject = container.removeChildAt(0);
				if(dis is IClearable)
					IClearable(dis).clear();
			}
		}
		
		/**
		 * 设置显示对象可用状态
		 */
		public static  function setEnabled(obj:DisplayObject, enabled:Boolean):void
		{
			if(obj is InteractiveObject)
			{
				InteractiveObject(obj).mouseEnabled = enabled;
			}
			var i:int;
			if(enabled)
			{
				obj.filters = null;
			}
			else
			{
				obj.filters = [disabledFilter];
			}
		}
		
		/**
		 * 设置显示对象亮度
		 * <br/>value取值范围-1~1, 对应Flash内容制作工具里的-100%-100%
		 */
		public static function setBrightness(obj:DisplayObject, value:Number):void 
		{
			var colorTransformer:ColorTransform = obj.transform.colorTransform;
			var backup_filters:Array = obj.filters;
			if (value >= 0) 
			{
				colorTransformer.blueMultiplier = 1 - value;
				colorTransformer.redMultiplier = 1 - value;
				colorTransformer.greenMultiplier = 1 - value;
				colorTransformer.redOffset = 255 * value;
				colorTransformer.greenOffset = 255 * value;
				colorTransformer.blueOffset = 255 * value;
			}
			else 
			{
				value = Math.abs(value);
				colorTransformer.blueMultiplier = 1 - value;
				colorTransformer.redMultiplier = 1 - value;
				colorTransformer.greenMultiplier = 1 - value;
				colorTransformer.redOffset = 0;
				colorTransformer.greenOffset = 0;
				colorTransformer.blueOffset = 0;
			}
			obj.transform.colorTransform = colorTransformer;
			obj.filters = backup_filters;
		}
	}
}