package org.robotlegs.base
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.robotlegs.core.*;

    public class ViewMap extends ViewMapBase implements IViewMap
    {
        protected var mappedPackages:Array;
        protected var mappedTypes:Dictionary;
        protected var injectedViews:Dictionary;

        public function ViewMap(param1:DisplayObjectContainer, param2:IInjector)
        {
            super(param1, param2);
            this.mappedPackages = new Array();
            this.mappedTypes = new Dictionary(false);
            this.injectedViews = new Dictionary(true);
            return;
        }// end function

        public function mapPackage(param1:String) : void
        {
            if (this.mappedPackages.indexOf(param1) == -1)
            {
                this.mappedPackages.push(param1);
                activate();
            }
            return;
        }// end function

        public function unmapPackage(param1:String) : void
        {
            var _loc_2:* = this.mappedPackages.indexOf(param1);
            if (_loc_2 > -1)
            {
                this.mappedPackages.splice(_loc_2, 1);
            }
            return;
        }// end function

        public function mapType(param1:Class) : void
        {
            if (this.mappedTypes[param1])
            {
                return;
            }
            this.mappedTypes[param1] = param1;
            if (contextView)
            {
            }
            if (contextView is param1)
            {
                this.injectInto(contextView);
            }
            activate();
            return;
        }// end function

        public function unmapType(param1:Class) : void
        {
            delete this.mappedTypes[param1];
            return;
        }// end function

        public function hasType(param1:Class) : Boolean
        {
            return this.mappedTypes[param1] != null;
        }// end function

        public function hasPackage(param1:String) : Boolean
        {
            return this.mappedPackages.indexOf(param1) > -1;
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
            }
            return;
        }// end function

        override protected function onViewAdded(event:Event) : void
        {
            var _loc_3:Class = null;
            var _loc_4:int = 0;
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_7:String = null;
            var _loc_2:* = DisplayObject(event.target);
            if (this.injectedViews[_loc_2])
            {
                return;
            }
            for each (_loc_3 in this.mappedTypes)
            {
                
                if (_loc_2 is _loc_3)
                {
                    this.injectInto(_loc_2);
                    return;
                }
            }
            _loc_4 = this.mappedPackages.length;
            if (_loc_4 > 0)
            {
                _loc_5 = getQualifiedClassName(_loc_2);
                _loc_6 = 0;
                while (_loc_6 < _loc_4)
                {
                    
                    _loc_7 = this.mappedPackages[_loc_6];
                    if (_loc_5.indexOf(_loc_7) == 0)
                    {
                        this.injectInto(_loc_2);
                        return;
                    }
                    _loc_6 = _loc_6 + 1;
                }
            }
            return;
        }// end function

        protected function injectInto(param1:DisplayObject) : void
        {
            injector.org.robotlegs.core:IInjector::injectInto(param1);
            this.injectedViews[param1] = true;
            return;
        }// end function

    }
}
