package org.robotlegs.adapters
{
    import flash.system.*;
    import org.robotlegs.core.*;
    import org.swiftsuspenders.*;

    public class SwiftSuspendersInjector extends Injector implements IInjector
    {
        static const XML_CONFIG:XML = <types>r
n	t	t	t	t<type name=''org.robotlegs.mvcs::Actor''>r
n	t	t	t	t	t<field name=''eventDispatcher''/>r
n	t	t	t	t</type>r
n	t	t	t	t<type name=''org.robotlegs.mvcs::Command''>r
n	t	t	t	t	t<field name=''contextView''/>r
n	t	t	t	t	t<field name=''mediatorMap''/>r
n	t	t	t	t	t<field name=''eventDispatcher''/>r
n	t	t	t	t	t<field name=''injector''/>r
n	t	t	t	t	t<field name=''commandMap''/>r
n	t	t	t	t</type>r
n	t	t	t	t<type name=''org.robotlegs.mvcs::Mediator''>r
n	t	t	t	t	t<field name=''contextView''/>r
n	t	t	t	t	t<field name=''mediatorMap''/>r
n	t	t	t	t	t<field name=''eventDispatcher''/>r
n	t	t	t	t</type>r
n	t	t	t</types>")("<types>
				<type name='org.robotlegs.mvcs::Actor'>
					<field name='eventDispatcher'/>
				</type>
				<type name='org.robotlegs.mvcs::Command'>
					<field name='contextView'/>
					<field name='mediatorMap'/>
					<field name='eventDispatcher'/>
					<field name='injector'/>
					<field name='commandMap'/>
				</type>
				<type name='org.robotlegs.mvcs::Mediator'>
					<field name='contextView'/>
					<field name='mediatorMap'/>
					<field name='eventDispatcher'/>
				</type>
			</types>;

        public function SwiftSuspendersInjector(param1:XML = null)
        {
            var _loc_2:XML = null;
            if (param1)
            {
                for each (_loc_2 in XML_CONFIG.children())
                {
                    
                    param1.appendChild(_loc_2);
                }
            }
            super(param1);
            return;
        }// end function

        public function createChild(param1:ApplicationDomain = null) : IInjector
        {
            var _loc_2:* = new SwiftSuspendersInjector();
            _loc_2.setApplicationDomain(param1);
            _loc_2.setParentInjector(this);
            return _loc_2;
        }// end function

    }
}
