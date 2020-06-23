package org.robotlegs.mvcs
{
    import flash.events.*;
    import org.robotlegs.base.*;
    import org.robotlegs.core.*;

    public class Actor extends Object
    {
        protected var _eventDispatcher:IEventDispatcher;
        protected var _eventMap:IEventMap;

        public function Actor()
        {
            return;
        }// end function

        public function get eventDispatcher() : IEventDispatcher
        {
            return this._eventDispatcher;
        }// end function

        public function set eventDispatcher(param1:IEventDispatcher) : void
        {
            this._eventDispatcher = param1;
            return;
        }// end function

        protected function get eventMap() : IEventMap
        {
            if (!this._eventMap)
            {
                var _loc_1:* = new EventMap(this.eventDispatcher);
                this._eventMap = new EventMap(this.eventDispatcher);
            }
            return _loc_1;
        }// end function

        protected function dispatch(event:Event) : Boolean
        {
            if (this.eventDispatcher.hasEventListener(event.type))
            {
                return this.eventDispatcher.dispatchEvent(event);
            }
            return false;
        }// end function

    }
}
