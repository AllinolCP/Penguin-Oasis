package org.swiftsuspenders.injectionpoints
{
    import flash.utils.*;
    import org.swiftsuspenders.*;

    public class MethodInjectionPoint extends InjectionPoint
    {
        protected var methodName:String;
        protected var m_injectionConfigs:Array;
        protected var requiredParameters:int = 0;

        public function MethodInjectionPoint(param1:XML, param2:Injector)
        {
            super(param1, param2);
            return;
        }// end function

        override public function applyInjection(param1:Object, param2:Injector) : Object
        {
            var _loc_3:* = this.gatherParameterValues(param1, param2);
            var _loc_4:* = param1[this.methodName];
            _loc_4.apply(param1, _loc_3);
            return param1;
        }// end function

        override protected function initializeInjection(param1:XML, param2:Injector) : void
        {
            var nameArgs:XMLList;
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
                    if (@key == "name")
                    {
                        _loc_4[_loc_5] = _loc_7;
                    }
                }
            }
            nameArgs = _loc_4;
            methodNode = node.parent();
            this.methodName = methodNode.@name.toString();
            this.gatherParameters(methodNode, nameArgs, injector);
            return;
        }// end function

        protected function gatherParameters(param1:XML, param2:XMLList, param3:Injector) : void
        {
            var _loc_5:XML = null;
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_8:Class = null;
            this.m_injectionConfigs = [];
            var _loc_4:int = 0;
            for each (_loc_5 in param1.parameter)
            {
                
                _loc_6 = "";
                if (param2[_loc_4])
                {
                    _loc_6 = param2[_loc_4].@value.toString();
                }
                _loc_7 = _loc_5.@type.toString();
                if (_loc_7 == "*")
                {
                    if (_loc_5.@optional.toString() == "false")
                    {
                        throw new Error("Error in method definition of injectee. Required " + "parameters can\'t have type \"*\".");
                    }
                    _loc_7 = null;
                }
                else
                {
                    _loc_8 = Class(param3.getApplicationDomain().getDefinition(_loc_7));
                }
                this.m_injectionConfigs.push(param3.getMapping(_loc_8, _loc_6));
                if (_loc_5.@optional.toString() == "false")
                {
                    var _loc_11:String = this;
                    var _loc_12:* = this.requiredParameters + 1;
                    _loc_11.requiredParameters = _loc_12;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        protected function gatherParameterValues(param1:Object, param2:Injector) : Array
        {
            var _loc_6:InjectionConfig = null;
            var _loc_7:Object = null;
            var _loc_3:Array = [];
            var _loc_4:* = this.m_injectionConfigs.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = this.m_injectionConfigs[_loc_5];
                _loc_7 = _loc_6.getResponse(param2);
                if (_loc_7 == null)
                {
                    if (_loc_5 >= this.requiredParameters)
                    {
                        break;
                    }
                    throw new InjectorError("Injector is missing a rule to handle injection into target " + param1 + ". Target dependency: " + getQualifiedClassName(_loc_6.request) + ", method: " + this.methodName + ", parameter: " + (_loc_5 + 1));
                }
                _loc_3[_loc_5] = _loc_7;
                _loc_5 = _loc_5 + 1;
            }
            return _loc_3;
        }// end function

    }
}
