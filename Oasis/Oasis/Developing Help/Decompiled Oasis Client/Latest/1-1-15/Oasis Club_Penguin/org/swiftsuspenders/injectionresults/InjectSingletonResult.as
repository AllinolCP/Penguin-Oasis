package org.swiftsuspenders.injectionresults
{
    import org.swiftsuspenders.*;

    public class InjectSingletonResult extends InjectionResult
    {
        private var m_responseType:Class;
        private var m_response:Object;

        public function InjectSingletonResult(param1:Class)
        {
            this.m_responseType = param1;
            return;
        }// end function

        override public function getResponse(param1:Injector) : Object
        {
            if (!this.m_response)
            {
            }
            var _loc_2:* = this.createResponse(param1);
            this.m_response = this.createResponse(param1);
            return _loc_2;
        }// end function

        private function createResponse(param1:Injector) : Object
        {
            return param1.instantiate(this.m_responseType);
        }// end function

    }
}
