package com.asual.swfaddress
{
    import flash.events.*;

    public class SWFAddressEvent extends Event
    {
        private var _pathNames:Array;
        private var _parameters:Object;
        private var _path:String;
        private var _value:String;
        private var _parameterNames:Array;
        public static const INIT:String = "init";
        public static const INTERNAL_CHANGE:String = "internalChange";
        public static const EXTERNAL_CHANGE:String = "externalChange";
        public static const CHANGE:String = "change";

        public function SWFAddressEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        public function get parameters() : Object
        {
            var _loc_1:int = 0;
            if (this._parameters == null)
            {
                this._parameters = new Object();
                _loc_1 = 0;
                while (_loc_1 < this.parameterNames.length)
                {
                    
                    this._parameters[this.parameterNames[_loc_1]] = SWFAddress.getParameter(this.parameterNames[_loc_1]);
                    _loc_1 = _loc_1 + 1;
                }
            }
            return this._parameters;
        }// end function

        public function get path() : String
        {
            if (this._path == null)
            {
                this._path = SWFAddress.getPath();
            }
            return this._path;
        }// end function

        override public function get currentTarget() : Object
        {
            return SWFAddress;
        }// end function

        override public function toString() : String
        {
            return formatToString("SWFAddressEvent", "type", "bubbles", "cancelable", "eventPhase", "value", "path", "pathNames", "parameterNames", "parameters");
        }// end function

        override public function get target() : Object
        {
            return SWFAddress;
        }// end function

        public function get value() : String
        {
            if (this._value == null)
            {
                this._value = SWFAddress.getValue();
            }
            return this._value;
        }// end function

        override public function get type() : String
        {
            return super.type;
        }// end function

        public function get pathNames() : Array
        {
            if (this._pathNames == null)
            {
                this._pathNames = SWFAddress.getPathNames();
            }
            return this._pathNames;
        }// end function

        override public function clone() : Event
        {
            return new SWFAddressEvent(this.type, bubbles, cancelable);
        }// end function

        public function get parameterNames() : Array
        {
            if (this._parameterNames == null)
            {
                this._parameterNames = SWFAddress.getParameterNames();
            }
            return this._parameterNames;
        }// end function

    }
}
