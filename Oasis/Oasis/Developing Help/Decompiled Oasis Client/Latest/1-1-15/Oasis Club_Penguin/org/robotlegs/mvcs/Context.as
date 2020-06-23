package org.robotlegs.mvcs
{
    import flash.display.*;
    import flash.events.*;
    import org.robotlegs.adapters.*;
    import org.robotlegs.base.*;
    import org.robotlegs.core.*;

    public class Context extends ContextBase implements IContext
    {
        protected var _injector:IInjector;
        protected var _reflector:IReflector;
        protected var _autoStartup:Boolean;
        protected var _contextView:DisplayObjectContainer;
        protected var _commandMap:ICommandMap;
        protected var _mediatorMap:IMediatorMap;
        protected var _viewMap:IViewMap;

        public function Context(param1:DisplayObjectContainer = null, param2:Boolean = true)
        {
            this._contextView = param1;
            this._autoStartup = param2;
            this.mapInjections();
            this.checkAutoStartup();
            return;
        }// end function

        public function startup() : void
        {
            dispatchEvent(new ContextEvent(ContextEvent.STARTUP_COMPLETE));
            return;
        }// end function

        public function shutdown() : void
        {
            dispatchEvent(new ContextEvent(ContextEvent.SHUTDOWN_COMPLETE));
            return;
        }// end function

        public function get contextView() : DisplayObjectContainer
        {
            return this._contextView;
        }// end function

        public function set contextView(param1:DisplayObjectContainer) : void
        {
            if (this._contextView != param1)
            {
                this._contextView = param1;
                this.mediatorMap.contextView = param1;
                this.viewMap.org.robotlegs.core:IViewMap::contextView = param1;
                this.mapInjections();
                this.checkAutoStartup();
            }
            return;
        }// end function

        protected function get injector() : IInjector
        {
            if (!this._injector)
            {
                var _loc_1:* = new SwiftSuspendersInjector();
                this._injector = new SwiftSuspendersInjector();
            }
            return _loc_1;
        }// end function

        protected function set injector(param1:IInjector) : void
        {
            this._injector = param1;
            return;
        }// end function

        protected function get reflector() : IReflector
        {
            if (!this._reflector)
            {
                var _loc_1:* = new SwiftSuspendersReflector();
                this._reflector = new SwiftSuspendersReflector();
            }
            return _loc_1;
        }// end function

        protected function set reflector(param1:IReflector) : void
        {
            this._reflector = param1;
            return;
        }// end function

        protected function get commandMap() : ICommandMap
        {
            if (!this._commandMap)
            {
                var _loc_1:* = new CommandMap(eventDispatcher, this.injector.createChild(), this.reflector);
                this._commandMap = new CommandMap(eventDispatcher, this.injector.createChild(), this.reflector);
            }
            return _loc_1;
        }// end function

        protected function set commandMap(param1:ICommandMap) : void
        {
            this._commandMap = param1;
            return;
        }// end function

        protected function get mediatorMap() : IMediatorMap
        {
            if (!this._mediatorMap)
            {
                var _loc_1:* = new MediatorMap(this.contextView, this.injector.createChild(), this.reflector);
                this._mediatorMap = new MediatorMap(this.contextView, this.injector.createChild(), this.reflector);
            }
            return _loc_1;
        }// end function

        protected function set mediatorMap(param1:IMediatorMap) : void
        {
            this._mediatorMap = param1;
            return;
        }// end function

        protected function get viewMap() : IViewMap
        {
            if (!this._viewMap)
            {
                var _loc_1:* = new ViewMap(this.contextView, this.injector);
                this._viewMap = new ViewMap(this.contextView, this.injector);
            }
            return _loc_1;
        }// end function

        protected function set viewMap(param1:IViewMap) : void
        {
            this._viewMap = param1;
            return;
        }// end function

        protected function mapInjections() : void
        {
            this.injector.mapValue(IReflector, this.reflector);
            this.injector.mapValue(IInjector, this.injector);
            this.injector.mapValue(IEventDispatcher, eventDispatcher);
            this.injector.mapValue(DisplayObjectContainer, this.contextView);
            this.injector.mapValue(ICommandMap, this.commandMap);
            this.injector.mapValue(IMediatorMap, this.mediatorMap);
            this.injector.mapValue(IViewMap, this.viewMap);
            this.injector.mapClass(IEventMap, EventMap);
            return;
        }// end function

        protected function checkAutoStartup() : void
        {
            if (this._autoStartup)
            {
            }
            if (this.contextView)
            {
                if (this.contextView.stage)
                {
                    this.startup();
                }
                else
                {
                    this.contextView.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage, false, 0, true);
                }
            }
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            this.contextView.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.startup();
            return;
        }// end function

    }
}
