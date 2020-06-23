class ps.oasis.OasisModeration
{
    function OasisModeration()
    {
    } // End of the function
    function SubmitWarn(warnReason)
    {
        if (PlayerId == 0)
        {
            return (false);
        } // end if
        if (warnReason.length < 3)
        {
            return (false);
        } // end if
        _global.getCurrentAirtower().send(_global.getCurrentAirtower().PLAY_EXT, "o#warn", [PlayerId, warnReason], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    function SubmitBan(banReason)
    {
        if (PlayerId == 0)
        {
            return (false);
        } // end if
        if (BanHour == 0)
        {
            return (false);
        } // end if
        if (banReason.length < 3)
        {
            return (false);
        } // end if
        _global.getCurrentAirtower().send(_global.getCurrentAirtower().PLAY_EXT, "o#create_ban", [PlayerId, BanHour, banReason], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    function SubmitKick(kickReason)
    {
        if (PlayerId == 0)
        {
            return (false);
        } // end if
        if (kickReason.length < 3)
        {
            return (false);
        } // end if
        _global.getCurrentAirtower().send(_global.getCurrentAirtower().PLAY_EXT, "o#kick", [PlayerId, kickReason], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    var BanHour = 0;
    var PlayerId = 0;
} // End of Class
