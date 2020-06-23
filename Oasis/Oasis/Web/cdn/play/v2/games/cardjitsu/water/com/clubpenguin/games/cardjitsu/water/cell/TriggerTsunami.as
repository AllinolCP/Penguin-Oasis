class com.clubpenguin.games.cardjitsu.water.cell.TriggerTsunami extends com.clubpenguin.lib.movieclip.TriggerClip
{
    function TriggerTsunami()
    {
        super();
    } // End of the function
    function actionContinue(_action)
    {
        switch (_action)
        {
            case com.clubpenguin.games.cardjitsu.water.cell.TriggerTsunami.ACTION_SWING_GONG:
            {
                com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.TsunamiEvent(this, com.clubpenguin.games.cardjitsu.water.event.TsunamiEvent.SWING_GONG));
            } 
        } // End of switch
    } // End of the function
    function killRow(_row)
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.TsunamiEvent(this, com.clubpenguin.games.cardjitsu.water.event.TsunamiEvent.KILL_ROW, _row));
    } // End of the function
    static var ACTION_SWING_GONG = "tsunamiSwing";
} // End of Class
