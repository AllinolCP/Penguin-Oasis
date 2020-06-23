package org.robotlegs.core
{
    import flash.events.*;

    public interface IContext
    {

        public function IContext();

        function get eventDispatcher() : IEventDispatcher;

    }
}
