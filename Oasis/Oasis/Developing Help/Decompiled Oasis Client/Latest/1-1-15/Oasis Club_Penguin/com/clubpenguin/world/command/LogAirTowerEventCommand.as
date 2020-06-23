package com.clubpenguin.world.command
{
    import com.clubpenguin.world.model.*;
    import com.clubpenguin.world.vo.*;
    import org.robotlegs.mvcs.*;

    public class LogAirTowerEventCommand extends SignalCommand
    {
        public var airTowerVO:AirtowerVO;
        public var model:MainModel;

        public function LogAirTowerEventCommand()
        {
            return;
        }// end function

        override public function execute() : void
        {
            return;
        }// end function

    }
}
