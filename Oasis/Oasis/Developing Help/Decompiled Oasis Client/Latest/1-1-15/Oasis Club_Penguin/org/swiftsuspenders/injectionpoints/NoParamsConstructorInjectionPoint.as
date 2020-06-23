package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.*;

    public class NoParamsConstructorInjectionPoint extends InjectionPoint
    {

        public function NoParamsConstructorInjectionPoint()
        {
            super(null, null);
            return;
        }// end function

        override public function applyInjection(param1:Object, param2:Injector) : Object
        {
            return new param1;
        }// end function

    }
}
