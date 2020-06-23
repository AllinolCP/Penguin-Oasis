class com.clubpenguin.endgame.model.EndGameParams
{
    var totalCoins, earnedCoins, numTotalStamps, numCompletedStamps, newStamps, isTable, activeTable, gameRoomId;
    function EndGameParams()
    {
        totalCoins = 0;
        earnedCoins = 0;
        numTotalStamps = 0;
        numCompletedStamps = 0;
        newStamps = [];
        isTable = false;
        activeTable = null;
        gameRoomId = 0;
    } // End of the function
    function toString()
    {
        var _loc2 = "EndGameParams:";
        _loc2 = _loc2 + ("\n\t-totalCoins             = " + totalCoins);
        _loc2 = _loc2 + ("\n\t-earnedCoins            = " + earnedCoins);
        _loc2 = _loc2 + ("\n\t-numTotalStamps         = " + numTotalStamps);
        _loc2 = _loc2 + ("\n\t-numCompletedStamps     = " + numCompletedStamps);
        _loc2 = _loc2 + ("\n\t-newStamps              = " + newStamps);
        _loc2 = _loc2 + ("\n\t-isTable                = " + isTable);
        _loc2 = _loc2 + ("\n\t-activeTable            = " + activeTable);
        _loc2 = _loc2 + ("\n\t-gameRoomId             = " + gameRoomId);
        return (_loc2);
    } // End of the function
} // End of Class
