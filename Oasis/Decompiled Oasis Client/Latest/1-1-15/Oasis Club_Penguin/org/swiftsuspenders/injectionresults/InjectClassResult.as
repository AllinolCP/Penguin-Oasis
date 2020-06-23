package org.swiftsuspenders.injectionresults
{
    import org.swiftsuspenders.*;

    public class InjectClassResult extends InjectionResult
    {
        private var m_responseType:Class;

        public function InjectClassResult(param1:Class)
        {
            this.m_responseType = param1;
            return;
        }// end function

        override public function getResponse(param1:Injector) : Object
        {
            return param1.instantiate(this.m_responseType);
        }// end function

    }
}
