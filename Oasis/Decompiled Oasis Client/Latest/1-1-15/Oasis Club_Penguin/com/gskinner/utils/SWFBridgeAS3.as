package com.gskinner.utils
{
    import flash.events.*;
    import flash.net.*;

    public class SWFBridgeAS3 extends EventDispatcher
    {
        private var myID:String;
        private var host:Boolean = true;
        private var _connected:Boolean = false;
        private var baseID:String;
        private var clientObj:Object;
        private var lc:LocalConnection;
        private var extID:String;

        public function SWFBridgeAS3(param1:String, param2:Object)
        {
            var p_id:* = param1;
            var p_clientObj:* = param2;
            baseID = p_id.split(":").join("");
            lc = new LocalConnection();
            lc.client = this;
            clientObj = p_clientObj;
            try
            {
                lc.connect(baseID + "_host");
            }
            catch (e:ArgumentError)
            {
                host = false;
            }
            myID = baseID + (host ? ("_host") : ("_guest"));
            extID = baseID + (host ? ("_guest") : ("_host"));
            if (!host)
            {
                lc.connect(myID);
                lc.send(extID, "com_gskinner_utils_SWFBridge_init");
            }
            return;
        }// end function

        public function com_gskinner_utils_SWFBridge_init() : void
        {
            if (host)
            {
                lc.send(extID, "com_gskinner_utils_SWFBridge_init");
            }
            _connected = true;
            dispatchEvent(new Event(Event.CONNECT));
            return;
        }// end function

        public function close() : void
        {
            try
            {
                lc.close();
            }
            catch (e)
            {
            }
            lc = null;
            clientObj = null;
            if (!_connected)
            {
                throw new ArgumentError("Close failed because the object is not connected.");
            }
            _connected = false;
            return;
        }// end function

        public function get connected() : Boolean
        {
            return _connected;
        }// end function

        public function send(param1:String, ... args) : void
        {
            if (!_connected)
            {
                throw new ArgumentError("Send failed because the object is not connected.");
            }
            args.unshift(param1);
            args.unshift("com_gskinner_utils_SWFBridge_receive");
            args.unshift(extID);
            lc.send.apply(lc, args);
            return;
        }// end function

        public function get id() : String
        {
            return baseID;
        }// end function

        public function com_gskinner_utils_SWFBridge_receive(param1:String, ... args) : void
        {
            clientObj[param1].apply(clientObj, args);
            return;
        }// end function

    }
}
