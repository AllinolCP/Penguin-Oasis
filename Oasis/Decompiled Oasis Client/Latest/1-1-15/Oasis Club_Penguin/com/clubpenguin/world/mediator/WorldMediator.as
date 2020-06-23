package com.clubpenguin.world.mediator
{
    import com.clubpenguin.world.model.*;
    import com.clubpenguin.world.view.*;
    import org.robotlegs.mvcs.*;

    public class WorldMediator extends Mediator
    {
        public var view:MainView;
        public var model:MainModel;

        public function WorldMediator()
        {
            return;
        }// end function

        override public function onRegister() : void
        {
            model.onAppClosed.addOnce(onAppClosed);
            return;
        }// end function

        private function onAppClosed() : void
        {
            view.changeState(null);
            return;
        }// end function

    }
}
