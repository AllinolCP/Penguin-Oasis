class com.disney.dlearning.games.cjfire.DLearning
{
    var dlsManager, gameMode, normalGameEnd;
    function DLearning(learnerId)
    {
        com.disney.dlearning.managers.DLSManager.init(learnerId, "jf.k.api.dlsnetwork.com");
        dlsManager = com.disney.dlearning.managers.DLSManager.instance;
        gameMode = EARN_FIRE_SUIT_MODE;
        normalGameEnd = false;
    } // End of the function
    function setNumberOfPlayers(players)
    {
        numberOfPlayers = players;
    } // End of the function
    function setMode(gMode)
    {
        if (gMode == 2)
        {
            gameMode = EARN_FIRE_SUIT_MODE;
        }
        else
        {
            gameMode = SENSEI_MODE;
        } // end else if
    } // End of the function
    function startGame()
    {
        dlsManager.pushOpcode("START", com.disney.dlearning.games.cjfire.OpcodeJournal.CP_Card_Jitsu_Fire, callBackFunc, "0", "0", "0");
    } // End of the function
    function endGame(energyPoints)
    {
        if (!normalGameEnd)
        {
            if (gameMode == EARN_FIRE_SUIT_MODE)
            {
                dlsManager.pushOpcode("NOTIFY", com.disney.dlearning.games.cjfire.OpcodeJournal.EARN_FIRE_SUIT, callBackFunc, String(energyPoints), "q", "0");
            }
            else
            {
                dlsManager.pushOpcode("NOTIFY", com.disney.dlearning.games.cjfire.OpcodeJournal.CHALLENGE_SENSEI, callBackFunc, String(energyPoints), "q", "0");
            } // end if
        } // end else if
        dlsManager.pushOpcode("STOP", com.disney.dlearning.games.cjfire.OpcodeJournal.CP_Card_Jitsu_Fire, callBackFunc, "0", "0", "0");
    } // End of the function
    function readInstructions()
    {
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("Selected", com.disney.dlearning.games.cjfire.OpcodeJournal.INSTRUCTIONS, "0", "0", "0");
    } // End of the function
    function winGame()
    {
        switch (numberOfPlayers)
        {
            case 2:
            {
                dlsManager.pushOpcode("SELECTED", com.disney.dlearning.games.cjfire.OpcodeJournal.WIN_MATCH_2PLAYERS, callBackFunc, "0", "0", "0");
                break;
            } 
            case 3:
            {
                dlsManager.pushOpcode("SELECTED", com.disney.dlearning.games.cjfire.OpcodeJournal.WIN_MATCH_3PLAYERS, callBackFunc, "0", "0", "0");
                break;
            } 
            case 4:
            {
                dlsManager.pushOpcode("SELECTED", com.disney.dlearning.games.cjfire.OpcodeJournal.WIN_MATCH_4PLAYERS, callBackFunc, "0", "0", "0");
                break;
            } 
        } // End of switch
    } // End of the function
    function gameOver(energyPoints, place)
    {
        var _loc2;
        normalGameEnd = true;
        if (place == 1)
        {
            _loc2 = "w";
            if (gameMode == EARN_FIRE_SUIT_MODE)
            {
                this.winGame();
            } // end if
        }
        else
        {
            _loc2 = "l";
        } // end else if
        if (gameMode == EARN_FIRE_SUIT_MODE)
        {
            dlsManager.pushOpcode("NOTIFY", com.disney.dlearning.games.cjfire.OpcodeJournal.EARN_FIRE_SUIT, callBackFunc, String(energyPoints), _loc2, String(place));
        }
        else
        {
            dlsManager.pushOpcode("NOTIFY", com.disney.dlearning.games.cjfire.OpcodeJournal.CHALLENGE_SENSEI, callBackFunc, String(energyPoints), _loc2, String(place));
        } // end else if
    } // End of the function
    function earnedReward(awardId)
    {
        dlsManager.pushOpcode("selected", FIRE_AWARD_ITEM[awardId], callBackFunc, "0", "0", "0");
    } // End of the function
    function earnedGem()
    {
        dlsManager.pushOpcode("selected", com.disney.dlearning.games.cjfire.OpcodeJournal.GET_FIRE_GEM, callBackFunc, "0", "0", "0");
    } // End of the function
    function callBackFunc(retString)
    {
    } // End of the function
    var EARN_FIRE_SUIT_MODE = 2;
    var SENSEI_MODE = 3;
    var numberOfPlayers = 0;
    var FIRE_AWARD_ITEM = [-777, com.disney.dlearning.games.cjfire.OpcodeJournal.GET_FIRE_FLAME_SANDALS, com.disney.dlearning.games.cjfire.OpcodeJournal.GET_FIRE_MAGMA_COAT, com.disney.dlearning.games.cjfire.OpcodeJournal.GET_FIRE_LAVA_MASK, com.disney.dlearning.games.cjfire.OpcodeJournal.GET_FIRE_FIERY_HELMET, -777];
} // End of Class
