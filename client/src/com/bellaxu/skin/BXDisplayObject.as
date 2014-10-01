package com.bellaxu.skin
{
	import com.bellaxu.IClearable;
	import com.bellaxu.ObjectPool;
	import game.core.GameFrameGroup;
	import com.bellaxu.util.BXUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import game.core.GameFrame;
	import game.core.GameTip;

	/**
	 * BX组件的基类
	 * @author BellaXu
	 */
	public class BXDisplayObject extends Sprite implements IClearable
	{
		private var _listeners:Dictionary;
		
		public function BXDisplayObject()
		{
			_listeners = new Dictionary();
			
			super.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			super.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			super.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
			super.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			super.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
			super.addEventListener(MouseEvent.MOUSE_UP, upHandler);
		}
		
		private var _tip:String;
		/**
		 * 文本悬浮
		 */
		public function set tip(value:String):void
		{
			_tip = value;
			_tip ? GameTip.regist(this) : GameTip.unRegist(this);
		}
		
		public function get tip():String
		{
			return _tip;
		}
		
		private var _itemId:int;
		/**
		 * 物品id
		 */
		public function set itemId(value:int):void
		{
			_itemId = value;
			_itemId > 0 ? GameTip.regist(this) : GameTip.unRegist(this);
		}
		
		public function get itemId():int
		{
			return _itemId;
		}
		
		public function clear():void
		{
			x = 0;
			y = 0;
			_width = 0;
			_height = 0;
			_itemId = 0;
			_tip = null;
			filters = null;
			
			var cls:Class;
			var name:String = getQualifiedClassName(this).replace("::", ".");
			if(ApplicationDomain.currentDomain.hasDefinition(name))
				cls = ApplicationDomain.currentDomain.getDefinition(name) as Class;
			ObjectPool.put(cls, this);
			
			var type:String;
			var list:Vector.<Function>;
			var func:Function;
			for(type in _listeners)
			{
				list = _listeners[type];
				for each(func in list)
				{
					super.removeEventListener(type, func);
				}
				list.length = 0;
			}
			BXUtil.clearDic(_listeners);
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			var list:Vector.<Function> = _listeners[type];
			if(!list)
				list = _listeners[type] = new <Function>[];
			if(list.indexOf(listener) < 0)
			{
				list.push(listener);
				super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			}
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			var list:Vector.<Function> = _listeners[type];
			if(list)
			{
				var i:int = list.indexOf(listener);
				if(i > -1)
				{
					list.splice(i, 1);
					super.removeEventListener(type, listener, useCapture);
				}
			}
		}
		
		protected var _width:int;
		
		override public function set width(value:Number):void
		{
			_width = value;
			repaintNextFrame();
		}
		
		override public function get width():Number
		{
			return _width ? _width : super.width;
		}
		
		protected var _height:int;
		
		override public function set height(value:Number):void
		{
			_height = value;
			repaintNextFrame();
		}
		
		override public function get height():Number
		{
			return _height ? _height : super.height;
		}
		
		/**
		 * 为子类提供永不移除的方法
		 */
		protected function addEventListener2(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		protected function onAddedToStage(e:Event):void
		{
			
		}
		
		protected function onRemovedFromStage(e:Event):void
		{
			
		}
		
		protected function overHandler(e:MouseEvent):void
		{
			
		}
		
		protected function downHandler(e:MouseEvent):void
		{
			
		}
		
		protected function outHandler(e:MouseEvent):void
		{
			
		}
		
		protected function upHandler(e:MouseEvent):void
		{
			
		}
		
		/**
		 * 下帧重绘
		 */
		final protected function repaintNextFrame():void
		{
			if(!GameFrame.has(repaint, GameFrameGroup.DISPLAY))
				GameFrame.add(repaint, GameFrameGroup.DISPLAY, 1);
		}
		
		protected function repaint():void
		{
			
		}
	}
}