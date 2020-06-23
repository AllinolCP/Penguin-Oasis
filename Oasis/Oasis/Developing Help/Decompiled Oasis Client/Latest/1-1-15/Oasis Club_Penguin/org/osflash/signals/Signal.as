package org.osflash.signals
{
    import flash.errors.*;
    import flash.utils.*;

    public class Signal extends Object implements ISignal, IDispatcher
    {
        protected var listenersNeedCloning:Boolean = false;
        protected var onceListeners:Dictionary;
        protected var _valueClasses:Array;
        protected var listeners:Array;

        public function Signal(... args)
        {
            listeners = [];
            onceListeners = new Dictionary();
            if (args.length == 1)
            {
            }
            if (args[0] is Array)
            {
                args = args[0];
            }
            setValueClasses(args);
            return;
        }// end function

        public function add(param1:Function) : Function
        {
            registerListener(param1);
            return param1;
        }// end function

        public function addOnce(param1:Function) : Function
        {
            registerListener(param1, true);
            return param1;
        }// end function

        public function remove(param1:Function) : Function
        {
            var _loc_2:* = listeners.indexOf(param1);
            if (_loc_2 == -1)
            {
                return param1;
            }
            if (listenersNeedCloning)
            {
                listeners = listeners.slice();
                listenersNeedCloning = false;
            }
            listeners.splice(_loc_2, 1);
            delete onceListeners[param1];
            return param1;
        }// end function

        protected function registerListener(param1:Function, param2:Boolean = false) : void
        {
            var _loc_3:String = null;
            if (param1.length < _valueClasses.length)
            {
                _loc_3 = param1.length == 1 ? ("argument") : ("arguments");
                throw new ArgumentError("Listener has " + param1.length + " " + _loc_3 + " but it needs at least " + _valueClasses.length + " to match the given value classes.");
            }
            if (!listeners.length)
            {
                listeners[0] = param1;
                if (param2)
                {
                    onceListeners[param1] = true;
                }
                return;
            }
            if (listeners.indexOf(param1) >= 0)
            {
                if (onceListeners[param1])
                {
                }
                if (!param2)
                {
                    throw new IllegalOperationError("You cannot addOnce() then add() the same listener without removing the relationship first.");
                }
                if (!onceListeners[param1])
                {
                }
                if (param2)
                {
                    throw new IllegalOperationError("You cannot add() then addOnce() the same listener without removing the relationship first.");
                }
                return;
            }
            if (listenersNeedCloning)
            {
                listeners = listeners.slice();
                listenersNeedCloning = false;
            }
            listeners[listeners.length] = param1;
            if (param2)
            {
                onceListeners[param1] = true;
            }
            return;
        }// end function

        protected function setValueClasses(param1:Array) : void
        {
            if (!param1)
            {
            }
            _valueClasses = [];
            var _loc_2:* = _valueClasses.length;
            while (_loc_2--)
            {
                
                if (!(_valueClasses[_loc_2] is Class))
                {
                    throw new ArgumentError("Invalid valueClasses argument: item at index " + _loc_2 + " should be a Class but was:<" + _valueClasses[_loc_2] + ">.");
                }
            }
            return;
        }// end function

        public function get numListeners() : uint
        {
            return listeners.length;
        }// end function

        public function dispatch(... args) : void
        {
            args = null;
            var _loc_3:Class = null;
            var _loc_6:Function = null;
            var _loc_4:* = _valueClasses.length;
            if (args.length < _loc_4)
            {
                throw new ArgumentError("Incorrect number of arguments. Expected at least " + _loc_4 + " but received " + args.length + ".");
            }
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                var _loc_7:* = args[_loc_5];
                args = args[_loc_5];
                if (_loc_7 !== null)
                {
                    var _loc_7:* = _valueClasses[_loc_5];
                    _loc_3 = _valueClasses[_loc_5];
                }
                if (args is _loc_7)
                {
                }
                else
                {
                    throw new ArgumentError("Value object <" + args + "> is not an instance of <" + _loc_3 + ">.");
                }
                _loc_5 = _loc_5 + 1;
            }
            if (!listeners.length)
            {
                return;
            }
            listenersNeedCloning = true;
            switch(args.length)
            {
                case 0:
                {
                    for each (_loc_6 in listeners)
                    {
                        
                        if (onceListeners[_loc_6])
                        {
                            remove(_loc_6);
                        }
                        this._loc_6();
                    }
                    break;
                }
                case 1:
                {
                    for each (_loc_6 in listeners)
                    {
                        
                        if (onceListeners[_loc_6])
                        {
                            remove(_loc_6);
                        }
                        this._loc_6(args[0]);
                    }
                    break;
                }
                default:
                {
                    for each (_loc_6 in listeners)
                    {
                        
                        if (onceListeners[_loc_6])
                        {
                            remove(_loc_6);
                        }
                        _loc_6.apply(null, args);
                    }
                    break;
                }
            }
            listenersNeedCloning = false;
            return;
        }// end function

        public function get valueClasses() : Array
        {
            return _valueClasses;
        }// end function

        public function removeAll() : void
        {
            var _loc_1:* = listeners.length;
            while (_loc_1--)
            {
                
                remove(listeners[_loc_1] as Function);
            }
            return;
        }// end function

    }
}
