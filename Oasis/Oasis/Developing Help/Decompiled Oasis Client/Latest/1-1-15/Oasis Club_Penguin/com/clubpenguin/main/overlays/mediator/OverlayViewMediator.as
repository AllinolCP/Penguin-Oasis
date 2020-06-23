package com.clubpenguin.main.overlays.mediator
{
    import com.clubpenguin.main.overlays.view.*;
    import com.clubpenguin.main.signal.*;
    import com.clubpenguin.world.model.*;
    import org.robotlegs.mvcs.*;

    public class OverlayViewMediator extends Mediator
    {
        private var _view:OverlayView;
        public var signalBus:SignalBus;
        public var model:MainModel;

        public function OverlayViewMediator()
        {
            return;
        }// end function

        public function register(param1:OverlayView) : void
        {
            _view = param1;
            return;
        }// end function

        public function get view() : OverlayView
        {
            return _view;
        }// end function

        public function set view(param1:OverlayView) : void
        {
            _view = param1;
            return;
        }// end function

    }
}
