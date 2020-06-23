package org.swiftsuspenders.injectionresults
{
    import org.swiftsuspenders.*;

    public class InjectValueResult extends InjectionResult
    {
        private var m_value:Object;

        public function InjectValueResult(param1:Object)
        {
            this.m_value = param1;
            return;
        }// end function

        override public function getResponse(param1:Injector) : Object
        {
            return this.m_value;
        }// end function

    }
}
