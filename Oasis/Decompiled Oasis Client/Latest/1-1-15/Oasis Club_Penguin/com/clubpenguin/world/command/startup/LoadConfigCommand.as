package com.clubpenguin.world.command.startup
{
    import com.clubpenguin.world.*;
    import com.clubpenguin.world.model.*;
    import com.clubpenguin.world.service.*;
    import com.clubpenguin.world.service.http.*;
    import org.robotlegs.mvcs.*;

    public class LoadConfigCommand extends SignalCommand
    {
        public var _worldContext:WorldContext;
        private var _service:GetJSONConfigService;
        public var _model:MainModel;

        public function LoadConfigCommand()
        {
            _service = new GetJSONConfigService();
            return;
        }// end function

        private function onResponseReceived(param1:HTTPResponse) : void
        {
            _model.setEnvironmentData(param1.data);
            _worldContext.onConfigLoaded();
            return;
        }// end function

        override public function execute() : void
        {
            if (_model.getEnvironmentData().isRunningLocally)
            {
                _service.responseReceived.addOnce(onResponseReceived);
                _service.requestFailed.addOnce(onRequestFailed);
                _service.send();
            }
            else
            {
                _model.setEnvironmentData(_worldContext.getFlashVars());
                _worldContext.onConfigLoaded();
            }
            return;
        }// end function

        private function onRequestFailed(param1:HTTPResponse) : void
        {
            return;
        }// end function

    }
}
