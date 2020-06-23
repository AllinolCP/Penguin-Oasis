package org.robotlegs.base
{
    import flash.events.*;

    public class EventMap extends Object implements IEventMap
    {
        protected var eventDispatcher:IEventDispatcher;
        protected var _dispatcherListeningEnabled:Boolean = true;
        protected var listeners:Array;

        public function EventMap(param1:IEventDispatcher)
        {
            this.listeners = new Array();
            this.eventDispatcher = param1;
            return;
        }// end function

        public function get dispatcherListeningEnabled() : Boolean
        {
            return this._dispatcherListeningEnabled;
        }// end function

        public function set dispatcherListeningEnabled(param1:Boolean) : void
        {
            this._dispatcherListeningEnabled = param1;
            return;
        }// end function

        public function mapListener(param1:IEventDispatcher, param2:String, param3:Function, param4:Class = null, param5:Boolean = false, param6:int = 0, param7:Boolean = true) : void
        {
            var params:Object;
            var dispatcher:* = param1;
            var type:* = param2;
            var listener:* = param3;
            var eventClass:* = param4;
            var useCapture:* = param5;
            var priority:* = param6;
            var useWeakReference:* = param7;
            if (this.dispatcherListeningEnabled == false)
            {
            }
            if (dispatcher == this.eventDispatcher)
            {
                throw new ContextError(ContextError.E_EVENTMAP_NOSNOOPING);
            }
            if (!eventClass)
            {
            }
            eventClass = Event;
            var i:* = this.listeners.length;
            do
            {
                
                params = this.listeners[i];
                if (params.dispatcher == dispatcher)
                {
                }
                if (params.type == type)
                {
                }
                if (params.listener == listener)
                {
                }
                if (params.useCapture == useCapture)
                {
                }
                if (params.eventClass == eventClass)
                {
                    return;
                }
                i = (i - 1);
            }while (i)
            var callback:* = function (event:Event) : void
            {
                routeEventToListener(event, listener, eventClass);
                return;
            }// end function
            ;
            params;
            this.listeners.push(params);
            dispatcher.addEventListener(type, callback, useCapture, priority, useWeakReference);
            return;
        }// end function

        public function unmapListener(param1:IEventDispatcher, param2:String, param3:Function, param4:Class = null, param5:Boolean = false) : void
        {
            var _loc_6:Object = null;
            if (!param4)
            {
            }
            param4 = Event;
            var _loc_7:* = this.listeners.length;
            while (_loc_7--)
            {
                
                _loc_6 = this.listeners[_loc_7];
                if (_loc_6.dispatcher == param1)
                {
                }
                if (_loc_6.type == param2)
                {
                }
                if (_loc_6.listener == param3)
                {
                }
                if (_loc_6.useCapture == param5)
                {
                }
                if (_loc_6.eventClass == param4)
                {
                    param1.removeEventListener(param2, _loc_6.callback, param5);
                    this.listeners.splice(_loc_7, 1);
                    return;
                }
            }
            return;
        }// end function

        public function unmapListeners() : void
        {
            var _loc_1:Object = null;
            var _loc_2:IEventDispatcher = null;
            do
            {
                
                _loc_2 = _loc_1.dispatcher;
                _loc_2.removeEventListener(_loc_1.type, _loc_1.callback, _loc_1.useCapture);
                var _loc_3:* = this.listeners.pop();
                _loc_1 = this.listeners.pop();
            }while (_loc_3)
            return;
        }// end function

        protected function routeEventToListener(event:Event, param2:Function, param3:Class) : void
        {
            if (event is param3)
            {
                this.param2(event);
            }
            return;
        }// end function

    }
}
