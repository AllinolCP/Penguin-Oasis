package com.clubpenguin.main.command
{
    import com.clubpenguin.lib.vo.*;
    import com.clubpenguin.world.model.*;
    import com.clubpenguin.world.service.avmbridge.*;
    import org.robotlegs.mvcs.*;

    public class SendBICommand extends SignalCommand
    {
        public var biVO:BiVO;
        public var mainModel:MainModel;

        public function SendBICommand()
        {
            return;
        }// end function

        override public function execute() : void
        {
            var _loc_1:* = new AVMBridgeMessage(AVMBridgeMessage.MSG_CLOSE_NEWSPAPER);
            var _loc_2:Object = {};
            _loc_2.args = new Array(biVO.biTrackingString);
            _loc_1.data = _loc_2;
            mainModel.getAVMBridge().send(_loc_1);
            return;
        }// end function

    }
}
