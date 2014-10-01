package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	
	import game.core.GameResLoader;

	/**
	 * 树节点
	 * @author BellaXu
	 */
	public class BXTreeNode extends BXDisplayObject
	{
		private var _btnNode:BXImageButton;
		private var _spliter:BXLabel;
		private var _label:BXLabel;
		
		private var _nodes:Vector.<BXTreeNode>;
		
		public function BXTreeNode()
		{
			_btnNode = ObjectPool.get(BXImageButton);
			_btnNode.bitmapData = GameResLoader.getBasicBitmapData("BXNumberInput_add");
			_btnNode.visible = false;
			addChild(_btnNode);
			
			_spliter = ObjectPool.get(BXLabel);
			_spliter.text = "-";
			_spliter.x = _btnNode.x + _btnNode.width;
			_spliter.y = _btnNode.height - _spliter.textHeight - 4 >> 1;
			_spliter.mouseEnabled = true;
			addChild(_spliter);
			
			_label = ObjectPool.get(BXLabel);
			_label.x = _spliter.x + _spliter.width - 3;
			_label.y = _spliter.y;
			_label.mouseEnabled = true;
			addChild(_label);
			
			_nodes = new <BXTreeNode>[];
		}
		
		/**
		 * 标签
		 */
		public function set label(value:String):void
		{
			_label.text = value;
		}
		
		public function get label():String
		{
			return _label.text;
		}
		
		private var _parentTree:BXTree;
		/**
		 * 父节点
		 */
		public function set parentTree(value:BXTree):void
		{
			_parentTree = value;
		}
		
		public function get parentTree():BXTree
		{
			return _parentTree;
		}
		
		private var _depth:int;
		
		/**
		 * 深度
		 */
		public function set depth(value:int):void
		{
			if(_depth == value)
				return;
			_depth = value;
			_btnNode.x = _depth * _btnNode.width;
			_spliter.x = _btnNode.x + _btnNode.width;
			_label.x = _spliter.x + _spliter.width - 3;
		}
		
		public function get depth():int
		{
			return _depth;
		}
		
		/**
		 * 选中
		 */
		public function set selected(value:Boolean):void
		{
			_label.selected = value;
			if(value && !open)
				open = value;
		}
		
		/**
		 * 添加节点
		 */
		public function addNode(label:String):void
		{
			var n:BXTreeNode;
			for each(n in _nodes)
			{
				if(n.label == label)
					return;
			}
			n = ObjectPool.get(BXTreeNode);
			n.label = label;
			n.parentTree = parentTree;
			n.depth = depth + 1;
			_nodes.push(n);
			repaintNextFrame();
		}
		
		/**
		 * 删除节点
		 */
		public function delNode(label:String):void
		{
			for(var i:int = 0;i < _nodes.length;i++)
			{
				if(_nodes[i].label == label)
				{
					_nodes.splice(i, 1);
					repaintNextFrame();
					return;
				}
			}
		}
		
		/**
		 * 节点集合
		 */
		public function get nodes():Vector.<BXTreeNode>
		{
			return _nodes;
		}
		
		private var _open:Boolean;
		
		/**
		 * 是否打开
		 */
		public function set open(value:Boolean):void
		{
			_open = value;
			_btnNode.bitmapData = GameResLoader.getBasicBitmapData("BXNumberInput_" + (value ? "red" : "add"));
			repaintNextFrame();
		}
		
		public function get open():Boolean
		{
			return _open;
		}
		
		override public function clear():void
		{
			super.clear();
			
			for each(var n:BXTreeNode in _nodes)
			{
				if(n.parentTree)
					n.parentTree.removeChild(n);
			}
			
			_parentTree = null;
			_nodes.length = 0;
			_depth = 0;
			_btnNode.style = 502;
			_btnNode.visible = false;
			_label.selected = false;
			_open = false;
		}
		
		override protected function repaint():void
		{
			super.repaint();
			
			_btnNode.visible = _nodes.length > 0;
			
			if(parentTree)
			{
				var i:int;
				if(open)
				{
					var pi:int = parentTree.getChildIndex(this);
					var ri:int;
					while(i < _nodes.length)
					{
						ri = pi + i + 1;
						
						if(!parentTree.contains(_nodes[i]) || parentTree.getChildIndex(_nodes[i]) != ri)
							parentTree.addChildAt(_nodes[i], ri);
						i++;
					}
				}
				else
				{
					while(i < _nodes.length)
					{
						if(parentTree.contains(_nodes[i]))
							parentTree.removeChild(_nodes[i]);
						i++;
					}
				}
			}
		}
	}
}