package org.swiftsuspenders
{
    import org.swiftsuspenders.injectionresults.*;

    public class InjectionConfig extends Object
    {
        public var request:Class;
        public var injectionName:String;
        private var m_injector:Injector;
        private var m_result:InjectionResult;

        public function InjectionConfig(param1:Class, param2:String)
        {
            this.request = param1;
            this.injectionName = param2;
            return;
        }// end function

        public function getResponse(param1:Injector) : Object
        {
            if (this.m_result)
            {
                if (!this.m_injector)
                {
                }
                return this.m_result.getResponse(param1);
            }
            if (!this.m_injector)
            {
            }
            var _loc_2:* = param1.getAncestorMapping(this.request, this.injectionName);
            if (_loc_2)
            {
                return _loc_2.getResponse(param1);
            }
            return null;
        }// end function

        public function hasResponse(param1:Injector) : Boolean
        {
            if (this.m_result)
            {
                return true;
            }
            if (!this.m_injector)
            {
            }
            var _loc_2:* = param1.getAncestorMapping(this.request, this.injectionName);
            return _loc_2 != null;
        }// end function

        public function hasOwnResponse() : Boolean
        {
            return this.m_result != null;
        }// end function

        public function setResult(param1:InjectionResult) : void
        {
            this.m_result = param1;
            return;
        }// end function

        public function setInjector(param1:Injector) : void
        {
            this.m_injector = param1;
            return;
        }// end function

    }
}
