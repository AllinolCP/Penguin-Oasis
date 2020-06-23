package com.clubpenguin.world.command.startup
{
    import com.clubpenguin.world.model.*;
    import org.robotlegs.mvcs.*;

    public class InitSWFAddressCommand extends SignalCommand
    {
        public var _model:MainModel;

        public function InitSWFAddressCommand()
        {
            return;
        }// end function

        override public function execute() : void
        {
            _model.initSWFAddress();
            return;
        }// end function

    }
}
