package com.asual.swfaddress
{
    import flash.errors.*;
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class SWFAddress extends Object
    {
        public static var onInit:Function;
        private static var _queue:Array = new Array();
        private static var _initTimer:Timer = new Timer(10);
        private static var _initializer:Boolean = _initialize();
        private static var _availability:Boolean = ExternalInterface.available;
        private static var _initChanged:Boolean = false;
        private static var _dispatcher:EventDispatcher = new EventDispatcher();
        private static var _queueTimer:Timer = new Timer(10);
        private static var _strict:Boolean = true;
        private static var _init:Boolean = false;
        private static var _value:String = "";
        public static var onChange:Function;
        private static var _initChange:Boolean = false;

        public function SWFAddress()
        {
            throw new IllegalOperationError("SWFAddress cannot be instantiated.");
        }// end function

        private static function _strictCheck(param1:String, param2:Boolean) : String
        {
            if (SWFAddress.getStrict())
            {
                if (param2)
                {
                    if (param1.substr(0, 1) != "/")
                    {
                        param1 = "/" + param1;
                    }
                }
                else if (param1 == "")
                {
                    param1 = "/";
                }
            }
            return param1;
        }// end function

        public static function getTracker() : String
        {
            return _availability ? (ExternalInterface.call("SWFAddress.getTracker") as String) : ("");
        }// end function

        public static function setStatus(param1:String) : void
        {
            _call("SWFAddress.setStatus", encodeURI(decodeURI(param1)));
            return;
        }// end function

        private static function _check(event:TimerEvent) : void
        {
            if (typeof(SWFAddress["onInit"]) != "function")
            {
            }
            if (_dispatcher.hasEventListener(SWFAddressEvent.INIT))
            {
                _dispatcher.hasEventListener(SWFAddressEvent.INIT);
            }
            if (!_init)
            {
                SWFAddress._setValueInit(_getValue());
                SWFAddress._init = true;
            }
            if (typeof(SWFAddress["onChange"]) != "function")
            {
            }
            if (!_dispatcher.hasEventListener(SWFAddressEvent.CHANGE))
            {
                _dispatcher.hasEventListener(SWFAddressEvent.CHANGE);
            }
            if (typeof(SWFAddress["onExternalChange"]) != "function")
            {
            }
            if (_dispatcher.hasEventListener(SWFAddressEvent.EXTERNAL_CHANGE))
            {
                _initTimer.stop();
                SWFAddress._init = true;
                SWFAddress._setValueInit(_getValue());
            }
            return;
        }// end function

        private static function _setValue(param1:String) : void
        {
            if (param1 != "undefined")
            {
            }
            if (param1 == null)
            {
                param1 = "";
            }
            if (SWFAddress._value == param1)
            {
            }
            if (SWFAddress._init)
            {
                return;
            }
            if (!SWFAddress._initChange)
            {
                return;
            }
            SWFAddress._value = param1;
            if (!_init)
            {
                SWFAddress._init = true;
                if (typeof(SWFAddress["onInit"]) != "function")
                {
                }
                if (_dispatcher.hasEventListener(SWFAddressEvent.INIT))
                {
                    _dispatchEvent(SWFAddressEvent.INIT);
                }
            }
            _dispatchEvent(SWFAddressEvent.CHANGE);
            _dispatchEvent(SWFAddressEvent.EXTERNAL_CHANGE);
            return;
        }// end function

        public static function getStatus() : String
        {
            var _loc_1:* = _availability ? (ExternalInterface.call("SWFAddress.getStatus") as String) : ("");
            if (_loc_1 != "undefined")
            {
            }
            if (_loc_1 == null)
            {
                _loc_1 = "";
            }
            return decodeURI(_loc_1);
        }// end function

        private static function _getValue() : String
        {
            var _loc_1:String = null;
            var _loc_3:Array = null;
            var _loc_2:String = null;
            if (_availability)
            {
                _loc_1 = ExternalInterface.call("SWFAddress.getValue") as String;
                _loc_3 = ExternalInterface.call("SWFAddress.getIds") as Array;
                if (_loc_3 != null)
                {
                    _loc_2 = _loc_3.toString();
                }
            }
            if (_loc_2 != null)
            {
            }
            if (_availability)
            {
            }
            if (_initChanged)
            {
                _loc_1 = SWFAddress._value;
            }
            else
            {
                if (_loc_1 != "undefined")
                {
                }
                if (_loc_1 == null)
                {
                    _loc_1 = "";
                }
            }
            if (!_loc_1)
            {
            }
            return _strictCheck("", false);
        }// end function

        public static function up() : void
        {
            var _loc_1:* = SWFAddress.getPath();
            SWFAddress.setValue(_loc_1.substr(0, _loc_1.lastIndexOf("/", _loc_1.length - 2) + (_loc_1.substr((_loc_1.length - 1)) == "/" ? (1) : (0))));
            return;
        }// end function

        public static function getParameterNames() : Array
        {
            var _loc_4:Array = null;
            var _loc_5:Number = NaN;
            var _loc_1:* = SWFAddress.getValue();
            var _loc_2:* = _loc_1.indexOf("?");
            var _loc_3:* = new Array();
            if (_loc_2 != -1)
            {
                _loc_1 = _loc_1.substr((_loc_2 + 1));
                if (_loc_1 != "")
                {
                }
                if (_loc_1.indexOf("=") != -1)
                {
                    _loc_4 = _loc_1.split("&");
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4.length)
                    {
                        
                        _loc_3.push(_loc_4[_loc_5].split("=")[0]);
                        _loc_5 = _loc_5 + 1;
                    }
                }
            }
            return _loc_3;
        }// end function

        public static function setTitle(param1:String) : void
        {
            _call("SWFAddress.setTitle", encodeURI(decodeURI(param1)));
            return;
        }// end function

        public static function resetStatus() : void
        {
            _call("SWFAddress.resetStatus");
            return;
        }// end function

        public static function getBaseURL() : String
        {
            var _loc_1:String = null;
            if (_availability)
            {
                _loc_1 = String(ExternalInterface.call("SWFAddress.getBaseURL"));
            }
            if (_loc_1 != null)
            {
            }
            if (_loc_1 != "null")
            {
            }
            return !_availability ? ("") : (_loc_1);
        }// end function

        public static function getTitle() : String
        {
            var _loc_1:* = _availability ? (ExternalInterface.call("SWFAddress.getTitle") as String) : ("");
            if (_loc_1 != "undefined")
            {
            }
            if (_loc_1 == null)
            {
                _loc_1 = "";
            }
            return decodeURI(_loc_1);
        }// end function

        public static function getPath() : String
        {
            var _loc_1:* = SWFAddress.getValue();
            if (_loc_1.indexOf("?") != -1)
            {
                return _loc_1.split("?")[0];
            }
            if (_loc_1.indexOf("#") != -1)
            {
                return _loc_1.split("#")[0];
            }
            return _loc_1;
        }// end function

        public static function href(param1:String, param2:String = "_self") : void
        {
            if (_availability)
            {
            }
            if (Capabilities.playerType == "ActiveX")
            {
                ExternalInterface.call("SWFAddress.href", param1, param2);
                return;
            }
            navigateToURL(new URLRequest(param1), param2);
            return;
        }// end function

        private static function _initialize() : Boolean
        {
            if (_availability)
            {
                try
                {
                    _availability = ExternalInterface.call("function() { return (typeof SWFAddress != \"undefined\"); }") as Boolean;
                    ExternalInterface.addCallback("getSWFAddressValue", function () : String
            {
                return _value;
            }// end function
            );
                    ExternalInterface.addCallback("setSWFAddressValue", _setValue);
                }
                catch (e:Error)
                {
                    _availability = false;
                }
            }
            _queueTimer.addEventListener(TimerEvent.TIMER, _callQueue);
            _initTimer.addEventListener(TimerEvent.TIMER, _check);
            _initTimer.start();
            return true;
        }// end function

        public static function popup(param1:String, param2:String = "popup", param3:String = "\"\"", param4:String = "") : void
        {
            if (_availability)
            {
                if (Capabilities.playerType != "ActiveX")
                {
                }
            }
            if (ExternalInterface.call("asual.util.Browser.isSafari"))
            {
                ExternalInterface.call("SWFAddress.popup", param1, param2, param3, param4);
                return;
            }
            navigateToURL(new URLRequest("javascript:popup=window.open(\"" + param1 + "\",\"" + param2 + "\"," + param3 + ");" + param4 + ";void(0);"), "_self");
            return;
        }// end function

        public static function setValue(param1:String) : void
        {
            if (param1 != "undefined")
            {
            }
            if (param1 == null)
            {
                param1 = "";
            }
            param1 = encodeURI(decodeURI(_strictCheck(param1, true)));
            if (SWFAddress._value == param1)
            {
                return;
            }
            SWFAddress._value = param1;
            _call("SWFAddress.setValue", param1);
            if (SWFAddress._init)
            {
                _dispatchEvent(SWFAddressEvent.CHANGE);
                _dispatchEvent(SWFAddressEvent.INTERNAL_CHANGE);
            }
            else
            {
                _initChanged = true;
            }
            return;
        }// end function

        public static function getValue() : String
        {
            if (!_value)
            {
            }
            return decodeURI(_strictCheck("", false));
        }// end function

        private static function _call(param1:String, param2:Object = "") : void
        {
            if (_availability)
            {
                if (Capabilities.os.indexOf("Mac") != -1)
                {
                    if (_queue.length == 0)
                    {
                        _queueTimer.start();
                    }
                    _queue.push({fn:param1, param:param2});
                }
                else
                {
                    ExternalInterface.call(param1, param2);
                }
            }
            return;
        }// end function

        private static function _setValueInit(param1:String) : void
        {
            SWFAddress._value = param1;
            if (!_init)
            {
                _dispatchEvent(SWFAddressEvent.INIT);
            }
            else
            {
                _dispatchEvent(SWFAddressEvent.CHANGE);
                _dispatchEvent(SWFAddressEvent.EXTERNAL_CHANGE);
            }
            _initChange = true;
            return;
        }// end function

        public static function getStrict() : Boolean
        {
            var _loc_1:String = null;
            if (_availability)
            {
                _loc_1 = ExternalInterface.call("SWFAddress.getStrict") as String;
            }
            return _loc_1 == null ? (_strict) : (_loc_1 == "true");
        }// end function

        public static function dispatchEvent(event:Event) : Boolean
        {
            return _dispatcher.dispatchEvent(event);
        }// end function

        private static function _dispatchEvent(param1:String) : void
        {
            if (_dispatcher.hasEventListener(param1))
            {
                _dispatcher.dispatchEvent(new SWFAddressEvent(param1));
            }
            param1 = param1.substr(0, 1).toUpperCase() + param1.substring(1);
            if (typeof(SWFAddress["on" + param1]) == "function")
            {
                var _loc_2:* = SWFAddress;
                _loc_2.SWFAddress["on" + param1]();
            }
            return;
        }// end function

        public static function getQueryString() : String
        {
            var _loc_1:* = SWFAddress.getValue();
            var _loc_2:* = _loc_1.indexOf("?");
            if (_loc_2 != -1)
            {
            }
            if (_loc_2 < _loc_1.length)
            {
                return _loc_1.substr((_loc_2 + 1));
            }
            return null;
        }// end function

        public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _dispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public static function setStrict(param1:Boolean) : void
        {
            _call("SWFAddress.setStrict", param1);
            _strict = param1;
            return;
        }// end function

        public static function forward() : void
        {
            _call("SWFAddress.forward");
            return;
        }// end function

        public static function setHistory(param1:Boolean) : void
        {
            _call("SWFAddress.setHistory", param1);
            return;
        }// end function

        private static function _callQueue(event:TimerEvent) : void
        {
            var _loc_2:String = null;
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            if (_queue.length != 0)
            {
                _loc_2 = "";
                _loc_3 = 0;
                do
                {
                    
                    if (_loc_4.param is String)
                    {
                        _loc_4.param = "\"" + _loc_4.param + "\"";
                    }
                    _loc_2 = _loc_2 + (_loc_4.fn + "(" + _loc_4.param + ");");
                    _loc_3 = _loc_3 + 1;
                    var _loc_5:* = _queue[_loc_3];
                    _loc_4 = _queue[_loc_3];
                }while (_loc_5)
                _queue = new Array();
                navigateToURL(new URLRequest("javascript:" + _loc_2 + "void(0);"), "_self");
            }
            else
            {
                _queueTimer.stop();
            }
            return;
        }// end function

        public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _dispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public static function back() : void
        {
            _call("SWFAddress.back");
            return;
        }// end function

        public static function getHistory() : Boolean
        {
            return _availability ? (ExternalInterface.call("SWFAddress.getHistory") as Boolean) : (false);
        }// end function

        public static function getParameter(param1:String) : Object
        {
            var _loc_4:Array = null;
            var _loc_5:Array = null;
            var _loc_6:Number = NaN;
            var _loc_7:Array = null;
            var _loc_2:* = SWFAddress.getValue();
            var _loc_3:* = _loc_2.indexOf("?");
            if (_loc_3 != -1)
            {
                _loc_2 = _loc_2.substr((_loc_3 + 1));
                _loc_4 = _loc_2.split("&");
                _loc_6 = _loc_4.length;
                _loc_7 = new Array();
                while (_loc_6--)
                {
                    
                    _loc_5 = _loc_4[_loc_6].split("=");
                    if (_loc_5[0] == param1)
                    {
                        _loc_7.push(_loc_5[1]);
                    }
                }
                if (_loc_7.length != 0)
                {
                    return _loc_7.length != 1 ? (_loc_7) : (_loc_7[0]);
                }
            }
            return null;
        }// end function

        public static function go(param1:int) : void
        {
            _call("SWFAddress.go", param1);
            return;
        }// end function

        public static function hasEventListener(param1:String) : Boolean
        {
            return _dispatcher.hasEventListener(param1);
        }// end function

        public static function getPathNames() : Array
        {
            var _loc_1:* = SWFAddress.getPath();
            var _loc_2:* = _loc_1.split("/");
            if (_loc_1.substr(0, 1) != "/")
            {
            }
            if (_loc_1.length == 0)
            {
                _loc_2.splice(0, 1);
            }
            if (_loc_1.substr((_loc_1.length - 1), 1) == "/")
            {
                _loc_2.splice((_loc_2.length - 1), 1);
            }
            return _loc_2;
        }// end function

        public static function setTracker(param1:String) : void
        {
            _call("SWFAddress.setTracker", param1);
            return;
        }// end function

    }
}
