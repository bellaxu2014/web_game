package game.core
{
    import com.bellaxu.log.Logger;
    
    import flash.events.TimerEvent;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import flash.utils.getTimer;
    
    /**
     * 延时控制器
     * @author BellaXu
     */
    public class GameTimer
    {
        private static var _instance:GameTimer = null;

        private static var timerDic:Dictionary = new Dictionary(); //存储new的timer  按照延时长短处理
        private static var funcToTimerDic:Dictionary = new Dictionary(); //存储new的timer  按照fun存储
        private static var funcListDic:Dictionary = new Dictionary(); //存储要调用的方法
        private static var paramsDic:Dictionary = new Dictionary();
        private static var countDic:Dictionary = new Dictionary();

        /**
         * 判断是否存在某function的定时器
         * @param fuc : Function
         * @return Boolean
         */
        public static function has(func:Function) : Boolean
        {
            return funcToTimerDic[func] != undefined;
        }

        /**
         * @param delay 延时ms
         * @param func  方法
         * @param count 执行次数，默认-1代表无限次
         * @param args  参数列表
         */
        public static function add(delay:int, func:Function, count:int = -1, ... args) : void
        {
			if(func == null)
				return;
			del(func);
			if(count == 0)
				return;
            funcToTimerDic[func] = createTimer(delay);
            paramsDic[func] = args;
            countDic[func] = [0, count];
            funcListDic[delay].push(func); //把此时的dic的此个obj看成数组，，存储方法为每个元素。。。
        }

        /**
         * 移除方法延时
         */
        public static function del(func:Function) : void
        {
            if(funcToTimerDic[func] == undefined)
                return;
            var timer:Timer = funcToTimerDic[func];
            delete funcToTimerDic[func];
            delete paramsDic[func];
            delete countDic[func];
            var list:Array = funcListDic[timer.delay];
            if(list.indexOf(func) > -1)
            {
                list.splice(list.indexOf(func), 1);
            }
            if(list.length == 0)
            {
                timer.stop();
                timer.removeEventListener(TimerEvent.TIMER, timerHandler);
                delete funcListDic[timer.delay];
                delete timerDic[timer.delay];
            }
        }

        private static function createTimer(delay:int) : Timer
        {
            if(timerDic[delay] == undefined)
            {
                var timer:Timer = new Timer(delay);
                timer.addEventListener(TimerEvent.TIMER, timerHandler);
                timer.start();
                timerDic[delay] = timer;

            }
            if(funcListDic[delay] == undefined)
            {
                funcListDic[delay] = [];
            }
            return timerDic[delay];
        }

        private static function timerHandler(e:TimerEvent) : void
        {
            var curTimer:Number = getTimer();
            var list:Array = funcListDic[Timer(e.target).delay];
			var len:int = list.length;
            for(var i:int = len - 1; i >= 0; i--)
            {
                var func:Function = list[i];
				if (func == null) continue;
                var params:Array = paramsDic[func];
                var count:Array = countDic[func];
                func.apply(null, params);
                if(count[1] != -1)
                {
                    count[0]++;
                    if(count[0] >= count[1])
						del(func);
                }
            }
            if(getTimer() - curTimer > 5)
                Logger.warn("timer(" + Timer(e.target).delay + "/" + len + ") cost: " + (getTimer() - curTimer) + "(ms)");
        }
    }
}