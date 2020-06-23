package org.robotlegs.base
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.robotlegs.core.*;

    public class MediatorMap extends ViewMapBase implements IMediatorMap
    {
        protected var mediatorByView:Dictionary;
        protected var mappingConfigByView:Dictionary;
        protected var mappingConfigByViewClassName:Dictionary;
        protected var mediatorsMarkedForRemoval:Dictionary;
        protected var hasMediatorsMarkedForRemoval:Boolean;
        protected var reflector:IReflector;
        static const enterFrameDispatcher:Sprite = new Sprite();

        public function MediatorMap(param1:DisplayObjectContainer, param2:IInjector, param3:IReflector)
        {
            super(param1, param2);
            this.reflector = param3;
            this.mediatorByView = new Dictionary(true);
            this.mappingConfigByView = new Dictionary(true);
            this.mappingConfigByViewClassName = new Dictionary(false);
            this.mediatorsMarkedForRemoval = new Dictionary(false);
            return;
        }// end function

        public function mapView(param1, param2:Class, param3:Class = null, param4:Boolean = true, param5:Boolean = true) : void
        {
            var _loc_6:* = this.reflector.getFQCN(param1);
            if (this.mappingConfigByViewClassName[_loc_6] != null)
            {
                throw new ContextError(ContextError.E_MEDIATORMAP_OVR + " - " + param2);
            }
            if (this.reflector.classExtendsOrImplements(param2, IMediator) == false)
            {
                throw new ContextError(ContextError.E_MEDIATORMAP_NOIMPL + " - " + param2);
            }
            var _loc_7:* = new MappingConfig();
            _loc_7.mediatorClass = param2;
            _loc_7.autoCreate = param4;
            _loc_7.autoRemove = param5;
            if (param3)
            {
                _loc_7.typedViewClass = param3;
            }
            else if (param1 is Class)
            {
                _loc_7.typedViewClass = param1;
            }
            this.mappingConfigByViewClassName[_loc_6] = _loc_7;
            if (param4)
            {
            }
            if (contextView)
            {
            }
            if (_loc_6 == getQualifiedClassName(contextView))
            {
                this.createMediator(contextView);
            }
            activate();
            return;
        }// end function

        public function unmapView(param1) : void
        {
            var _loc_2:* = this.reflector.getFQCN(param1);
            delete this.mappingConfigByViewClassName[_loc_2];
            return;
        }// end function

        public function createMediator(param1:Object) : IMediator
        {
            var _loc_3:String = null;
            var _loc_4:MappingConfig = null;
            var _loc_2:* = this.mediatorByView[param1];
            if (_loc_2 == null)
            {
                _loc_3 = getQualifiedClassName(param1);
                _loc_4 = this.mappingConfigByViewClassName[_loc_3];
                if (_loc_4)
                {
                    injector.mapValue(_loc_4.typedViewClass, param1);
                    _loc_2 = injector.instantiate(_loc_4.mediatorClass);
                    injector.unmap(_loc_4.typedViewClass);
                    this.registerMediator(param1, _loc_2);
                }
            }
            return _loc_2;
        }// end function

        public function registerMediator(param1:Object, param2:IMediator) : void
        {
            injector.mapValue(this.reflector.getClass(param2), param2);
            this.mediatorByView[param1] = param2;
            this.mappingConfigByView[param1] = this.mappingConfigByViewClassName[getQualifiedClassName(param1)];
            param2.setViewComponent(param1);
            param2.preRegister();
            return;
        }// end function

        public function removeMediator(param1:IMediator) : IMediator
        {
            var _loc_2:Object = null;
            if (param1)
            {
                _loc_2 = param1.getViewComponent();
                delete this.mediatorByView[_loc_2];
                delete this.mappingConfigByView[_loc_2];
                param1.preRemove();
                param1.setViewComponent(null);
                injector.unmap(this.reflector.getClass(param1));
            }
            return param1;
        }// end function

        public function removeMediatorByView(param1:Object) : IMediator
        {
            return this.removeMediator(this.retrieveMediator(param1));
        }// end function

        public function retrieveMediator(param1:Object) : IMediator
        {
            return this.mediatorByView[param1];
        }// end function

        public function hasMediatorForView(param1:Object) : Boolean
        {
            return this.mediatorByView[param1] != null;
        }// end function

        public function hasMediator(param1:IMediator) : Boolean
        {
            var _loc_2:IMediator = null;
            for each (_loc_2 in this.mediatorByView)
            {
                
                if (_loc_2 == param1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        override protected function addListeners() : void
        {
            if (contextView)
            {
            }
            if (enabled)
            {
            }
            if (_active)
            {
                contextView.addEventListener(Event.ADDED_TO_STAGE, this.onViewAdded, useCapture, 0, true);
                contextView.addEventListener(Event.REMOVED_FROM_STAGE, this.onViewRemoved, useCapture, 0, true);
            }
            return;
        }// end function

        override protected function removeListeners() : void
        {
            if (contextView)
            {
            }
            if (enabled)
            {
            }
            if (_active)
            {
                contextView.removeEventListener(Event.ADDED_TO_STAGE, this.onViewAdded, useCapture);
                contextView.removeEventListener(Event.REMOVED_FROM_STAGE, this.onViewRemoved, useCapture);
            }
            return;
        }// end function

        override protected function onViewAdded(event:Event) : void
        {
            if (this.mediatorsMarkedForRemoval[event.target])
            {
                delete this.mediatorsMarkedForRemoval[event.target];
                return;
            }
            var _loc_2:* = this.mappingConfigByViewClassName[getQualifiedClassName(event.target)];
            if (_loc_2)
            {
            }
            if (_loc_2.autoCreate)
            {
                this.createMediator(event.target);
            }
            return;
        }// end function

        protected function onViewRemoved(event:Event) : void
        {
            var _loc_2:* = this.mappingConfigByView[event.target];
            if (_loc_2)
            {
            }
            if (_loc_2.autoRemove)
            {
                this.mediatorsMarkedForRemoval[event.target] = event.target;
                if (!this.hasMediatorsMarkedForRemoval)
                {
                    this.hasMediatorsMarkedForRemoval = true;
                    enterFrameDispatcher.addEventListener(Event.ENTER_FRAME, this.removeMediatorLater);
                }
            }
            return;
        }// end function

        protected function removeMediatorLater(event:Event) : void
        {
            var _loc_2:DisplayObject = null;
            enterFrameDispatcher.removeEventListener(Event.ENTER_FRAME, this.removeMediatorLater);
            for each (_loc_2 in this.mediatorsMarkedForRemoval)
            {
                
                if (!_loc_2.stage)
                {
                    this.removeMediatorByView(_loc_2);
                }
                delete this.mediatorsMarkedForRemoval[_loc_2];
            }
            this.hasMediatorsMarkedForRemoval = false;
            return;
        }// end function

    }
}

class MappingConfig extends Object
{
    public var mediatorClass:Class;
    public var typedViewClass:Class;
    public var autoCreate:Boolean;
    public var autoRemove:Boolean;

    function MappingConfig()
    {
        return;
    }// end function

}

