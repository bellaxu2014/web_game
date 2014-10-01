package game.core
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	/**
	 * 帧管理
	 * @author BellaXu
	 */
	public class GameFrame
	{
		private static var groupDic:Dictionary = new Dictionary(); //组别字典, 存放数据[funcVec]
		private static var pauseDic:Dictionary = new Dictionary(); //暂停字典, 存放数据[groups]
		private static var funcParamsDic:Dictionary = new Dictionary(); //方法被Enter的次数字典, 存放数据[runCount, runCount, ...args]
		private static var interval:uint;//时间片长度
		private static var lastTime:uint;//上次帧时间
		private static var lostTime:uint;//丢失的时间
		private static var lostCount:uint;//连续丢帧的次数
		private static var lostFlag:Boolean = false; //连续丢帧的标志
		
		public static function regist(stage:Stage) : void
		{
			//算每帧时间
			interval = 1000 / stage.frameRate;
			//监听舞台帧，全局只有这个帧监听，其他地方不要添加了
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * 假如连续100帧丢帧，则认定为当前不适合跑高帧频
		 */
		public static function get isFluent():Boolean
		{
			return lostCount > 100;
		}
		
		private static function onEnterFrame(e:Event) : void
		{
			var curTime:uint = getTimer();
			var timeGap:uint = curTime - lastTime;
			if(timeGap > interval)
			{
				lostTime += timeGap - interval;
				if(timeGap >= interval << 1)
				{
					lostFlag = true;
					lostCount++;
				}
				else
				{
					lostFlag = false;
					lostCount = 0;
				}
			}
			else
			{
				lostFlag = false;
				lostCount = 0;
			}
			var renderTimes:uint = 1;
			if(lostTime >= interval)
			{
				renderTimes += int(lostTime / interval);
				lostTime = lostTime % interval;
				
				if(renderTimes >= 3)
				{
					//新增规则，最多渲染3次，避免单个时间片因为补帧太卡
					renderTimes = 3;
				}
			}
			var i:int = 0, j:int = 0;
			var group:String = null;
			var funcVec:Vector.<Function> = null;
			var func:Function = null;
			var funcParams:Array = null;
			for(i = 0; i < renderTimes; i++)
			{
				for(group in groupDic)
				{
					if(pauseDic[group] == true)
						continue;
					funcVec = groupDic[group];
					for(j = funcVec.length - 1; j >= 0;j--)
					{
						func = funcVec[j];
						funcParams = funcParamsDic[func];
						//若达到规定运行的次数则删除该方法
						if(funcParams[1] >= 0 && ++funcParams[0] >= funcParams[1])
						{
							funcVec.splice(j, 1);
							delete funcParamsDic[func];
						}
						func.apply(null, funcParams[2]);
					}
				}
			}
			lastTime = getTimer();
		}
		
		public static function has(func:Function, group:String):Boolean
		{
			return groupDic[group] && groupDic[group].indexOf(func) > -1;
		}
		
		public static function add(func:Function, group:String, count:int = -1, ...args):void
		{
			if(func == null)
				return;
			var vec:Vector.<Function> = groupDic[group];
			if(!vec)
				vec = groupDic[group] = new <Function>[];
			if(funcParamsDic[func])
				del(func, group);
			funcParamsDic[func] = [0, count, args];
			vec.unshift(func);
		}
		
		public static function del(func:Function, group:String):void
		{
			if (!has(func, group))
				return;
			//从字典中也删除
			var funcVec:Vector.<Function> = groupDic[group];
			if(funcVec.indexOf(func) > -1)
			{
				funcVec.splice(funcVec.indexOf(func), 1);
				delete funcParamsDic[func];
			}
		}
		
		public static function play(group:String):void
		{
			if(pauseDic[group])
				delete pauseDic[group];
		}
		
		public static function pause(group:String):void
		{
			pauseDic[group] = true;
		}
	}
}