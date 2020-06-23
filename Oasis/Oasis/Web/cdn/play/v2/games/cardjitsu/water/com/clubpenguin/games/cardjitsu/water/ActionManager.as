class com.clubpenguin.games.cardjitsu.water.ActionManager
{
    static var __instance;
    function ActionManager()
    {
    } // End of the function
    static function getInstance()
    {
        if (com.clubpenguin.games.cardjitsu.water.ActionManager.__instance == null)
        {
            __instance = new com.clubpenguin.games.cardjitsu.water.ActionManager();
        } // end if
        return (com.clubpenguin.games.cardjitsu.water.ActionManager.__instance);
    } // End of the function
} // End of Class
