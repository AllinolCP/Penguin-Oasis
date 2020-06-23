package com.clubpenguin.world.service.avmbridge
{

    public class AVMBridgeMessage extends Object
    {
        public var data:Object;
        public var type:String = "";
        public static const MSG_MODULE_CLOSED:String = "moduleClosed";
        public static const MSG_OPEN_NEWSPAPER:String = "openNewspaper";
        public static const MSG_OPEN_MODULE:String = "openModule";
        public static const MSG_AS2_READY:String = "as2Ready";
        public static const MSG_SEND_SERVER_COMMAND:String = "sendServerCommand";
        public static const MSG_MAKE_PLAYER_VO:String = "buildPlayerVO";
        public static const MSG_CLOSE_NEWSPAPER:String = "closeNewspaper";
        public static const MSG_SET_BOOT_DATA:String = "setEnvironmentData";

        public function AVMBridgeMessage(param1:String)
        {
            type = param1;
            return;
        }// end function

    }
}
