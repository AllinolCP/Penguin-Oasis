package org.robotlegs.mvcs
{
    import flash.display.*;
    import flash.events.*;
    import org.robotlegs.core.*;

    public class Command extends Object
    {
        public var contextView:DisplayObjectContainer;
        public var commandMap:ICommandMap;
        public var eventDispatcher:IEventDispatcher;
        public var injector:IInjector;
        public var mediatorMap:IMediatorMap;

        public function Command()
        {
            return;
        }// end function

        public function execute() : void
        {
            return;
        }// end function

        protected function dispatch(event:Event) : Boolean
        {
            if (this.eventDispatcher.hasEventListener(event.type))
            {
                return this.eventDispatcher.dispatchEvent(event);
            }
            return false;
        }// end function

    }
}
