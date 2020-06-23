class ps.oasis.OasisPermission
{
    function OasisPermission()
    {
        ps.oasis.OasisLogger.debug("Starting OasisPermission");
    } // End of the function
    function hasPermission(permissionType, permissionBits, permissionCatg)
    {
        if (permissionType == "char" || permissionType == "a")
        {
            permissionType = permissionType + "_permission";
        } // end if
        if (_global.getCurrentShell().OasisPermission[permissionType.toUpperCase() + "_" + permissionCatg.toUpperCase()] == undefined)
        {
            return (false);
        } // end if
        return (_global.getCurrentShell().OasisPermission.bitwiseBool(Number(permissionBits), _global.getCurrentShell().OasisPermission[permissionType.toUpperCase() + "_" + permissionCatg.toUpperCase()], false, false));
    } // End of the function
    function bitwiseBool(bits, againstBit, returnString, returnNumberFormat)
    {
        if ((Number(bits) & Number(againstBit)) > 0)
        {
            if (returnString == true)
            {
                if (returnNumberFormat == true)
                {
                    return ("1");
                }
                else
                {
                    return ("true");
                } // end if
            } // end else if
            if (returnNumberFormat == true)
            {
                return (1);
            } // end if
            return (true);
        } // end if
        if (returnString == true)
        {
            if (returnNumberFormat == true)
            {
                return ("0");
            }
            else
            {
                return ("false");
            } // end if
        } // end else if
        if (returnNumberFormat == true)
        {
            return (0);
        } // end if
        return (false);
    } // End of the function
    var A_PERMISSION_SPEAK = 1;
    var A_PERMISSION_EMOTE = 2;
    var A_PERMISSION_ACTION = 4;
    var A_PERMISSION_WARN = 8;
    var A_PERMISSION_KICK = 16;
    var A_PERMISSION_BAN = 32;
    var A_PERMISSION_ACCESS_EXTERNAL_PLAYERS = 64;
    var A_PERMISSION_UNBAN = 128;
    var A_PERMISSION_RELOAD_EXTENSION = 256;
    var A_PERMISSION_EDIT_USER = 512;
    var A_PERMISSION_EDIT_SUPERUSER = 1024;
    var A_PERMISSION_ALTER_ENMITY_AND_FRIENDSHIP = 2048;
    var A_PERMISSION_SET_CONFIG = 4096;
    var A_PERMISSION_SERVICE_EDITOR = 8192;
    var A_PERMISSION_EDIT_CLOTHING_SELF = 16384;
    var A_PERMISSION_PURCHASE_ITEM = 32768;
    var A_PERMISSION_SEND_PRIVATE_MESSAGE = 65536;
    var A_PERMISSION_PLAYERCARD_ATTRIBUTES = 131072;
    var CHAR_PERMISSION_NAMEGLOW = 1;
    var CHAR_PERMISSION_BUBBLE_COLOR = 2;
    var CHAR_PERMISSION_CHARACTER_SWAP = 4;
    var CHAR_PERMISSION_CHARACTER_SPEED = 8;
    var CHAR_PERMISSION_RING_COLOR = 16;
    var CHAR_PERMISSION_GROUP_CHATS = 32;
    var CHAR_PERMISSION_WALL_HACK = 64;
    var CHAR_PERMISSION_SNOWBALL_COLOR = 128;
    var CHAR_PERMISSION_BACKGROUND_CREATOR = 256;
    var CHAR_PERMISSION_IGLOO_MUSIC_UPLOAD = 512;
    var CHAR_PERMISSION_SNOWBALL_OVERRIDE = 1024;
    var USER_CAN_ADD_FRIEND = 1;
    var USER_CAN_VISIT_HOME = 2;
    var USER_CAN_CLONE_AND_SAVE_OUTFIT = 4;
    var USER_CAN_FIND_ONLY_IF_BUDDY = 8;
    var USER_CAN_SEND_PRIVATE_MESSAGE = 16;
} // End of Class
