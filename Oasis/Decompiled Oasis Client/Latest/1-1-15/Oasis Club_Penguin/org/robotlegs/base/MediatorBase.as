package org.robotlegs.base
{
    import flash.events.*;
    import flash.utils.*;

    public class MediatorBase extends Object implements IMediator
    {
        protected var viewComponent:Object;
        protected var removed:Boolean;
        static var UIComponentClass:Class;
        static const flexAvailable:Boolean = checkFlex();

        public function MediatorBase()
        {
            return;
        }// end function

        public function preRegister() : void
        {
            this.removed = false;
            if (flexAvailable)
            {
            }
            if (this.viewComponent is UIComponentClass)
            {
            }
            if (!this.viewComponent["initialized"])
            {
                IEventDispatcher(this.viewComponent).addEventListener("creationComplete", this.onCreationComplete, false, 0, true);
            }
            else
            {
                this.onRegister();
            }
            return;
        }// end function

        public function onRegister() : void
        {
            return;
        }// end function

        public function preRemove() : void
        {
            this.removed = true;
            this.onRemove();
            return;
        }// end function

        public function onRemove() : void
        {
            return;
        }// end function

        public function getViewComponent() : Object
        {
            return this.viewComponent;
        }// end function

        public function setViewComponent(param1:Object) : void
        {
            this.viewComponent = param1;
            return;
        }// end function

        protected function onCreationComplete(event:Event) : void
        {
            IEventDispatcher(event.target).removeEventListener("creationComplete", this.onCreationComplete);
            if (!this.removed)
            {
                this.onRegister();
            }
            return;
        }// end function

        static function checkFlex() : Boolean
        {
            try
            {
                UIComponentClass = getDefinitionByName("mx.core::UIComponent") as Class;
            }
            catch (error:Error)
            {
            }
            return UIComponentClass != null;
        }// end function

    }
}
