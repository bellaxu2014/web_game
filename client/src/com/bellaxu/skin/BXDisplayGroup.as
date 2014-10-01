package com.bellaxu.skin
{
	import com.bellaxu.util.BXUtil;
	
	import flash.utils.Dictionary;

	/**
	 * 提供增删接口的集合基类
	 * @author BellaXu
	 */
	internal class BXDisplayGroup extends BXDisplayObjectContainer
	{
		protected var _disDic:Dictionary;
		
		public function BXDisplayGroup()
		{
			_disDic = new Dictionary();
			
			numColumns = 1;
		}
		
		override public function clear():void
		{
			super.clear();
			BXUtil.clearDic(_disDic);

			numColumns = 1;
		}
		
		/**
		 * 增加项
		 */
		public function addOne(label:String):void
		{
			
		}
		
		/**
		 * 添加子项
		 */
		public function addSub(sub:BXDisplayObject, ...args):void
		{
			
		}
		
		/**
		 * 删除项
		 */
		public function delOne(label:String):void
		{
			
		}
		
		/**
		 * 删除项
		 */
		public function delSub(sub:BXDisplayObject, ...args):void
		{
			
		}
	}
}