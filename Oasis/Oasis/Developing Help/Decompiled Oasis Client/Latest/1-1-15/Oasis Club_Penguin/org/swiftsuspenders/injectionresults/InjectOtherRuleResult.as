package org.swiftsuspenders.injectionresults
{
    import org.swiftsuspenders.*;

    public class InjectOtherRuleResult extends InjectionResult
    {
        private var m_rule:InjectionConfig;

        public function InjectOtherRuleResult(param1:InjectionConfig)
        {
            this.m_rule = param1;
            return;
        }// end function

        override public function getResponse(param1:Injector) : Object
        {
            return this.m_rule.getResponse(param1);
        }// end function

    }
}
