package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.*;

    public class PropertyInjectionPoint extends InjectionPoint
    {
        private var propertyName:String;
        private var propertyType:String;
        private var m_injectionConfig:InjectionConfig;

        public function PropertyInjectionPoint(param1:XML, param2:Injector)
        {
            super(param1, param2);
            return;
        }// end function

        override public function applyInjection(param1:Object, param2:Injector) : Object
        {
            var _loc_3:* = this.m_injectionConfig.getResponse(param2);
            if (_loc_3 == null)
            {
                throw new InjectorError("Injector is missing a rule to handle injection into target " + param1 + ". Target dependency: " + this.propertyType);
            }
            param1[this.propertyName] = _loc_3;
            return param1;
        }// end function

        override protected function initializeInjection(param1:XML, param2:Injector) : void
        {
            this.propertyType = param1.parent().@type.toString();
            this.propertyName = param1.parent().@name.toString();
            this.m_injectionConfig = param2.getMapping(Class(param2.getApplicationDomain().getDefinition(this.propertyType)), param1.arg.attribute("value").toString());
            return;
        }// end function

    }
}
