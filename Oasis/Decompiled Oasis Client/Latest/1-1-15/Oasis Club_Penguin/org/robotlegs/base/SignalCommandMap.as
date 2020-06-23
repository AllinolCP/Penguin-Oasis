package org.robotlegs.base
{
    import flash.utils.*;
    import org.osflash.signals.*;
    import org.robotlegs.core.*;

    public class SignalCommandMap extends Object implements ISignalCommandMap
    {
        protected var injector:IInjector;
        protected var signalMap:Dictionary;
        protected var signalClassMap:Dictionary;
        protected var verifiedCommandClasses:Dictionary;

        public function SignalCommandMap(param1:IInjector)
        {
            this.injector = param1;
            this.signalMap = new Dictionary(false);
            this.signalClassMap = new Dictionary(false);
            this.verifiedCommandClasses = new Dictionary(false);
            return;
        }// end function

        public function mapSignal(param1:ISignal, param2:Class, param3:Boolean = false) : void
        {
            var signal:* = param1;
            var commandClass:* = param2;
            var oneShot:* = param3;
            this.verifyCommandClass(commandClass);
            if (this.hasSignalCommand(signal, commandClass))
            {
                return;
            }
            if (!this.signalMap[signal])
            {
            }
            var _loc_5:* = new Dictionary(false);
            this.signalMap[signal] = new Dictionary(false);
            var signalCommandMap:* = _loc_5;
            var callback:* = function (param1 = null, param2 = null, param3 = null, param4 = null, param5 = null, param6 = null, param7 = null) : void
            {
                routeSignalToCommand(signal, arguments, commandClass, oneShot);
                return;
            }// end function
            ;
            signalCommandMap[commandClass] = callback;
            signal.add(callback);
            return;
        }// end function

        public function mapSignalClass(param1:Class, param2:Class, param3:Boolean = false) : ISignal
        {
            var _loc_4:* = this.getSignalClassInstance(param1);
            this.mapSignal(_loc_4, param2, param3);
            return _loc_4;
        }// end function

        private function getSignalClassInstance(param1:Class) : ISignal
        {
            if (!ISignal(this.signalClassMap[param1]))
            {
                ISignal(this.signalClassMap[param1]);
            }
            return this.createSignalClassInstance(param1);
        }// end function

        private function createSignalClassInstance(param1:Class) : ISignal
        {
            var _loc_3:ISignal = null;
            var _loc_2:* = this.injector;
            if (this.injector.hasMapping(IInjector))
            {
                _loc_2 = this.injector.getInstance(IInjector);
            }
            _loc_3 = _loc_2.instantiate(param1);
            _loc_2.mapValue(param1, _loc_3);
            this.signalClassMap[param1] = _loc_3;
            return _loc_3;
        }// end function

        public function hasSignalCommand(param1:ISignal, param2:Class) : Boolean
        {
            var _loc_3:* = this.signalMap[param1];
            if (_loc_3 == null)
            {
                return false;
            }
            var _loc_4:* = _loc_3[param2];
            return _loc_4 != null;
        }// end function

        public function unmapSignal(param1:ISignal, param2:Class) : void
        {
            var _loc_3:* = this.signalMap[param1];
            if (_loc_3 == null)
            {
                return;
            }
            var _loc_4:* = _loc_3[param2];
            if (_loc_4 == null)
            {
                return;
            }
            param1.remove(_loc_4);
            delete _loc_3[param2];
            return;
        }// end function

        public function unmapSignalClass(param1:Class, param2:Class) : void
        {
            this.unmapSignal(this.getSignalClassInstance(param1), param2);
            return;
        }// end function

        protected function routeSignalToCommand(param1:ISignal, param2:Array, param3:Class, param4:Boolean) : void
        {
            this.createCommandInstance(param1.valueClasses, param2, param3).execute();
            if (param4)
            {
                this.unmapSignal(param1, param3);
            }
            return;
        }// end function

        protected function createCommandInstance(param1:Array, param2:Array, param3:Class) : Object
        {
            var _loc_4:uint = 0;
            while (_loc_4 < param1.length)
            {
                
                this.injector.mapValue(param1[_loc_4], param2[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            return this.injector.instantiate(param3);
        }// end function

        protected function verifyCommandClass(param1:Class) : void
        {
            var commandClass:* = param1;
            if (this.verifiedCommandClasses[commandClass])
            {
                return;
            }
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
            if (_loc_3.length() != 1)
            {
                throw new ContextError(ContextError.E_COMMANDMAP_NOIMPL + " - " + commandClass);
            }
            this.verifiedCommandClasses[commandClass] = true;
            return;
        }// end function

    }
}
