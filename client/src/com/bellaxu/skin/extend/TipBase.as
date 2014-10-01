package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.net.struct.StructBase;
	import com.bellaxu.skin.BXDisplayObject;
	import com.bellaxu.skin.BXImage;
	import com.bellaxu.skin.BXLabel;
	import com.bellaxu.skin.BXLine;
	import com.bellaxu.skin.BXTextArea;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import game.core.GameFrame;
	import game.core.GameFrameGroup;
	import game.core.GameResLoader;

	/**
	 * 悬浮基类
	 * @author BellaXu
	 */
	public class TipBase extends BXDisplayObject
	{
		protected var _border:MovieClip;
		protected var _ImgArrow1:BXImage;
		protected var _ImgArrow2:BXImage;
		protected var _imgTitle:BXImage;
		protected var _lbTitle:BXLabel;
		protected var _line1:BXLine;
		protected var _taDesc:BXTextArea;
		
		public function TipBase()
		{
			_border = GameResLoader.getBasicSkin("BXTip1");
			_border.width = 220;
			addChild(_border);
			
			_ImgArrow1 = ObjectPool.get(BXImage);
			_ImgArrow1.bitmapData = GameResLoader.getExtendBitmapData("ItemTip_a");
			_ImgArrow1.x = 3;
			_ImgArrow1.y = 22;
			addChild(_ImgArrow1);
			
			_ImgArrow2 = ObjectPool.get(BXImage);
			_ImgArrow2.bitmapData = GameResLoader.getExtendBitmapData("ItemTip_a");
			_ImgArrow2.rotation = 180;
			_ImgArrow2.x = _border.width - 4;
			_ImgArrow2.y = _ImgArrow2.height + 22;
			addChild(_ImgArrow2);
			
			_imgTitle = ObjectPool.get(BXImage);
			_imgTitle.x = 1;
			_imgTitle.y = 3;
			addChild(_imgTitle);
			
			_lbTitle = ObjectPool.get(BXLabel);
			_lbTitle.y = 4;
			addChild(_lbTitle);
			
			_line1 = ObjectPool.get(BXLine);
			_line1.x = 18;
			_line1.y = 97;
			_line1.width = _border.width - (_line1.x << 1);
			addChild(_line1);
			
			_taDesc = ObjectPool.get(BXTextArea);
			_taDesc.width = _border.width - 24;
			_taDesc.x = 12;
			_taDesc.y = _line1.y + _line1.height + 5;
			addChild(_taDesc);
			
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_itemId = 0;
			_more = null;
			_border.width = 220;
		}
		
		private var _itemId:int;
		/**
		 * 物品id
		 */
		override public function set itemId(value:int):void
		{
			_itemId = value;
		}
		
		override public function get itemId():int
		{
			return _itemId;
		}
		
		private var _more:StructBase;
		/**
		 * 更多数据
		 */
		public function set more(value:StructBase):void
		{
			_more = value;
		}
		
		public function get more():StructBase
		{
			return _more;
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);
			GameFrame.add(updateTip, GameFrameGroup.DISPLAY);
		}
		
		override protected function onRemovedFromStage(e:Event):void
		{
			super.onRemovedFromStage(e);
			GameFrame.del(updateTip, GameFrameGroup.DISPLAY);
			clear();
		}
		
		override public function get width():Number
		{
			return _border.width;
		}
		
		override public function get height():Number
		{
			return _border.height;
		}
		
		protected function updateTip():void
		{
			if(stage)
			{
				x = stage.mouseX;
				y = stage.mouseY;
				
				var p:Point = localToGlobal(new Point(_border.width, _border.height));
				if(p.x < stage.stageWidth)
				{
					x += 25;
				}
				else
				{
					x -= width + 2;
				}
				if(p.y < stage.stageHeight)
				{
					y += 25;
				}
				else
				{
					y -= height + 2;
				}
			}
		}
	}
}