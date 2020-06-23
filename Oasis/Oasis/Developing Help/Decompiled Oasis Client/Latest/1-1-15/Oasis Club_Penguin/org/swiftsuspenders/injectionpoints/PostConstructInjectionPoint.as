package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.*;

    public class PostConstructInjectionPoint extends InjectionPoint
    {
        protected var methodName:String;
        protected var orderValue:int;

        public function PostConstructInjectionPoint(param1:XML, param2:Injector)
        {
            super(param1, param2);
            return;
        }// end function

        public function get order() : int
        {
            return this.orderValue;
        }// end function

        override public function applyInjection(param1:Object, param2:Injector) : Object
        {
            var _loc_3:* = param1;
            _loc_3.param1[this.methodName]();
            return param1;
        }// end function

        override protected function initializeInjection(param1:XML, param2:Injector) : void
        {
            var orderArg:XMLList;
            var methodNode:XML;
            var node:* = param1;
            var injector:* = param2;
            var _loc_5:int = 0;
            var _loc_6:* = node.arg;
            var _loc_4:* = new XMLList("");
            for each (_loc_7 in _loc_6)
            {
                
                var _loc_8:* = _loc_7;
                with (_loc_7)
                {
                    if (@key == "order")
                    {
                        _loc_4[_loc_5] = _loc_7;
                    }
                }
            }
            orderArg = _loc_4;
            methodNode = node.parent();
            this.orderValue = int(orderArg.@value);
            this.methodName = methodNode.@name.toString();
            return;
        }// end function

    }
}
