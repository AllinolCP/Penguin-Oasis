package com.clubpenguin.world.command.startup
{
    import com.clubpenguin.world.*;
    import com.clubpenguin.world.model.*;
    import com.clubpenguin.world.service.avmbridge.*;
    import org.robotlegs.mvcs.*;

    public class InitAVMCommunicationCommand extends SignalCommand
    {
        public var _model:MainModel;
        public var _worldContext:WorldContext;
        private var _bridge:AVMBridgeService;

        public function InitAVMCommunicationCommand()
        {
            return;
        }// end function

        public function onAVMConnect() : void
        {
            _worldContext.onAVMCommunicationReady();
            return;
        }// end function

        override public function execute() : void
        {
            _bridge = _model.getAVMBridge();
            _bridge.connected.addOnce(onAVMConnect);
            _model.connectAVMBridge();
            return;
        }// end function

    }
}
