package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.util.BXUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * 树形控件
	 * @author BellaXu
	 */
	public class BXTree extends BXDisplayObjectContainer
	{
		private var _nodes:Vector.<BXTreeNode>;
		
		public function BXTree()
		{
			numColumns = 1;
			
			_nodes = new <BXTreeNode>[];
		}
		
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
			n.depth = 0;
			n.parentTree = this;
			addChild(n);
			_nodes.push(n);
			
			if(numChildren == 1)
				selectedNode = getNode(0);
		}
		
		public function delNode(label:String):void
		{
			for(var i:int = 0;i < _nodes.length;i++)
			{
				if(_nodes[i].label == label)
				{
					if(_selectedNode == _nodes[i])
						_selectedNode = null;
					if(contains(_nodes[i]))
						removeChild(_nodes[i]);
					_nodes[i].clear();
					_nodes.splice(i, 1);
					return;
				}
			}
		}
		
		public function addSub(label:String, ...args):void
		{
			var n:BXTreeNode = _nodes[args[0]];
			var i:int = 1;
			while(i < args.length)
			{
				n = n.nodes[args[i]];
				i++;
			}
			n.addNode(label);
			
			if(selectedNode == n)
				selectedNode = n.nodes[0];
		}
		
		public function delSub(label:String, ...args):void
		{
			var pn:BXTreeNode = null;
			var n:BXTreeNode = _nodes[args[0]];
			var i:int = 1;
			while(i < args.length)
			{
				pn = n;
				n = n.nodes[args[i]];
				i++;
			}
			if(_selectedNode == n)
				_selectedNode = null;
			if(contains(n))
				removeChild(n);
			if(pn)
				pn.nodes.splice(args[args.length - 1], 1);
			n.clear();
		}
		
		public function openAll():void
		{
			for(var i:int = 0;i < _nodes.length;i++)
			{
				_nodes[i].open = true;
			}
		}
		
		override public function clear():void
		{
			super.clear();
			
			_selectedNode = null;
			_nodes.length = 0;
			
			BXUtil.clearContainer(this);
		}
		
		public function getNode(...args):BXTreeNode
		{
			if(!args.length)
				return null;
			var i:int = 1;
			var n:BXTreeNode = _nodes[args[0]];
			while(i < args.length)
			{
				n = n.nodes[args[i]];
				i++;
			}
			return n;
		}
		
		private var _selectedNode:BXTreeNode;
		
		public function set selectedNode(value:BXTreeNode):void
		{
			if(value)
				value.selected = true;
			
			if(_selectedNode && _selectedNode != value)
				_selectedNode.selected = false;
			
			_selectedNode = value;
			
			if(value)
				this.dispatchEvent(new Event(BXEvent.SELECTED));
		}
		
		public function get selectedNode():BXTreeNode
		{
			return _selectedNode;
		}
		
		override public function set selectedIndex(value:int):void
		{
			
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			var node:BXTreeNode;
			if(e.target is BXImageButton)
			{
				if(e.target.parent && e.target.parent is BXTreeNode)
				{
					node = e.target.parent as BXTreeNode;
					if(node.open)
					{
						closeNode(node);
					}
					else
					{
						node.open = true;
					}
				}
			}
			else if(e.target is BXLabel)
			{
				selectedNode = e.target.parent as BXTreeNode;
			}
		}
		
		private function closeNode(node:BXTreeNode):void
		{
			for each(var sn:BXTreeNode in node.nodes)
			{
				closeNode(sn);
			}
			node.open = false;
		}
	}
}