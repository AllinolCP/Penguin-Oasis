package com.clubpenguin.main.command
{
    import com.clubpenguin.lib.vo.*;
    import com.clubpenguin.world.model.*;
    import flash.net.*;
    import org.robotlegs.mvcs.*;

    public class SendUserSubmissionCommand extends SignalCommand
    {
        public var mainModel:MainModel;
        public var userSubmission:UserSubmissionVO;

        public function SendUserSubmissionCommand()
        {
            return;
        }// end function

        override public function execute() : void
        {
            var _loc_4:String = null;
            var _loc_1:* = new URLRequest("http://play.clubpenguin.com/submit_ugc.php");
            var _loc_2:* = new URLLoader();
            var _loc_3:* = new URLVariables();
            _loc_4 = mainModel.getEnvironmentData().language;
            _loc_3.PlayerId = mainModel.myPlayerVO.player_id;
            _loc_3.Nickname = mainModel.myPlayerVO.nickname;
            _loc_3.Category = "auntarctic";
            _loc_3.Language = _loc_4;
            _loc_3.Comments = userSubmission.submissionText;
            _loc_1.method = URLRequestMethod.POST;
            _loc_1.data = _loc_3;
            _loc_2.load(_loc_1);
            return;
        }// end function

    }
}
