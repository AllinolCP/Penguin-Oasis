package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.*;

    public class InjectionPoint extends Object
    {

        public function InjectionPoint(param1:XML, param2:Injector)
        {
            this.initializeInjection(param1, param2);
            return;
        }// end function

        public function applyInjection(param1:Object, param2:Injector) : Object
        {
            return param1;
        }// end function

        protected function initializeInjection(param1:XML, param2:Injector) : void
        {
            return;
        }// end function

    }
}
