﻿class com.clubpenguin.util.EventDispatcher implements com.clubpenguin.util.IEventDispatcher
{
    function EventDispatcher()
    {
    } // End of the function
    function addEventListener(eventType, handler, scope)
    {
        eventType.length;
        handler instanceof Function;
        var _loc2 = com.clubpenguin.util.EventDispatcher.getListenersArray(this, eventType);
        var _loc3 = com.clubpenguin.util.EventDispatcher.getListenerIndex(_loc2, handler, scope);
        if (_loc3 == -1)
        {
            _loc2.push({handler: handler, scope: scope});
            return (true);
        } // end if
        return (false);
    } // End of the function
    function removeEventListener(eventType, handler, scope)
    {
        eventType.length;
        handler instanceof Function;
        var _loc3 = com.clubpenguin.util.EventDispatcher.getListenersArray(this, eventType);
        var _loc2 = com.clubpenguin.util.EventDispatcher.getListenerIndex(_loc3, handler, scope);
        if (_loc2 != -1)
        {
            _loc3.splice(_loc2, 1);
            return (true);
        } // end if
        return (false);
    } // End of the function
    function updateListeners(eventType, event)
    {
        if (event == undefined)
        {
            event = {};
        } // end if
        event.type = eventType;
        return (this.dispatchEvent(event));
    } // End of the function
    function dispatchEvent(event)
    {
        event.type.length;
        if (event.target == undefined)
        {
            event.target = this;
        } // end if
        var _loc3 = com.clubpenguin.util.EventDispatcher.getListenersArray(this, event.type).concat();
        var _loc5 = _loc3.length;
        if (_loc5 < 1)
        {
            return (false);
        } // end if
        for (var _loc2 = 0; _loc2 < _loc5; ++_loc2)
        {
            _loc3[_loc2].scope ? (_loc3[_loc2].handler.call(_loc3[_loc2].scope, event)) : (_loc3[_loc2].handler(event));
        } // end of for
        return (true);
    } // End of the function
    static function getListenerIndex(listeners, handler, scope)
    {
        var _loc4 = listeners.length;
        for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
        {
            if (listeners[_loc1].handler == handler && (scope == undefined || listeners[_loc1].scope == scope))
            {
                return (_loc1);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    static function getListenersArray(eventSource, eventType)
    {
        if (!eventSource.__listener_obj)
        {
            eventSource.__listener_obj = {};
        } // end if
        if (!eventSource.__listener_obj[eventType])
        {
            eventSource.__listener_obj[eventType] = [];
        } // end if
        return (eventSource.__listener_obj[eventType]);
    } // End of the function
    static function initialize(eventSource)
    {
        eventSource.addEventListener = com.clubpenguin.util.EventDispatcher.prototype.addEventListener;
        eventSource.removeEventListener = com.clubpenguin.util.EventDispatcher.prototype.removeEventListener;
        eventSource.addListener = com.clubpenguin.util.EventDispatcher.prototype.addEventListener;
        eventSource.removeListener = com.clubpenguin.util.EventDispatcher.prototype.removeEventListener;
        eventSource.dispatchEvent = com.clubpenguin.util.EventDispatcher.prototype.dispatchEvent;
        eventSource.updateListeners = com.clubpenguin.util.EventDispatcher.prototype.updateListeners;
    } // End of the function
} // End of Class
