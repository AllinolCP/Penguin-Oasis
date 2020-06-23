package com.clubpenguin.world.command.startup
{
    import com.clubpenguin.world.*;
    import com.clubpenguin.world.model.*;
    import com.clubpenguin.world.service.avmbridge.*;
    import org.robotlegs.mvcs.*;

    public class SendAVM1FlashVarsCommand extends SignalCommand
    {
        public var _model:MainModel;
        public var _worldContext:WorldContext;
        private var _bridge:AVMBridgeService;

        public function SendAVM1FlashVarsCommand()
        {
            return;
        }// end function

        override public function execute() : void
        {
            _bridge = _model.getAVMBridge();
            var _loc_1:* = new AVMBridgeMessage(AVMBridgeMessage.MSG_SET_BOOT_DATA);
            _loc_1.data = _model.getEnvironmentData();
            _bridge.send(_loc_1);
            return;
        }// end function

    }
}
