class com.disney.dlearning.games.cardjitsu.water.DLearning
{
    static var gameMode;
    function DLearning(learnerId)
    {
        com.disney.dlearning.managers.DLSManager.init(learnerId, "jw.k.api.dlsnetwork.com");
        gameCompleted = false;
    } // End of the function
    function setNumberOfPlayers(players)
    {
        numberOfPlayers = players;
    } // End of the function
    function setMode(gMode)
    {
        gameMode = gMode;
    } // End of the function
    function startGame()
    {
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "START", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.CARDJITSU_WATER, callBackFunc, "0", "0", "0");
        if (com.disney.dlearning.games.cardjitsu.water.DLearning.gameMode == com.disney.dlearning.games.cardjitsu.water.DLearning.EARN_WATER_SUIT)
        {
            com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "SELECTED", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.EARN_WATER_SUIT, callBackFunc, "0", "0", "0");
            this.setMode(com.disney.dlearning.games.cardjitsu.water.DLearning.EARN_WATER_SUIT);
        }
        else
        {
            com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "SELECTED", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.CHALLENGE_SENSEI, callBackFunc, "0", "0", "0");
            this.setMode(com.disney.dlearning.games.cardjitsu.water.DLearning.SENSEI_MODE);
        } // end else if
    } // End of the function
    function readInstructions()
    {
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "SELECTED", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.INSTRUCTIONS, callBackFunc, "0", "0", "0");
    } // End of the function
    function wonMatch()
    {
        switch (numberOfPlayers)
        {
            case 2:
            {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "SELECTED", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.WIN_MATCH_2Players, callBackFunc, "0", "0", "0");
                break;
            } 
            case 3:
            {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "SELECTED", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.WIN_MATCH_3Players, callBackFunc, "0", "0", "0");
                break;
            } 
            case 4:
            {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "SELECTED", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.WIN_MATCH_4Players, callBackFunc, "0", "0", "0");
                break;
            } 
        } // End of switch
    } // End of the function
    function sendScore(completed, position, stones)
    {
        var _loc2;
        gameCompleted = true;
        if (!scoreSent)
        {
            if (position == 0)
            {
                _loc2 = "w";
                position = 1;
                if (com.disney.dlearning.games.cardjitsu.water.DLearning.gameMode == com.disney.dlearning.games.cardjitsu.water.DLearning.EARN_WATER_SUIT)
                {
                    this.wonMatch();
                } // end if
            }
            else
            {
                _loc2 = "l";
            } // end else if
            if (com.disney.dlearning.games.cardjitsu.water.DLearning.gameMode == com.disney.dlearning.games.cardjitsu.water.DLearning.EARN_WATER_SUIT)
            {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "NOTIFY", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.EARN_WATER_SUIT, callBackFunc, String(stones), _loc2, String(position));
            }
            else
            {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "NOTIFY", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.CHALLENGE_SENSEI, callBackFunc, String(stones), _loc2, String(position));
            } // end if
        } // end else if
    } // End of the function
    function quitGame(stones)
    {
        if (!quitGameOnce)
        {
            if (!gameCompleted)
            {
                if (com.disney.dlearning.games.cardjitsu.water.DLearning.gameMode == com.disney.dlearning.games.cardjitsu.water.DLearning.EARN_WATER_SUIT)
                {
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "NOTIFY", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.EARN_WATER_SUIT, callBackFunc, String(stones), "q", "0");
                }
                else
                {
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "NOTIFY", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.CHALLENGE_SENSEI, callBackFunc, String(stones), "q", "0");
                } // end if
            } // end else if
            com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "STOP", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.CARDJITSU_WATER, callBackFunc, "0", "0", "0");
            quitGameOnce = true;
        } // end if
    } // End of the function
    function ringGong()
    {
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "SELECTED", com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.RING_GONG, callBackFunc, "0", "0", "0");
    } // End of the function
    function pushOpcode(opCode, nodeId)
    {
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode(opCode, nodeId, callBackFunc, "0", "0", "0");
    } // End of the function
    function earnedSuit(awardId)
    {
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcodeToHost("jw.k.api.dlsnetwork.com", "SELECTED", WATER_AWARD_ITEM[awardId], callBackFunc, "0", "0", "0");
    } // End of the function
    function callBackFunc(retString)
    {
    } // End of the function
    static var EARN_WATER_SUIT = 2;
    static var SENSEI_MODE = 3;
    var numberOfPlayers = 2;
    var WATER_AWARD_ITEM = [-777, com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.WAVE_SANDALS, com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.WATERFALL_COAT, com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.TORRENT_MASK, com.disney.dlearning.games.cardjitsu.water.OpcodeJournal.HELMET_OF_OCEANS, -777];
    var scoreSent = false;
    var quitGameOnce = false;
    var gameCompleted = false;
} // End of Class
