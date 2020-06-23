package org.robotlegs.base
{
    import flash.display.*;
    import flash.events.*;
    import org.robotlegs.core.*;

    public class ViewMapBase extends Object
    {
        protected var _enabled:Boolean = true;
        protected var _active:Boolean = true;
        protected var _contextView:DisplayObjectContainer;
        protected var injector:IInjector;
        protected var useCapture:Boolean;

        public function ViewMapBase(param1:DisplayObjectContainer, param2:IInjector)
        {
            this.injector = param2;
            this.useCapture = true;
            this.contextView = param1;
            return;
        }// end function

        public function get contextView() : DisplayObjectContainer
        {
            return this._contextView;
        }// end function

        public function set contextView(param1:DisplayObjectContainer) : void
        {
            if (param1 != this._contextView)
            {
                this.removeListeners();
                this._contextView = param1;
                this.addListeners();
            }
            return;
        }// end function

        public function get enabled() : Boolean
        {
            return this._enabled;
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            if (param1 != this._enabled)
            {
                this.removeListeners();
                this._enabled = param1;
                this.addListeners();
            }
            return;
        }// end function

        protected function activate() : void
        {
            if (!this._active)
            {
                this._active = true;
                this.addListeners();
            }
            return;
        }// end function

        protected function addListeners() : void
        {
            return;
        }// end function

        protected function removeListeners() : void
        {
            return;
        }// end function

        protected function onViewAdded(event:Event) : void
        {
            return;
        }// end function

    }
}
