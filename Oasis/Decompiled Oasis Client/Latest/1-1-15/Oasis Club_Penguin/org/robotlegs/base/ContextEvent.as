package org.robotlegs.base
{
    import flash.events.*;

    public class ContextEvent extends Event
    {
        protected var _body:Object;
        public static const STARTUP:String = "startup";
        public static const STARTUP_COMPLETE:String = "startupComplete";
        public static const SHUTDOWN:String = "shutdown";
        public static const SHUTDOWN_COMPLETE:String = "shutdownComplete";

        public function ContextEvent(param1:String, param2 = null)
        {
            super(param1);
            this._body = param2;
            return;
        }// end function

        public function get body()
        {
            return this._body;
        }// end function

        override public function clone() : Event
        {
            return new ContextEvent(type, this.body);
        }// end function

    }
}
