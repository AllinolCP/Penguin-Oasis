package com.clubpenguin.lib.module
{
    import flash.display.*;
    import org.osflash.signals.*;

    public class BaseModule extends Sprite
    {
        protected var appContext:IModuleAppContext;

        public function BaseModule()
        {
            return;
        }// end function

        public function init() : void
        {
            return;
        }// end function

        public function setDependencies(param1:IModuleAppContext = null, param2:Object = null) : void
        {
            return;
        }// end function

        public function close() : void
        {
            var _loc_1:IModuleAppSignalBus = null;
            if (appContext)
            {
                _loc_1 = appContext.getSignalBus();
                Signal(_loc_1.getCloseView()).dispatch(this);
                ;
            }
            return;
        }// end function

    }
}
