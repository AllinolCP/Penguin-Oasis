package org.robotlegs.base
{
    import flash.events.*;
    import flash.utils.*;
    import org.robotlegs.core.*;

    public class CommandMap extends Object implements ICommandMap
    {
        protected var eventDispatcher:IEventDispatcher;
        protected var injector:IInjector;
        protected var reflector:IReflector;
        protected var eventTypeMap:Dictionary;
        protected var verifiedCommandClasses:Dictionary;
        protected var detainedCommands:Dictionary;

        public function CommandMap(param1:IEventDispatcher, param2:IInjector, param3:IReflector)
        {
            this.eventDispatcher = param1;
            this.injector = param2;
            this.reflector = param3;
            this.eventTypeMap = new Dictionary(false);
            this.verifiedCommandClasses = new Dictionary(false);
            this.detainedCommands = new Dictionary(false);
            return;
        }// end function

        public function mapEvent(param1:String, param2:Class, param3:Class = null, param4:Boolean = false) : void
        {
            var eventType:* = param1;
            var commandClass:* = param2;
            var eventClass:* = param3;
            var oneshot:* = param4;
            this.verifyCommandClass(commandClass);
            if (!eventClass)
            {
            }
            eventClass = Event;
            if (!this.eventTypeMap[eventType])
            {
                var _loc_6:* = new Dictionary(false);
                this.eventTypeMap[eventType] = new Dictionary(false);
            }
            var eventClassMap:* = _loc_6;
            if (!eventClassMap[eventClass])
            {
                var _loc_6:* = new Dictionary(false);
                eventClassMap[eventClass] = new Dictionary(false);
            }
            var callbacksByCommandClass:* = _loc_6;
            if (callbacksByCommandClass[commandClass] != null)
            {
                throw new ContextError(ContextError.E_COMMANDMAP_OVR + " - eventType (" + eventType + ") and Command (" + commandClass + ")");
            }
            var callback:* = function (event:Event) : void
            {
                routeEventToCommand(event, commandClass, oneshot, eventClass);
                return;
            }// end function
            ;
            this.eventDispatcher.addEventListener(eventType, callback, false, 0, true);
            callbacksByCommandClass[commandClass] = callback;
            return;
        }// end function

        public function unmapEvent(param1:String, param2:Class, param3:Class = null) : void
        {
            var _loc_4:* = this.eventTypeMap[param1];
            if (_loc_4 == null)
            {
                return;
            }
            if (!param3)
            {
            }
            var _loc_5:* = _loc_4[Event];
            if (_loc_5 == null)
            {
                return;
            }
            var _loc_6:* = _loc_5[param2];
            if (_loc_6 == null)
            {
                return;
            }
            this.eventDispatcher.removeEventListener(param1, _loc_6, false);
            delete _loc_5[param2];
            return;
        }// end function

        public function unmapEvents() : void
        {
            var _loc_1:String = null;
            var _loc_2:Dictionary = null;
            var _loc_3:Dictionary = null;
            var _loc_4:Function = null;
            for (_loc_1 in this.eventTypeMap)
            {
                
                _loc_2 = this.eventTypeMap[_loc_1];
                for each (_loc_3 in _loc_2)
                {
                    
                    for each (_loc_4 in _loc_3)
                    {
                        
                        this.eventDispatcher.removeEventListener(_loc_1, _loc_4, false);
                    }
                }
            }
            this.eventTypeMap = new Dictionary(false);
            return;
        }// end function

        public function hasEventCommand(param1:String, param2:Class, param3:Class = null) : Boolean
        {
            var _loc_4:* = this.eventTypeMap[param1];
            if (_loc_4 == null)
            {
                return false;
            }
            if (!param3)
            {
            }
            var _loc_5:* = _loc_4[Event];
            if (_loc_5 == null)
            {
                return false;
            }
            return _loc_5[param2] != null;
        }// end function

        public function execute(param1:Class, param2:Object = null, param3:Class = null, param4:String = "") : void
        {
            this.verifyCommandClass(param1);
            if (param2 == null)
            {
            }
            if (param3 != null)
            {
                if (!param3)
                {
                }
                param3 = this.reflector.getClass(param2);
                this.injector.mapValue(param3, param2, param4);
            }
            var _loc_5:* = this.injector.instantiate(param1);
            if (param2 === null)
            {
            }
            if (param3 != null)
            {
                this.injector.unmap(param3, param4);
            }
            _loc_5.execute();
            return;
        }// end function

        public function detain(param1:Object) : void
        {
            this.detainedCommands[param1] = true;
            return;
        }// end function

        public function release(param1:Object) : void
        {
            if (this.detainedCommands[param1])
            {
                delete this.detainedCommands[param1];
            }
            return;
        }// end function

        protected function verifyCommandClass(param1:Class) : void
        {
            var commandClass:* = param1;
            if (!this.verifiedCommandClasses[commandClass])
            {
                var _loc_4:int = 0;
                var _loc_5:* = describeType(commandClass).factory.method;
                var _loc_3:* = new XMLList("");
                for each (_loc_6 in _loc_5)
                {
                    
                    var _loc_7:* = _loc_6;
                    with (_loc_6)
                    {
                        if (@name == "execute")
                        {
                            _loc_3[_loc_4] = _loc_6;
                        }
                    }
                }
                this.verifiedCommandClasses[commandClass] = _loc_3.length();
                if (!this.verifiedCommandClasses[commandClass])
                {
                    throw new ContextError(ContextError.E_COMMANDMAP_NOIMPL + " - " + commandClass);
                }
            }
            return;
        }// end function

        protected function routeEventToCommand(event:Event, param2:Class, param3:Boolean, param4:Class) : Boolean
        {
            if (!(event is param4))
            {
                return false;
            }
            this.execute(param2, event);
            if (param3)
            {
                this.unmapEvent(event.type, param2, param4);
            }
            return true;
        }// end function

    }
}
