package com.clubpenguin.world.command.startup
{
    import com.clubpenguin.world.*;
    import com.clubpenguin.world.model.*;
    import com.clubpenguin.world.service.*;
    import com.clubpenguin.world.service.http.*;
    import com.clubpenguin.world.view.*;
    import flash.display.*;
    import org.robotlegs.mvcs.*;

    public class LoadAS2Command extends SignalCommand
    {
        public var _mainModel:MainModel;
        private var _service:LoadAS2ClubPenguinService;
        public var _worldContext:WorldContext;
        public var _as2ContentView:AS2ContentView;

        public function LoadAS2Command()
        {
            return;
        }// end function

        private function onResponseReceived(param1:LoadSWFResponse) : void
        {
            _as2ContentView.addContent(param1.data as Loader);
            _worldContext.onAS2Loaded();
            return;
        }// end function

        private function onRequestFailed(param1:LoadSWFResponse) : void
        {
            return;
        }// end function

        override public function execute() : void
        {
            _service = new LoadAS2ClubPenguinService(_mainModel.getEnvironmentData());
            _service.responseReceived.addOnce(onResponseReceived);
            _service.requestFailed.addOnce(onRequestFailed);
            _service.send();
            return;
        }// end function

    }
}
