package org.robotlegs.base
{
    import flash.events.*;

    public class ContextBase extends Object implements IContext, IEventDispatcher
    {
        protected var _eventDispatcher:IEventDispatcher;

        public function ContextBase()
        {
            this._eventDispatcher = new EventDispatcher(this);
            return;
        }// end function

        public function get eventDispatcher() : IEventDispatcher
        {
            return this._eventDispatcher;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            this.eventDispatcher.addEventListener(param1, param2, param3, param4);
            return;
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            if (this.eventDispatcher.hasEventListener(event.type))
            {
                return this.eventDispatcher.dispatchEvent(event);
            }
            return false;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return this.eventDispatcher.hasEventListener(param1);
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            this.eventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return this.eventDispatcher.willTrigger(param1);
        }// end function

    }
}
