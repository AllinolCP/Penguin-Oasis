package com.clubpenguin.world.service
{
    import com.clubpenguin.world.model.*;
    import com.clubpenguin.world.service.http.*;

    public class LoadAS2ClubPenguinService extends LoadSWFService
    {
        public static const AS2_CLUB_PENGUIN_LIVE_URL:String = "load.swf";
        public static const AS2_CLUB_PENGUIN_URL:String = "../world/tools/launchers/club_penguin/localLoader.swf";

        public function LoadAS2ClubPenguinService(param1:EnvironmentData)
        {
            if (param1.isRunningLocally)
            {
                setURL(AS2_CLUB_PENGUIN_URL);
            }
            else
            {
                setURL(param1.clientPath + AS2_CLUB_PENGUIN_LIVE_URL + "?connectionID=" + param1.connectionID);
            }
            return;
        }// end function

    }
}
