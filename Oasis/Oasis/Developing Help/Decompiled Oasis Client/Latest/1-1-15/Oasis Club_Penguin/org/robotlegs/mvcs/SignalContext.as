package org.robotlegs.mvcs
{
    import flash.display.*;
    import org.robotlegs.base.*;
    import org.robotlegs.core.*;

    public class SignalContext extends Context implements ISignalContext
    {
        protected var _signalCommandMap:ISignalCommandMap;

        public function SignalContext(param1:DisplayObjectContainer = null, param2:Boolean = true)
        {
            super(param1, param2);
            return;
        }// end function

        public function get signalCommandMap() : ISignalCommandMap
        {
            if (!this._signalCommandMap)
            {
                var _loc_1:* = new SignalCommandMap(injector.createChild());
                this._signalCommandMap = new SignalCommandMap(injector.createChild());
            }
            return _loc_1;
        }// end function

        public function set signalCommandMap(param1:ISignalCommandMap) : void
        {
            this._signalCommandMap = param1;
            return;
        }// end function

        override protected function mapInjections() : void
        {
            super.mapInjections();
            injector.mapValue(ISignalCommandMap, this.signalCommandMap);
            return;
        }// end function

    }
}
