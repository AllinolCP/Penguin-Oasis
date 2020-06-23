class com.clubpenguin.games.fire.GameEngine extends com.clubpenguin.games.fire.GameEngineBase
{
    var movie, debugTrace, boardObject, SHELL, INTERFACE, dLearning, initDone, isIgnoreMode, playerAbortQueue, gameLoadCountdown, debugButtonOnRelease, debugCopyButtonOnRelease, debugClearButtonOnRelease, leaveRoom, hasBootedHacker, validPlayer, netClient, hideCards, hideBattleCards, playerMySeatId, playerActiveSeatId, serverMessageData, debugObject, playerEnergyLevel, portraitObjectRef, hideBattleFrames, cardJumpTo, battleFrameBySeatId, screenPositionBySeatId, setHighlightTint, setStatusText, playerFinishPositionList, playerCardList, addSFX, battleEnergyAnimOffsetFlip, battleEnergyAnimOffsetNormal, addWaitForAnimation, playerNicknames, playerAmount, playerColorList, playerCurrentBoardId, spinAmount, moveClockwise, moveCounterClockwise, playerRank, playerScore, playerMyGameOver, gameState, playerNewRank, playerAutoplayBoard, isLocalPlayerTurn, timeoutBoardHandled, playerAutoplayBattle, timeoutBattleHandled, serverMessageLock, gameCurrentPhase, dropSeatId, isAnimationComplete, isMovieLoaded, gameInitTimeout, randomRange, gameHackerTimeout, assetLoadDone, seatIdByScreenPosition, gameIsReady, playerObjRef, timerObjectRef, timerMovieRef, resetAutoPlay, activePlayerCount, hasFireGem, hasWaterGem, hasSnowGem, flagAnimateBubbles, bubbleTimerCount, bubbleStart, flagAnimateFirepops, firepopTimerCount, firepopStart, flagSenseiMode, playerMovieRef, cardIndex, cardTotalAmount, cardBorderColour, cardGlowColour, assetList, assetLoadingCount, timerPosition, timerSize, bubbleDestroyAll, firepopDestroyAll, freeGameMemory, endOfGameStampObject, cardSymbol, stampInfoAbort;
    static var instance, lastGameState;
    function GameEngine(ref_movie)
    {
        if (ref_movie)
        {
            movie = ref_movie;
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("GameEngine: movie = " + movie);
            } // end if
            boardObject = new com.clubpenguin.games.fire.Board(movie, this);
            SHELL = _global.getCurrentShell();
            INTERFACE = _global.getCurrentInterface();
            dLearning = new com.disney.dlearning.games.cjfire.DLearning(SHELL.getMyPlayerId());
            initDone = false;
            super.init(movie);
            this.init();
            instance = this;
        }
        else if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("Fatal: Empty movie reference passed to constructor");
        } // end else if
        this.setSenseiMode(false);
        isIgnoreMode = false;
    } // End of the function
    static function getInstance(Void)
    {
        return (com.clubpenguin.games.fire.GameEngine.instance);
    } // End of the function
    function init(Void)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("init:");
        } // end if
        if (!initDone)
        {
            playerAbortQueue = new Array();
            movie.attachSFX._visible = false;
            movie.ambientSFX._visible = false;
            movie.flame_holder._visible = false;
            this.hideAwardIntro();
            this.hideSpinner();
            this.sinkSpinner();
            gameLoadCountdown = com.clubpenguin.games.fire.Constants.GAME_MAX_INIT_TIMEOUT;
            this.showChoosePopup("" + com.clubpenguin.games.fire.Constants.GAME_LOADING, null, null);
            this.initCards();
            movie.status_mc.gotoAndStop(1);
            this.initNetClient();
            movie.closeBtn.onRelease = com.clubpenguin.util.Delegate.create(this, closeBtnHandleOnRelease, movie.closeBtn);
            SHELL.hideLoading();
            SHELL.startGameMusic();
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                movie.debug_mc._alpha = 80;
                movie.debug_mc._visible = false;
                movie.debug_btn._alpha = 65;
                movie.debug_btn._visible = true;
                movie.debug_btn.onRelease = com.clubpenguin.util.Delegate.create(this, debugButtonOnRelease);
                movie.debug_copy_btn._alpha = 65;
                movie.debug_copy_btn._visible = false;
                movie.debug_copy_btn.onRelease = com.clubpenguin.util.Delegate.create(this, debugCopyButtonOnRelease);
                movie.debug_clear_btn._alpha = 65;
                movie.debug_clear_btn._visible = false;
                movie.debug_clear_btn.onRelease = com.clubpenguin.util.Delegate.create(this, debugClearButtonOnRelease);
            }
            else
            {
                movie.debug_mc._visible = false;
                movie.debug_btn._visible = false;
                movie.debug_copy_btn._visible = false;
                movie.debug_clear_btn._visible = false;
                movie.debug_mc.removeMovieClip();
                movie.debug_btn.removeMovieClip();
                movie.debug_copy_btn.removeMovieClip();
                movie.debug_clear_btn.removeMovieClip();
            } // end else if
            this.initSprites();
            leaveRoom = "dojofire";
            movie.version_txt.text = com.clubpenguin.games.fire.Constants.VERSION_NUMBER;
            hasBootedHacker = false;
            var _loc2 = SHELL.getMyPlayerNickname();
            if (SHELL.isMyPlayerMember() && SHELL.isItemInMyInventory(STARTER_DECK_ITEM_ID) && SHELL.isItemInMyInventory(BLACK_BELT_ITEM_ID) && SHELL.isItemInMyInventory(FIRE_STARTER_DECK_ITEM_ID) && SHELL.isItemInMyInventory(AMULET_ITEM_ID))
            {
                validPlayer = true;
            }
            else
            {
                validPlayer = false;
            } // end else if
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("Nickname = " + _loc2);
                this.debugTrace("Is a member = " + SHELL.isMyPlayerMember());
                this.debugTrace("Has Card-Jitsu Starter Deck: " + SHELL.isItemInMyInventory(STARTER_DECK_ITEM_ID));
                this.debugTrace("Has Black Belt: " + SHELL.isItemInMyInventory(BLACK_BELT_ITEM_ID));
                this.debugTrace("Has Fire Starter Deck: " + SHELL.isItemInMyInventory(FIRE_STARTER_DECK_ITEM_ID));
                this.debugTrace("Has Amulet: " + SHELL.isItemInMyInventory(AMULET_ITEM_ID));
                this.debugTrace("ergo... validPlayer = " + validPlayer);
            } // end if
            initDone = true;
        } // end if
    } // End of the function
    function initNetClient()
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("initNetClient:");
        } // end if
        var _loc2 = SHELL.getCookie(SHELL.GAME_COOKIE, "game_fire").mode;
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("initNetClient");
            this.debugTrace("\t mode = " + _loc2);
        } // end if
        netClient = new com.clubpenguin.games.fire.NetClientFire(this);
        netClient.sendGetGameMessage(_loc2);
    } // End of the function
    function initCards(Void)
    {
        var mc;
        var q;
        this.hideCards();
        this.hideBattleCards();
        this.movie.battleCard_depth_holder.battle_card0.flame_icon._x = -75;
        for (q = 0; q < com.clubpenguin.games.fire.Constants.GAME_MAX_CARDS_PER_HAND; q++)
        {
            mc = eval(this.movie + ".card_depth_holder.card" + q);
            if (q == com.clubpenguin.games.fire.Constants.GAME_MAX_CARDS_PER_HAND - 1)
            {
                mc.artwork.hitarea_mc.gotoAndStop("big");
            }
            else
            {
                mc.artwork.hitarea_mc.gotoAndStop("small");
            } // end else if
            mc.hitArea = mc.artwork.hitarea_mc;
            mc.artwork.hitarea_mc._alpha = 0;
            mc.flame_icon._visible = false;
        } // end of for
    } // End of the function
    function playerTurnStart(Void)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("playerTurnStart:");
            this.debugTrace("\t playerMySeatId = " + playerMySeatId + ", playerActiveSeatId = " + playerActiveSeatId);
        } // end if
        this.hideBattleCards();
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            for (var _loc2 in serverMessageData)
            {
                this.debugTrace("\t serverMessageData[" + _loc2 + "] = " + serverMessageData[_loc2]);
            } // end of for...in
        } // end if
    } // End of the function
    function playerBattleStart(resArray)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("playerBattleStart:");
            this.debugObject("resArray", resArray);
        } // end if
        var battleType;
        var battleType;
        var battlingSeatIdList;
        var trumpSymbol;
        var q;
        var seatId;
        var cardPos;
        var battlingAmount;
        var remoteBattleOffset;
        var mc;
        var mc_frame;
        var mc_card;
        var symbolFullName = new Array();
        symbolFullName.f = "FIRE";
        symbolFullName.w = "WATER";
        symbolFullName.s = "SNOW";
        var battleType = resArray[2];
        var battlingSeatIdList = resArray[3].split(",");
        var trumpSymbol = resArray[4];
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t playerEnergyLevel[" + this.playerMySeatId + "] = " + this.playerEnergyLevel[this.playerMySeatId]);
            this.debugTrace("\t battlingSeatIdList = " + battlingSeatIdList.toString(":"));
            this.debugTrace("\t resArray[3].indexOf(" + this.playerMySeatId + ") = " + resArray[3].indexOf(this.playerMySeatId));
            this.debugTrace("\t trumpSymbol = " + trumpSymbol);
        } // end if
        battlingSeatIdList.sort();
        battlingAmount = battlingSeatIdList.length;
        for (q = 0; q < battlingAmount; q++)
        {
            if (this.playerEnergyLevel[battlingSeatIdList[q]] > 0)
            {
                this.portraitObjectRef[battlingSeatIdList[q]].setEmotion(com.clubpenguin.games.fire.PortraitConstants.EMOTION_BATTLING);
            } // end if
        } // end of for
        this.hideBattleFrames();
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t resArray[3].indexOf(" + this.playerMySeatId + ") = " + resArray[3].indexOf(this.playerMySeatId));
        } // end if
        remoteBattleOffset = 0;
        if (resArray[3].indexOf(this.playerMySeatId) == -1)
        {
            remoteBattleOffset = 1;
        } // end if
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t remoteBattleOffset = " + remoteBattleOffset);
        } // end if
        cardPos = 1;
        for (q = 0; q < battlingAmount; q++)
        {
            if (this.playerMySeatId == battlingSeatIdList[q])
            {
                mc_frame = eval(this.movie + ".battleFrame_depth_holder.battle_frame0");
                mc_frame._x = this.cardJumpTo[battlingAmount][0].x - 6;
                mc_frame._y = this.cardJumpTo[battlingAmount][0].y - 6;
                mc_frame._visible = true;
                mc_card = eval(this.movie + ".battleCard_depth_holder.battle_card0");
                mc_card._visible = false;
                mc_card._x = this.cardJumpTo[battlingAmount][0].x;
                mc_card._y = this.cardJumpTo[battlingAmount][0].y;
            }
            else
            {
                mc_frame = eval(this.movie + ".battleFrame_depth_holder.battle_frame" + cardPos);
                mc_frame._x = this.cardJumpTo[battlingAmount + remoteBattleOffset][cardPos].x - 6;
                mc_frame._y = this.cardJumpTo[battlingAmount + remoteBattleOffset][cardPos].y - 6;
                mc_frame._visible = true;
                mc_card = eval(this.movie + ".battleCard_depth_holder.battle_card" + cardPos);
                mc_card._visible = false;
                mc_card._x = this.cardJumpTo[battlingAmount + remoteBattleOffset][cardPos].x;
                mc_card._y = this.cardJumpTo[battlingAmount + remoteBattleOffset][cardPos].y;
                ++cardPos;
            } // end else if
            if (battleType == com.clubpenguin.games.fire.Constants.BATTLE_TYPE_TRUMP)
            {
                if (!this.hasTrump(trumpSymbol) && this.playerMySeatId == battlingSeatIdList[q])
                {
                    mc_frame.symbol.gotoAndStop("no-" + trumpSymbol);
                }
                else
                {
                    mc_frame.symbol.gotoAndStop(trumpSymbol);
                } // end else if
                continue;
            } // end if
            mc_frame.symbol.gotoAndStop("cardjitsu");
        } // end of for
        this.battleFrameBySeatId = new Array();
        var arrayPosition = -1;
        for (q = 0; q < battlingAmount; q++)
        {
            if (battlingSeatIdList[q] >= this.playerMySeatId)
            {
                arrayPosition = q;
                break;
            } // end if
        } // end of for
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t arrayPosition = " + arrayPosition);
        } // end if
        cardPos = 1;
        if (arrayPosition == -1)
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t seatId " + this.playerMySeatId + " is NOT in the battlingSeatIdList");
            } // end if
            for (q = 0; q < battlingAmount; q++)
            {
                this.battleFrameBySeatId[battlingSeatIdList[q]] = cardPos;
                ++cardPos;
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t " + q + ": battleFrameBySeatId[" + battlingSeatIdList[q] + "] = " + this.battleFrameBySeatId[battlingSeatIdList[q]]);
                } // end if
            } // end of for
        }
        else
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t seatId " + this.playerMySeatId + " EXISTS in the battlingSeatIdList");
            } // end if
            for (q = 0; q < battlingAmount; q++)
            {
                if (this.playerMySeatId == battlingSeatIdList[arrayPosition])
                {
                    this.battleFrameBySeatId[this.playerMySeatId] = 0;
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t (local)" + arrayPosition + ": battleFrameBySeatId[" + this.playerMySeatId + "] = " + this.battleFrameBySeatId[this.playerMySeatId]);
                    } // end if
                }
                else
                {
                    this.battleFrameBySeatId[battlingSeatIdList[arrayPosition]] = cardPos;
                    ++cardPos;
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t (remote)" + arrayPosition + ": battleFrameBySeatId[" + battlingSeatIdList[arrayPosition] + "] = " + this.battleFrameBySeatId[battlingSeatIdList[arrayPosition]]);
                    } // end if
                } // end else if
                if (++arrayPosition >= battlingAmount)
                {
                    arrayPosition = 0;
                } // end if
            } // end of for
        } // end else if
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t battlingSeatIdList = " + battlingSeatIdList.toString());
            this.debugTrace("\t battleFrameBySeatId = " + this.battleFrameBySeatId.toString());
        } // end if
        for (q = 0; q < battlingAmount; q++)
        {
            mc_frame = eval(this.movie + ".battleFrame_depth_holder.battle_frame" + this.battleFrameBySeatId[battlingSeatIdList[q]] + ".outline");
            this.setHighlightTint(mc_frame, com.clubpenguin.games.fire.Constants.HIGHLIGHT_COLOUR_ON[this.screenPositionBySeatId[battlingSeatIdList[q]]], 65);
        } // end of for
        if (this.playerEnergyLevel[this.playerMySeatId] > 0 && resArray[3].indexOf(this.playerMySeatId) > -1)
        {
            if (battleType == com.clubpenguin.games.fire.Constants.BATTLE_TYPE_TRUMP)
            {
                switch (trumpSymbol)
                {
                    case com.clubpenguin.games.fire.Constants.SYMBOL_FIRE:
                    {
                        this.setStatusText(com.clubpenguin.util.LocaleText.getText("text_battle_fire"));
                        break;
                    } 
                    case com.clubpenguin.games.fire.Constants.SYMBOL_WATER:
                    {
                        this.setStatusText(com.clubpenguin.util.LocaleText.getText("text_battle_water"));
                        break;
                    } 
                    case com.clubpenguin.games.fire.Constants.SYMBOL_SNOW:
                    {
                        this.setStatusText(com.clubpenguin.util.LocaleText.getText("text_battle_snow"));
                        break;
                    } 
                } // End of switch
                this.showChoosePopup(com.clubpenguin.games.fire.Constants.CHOOSE_CARD_MESSAGE, com.clubpenguin.games.fire.Constants.BATTLE_TYPE_TRUMP, trumpSymbol);
            }
            else if (battleType == com.clubpenguin.games.fire.Constants.BATTLE_TYPE_ENERGY)
            {
                this.setStatusText(com.clubpenguin.util.LocaleText.getText("text_battle_cardjitsu"));
                this.showChoosePopup(com.clubpenguin.games.fire.Constants.CHOOSE_CARD_MESSAGE, com.clubpenguin.games.fire.Constants.BATTLE_TYPE_ENERGY, null);
            }
            else if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("Critical: startPlayerBattle -- bad value, battleType = " + battleType);
            } // end else if
        } // end else if
    } // End of the function
    function playerBattleResolve(resArray)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("playerBattleResolve:");
            this.debugObject("resArray", resArray);
        } // end if
        var seatIdList = new Array();
        var cardIdList = new Array();
        var playerNewCards = new Array();
        var energyLevelList = new Array();
        var winStatusList = new Array();
        var q;
        var mc;
        var cardPos;
        var remoteBattleOffset;
        var playerBattleAmount;
        var tmpArray = new Array();
        var battleType = "";
        var winningSymbol = "";
        var battleAnimFrameName = "";
        var localPlayerInvolved;
        seatIdList = resArray[2].split(",");
        cardIdList = resArray[3].split(",");
        energyLevelList = resArray[4].split(",");
        winStatusList = resArray[5].split(",");
        tmpArray = resArray[6].split(",");
        battleType = tmpArray[0];
        winningSymbol = tmpArray[1];
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t battleType = " + battleType + ", winningSymbol = " + winningSymbol);
        } // end if
        playerNewCards = resArray[7].split(",");
        this.playerFinishPositionList = resArray[8].split(",");
        localPlayerInvolved = false;
        remoteBattleOffset = 1;
        if (resArray[2].indexOf(this.playerMySeatId) > -1)
        {
            localPlayerInvolved = true;
            remoteBattleOffset = 0;
        } // end if
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t remoteBattleOffset = " + remoteBattleOffset);
            this.debugTrace("\t localPlayerInvolved = " + localPlayerInvolved);
        } // end if
        cardPos = 1;
        playerBattleAmount = seatIdList.length;
        for (q = 0; q < playerBattleAmount; q++)
        {
            if (this.playerMySeatId == seatIdList[q])
            {
                if (localPlayerInvolved)
                {
                    var flagCardFound = false;
                    var i = 0;
                    while (i < this.playerCardList.length)
                    {
                        if (this.playerCardList[i] == cardIdList[q])
                        {
                            this.showBattleCardFace(i);
                            flagCardFound = true;
                            break;
                        } // end if
                        ++i;
                    } // end while
                    if (!flagCardFound)
                    {
                        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                        {
                            this.debugTrace("\t ERROR: Can\'t find battle card in the player\'s hand! ");
                        } // end if
                    } // end if
                } // end if
                continue;
            } // end if
            cardPos = this.battleFrameBySeatId[seatIdList[q]];
            mc = eval(this.movie + ".battleCard_depth_holder.battle_card" + cardPos);
            mc._x = this.cardJumpTo[playerBattleAmount + remoteBattleOffset][cardPos].x;
            mc._y = this.cardJumpTo[playerBattleAmount + remoteBattleOffset][cardPos].y;
            this.displayCard(mc, cardIdList[q]);
        } // end of for
        for (q = 0; q < seatIdList.length; q++)
        {
            mc = eval(this.movie + ".battleCard_depth_holder.battle_card" + this.battleFrameBySeatId[seatIdList[q]] + ".flame_icon.ring.fill");
            this.setHighlightTint(mc, com.clubpenguin.games.fire.Constants.HIGHLIGHT_COLOUR_ON[this.screenPositionBySeatId[seatIdList[q]]], 65);
        } // end of for
        for (q = 0; q < playerBattleAmount; q++)
        {
            this.playerEnergyLevel[seatIdList[q]] = energyLevelList[q];
            this.portraitObjectRef[seatIdList[q]].setEnergy(this.playerEnergyLevel[seatIdList[q]]);
            switch (parseInt(winStatusList[q]))
            {
                case com.clubpenguin.games.fire.Constants.BATTLE_STATE_UNDECIDED:
                {
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("Error: playerBattleResolve -- impossible value, winStatusList[" + q + "] is UNDECIDED (" + winStatusList[q] + ")");
                    } // end if
                    break;
                } 
                case com.clubpenguin.games.fire.Constants.BATTLE_STATE_LOSE:
                {
                    if (this.playerMySeatId == seatIdList[q])
                    {
                        this.setStatusText(com.clubpenguin.util.LocaleText.getText("text_battle_lost_energy"));
                    } // end if
                    this.portraitObjectRef[seatIdList[q]].setEmotion(com.clubpenguin.games.fire.PortraitConstants.EMOTION_OUCH);
                    break;
                } 
                case com.clubpenguin.games.fire.Constants.BATTLE_STATE_TIE:
                {
                    if (this.playerMySeatId == seatIdList[q])
                    {
                        this.setStatusText(com.clubpenguin.util.LocaleText.getText("text_battle_tie"));
                    } // end if
                    this.portraitObjectRef[seatIdList[q]].setEmotion(com.clubpenguin.games.fire.PortraitConstants.EMOTION_WAITING);
                    this.addSFX("tie", 1, 50);
                    break;
                } 
                case com.clubpenguin.games.fire.Constants.BATTLE_STATE_WIN_SYMBOL:
                {
                    if (this.playerMySeatId == seatIdList[q])
                    {
                        this.setStatusText(com.clubpenguin.util.LocaleText.getText("text_battle_won_neutral"));
                    } // end if
                    this.portraitObjectRef[seatIdList[q]].setEmotion(com.clubpenguin.games.fire.PortraitConstants.EMOTION_HAPPY);
                    break;
                } 
                case com.clubpenguin.games.fire.Constants.BATTLE_STATE_WIN_ENERGY:
                {
                    if (this.playerMySeatId == seatIdList[q])
                    {
                        this.setStatusText(com.clubpenguin.util.LocaleText.getText("text_battle_won_energy"));
                    } // end if
                    this.portraitObjectRef[seatIdList[q]].setEmotion(com.clubpenguin.games.fire.PortraitConstants.EMOTION_HAPPY);
                    break;
                } 
                default:
                {
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("Error: playerBattleResolve -- bad value for winStatusList[" + q + "] = " + winStatusList[q]);
                    } // end if
                    break;
                } 
            } // End of switch
        } // end of for
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("-------");
        } // end if
        cardPos = 1;
        for (q = 0; q < playerBattleAmount; q++)
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t playerMySeatId = " + this.playerMySeatId);
                this.debugTrace("\t seatIdList[" + q + "] = " + seatIdList[q]);
            } // end if
            if (this.playerMySeatId == seatIdList[q])
            {
                mc = eval(this.movie + ".battleCard_depth_holder.battle_card0");
            }
            else
            {
                cardPos = this.battleFrameBySeatId[seatIdList[q]];
                mc = eval(this.movie + ".battleCard_depth_holder.battle_card" + cardPos);
            } // end else if
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t mc = " + mc);
                this.debugTrace("\t winStatusList[" + q + "] = " + winStatusList[q]);
                if (!mc.battle_anim)
                {
                    this.debugTrace("\t Error: " + mc + ".battle_anim movieClip is missing/guided, game will be stuck waiting for it to finish!");
                } // end if
            } // end if
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t mc = " + mc);
                this.debugTrace("\t mc.flame_icon = " + mc.flame_icon);
            } // end if
            mc.flame_icon._visible = true;
            if (winStatusList[q] == com.clubpenguin.games.fire.Constants.BATTLE_STATE_LOSE)
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t setting flame_icon to \'-1\'");
                } // end if
                mc.flame_icon.amount_txt.text = "-1";
            }
            else if (winStatusList[q] == com.clubpenguin.games.fire.Constants.BATTLE_STATE_WIN_ENERGY)
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t setting flame_icon to \'+1\'");
                } // end if
                mc.flame_icon.amount_txt.text = "+1";
            }
            else
            {
                mc.flame_icon.amount_txt.text = "+0";
            } // end else if
            if (winStatusList[q] == com.clubpenguin.games.fire.Constants.BATTLE_STATE_LOSE)
            {
                mc.battle_anim._visible = true;
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t seatId " + seatIdList[q] + " has lost, starting battle_anim");
                } // end if
                mc.swapDepths(500);
            }
            else
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t seatId " + seatIdList[q] + " has won, turning off battle_anim");
                } // end if
                mc.battle_anim._visible = false;
            } // end else if
            if (battleType == com.clubpenguin.games.fire.Constants.BATTLE_TYPE_ENERGY && remoteBattleOffset == 1)
            {
                battleAnimFrameName = "bt-" + winningSymbol;
            }
            else if (winStatusList[q] == com.clubpenguin.games.fire.Constants.BATTLE_STATE_TIE)
            {
                battleAnimFrameName = "blank_anim";
            }
            else
            {
                battleAnimFrameName = battleType + "-" + winningSymbol;
            } // end else if
            mc.battle_anim.gotoAndStop(battleAnimFrameName);
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t battleAnimFrameName = " + battleAnimFrameName);
            } // end if
            if (remoteBattleOffset == 0 && battleType == com.clubpenguin.games.fire.Constants.BATTLE_TYPE_ENERGY)
            {
                if (this.playerMySeatId == seatIdList[q] && winStatusList[q] == com.clubpenguin.games.fire.Constants.BATTLE_STATE_LOSE)
                {
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("playerBattleResolve -- flipping ENERGY movie");
                    } // end if
                    mc.battle_anim.anim._xscale = Math.abs(mc.battle_anim.anim._xscale) * -1;
                    mc.battle_anim.anim._x = this.battleEnergyAnimOffsetFlip[winningSymbol];
                }
                else
                {
                    mc.battle_anim.anim._xscale = Math.abs(mc.battle_anim.anim._xscale);
                    mc.battle_anim.anim._x = this.battleEnergyAnimOffsetNormal[winningSymbol];
                } // end if
            } // end else if
            if (winStatusList[q] == com.clubpenguin.games.fire.Constants.BATTLE_STATE_LOSE)
            {
                mc.battle_mask.gotoAndStop(battleAnimFrameName);
                mc.battle_mask._visible = true;
                mc.artwork.setMask(mc.battle_mask.mask);
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t mc.battle_mask.mask = " + mc.battle_mask.mask);
                } // end if
            }
            else
            {
                mc.battle_mask._visible = false;
                mc.artwork.setMask(null);
            } // end else if
            mc.battle_mask.mask.gotoAndPlay(1);
            mc.battle_anim.anim.gotoAndPlay(1);
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t addWaitForAnimation(1) for playerBattleResolve");
            } // end if
            this.addWaitForAnimation(1);
            if (playerNewCards.length > 0)
            {
                this.playerCardList = playerNewCards;
            } // end if
        } // end of for
    } // End of the function
    function getGameMessage(resArray)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("getGameMessage");
            this.debugObject("resArray", resArray);
        } // end if
        serverMessageData.getGameMessage = resArray;
    } // End of the function
    function joinGameMessage(resArray)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("joinGameMessage");
            this.debugObject("resArray", resArray);
        } // end if
        serverMessageData.joinGameMessage = resArray;
        playerMySeatId = parseInt(resArray[1]);
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t playerMySeatId = " + playerMySeatId);
        } // end if
    } // End of the function
    function abortGameMessage(resArray)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("abortGameMessage:");
            this.debugTrace("\t SHOULD I IGNORE THIS MESSAGE?");
            this.debugObject("resArray", resArray);
        } // end if
    } // End of the function
    function updateGameMessage(resArray)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("updateGameMessage");
            this.debugObject("resArray", resArray);
        } // end if
        serverMessageData.updateGameMessage = resArray;
    } // End of the function
    function startGameMessage(resArray)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("startGameMessage");
            this.debugObject("resArray", resArray);
        } // end if
        serverMessageData.startGameMessage = resArray;
        var _loc3 = new Array();
        var _loc2;
        playerActiveSeatId = parseInt(resArray[1]);
        playerNicknames = resArray[2].split(",");
        playerAmount = playerNicknames.length;
        this.setSenseiMode(false);
        _loc3 = resArray[3].split(",");
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t tmpArray[" + _loc2 + "] = " + _loc3[_loc2]);
                this.debugTrace("\t Constants.PENGUIN_COLOURS[" + _loc3[_loc2] + "] = " + com.clubpenguin.games.fire.Constants.PENGUIN_COLOURS[_loc3[_loc2]]);
            } // end if
            if (_loc3[_loc2] == com.clubpenguin.games.fire.Constants.SENSEI_COLOUR_INDEX || _loc3[_loc2] == "9674916")
            {
                playerColorList[_loc2] = com.clubpenguin.games.fire.Constants.SENSEI_COLOUR;
                this.setSenseiMode(true);
                dLearning.setMode(3);
                continue;
            } // end if
            playerColorList[_loc2] = SHELL.getPlayerHexFromId(_loc3[_loc2]);
        } // end of for
        playerEnergyLevel = resArray[4].split(",");
        playerCurrentBoardId = resArray[5].split(",");
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t playerCurrentBoardId = " + playerCurrentBoardId.toString());
        } // end if
        boardObject.setPlayerList(playerCurrentBoardId);
        playerCardList = resArray[6].split(",");
        _loc3 = resArray[7].split(",");
        spinAmount = parseInt(_loc3[0]);
        moveClockwise = parseInt(_loc3[1]);
        moveCounterClockwise = parseInt(_loc3[2]);
        playerRank = resArray[8].split(",");
        playerScore = resArray[9].split(",");
    } // End of the function
    function closeGameMessage(resArray)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("closeGameMessage, ABORTING GAME!");
            this.debugObject("resArray", resArray);
        } // end if
        serverMessageData.closeGameMessage = resArray;
        if (!playerMyGameOver)
        {
            this.showChoosePopup("" + com.clubpenguin.games.fire.Constants.EXIT_ALL_QUIT, null, null);
            playerMyGameOver = true;
        } // end if
        gameState = com.clubpenguin.games.fire.Constants.STATE_GAME_OVER_PROCESSING;
    } // End of the function
    function playerActionMessage(resArray)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("playerActionMessage");
            this.debugObject("resArray", resArray);
        } // end if
        var _loc3;
        var _loc4;
        var _loc5 = new Array();
        _loc3 = resArray[1];
        _loc4 = parseInt(resArray[2]);
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t playerAction = " + _loc3);
            this.debugTrace("\t playerRecipientSeatId = " + _loc4);
            this.debugTrace("\t playerMySeatId = " + playerMySeatId);
        } // end if
        switch (_loc3)
        {
            case com.clubpenguin.games.fire.Constants.INFO_CLICK_SPINNER:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got INFO_CLICK_SPINNER");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.INFO_CLICK_SPINNER] = resArray;
                break;
            } 
            case com.clubpenguin.games.fire.Constants.INFO_CLICK_CARD:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got INFO_CLICK_CARD");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.INFO_CLICK_CARD] = resArray;
                break;
            } 
            case com.clubpenguin.games.fire.Constants.CHOOSE_BOARD_ID_MESSAGE:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got CHOOSE_BOARD_ID_MESSAGE");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.CHOOSE_BOARD_ID_MESSAGE] = resArray;
                break;
            } 
            case com.clubpenguin.games.fire.Constants.UPDATE_BOARD_ID_MESSAGE:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got UPDATE_BOARD_ID_MESSAGE");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.UPDATE_BOARD_ID_MESSAGE] = resArray;
                break;
            } 
            case com.clubpenguin.games.fire.Constants.CHOOSE_OPPONENT_MESSAGE:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got CHOOSE_OPPONENT_MESSAGE");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.CHOOSE_OPPONENT_MESSAGE] = resArray;
                break;
            } 
            case com.clubpenguin.games.fire.Constants.CHOOSE_TRUMP_MESSAGE:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got CHOOSE_TRUMP_MESSAGE");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.CHOOSE_TRUMP_MESSAGE] = resArray;
                break;
            } 
            case com.clubpenguin.games.fire.Constants.START_BATTLE_MESSAGE:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got START_BATTLE_MESSAGE");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.START_BATTLE_MESSAGE] = resArray;
                break;
            } 
            case com.clubpenguin.games.fire.Constants.BATTLE_TYPE_TRUMP:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got BATTLE_TYPE_TRUMP");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.BATTLE_TYPE_TRUMP] = resArray;
                break;
            } 
            case com.clubpenguin.games.fire.Constants.BATTLE_TYPE_ENERGY:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got BATTLE_TYPE_ENERGY");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.BATTLE_TYPE_ENERGY] = resArray;
                break;
            } 
            case com.clubpenguin.games.fire.Constants.RESOLVE_BATTLE_MESSAGE:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got RESOLVE_BATTLE_MESSAGE");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.RESOLVE_BATTLE_MESSAGE] = resArray;
                break;
            } 
            case com.clubpenguin.games.fire.Constants.CHOOSE_CARD_MESSAGE:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got CHOOSE_CARD_MESSAGE");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.CHOOSE_CARD_MESSAGE] = resArray;
                break;
            } 
            case com.clubpenguin.games.fire.Constants.START_NEXT_TURN_MESSAGE:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got START_NEXT_TURN_MESSAGE");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.START_NEXT_TURN_MESSAGE] = resArray;
                break;
            } 
            case com.clubpenguin.games.fire.Constants.FIRE_DEBUG_INFO:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got FIRE_DEBUG_INFO");
                } // end if
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugObject("\t resArray", resArray);
                } // end if
                break;
            } 
            case com.clubpenguin.games.fire.Constants.EARNED_NEW_RANK:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got EARNED_NEW_RANK");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.EARNED_NEW_RANK] = resArray;
                playerNewRank = parseInt(serverMessageData[com.clubpenguin.games.fire.Constants.EARNED_NEW_RANK][3]);
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t\t playerNewRank = " + playerNewRank);
                } // end if
                if (playerNewRank > 0 && playerNewRank < com.clubpenguin.games.fire.Constants.MAX_PATH_RANK)
                {
                    SHELL.addItemToInventory(com.clubpenguin.games.fire.Constants.FIRE_AWARD_ITEM[playerNewRank]);
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t\t ADDING NEW RANK ITEM:");
                        this.debugTrace("\t\t Constants.FIRE_AWARD_ITEM[" + playerNewRank + "] = " + com.clubpenguin.games.fire.Constants.FIRE_AWARD_ITEM[playerNewRank]);
                    } // end if
                } // end if
                break;
            } 
            case com.clubpenguin.games.fire.Constants.MESSAGE_TIMEOUT_BOARD:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got MESSAGE_TIMEOUT_BOARD");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.MESSAGE_TIMEOUT_BOARD] = resArray;
                playerAutoplayBoard = true;
                if (this.isLocalPlayerTurn() && !playerMyGameOver && !timeoutBoardHandled)
                {
                    this.timeoutRemoveAllHandlers();
                    timeoutBoardHandled = true;
                } // end if
                break;
            } 
            case com.clubpenguin.games.fire.Constants.MESSAGE_TIMEOUT_BATTLE:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got MESSAGE_TIMEOUT_BATTLE");
                } // end if
                serverMessageData[com.clubpenguin.games.fire.Constants.MESSAGE_TIMEOUT_BATTLE] = resArray;
                playerAutoplayBattle = true;
                if (!playerMyGameOver && !timeoutBattleHandled)
                {
                    this.timeoutRemoveAllHandlers();
                    timeoutBattleHandled = true;
                } // end if
                break;
            } 
            case com.clubpenguin.games.fire.Constants.MESSAGE_GAME_OVER:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got MESSAGE_GAME_OVER");
                } // end if
                if (serverMessageLock[com.clubpenguin.games.fire.Constants.MESSAGE_GAME_OVER])
                {
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t\t rec\'d multiple MESSAGE_GAME_OVER messages, ignoring this one");
                    } // end if
                }
                else
                {
                    serverMessageLock[com.clubpenguin.games.fire.Constants.MESSAGE_GAME_OVER] = true;
                    serverMessageData[com.clubpenguin.games.fire.Constants.MESSAGE_GAME_OVER] = resArray;
                    playerFinishPositionList = serverMessageData[com.clubpenguin.games.fire.Constants.MESSAGE_GAME_OVER][2].split(",");
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t\t playerFinishPositionList = " + playerFinishPositionList);
                    } // end if
                    if (this.validFinishCount(playerFinishPositionList, playerMySeatId, playerAmount) <= 0 || gameCurrentPhase == com.clubpenguin.games.fire.Constants.CURRENT_PHASE_BOARD)
                    {
                        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                        {
                            this.debugTrace("\t\t No other players have valid finish positions, ABORTING this game");
                        } // end if
                        gameState = com.clubpenguin.games.fire.Constants.STATE_GAME_OVER;
                    }
                    else if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t\t At least one other player has a valid finish position, continuing");
                    } // end else if
                } // end else if
                break;
            } 
            case com.clubpenguin.games.fire.Constants.MESSAGE_PLAYER_ABORT:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Got MESSAGE_PLAYER_ABORT");
                } // end if
                dropSeatId = parseInt(resArray[2]);
                playerAbortQueue.push(dropSeatId);
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t playerAbortQueue = [ " + playerAbortQueue + " ]");
                } // end if
                break;
            } 
            default:
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("Warning: playerActionMessage -- got bad value, playerAction = " + _loc3);
                } // end if
                break;
            } 
        } // End of switch
    } // End of the function
    function gameOverMessage(resArray)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("gameOverMessage");
            this.debugObject("resArray", resArray);
        } // end if
    } // End of the function
    function errorMessage(resArray)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("errorMessage");
            this.debugObject("resArray", resArray);
        } // end if
        serverMessageData[com.clubpenguin.games.fire.Constants.MESSAGE_ERROR] = resArray;
    } // End of the function
    function handleStartTurn(resArray)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("handleStartTurn");
        } // end if
        serverMessageData[com.clubpenguin.games.fire.Constants.MESSAGE_START_GAME] = resArray;
    } // End of the function
}
else
{
} // end else if
function updateGame()
{
    var netData = new Array();
    var q;
    var seatId;
    var mc = new MovieClip();
    var size;
    var tmpArray = new Array();
    var screenPos;
    var opponentSeatIdList = new Array();
    var activePlayers;
    var tabId;
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING && this.playerEnergyLevel[this.playerMySeatId] <= 0 && this.gameState != com.clubpenguin.games.fire.GameEngine.lastGameState)
    {
        this.debugTrace("gameState = " + this.gameState);
        lastGameState = this.gameState;
    } // end if
    if (!this.validPlayer && !this.isIgnoreMode)
    {
        this.gameState = com.clubpenguin.games.fire.Constants.STATE_PRESTART;
        this.serverMessageData.joinGameMessage = true;
    } // end if
    if (this.isIgnoreMode)
    {
        this.gameState = com.clubpenguin.games.fire.Constants.STATE_GAME_OVER_PROCESSING;
    } // end if
    switch (this.gameState)
    {
        case com.clubpenguin.games.fire.Constants.STATE_PRESTART:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_PRESTART");
            } // end if
            if (this.isAnimationComplete() && this.isMovieLoaded(this.movie) && this.serverMessageData.joinGameMessage)
            {
                if (this.gameInitTimeout <= 0)
                {
                    this.gameInitTimeout = getTimer() + com.clubpenguin.games.fire.Constants.GAME_MAX_INIT_TIMEOUT;
                    this.gameHackerTimeout = getTimer() + this.randomRange(com.clubpenguin.games.fire.Constants.GAME_MIN_HACKER_TIMEOUT, com.clubpenguin.games.fire.Constants.GAME_MAX_HACKER_TIMEOUT);
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\tSTATE_PRESTART: gameInitTimeout = " + this.gameInitTimeout);
                        this.debugTrace("\t\t\t  gameHackerTimeout = " + this.gameHackerTimeout);
                    } // end if
                } // end if
                this.gameLoadCountdown = this.gameInitTimeout - getTimer();
                if (this.gameLoadCountdown < 0)
                {
                    this.gameLoadCountdown = 0;
                } // end if
                this.movie.choose_popup.title_txt.text = Math.floor(this.gameLoadCountdown / 1000);
                if (this.serverMessageData.startGameMessage)
                {
                    if (!this.validPlayer)
                    {
                        if (!this.hasBootedHacker)
                        {
                            if (getTimer() >= this.gameHackerTimeout)
                            {
                                this.serverMessageData.startGameMessage = null;
                                this.netClient.sendLeaveGameMessage();
                                this.hasBootedHacker = true;
                            } // end if
                        } // end if
                    }
                    else
                    {
                        this.serverMessageData.startGameMessage = null;
                        this.serverMessageData.joinGameMessage = null;
                        this.gameState = com.clubpenguin.games.fire.Constants.STATE_INIT_PORTRAITS;
                    } // end else if
                }
                else if (getTimer() > this.gameInitTimeout)
                {
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("STATE_PRESTART: INITIALIZATION TIMEOUT, QUITTING GAME");
                        this.debugTrace("\t getTimer() = " + getTimer() + ", gameInitTimeout = " + this.gameInitTimeout);
                    } // end if
                    this.showChoosePopup("" + com.clubpenguin.games.fire.Constants.EXIT_ALL_QUIT, null, null);
                    this.playerMyGameOver = true;
                    this.gameState = com.clubpenguin.games.fire.Constants.STATE_GAME_OVER_PROCESSING;
                    this.isIgnoreMode = true;
                } // end if
            } // end else if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_INIT_PORTRAITS:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_INIT_PORTRAITS");
            } // end if
            if (!this.playerMyGameOver)
            {
                this.hideChoosePopup();
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t calling hideChoosePopup()");
                } // end if
            } // end if
            this.setupEmptyPortraits();
            for (q = 0; q < this.playerNicknames.length; q++)
            {
                mc = eval(this.portraitObjectRef[q].getMovie() + ".anchor");
                this.loadAsset(mc, "assets/avatar.swf", "emotion", false);
            } // end of for
            this.gameState = com.clubpenguin.games.fire.Constants.STATE_INIT_ASSETS;
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_INIT_ASSETS:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_INIT_ASSETS");
            } // end if
            if (this.assetLoadDone)
            {
                for (screenPos = 0; screenPos < this.playerNicknames.length; screenPos++)
                {
                    this.portraitObjectRef[this.seatIdByScreenPosition[screenPos]].setupArtwork(screenPos, this.playerColorList[this.seatIdByScreenPosition[screenPos]]);
                } // end of for
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_INIT_DONE;
                if (!this.playerMyGameOver)
                {
                    this.hideChoosePopup();
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t calling hideChoosePopup()");
                    } // end if
                } // end if
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_INIT_DONE:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_INIT_DONE");
            } // end if
            if (this.isAnimationComplete())
            {
                this.gameInit();
                this.gameIsReady = true;
                if (!this.playerMyGameOver)
                {
                    this.hideChoosePopup();
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t calling hideChoosePopup()");
                    } // end if
                } // end if
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_GAME_STARTED;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_GAME_STARTED:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_GAME_STARTED");
            } // end if
            if (this.isAnimationComplete())
            {
                if (!this.playerMyGameOver)
                {
                    this.hideChoosePopup();
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t calling hideChoosePopup()");
                    } // end if
                } // end if
                this.playerTurnStart();
                this.showSpinner();
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_SPINNER_RISE;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_SPINNER_RISE:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_SPINNER_RISE");
            } // end if
            if (this.isAnimationComplete())
            {
                this.enableSpinnerTablets(this.isLocalPlayerTurn());
                this.gameCurrentPhase = com.clubpenguin.games.fire.Constants.CURRENT_PHASE_BOARD;
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_SPINNER_WAITING;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_SPINNER_WAITING:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_SPINNER_WAITING");
            } // end if
            if (this.isAnimationComplete())
            {
                if (this.isLocalPlayerTurn())
                {
                    if (this.playerAutoplayBoard)
                    {
                        this.debugTrace("STATE_SPINNER_WAITING: <<< Autoplaying... >>>");
                        this.disableSpinnerTablets();
                        if (this.serverMessageData[com.clubpenguin.games.fire.Constants.UPDATE_BOARD_ID_MESSAGE])
                        {
                            tabId = parseInt(this.serverMessageData[com.clubpenguin.games.fire.Constants.UPDATE_BOARD_ID_MESSAGE][4]);
                            this.startSpinnerFlipping(tabId);
                        } // end if
                        this.serverMessageData[com.clubpenguin.games.fire.Constants.INFO_CLICK_SPINNER] = null;
                        this.gameState = com.clubpenguin.games.fire.Constants.STATE_SPINNER_ANIMATE;
                    } // end if
                }
                else if (this.serverMessageData[com.clubpenguin.games.fire.Constants.INFO_CLICK_SPINNER])
                {
                    tabId = parseInt(this.serverMessageData[com.clubpenguin.games.fire.Constants.INFO_CLICK_SPINNER][3]);
                    this.startSpinnerFlipping(tabId);
                    this.serverMessageData[com.clubpenguin.games.fire.Constants.INFO_CLICK_SPINNER] = null;
                    this.gameState = com.clubpenguin.games.fire.Constants.STATE_SPINNER_ANIMATE;
                }
                else if (this.serverMessageData[com.clubpenguin.games.fire.Constants.UPDATE_BOARD_ID_MESSAGE])
                {
                    tabId = parseInt(this.serverMessageData[com.clubpenguin.games.fire.Constants.UPDATE_BOARD_ID_MESSAGE][4]);
                    this.startSpinnerFlipping(tabId);
                    this.gameState = com.clubpenguin.games.fire.Constants.STATE_SPINNER_ANIMATE;
                } // end else if
            } // end else if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_SPINNER_ANIMATE:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_SPINNER_ANIMATE");
            } // end if
            if (this.isAnimationComplete())
            {
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_CHOOSE_MOVE;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_CHOOSE_MOVE:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_CHOOSE_MOVE");
            } // end if
            if (this.isLocalPlayerTurn() && this.isAnimationComplete() && !this.playerAutoplayBoard)
            {
                this.boardObject.highlightSpaces(this.moveClockwise, this.moveCounterClockwise, true, this.screenPositionBySeatId[this.playerActiveSeatId]);
            }
            else
            {
                this.boardObject.highlightSpaces(this.moveClockwise, this.moveCounterClockwise, false, this.screenPositionBySeatId[this.playerActiveSeatId]);
            } // end else if
            this.gameState = com.clubpenguin.games.fire.Constants.STATE_WAITING_FOR_MOVE_DATA;
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_WAITING_FOR_MOVE_DATA:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_WAITING_FOR_MOVE_DATA");
            } // end if
            if (this.isAnimationComplete() && this.serverMessageData[com.clubpenguin.games.fire.Constants.UPDATE_BOARD_ID_MESSAGE])
            {
                this.sinkSpinner();
                this.playerJumpPrepare(this.serverMessageData[com.clubpenguin.games.fire.Constants.UPDATE_BOARD_ID_MESSAGE]);
                this.serverMessageData[com.clubpenguin.games.fire.Constants.UPDATE_BOARD_ID_MESSAGE] = null;
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_JUMP_ANIMATE;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_JUMP_ANIMATE:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_JUMP_ANIMATE");
            } // end if
            if (!this.isAnimationComplete())
            {
                for (q = 0; q < this.playerAmount; q++)
                {
                    if (this.playerObjRef[q].isJumping())
                    {
                        this.playerObjRef[q].updateJump();
                    } // end if
                } // end of for
            }
            else
            {
                if (this.isLocalPlayerTurn())
                {
                    this.boardObject.resetHighlights();
                } // end if
                this.portraitObjectRef[this.playerActiveSeatId].setEmotion(com.clubpenguin.games.fire.PortraitConstants.EMOTION_BATTLING);
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_JUMP_ANIMATE_DONE;
            } // end else if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_JUMP_ANIMATE_DONE:
        {
            if (this.playerAutoplayBoard)
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("STATE_JUMP_ANIMATE_DONE: <<< Autoplaying... >>>");
                } // end if
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_BATTLE_WAIT_FOR_START;
                this.stopAndHideAllTimers();
            }
            else if (this.serverMessageData[com.clubpenguin.games.fire.Constants.CHOOSE_OPPONENT_MESSAGE])
            {
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_CHOOSE_OPPONENT;
            }
            else if (this.serverMessageData[com.clubpenguin.games.fire.Constants.CHOOSE_TRUMP_MESSAGE])
            {
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_CHOOSE_TRUMP;
            }
            else if (this.serverMessageData[com.clubpenguin.games.fire.Constants.START_BATTLE_MESSAGE])
            {
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_BATTLE_WAIT_FOR_START;
                this.stopAndHideAllTimers();
            } // end else if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_CHOOSE_OPPONENT:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_CHOOSE_OPPONENT");
                this.debugObject("serverMessageData[Constants.CHOOSE_OPPONENT_MESSAGE]", this.serverMessageData[com.clubpenguin.games.fire.Constants.CHOOSE_OPPONENT_MESSAGE]);
            } // end if
            if (this.isLocalPlayerTurn() && this.isAnimationComplete())
            {
                opponentSeatIdList = this.serverMessageData[com.clubpenguin.games.fire.Constants.CHOOSE_OPPONENT_MESSAGE][3].split(",");
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t >>> opponentSeatIdList.toString() = " + opponentSeatIdList.toString());
                } // end if
                if (opponentSeatIdList.length == 1)
                {
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t >>> Player " + opponentSeatIdList[0] + " is the only opponent, automatically selecting them");
                    } // end if
                    this.handleOpponentBtnOnRelease(opponentSeatIdList[0]);
                }
                else
                {
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t >>> Multiple opponents, player must choose one");
                    } // end if
                    this.setStatusText(com.clubpenguin.util.LocaleText.getText("text_battle_cardjitsu"));
                    this.showChoosePopup(com.clubpenguin.games.fire.Constants.BATTLE_TYPE_ENERGY, null, null);
                } // end if
            } // end else if
            this.serverMessageData[com.clubpenguin.games.fire.Constants.CHOOSE_OPPONENT_MESSAGE] = null;
            this.gameState = com.clubpenguin.games.fire.Constants.STATE_BATTLE_WAIT_FOR_START;
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_CHOOSE_TRUMP:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_CHOOSE_TRUMP");
            } // end if
            if (this.isLocalPlayerTurn() && this.isAnimationComplete())
            {
                this.showChoosePopup(com.clubpenguin.games.fire.Constants.BATTLE_TYPE_TRUMP, null, null);
            } // end if
            this.serverMessageData[com.clubpenguin.games.fire.Constants.CHOOSE_TRUMP_MESSAGE] = null;
            this.gameState = com.clubpenguin.games.fire.Constants.STATE_BATTLE_WAIT_FOR_START;
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_BATTLE_WAIT_FOR_START:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_BATTLE_WAIT_FOR_START");
            } // end if
            if (this.serverMessageData[com.clubpenguin.games.fire.Constants.START_BATTLE_MESSAGE] && this.isAnimationComplete())
            {
                if (this.playerAutoplayBoard)
                {
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("STATE_BATTLE_WAIT_FOR_START <<< Autoplaying... >>>");
                    } // end if
                    this.hideChoosePopup();
                } // end if
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_BATTLE_CHOOSE_CARD;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_BATTLE_CHOOSE_CARD:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_BATTLE_CHOOSE_CARD");
            } // end if
            if (this.serverMessageData[com.clubpenguin.games.fire.Constants.START_BATTLE_MESSAGE] && this.isAnimationComplete())
            {
                this.gameCurrentPhase = com.clubpenguin.games.fire.Constants.CURRENT_PHASE_BATTLE;
                this.playerBattleStart(this.serverMessageData[com.clubpenguin.games.fire.Constants.START_BATTLE_MESSAGE]);
                var battlingSeatIdList = this.serverMessageData[com.clubpenguin.games.fire.Constants.START_BATTLE_MESSAGE][3].split(",");
                var i = 0;
                while (i < battlingSeatIdList.length)
                {
                    this.timerObjectRef[battlingSeatIdList[i]].stop();
                    this.timerObjectRef[battlingSeatIdList[i]].setTime((com.clubpenguin.games.fire.Constants.BATTLE_TIMEOUT_VALUE - com.clubpenguin.games.fire.Constants.FUDGE) / 1000);
                    this.timerMovieRef[battlingSeatIdList[i]]._alpha = 100;
                    this.timerObjectRef[battlingSeatIdList[i]].start();
                    ++i;
                } // end while
                this.serverMessageData[com.clubpenguin.games.fire.Constants.START_BATTLE_MESSAGE] = null;
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_BATTLE_RESOLVE;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_BATTLE_RESOLVE:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_BATTLE_RESOLVE");
            } // end if
            if (this.serverMessageData[com.clubpenguin.games.fire.Constants.INFO_CLICK_CARD])
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("STATE_BATTLE_RESOLVE: got INFO_CLICK_CARD");
                } // end if
                var flipCardSeatId = parseInt(this.serverMessageData[com.clubpenguin.games.fire.Constants.INFO_CLICK_CARD][2]);
                this.showBattleCardBack(flipCardSeatId);
                if (this.playerEnergyLevel[flipCardSeatId] > 0 && !this.playerObjRef[flipCardSeatId].isFinished())
                {
                    this.timerObjectRef[flipCardSeatId].stop();
                    this.timerMovieRef[flipCardSeatId]._alpha = 0;
                } // end if
                this.serverMessageData[com.clubpenguin.games.fire.Constants.INFO_CLICK_CARD] = null;
            } // end if
            if (this.serverMessageData[com.clubpenguin.games.fire.Constants.RESOLVE_BATTLE_MESSAGE] && this.isAnimationComplete())
            {
                if (this.playerAutoplayBattle)
                {
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("STATE_BATTLE_RESOLVE <<< Autoplaying... >>>");
                    } // end if
                    var battlingSeatIdList = this.serverMessageData[com.clubpenguin.games.fire.Constants.RESOLVE_BATTLE_MESSAGE][2].split(",");
                    var cardIdList = this.serverMessageData[com.clubpenguin.games.fire.Constants.RESOLVE_BATTLE_MESSAGE][3].split(",");
                    var indexNum = -1;
                    var i = 0;
                    while (i < battlingSeatIdList.length)
                    {
                        if (battlingSeatIdList[i] == this.playerMySeatId)
                        {
                            indexNum = i;
                            break;
                        } // end if
                        ++i;
                    } // end while
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t Autoplaying: indexNum = " + indexNum);
                    } // end if
                    if (indexNum > -1)
                    {
                        var flagCardFound = false;
                        var i = 0;
                        while (i < this.playerCardList.length)
                        {
                            if (this.playerCardList[i] == cardIdList[indexNum])
                            {
                                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                                {
                                    this.debugTrace("\t Autoplaying: Found card in hand, moving to battle area");
                                } // end if
                                this.showBattleCardFace(i);
                                flagCardFound = true;
                                break;
                            } // end if
                            ++i;
                        } // end while
                        if (!flagCardFound)
                        {
                            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                            {
                                this.debugTrace("\t ERROR: auto-dealt card isn\'t in the player\'s hand! ");
                            } // end if
                        } // end if
                    } // end if
                }
                else if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("STATE_BATTLE_RESOLVE <<< Normal manual playing >>> ");
                } // end else if
                this.playerBattleResolve(this.serverMessageData[com.clubpenguin.games.fire.Constants.RESOLVE_BATTLE_MESSAGE]);
                this.serverMessageData[com.clubpenguin.games.fire.Constants.RESOLVE_BATTLE_MESSAGE] = null;
                this.stopAndHideAllTimers();
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_BATTLE_ANIMATE;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_BATTLE_ANIMATE:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_BATTLE_ANIMATE");
            } // end if
            if (this.isAnimationComplete())
            {
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_BATTLE_AFTERMATH;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_BATTLE_AFTERMATH:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_BATTLE_AFTERMATH");
            } // end if
            if (this.isAnimationComplete())
            {
                this.resetAutoPlay();
                this.hideBattleCards();
                this.hideBattleFrames();
                activePlayers = this.activePlayerCount();
                for (seatId = 0; seatId < this.playerAmount; seatId++)
                {
                    if (this.playerEnergyLevel[seatId] <= 0)
                    {
                        if (this.playerObjRef[seatId].isFinished() == false)
                        {
                            this.playerObjRef[seatId].setIsFinished();
                            this.playerObjRef[seatId].hide();
                            if (this.timerObjectRef[seatId])
                            {
                                this.timerObjectRef[seatId].stop();
                                this.timerObjectRef[seatId].destroy();
                                this.timerMovieRef[seatId]._alpha = 0;
                            } // end if
                            this.portraitObjectRef[seatId].disable(this.playerFinishPositionList[seatId]);
                            if (seatId == this.playerMySeatId)
                            {
                                this.hideCards();
                                this.playerMyGameOver = true;
                                if (activePlayers > 1)
                                {
                                    this.showChoosePopup("" + com.clubpenguin.games.fire.Constants.STATE_SPECTATE_OR_LEAVE, this.playerFinishPositionList[this.playerMySeatId], null);
                                } // end if
                            } // end if
                        } // end if
                        continue;
                    } // end if
                    if (activePlayers == 1)
                    {
                        this.playerMyGameOver = true;
                        this.portraitObjectRef[seatId].setFinishPosition(this.playerFinishPositionList[seatId]);
                    } // end if
                } // end of for
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_BATTLE_AFTERMATH_SYNC;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_BATTLE_AFTERMATH_SYNC:
        {
            if (this.isAnimationComplete())
            {
                netData.push(com.clubpenguin.games.fire.Constants.INFO_READY_SYNC);
                netData.push(this.playerMySeatId);
                this.netClient.sendPlayerActionMessage(netData);
                this.resetAutoPlay();
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_BATTLE_AFTERMATH_WAITING;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_BATTLE_AFTERMATH_WAITING:
        {
            if (this.isAnimationComplete())
            {
                if (this.serverMessageData[com.clubpenguin.games.fire.Constants.MESSAGE_GAME_OVER])
                {
                    this.playerFinishPositionList = this.serverMessageData[com.clubpenguin.games.fire.Constants.MESSAGE_GAME_OVER][2].split(",");
                    this.serverMessageData[com.clubpenguin.games.fire.Constants.MESSAGE_GAME_OVER] = null;
                    this.gameState = com.clubpenguin.games.fire.Constants.STATE_GAME_OVER;
                    this.playerMyGameOver = true;
                }
                else if (!this.playerMyGameOver && this.serverMessageData[com.clubpenguin.games.fire.Constants.START_NEXT_TURN_MESSAGE])
                {
                    this.gameState = com.clubpenguin.games.fire.Constants.STATE_NEW_TURN;
                }
                else if (!this.playerMyGameOver && this.serverMessageData[com.clubpenguin.games.fire.Constants.START_BATTLE_MESSAGE])
                {
                    this.gameState = com.clubpenguin.games.fire.Constants.STATE_BATTLE_WAIT_FOR_START;
                    if (this.playerMySeatId == this.playerActiveSeatId && this.playerEnergyLevel[this.playerMySeatId] > 0)
                    {
                        this.showAllCards(true);
                    } // end if
                }
                else if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("STATE_BATTLE_AFTERMATH_WAITING: current message queue is:");
                    for (var q in this.serverMessageData)
                    {
                        this.debugTrace("\t serverMessageData[" + q + "] = " + this.serverMessageData[q]);
                    } // end of for...in
                } // end else if
            } // end else if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_NEW_TURN:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_NEW_TURN");
            } // end if
            if (this.isAnimationComplete() && this.serverMessageData[com.clubpenguin.games.fire.Constants.START_NEXT_TURN_MESSAGE])
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                } // end if
                this.resetAutoPlay();
                this.boardObject.resetHighlights();
                this.hideBattleFrames();
                this.playerActiveSeatId = parseInt(this.serverMessageData[com.clubpenguin.games.fire.Constants.START_NEXT_TURN_MESSAGE][2]);
                tmpArray = this.serverMessageData[com.clubpenguin.games.fire.Constants.START_NEXT_TURN_MESSAGE][3].split(",");
                this.spinAmount = parseInt(tmpArray[0]);
                this.moveClockwise = parseInt(tmpArray[1]);
                this.moveCounterClockwise = parseInt(tmpArray[2]);
                if (this.playerEnergyLevel[this.playerMySeatId] > 0)
                {
                    this.playerCardList = this.serverMessageData[com.clubpenguin.games.fire.Constants.START_NEXT_TURN_MESSAGE][4].split(",");
                    this.showAllCards(true);
                } // end if
                this.playerTurnStart();
                this.showSpinner();
                this.serverMessageData[com.clubpenguin.games.fire.Constants.START_NEXT_TURN_MESSAGE] = null;
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_SPINNER_RISE;
                for (seatId = 0; seatId < this.playerAmount; seatId++)
                {
                    if (this.playerEnergyLevel[seatId] > 0)
                    {
                        if (this.playerActiveSeatId == seatId)
                        {
                            this.portraitObjectRef[seatId].setEmotion(com.clubpenguin.games.fire.PortraitConstants.EMOTION_THINKING);
                            continue;
                        } // end if
                        this.portraitObjectRef[seatId].setEmotion(com.clubpenguin.games.fire.PortraitConstants.EMOTION_WAITING);
                    } // end if
                } // end of for
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_GAME_OVER:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_GAME_OVER");
            } // end if
            if (this.isAnimationComplete())
            {
                this.resetAutoPlay();
                var finishCount = 0;
                var finishedLocal = false;
                if (this.playerFinishPositionList[this.playerMySeatId] > 0)
                {
                    finishedLocal = true;
                    this.playerMyGameOver = true;
                } // end if
                finishCount = this.validFinishCount(this.playerFinishPositionList, this.playerMySeatId, this.playerAmount);
                if (this.serverMessageData[com.clubpenguin.games.fire.Constants.EARNED_NEW_RANK])
                {
                    this.showChoosePopup("" + com.clubpenguin.games.fire.Constants.MESSAGE_GAME_OVER, this.playerFinishPositionList[this.playerMySeatId], com.clubpenguin.games.fire.Constants.EARNED_NEW_RANK);
                }
                else if (finishedLocal)
                {
                    if (finishCount <= 0)
                    {
                        this.showChoosePopup("" + com.clubpenguin.games.fire.Constants.EXIT_ALL_QUIT, null, null);
                    }
                    else
                    {
                        this.showChoosePopup("" + com.clubpenguin.games.fire.Constants.MESSAGE_GAME_OVER, this.playerFinishPositionList[this.playerMySeatId], null);
                        this.dLearning.gameOver(this.playerEnergyLevel[this.playerMySeatId], this.playerFinishPositionList[this.playerMySeatId]);
                    } // end else if
                }
                else if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t local player\'s finish level is 0, shouldn\'t be processing a game over message");
                } // end else if
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_GAME_OVER_PROCESSING;
                this.isIgnoreMode = true;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_AWARD_INTRO_WAITING:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_AWARD_INTRO_WAITING");
            } // end if
            if (this.isAnimationComplete())
            {
                this.resetAutoPlay();
                this.gameRemoveUserInterface();
                if (this.playerNewRank < 1 || this.playerNewRank > com.clubpenguin.games.fire.Constants.MAX_PATH_RANK)
                {
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t ERROR: bad value, playerNewRank = " + this.playerNewRank + ", defaulting to 1");
                    } // end if
                    this.playerNewRank = 1;
                } // end if
                this.movie.award_mc.sensei_art.items_mc.gotoAndStop("rank" + this.playerNewRank);
                if (this.playerNewRank < 5)
                {
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("movie = " + this.movie);
                        this.debugTrace("movie.award_mc = " + this.movie.award_mc);
                        this.debugTrace("movie.award_mc.btn_ok = " + this.movie.award_mc.btn_ok);
                        this.debugTrace("movie.award_mc.btn_ok_txt = " + this.movie.award_mc.btn_ok_txt);
                    } // end if
                    this.movie.award_mc.sensei_art.speech.message.text = com.clubpenguin.util.LocaleText.getText("text_award" + this.playerNewRank);
                    this.dLearning.earnedReward(this.playerNewRank);
                    this.movie.award_mc.btn_ok.onRelease = com.clubpenguin.util.Delegate.create(this, this.closeBtnHandleOnRelease, this.movie.award_mc.btn_ok);
                    this.movie.award_mc.btn_ok_txt.text = com.clubpenguin.util.LocaleText.getText("ui_btn_ok");
                }
                else
                {
                    this.dLearning.earnedGem();
                    this.movie.award_mc.btn_ok_txt.text = com.clubpenguin.util.LocaleText.getText("ui_btn_next");
                    this.movie.award_mc.sensei_art.speech.message.text = com.clubpenguin.util.LocaleText.getText("text_award5_part1");
                    this.movie.award_mc.btn_ok.onRelease = com.clubpenguin.util.Delegate.create(this, this.nextBtnFinalRewardHandleOnRelease, 2, this.movie.award_mc.btn_ok);
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t hasFireGem: " + this.hasFireGem);
                        this.debugTrace("\t hasWaterGem: " + this.hasWaterGem);
                        this.debugTrace("\t hasSnowGem: " + this.hasSnowGem);
                    } // end if
                    this.movie.award_mc.sensei_art.items_mc.item_art.amulet_art.gem_fire.gotoAndStop("empty");
                    if (this.hasWaterGem)
                    {
                        this.movie.award_mc.sensei_art.items_mc.item_art.amulet_art.gem_water.gotoAndStop("gem");
                    }
                    else
                    {
                        this.movie.award_mc.sensei_art.items_mc.item_art.amulet_art.gem_water.gotoAndStop("empty");
                    } // end else if
                    if (this.hasSnowGem)
                    {
                        this.movie.award_mc.sensei_art.items_mc.item_art.amulet_art.gem_snow.gotoAndStop("gem");
                    }
                    else
                    {
                        this.movie.award_mc.sensei_art.items_mc.item_art.amulet_art.gem_snow.gotoAndStop("empty");
                    } // end else if
                } // end else if
                this.gameState = com.clubpenguin.games.fire.Constants.STATE_GAME_OVER_PROCESSING;
                this.isIgnoreMode = true;
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_GAME_OVER_PROCESSING:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_GAME_OVER_PROCESSING");
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_TIMEOUT:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_TIMEOUT");
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_ABORT_GAME:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_ABORT_GAME");
            } // end if
            break;
        } 
        case com.clubpenguin.games.fire.Constants.STATE_BUG_OR_HACKER:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("STATE_BUG_OR_HACKER");
            } // end if
            break;
        } 
        default:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("updateGame: Error, got unknown gameState of " + this.gameState);
            } // end if
            break;
        } 
    } // End of switch
    while (this.gameIsReady && this.playerAbortQueue.length > 0 && !this.playerMyGameOver)
    {
        var dropSeatId = Number(this.playerAbortQueue.pop());
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("playerAbortQueue:");
            this.debugTrace("\t processing aborted player with dropSeatId = " + dropSeatId);
            this.debugTrace("\t remaining playerAbortQueue = [ " + this.playerAbortQueue + " ]");
        } // end if
        this.processAbortPlayerQueue(dropSeatId);
    } // end while
    if (this.flagAnimateBubbles)
    {
        if (this.bubbleTimerCount > com.clubpenguin.games.fire.Constants.BUBBLE_MAX_TIME)
        {
            this.bubbleTimerCount = 0;
            this.bubbleStart();
        }
        else
        {
            this.bubbleTimerCount = this.bubbleTimerCount + Math.ceil(Math.random() * com.clubpenguin.games.fire.Constants.BUBBLE_MAX_STEP);
        } // end if
    } // end else if
    if (this.flagAnimateFirepops)
    {
        if (this.firepopTimerCount > com.clubpenguin.games.fire.Constants.FIREPOP_MAX_TIME)
        {
            this.firepopTimerCount = 0;
            this.firepopStart();
        }
        else
        {
            this.firepopTimerCount = this.firepopTimerCount + Math.ceil(Math.random() * com.clubpenguin.games.fire.Constants.FIREPOP_MAX_STEP);
        } // end if
    } // end else if
} // End of the function
function gameInit(resArray)
{
    dLearning.startGame();
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("gameInit:");
        this.debugTrace("\t playerCurrentBoardId[" + playerMySeatId + "] = " + playerCurrentBoardId[playerMySeatId]);
        this.debugTrace("\t spinAmount = " + spinAmount);
    } // end if
    this.showAllCards(true);
    this.initPenguins();
    this.initTimers();
    SHELL.addListener(SHELL.GET_NINJA_RANKS, handleGetNinjaRanks, this);
    SHELL.sendGetNinjaRanks(SHELL.getMyPlayerId());
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("SHELL.getMyPlayerId() = " + SHELL.getMyPlayerId());
        this.debugTrace("SHELL.sendGetNinjaRanks = " + SHELL.sendGetNinjaRanks);
    } // end if
} // End of the function
function initPenguins(Void)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("initPenguins:");
    } // end if
    var seatId;
    var playerName = new String();
    var mc = new MovieClip();
    var tmpArray = new Array();
    var playerObj;
    this.dLearning.setNumberOfPlayers(this.playerNicknames.length);
    for (seatId = 0; seatId < this.playerNicknames.length; seatId++)
    {
        if (this.flagSenseiMode && seatId == 1)
        {
            playerName = "penguinSensei";
        }
        else
        {
            playerName = "penguin" + seatId;
        } // end else if
        mc = eval(this.movie.penguin_holder + "." + playerName);
        this.playerMovieRef[seatId] = mc;
        playerObj = new com.clubpenguin.games.fire.Player(mc, this, this.screenPositionBySeatId[seatId]);
        this.playerObjRef[seatId] = playerObj;
        this.playerObjRef[seatId].setColour(this.playerColorList[seatId]);
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t playerColorList[" + seatId + "] = " + this.playerColorList[seatId]);
        } // end if
        tmpArray = this.boardObject.getPositionData(this.playerCurrentBoardId[seatId], 1);
        this.playerObjRef[seatId].setStartPosition(tmpArray[0]);
    } // end of for
    for (seatId = this.playerNicknames.length; seatId < com.clubpenguin.games.fire.Constants.GAME_MAX_PLAYERS; seatId++)
    {
        playerName = "penguin" + seatId;
        mc = eval(this.movie.penguin_holder + "." + playerName);
        mc.removeMovieClip();
    } // end of for
} // End of the function
function initSprites(Void)
{
    var _loc2;
    var _loc1;
} // End of the function
function setSenseiMode(isOn)
{
    flagSenseiMode = isOn;
} // End of the function
function setSensei(seatId)
{
    var _loc1 = seatId;
} // End of the function
function isSensei(seatId)
{
    var _loc2;
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("isSensei:");
        this.debugTrace("\t senseiSeatId = " + _loc2);
        this.debugTrace("\t seatId = " + seatId);
    } // end if
    return (seatId == _loc2);
} // End of the function
function playerJumpPrepare(resArray)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("playerJumpPrepare");
        this.debugObject("\t rec\'d --> resArray", resArray);
    } // end if
    var _loc12 = 0;
    var _loc4 = new Array();
    var _loc5 = 0;
    var _loc6 = 0;
    var _loc9 = 0;
    var _loc7 = 0;
    var _loc8 = 0;
    var _loc10 = new Array();
    var _loc11 = new Array();
    var _loc3 = new Array();
    var _loc2;
    _loc12 = parseInt(resArray[2]);
    _loc4 = resArray[3].split(",");
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t playerSeatId = " + _loc12);
        this.debugTrace("\t boardIdList = " + _loc4.toString());
        this.debugTrace("\t\t ( resArray[3] = " + resArray[3].toString() + " )");
        this.debugTrace("\t playerCurrentBoardId = " + playerCurrentBoardId.toString());
    } // end if
    this.sinkSpinner();
    _loc5 = _loc4[_loc12];
    _loc6 = playerCurrentBoardId[_loc12];
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t newSpace = " + _loc5);
        this.debugTrace("\t oldSpace = " + _loc6);
    } // end if
    for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
    {
        if (_loc4[_loc2] == _loc6)
        {
            ++_loc7;
        } // end if
        if (_loc4[_loc2] == _loc5)
        {
            ++_loc9;
        } // end if
    } // end of for
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t newCount = " + _loc9);
        this.debugTrace("\t oldCount = " + _loc7);
    } // end if
    _loc10 = boardObject.getPositionData(_loc5, _loc9);
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugObject("\t newPos", _loc10);
    } // end if
    if (_loc7 > 0)
    {
        _loc11 = boardObject.getPositionData(_loc6, _loc7);
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugObject("\t oldPos", _loc11);
        } // end if
    } // end if
    _loc8 = 0;
    for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
    {
        if (_loc4[_loc2] == _loc5)
        {
            if (_loc9 == 1)
            {
                playerObjRef[_loc2].setBehaviour(new flash.geom.Point(380, 240), false);
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t only one penguin in NEW space, looking at BOARD CENTER");
                } // end if
            }
            else
            {
                _loc3 = boardObject.getPositionData(_loc5, 1);
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t tmpPos = " + _loc3);
                } // end if
                playerObjRef[_loc2].setBehaviour(new flash.geom.Point(_loc3[0].x, _loc3[0].y), true);
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t multiple penguins in NEW space, looking at SPACE CENTER with REACTION");
                } // end if
            } // end else if
            playerObjRef[_loc2].jumpTo(_loc10[_loc8++]);
            this.addWaitForAnimation(1);
            this.debugTrace("\t addWaitForAnimation for big jump to new space");
        } // end if
    } // end of for
    if (_loc7 > 0)
    {
        _loc8 = 0;
        for (var _loc2 = 0; _loc2 < playerCurrentBoardId.length; ++_loc2)
        {
            if (_loc4[_loc2] == _loc6)
            {
                playerObjRef[_loc2].jumpTo(_loc11[_loc8++]);
                this.addWaitForAnimation(1);
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t addWaitForAnimation for little jump in old space");
                } // end if
                if (_loc7 == 1)
                {
                    playerObjRef[_loc2].setBehaviour(new flash.geom.Point(380, 240), false);
                    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                    {
                        this.debugTrace("\t only one penguin in OLD space, looking at BOARD CENTER");
                    } // end if
                    continue;
                } // end if
                _loc3 = boardObject.getPositionData(_loc6, 1);
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t tmpPos = " + _loc3);
                } // end if
                playerObjRef[_loc2].setBehaviour(new flash.geom.Point(_loc3[0].x, _loc3[0].y), false);
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t multiple penguins in OLD space, looking at SPACE CENTER but no reaction");
                } // end if
            } // end if
        } // end of for
    } // end if
    playerCurrentBoardId = _loc4;
    boardObject.setPlayerList(playerCurrentBoardId);
} // End of the function
function showSpinner(Void)
{
    var _loc2;
    var _loc3;
    movie.spinner_mc._visible = true;
    this.addWaitForAnimation(1);
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("showSpinner:");
        this.debugTrace("\t addWaitForAnimation(1)");
    } // end if
    for (var _loc2 = 0; _loc2 < com.clubpenguin.games.fire.Constants.GAME_MAX_PLAYERS; ++_loc2)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t playerEnergyLevel[" + _loc2 + "] = " + playerEnergyLevel[_loc2]);
        } // end if
        if (playerEnergyLevel[_loc2] > 0)
        {
            if (_loc2 == playerActiveSeatId)
            {
                _loc3 = true;
            }
            else
            {
                _loc3 = false;
            } // end else if
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t isActive = " + _loc3);
                this.debugTrace("\t screenPositionBySeatId[" + _loc2 + "] = " + screenPositionBySeatId[_loc2]);
            } // end if
            playerObjRef[_loc2].showHighlight(screenPositionBySeatId[_loc2], _loc3);
            portraitObjectRef[_loc2].showHighlight(screenPositionBySeatId[_loc2], _loc3);
        } // end if
    } // end of for
    if (this.isLocalPlayerTurn() && playerEnergyLevel[playerMySeatId] > 0)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t It\'s my turn.");
        } // end if
        this.setStatusText(com.clubpenguin.util.LocaleText.getText("text_start_turn_local"));
        movie.spinner_mc.gotoAndPlay("rise");
        portraitObjectRef[playerMySeatId].setEmotion(com.clubpenguin.games.fire.PortraitConstants.EMOTION_THINKING);
    }
    else
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t It\'s NOT my turn.");
        } // end if
        this.setStatusText(com.clubpenguin.util.LocaleText.getTextReplaced("text_start_turn_remote", [playerNicknames[playerActiveSeatId].toUpperCase()]));
        if (playerEnergyLevel[playerActiveSeatId] > 0)
        {
            portraitObjectRef[playerActiveSeatId].setEmotion(com.clubpenguin.games.fire.PortraitConstants.EMOTION_THINKING);
        } // end if
        movie.spinner_mc.gotoAndPlay("rise");
        timerObjectRef[playerMySeatId].stop();
        timerMovieRef[playerMySeatId]._alpha = 0;
    } // end else if
    timerObjectRef[playerActiveSeatId].stop();
    timerObjectRef[playerActiveSeatId].setTime((com.clubpenguin.games.fire.Constants.BOARD_TIMEOUT_VALUE - com.clubpenguin.games.fire.Constants.FUDGE) / 1000);
    timerObjectRef[playerActiveSeatId].start();
    timerMovieRef[playerActiveSeatId]._alpha = 100;
} // End of the function
function enableSpinnerTablets(showSelect)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("enableSpinnerTablets:");
    } // end if
    var i;
    var mc_btn;
    var mc_tab;
    for (i = 1; i < 7; i++)
    {
        mc_btn = eval(this.movie.spinner_mc + ".tablet" + i + "_btn");
        mc_tab = eval(this.movie.spinner_mc + ".tab" + i);
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t mc_btn = " + mc_btn);
        } // end if
        if (showSelect)
        {
            mc_btn.onRelease = com.clubpenguin.util.Delegate.create(this, this.handleTabletOnRelease, i, mc_btn);
        }
        else if (mc_btn)
        {
            delete mc_btn.onRelease;
        } // end else if
        mc_tab.gotoAndStop(3);
    } // end of for
} // End of the function
function handleTabletOnRelease(tabId, btn_mc)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("handleTabletOnRelease:");
    } // end if
    var _loc2 = new Array();
    delete btn_mc.onRelease;
    if (tabId < 1 || tabId > 6)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("ERROR: handleTabletOnRelease, bad value: tabId = " + tabId);
        } // end if
        return;
    } // end if
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t tabId = " + tabId);
    } // end if
    this.disableSpinnerTablets();
    this.startSpinnerFlipping(tabId);
    gameState = com.clubpenguin.games.fire.Constants.STATE_SPINNER_ANIMATE;
    _loc2.push(com.clubpenguin.games.fire.Constants.INFO_CLICK_SPINNER);
    _loc2.push(playerMySeatId);
    _loc2.push(tabId);
    netClient.sendPlayerActionMessage(_loc2);
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t sendPlayerActionMessage called");
    } // end if
} // End of the function
function disableSpinnerTablets(Void)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("disableSpinnerTablets:");
    } // end if
    var i;
    var mc_btn;
    var mc_tab;
    for (i = 1; i < 7; i++)
    {
        mc_btn = eval(this.movie.spinner_mc + ".tablet" + i + "_btn");
        mc_tab = eval(this.movie.spinner_mc + ".tab" + i);
        if (mc_btn)
        {
            delete mc_btn.onRelease;
            mc_btn._visible = false;
            continue;
        } // end if
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t Button not found --> mc_btn = " + mc_btn);
        } // end if
    } // end of for
} // End of the function
function startSpinnerFlipping(tabId)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("startSpinnerFlipping:");
    } // end if
    var i;
    var currentNum;
    var currentTab;
    var mc_btn;
    var mc_tab;
    var showFlare;
    currentNum = this.spinAmount;
    currentTab = tabId;
    this.movie.spinner_mc.gotoAndStop("flip");
    for (i = 1; i < 7; i++)
    {
        mc_tab = eval(this.movie.spinner_mc + ".tab" + currentTab);
        mc_tab.gotoAndPlay(3);
        showFlare = false;
        if (tabId == currentTab)
        {
            showFlare = true;
            this.addSFX("spinnerFlare", 1, 100);
        } // end if
        mc_tab.flipTablet(currentNum, showFlare);
        if (++currentNum > 6)
        {
            currentNum = 1;
        } // end if
        if (++currentTab > 6)
        {
            currentTab = 1;
        } // end if
    } // end of for
    this.addWaitForAnimation(6);
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t addWaitForAnimation(6) for startSpinnerFlipping");
    } // end if
} // End of the function
function hideSpinner(Void)
{
    movie.spinner_mc._visible = false;
    movie.spinner_mc.gotoAndStop(1);
} // End of the function
function sinkSpinner(Void)
{
    var i;
    var mc_tab;
    this.movie.spinner_mc.gotoAndPlay("sink");
    for (i = 1; i < 7; i++)
    {
        mc_tab = eval(this.movie.spinner_mc + ".tab" + i + ".number" + i);
        mc_tab._visible = false;
    } // end of for
} // End of the function
function showAllCards(reloadArtwork)
{
    var mc;
    var q;
    for (q = 0; q < com.clubpenguin.games.fire.Constants.GAME_MAX_CARDS_PER_HAND; q++)
    {
        mc = eval(this.movie + ".card_depth_holder.card" + q);
        delete mc.onRelease;
        this.displayCard(mc, this.playerCardList[q], reloadArtwork);
    } // end of for
} // End of the function
function displayCard(mc, cardId, loadIcon)
{
    var cardAttribute = new Array();
    var tmpColour;
    if (loadIcon == null || loadIcon == undefined)
    {
        loadIcon = true;
    } // end if
    mc.artwork.gotoAndStop("front");
    mc.battle_anim._visible = false;
    cardAttribute = this.cardIndex[cardId].split("|");
    if (cardId < 1 || cardId >= this.cardTotalAmount)
    {
        cardId = 1;
    } // end if
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        if (cardId > 0 && cardId < this.cardTotalAmount)
        {
        }
        else
        {
            this.debugTrace("\t cardId = " + cardId + " (ERROR: should be between 1 and " + this.cardTotalAmount + ")");
        } // end else if
        if (cardAttribute.length == 5)
        {
        }
        else
        {
            this.debugTrace("\t cardAttribute [parsed] = " + cardAttribute + " (ERROR: non-standard card data, should be 5 fields in this format: 1,f,3,b,0)");
        } // end if
    } // end else if
    mc.artwork.mc_atr.gotoAndStop(cardAttribute[1]);
    mc.artwork.mc_pt.tf_pt.text = cardAttribute[2];
    tmpColour = new Color(mc.artwork.mc_col);
    tmpColour.setRGB(this.cardBorderColour[cardAttribute[3]]);
    if (parseInt(cardAttribute[4]) > 0)
    {
        mc.artwork.mc_glow.gotoAndPlay("glow_on");
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
        } // end if
        tmpColour = new Color(mc.artwork.mc_glow);
        tmpColour.setTransform(this.cardGlowColour[cardAttribute[3]]);
        mc.artwork.mc_glow._visible = true;
    }
    else
    {
        mc.artwork.mc_glow.gotoAndStop("glow_off");
        mc.artwork.mc_glow._visible = false;
    } // end else if
    mc._visible = true;
    if (loadIcon)
    {
        var mc_card = eval(mc + ".artwork.mc_art");
        var iconName = "/card/icons/" + cardId + ".swf";
        this.loadAsset(mc_card, iconName, "cardArt", true);
    } // end if
} // End of the function
function setupEmptyPortraits(Void)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("setupEmptyPortraits:");
    } // end if
    var mc = new MovieClip();
    var portraitName = "";
    var seatId = 0;
    var q = 0;
    var screenPos;
    seatId = this.playerMySeatId;
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t playerMySeatId = " + this.playerMySeatId);
        this.debugTrace("\t seatId = " + seatId);
        this.debugTrace("\t playerAmount = " + this.playerAmount);
    } // end if
    for (screenPos = 0; screenPos < com.clubpenguin.games.fire.Constants.GAME_MAX_PLAYERS; screenPos++)
    {
        mc = eval(this.movie + ".avatar" + screenPos);
        mc._visible = false;
    } // end of for
    for (screenPos = 0; screenPos < this.playerAmount; screenPos++)
    {
        this.seatIdByScreenPosition[screenPos] = seatId;
        this.screenPositionBySeatId[seatId] = screenPos;
        this.portraitObjectRef[seatId] = new com.clubpenguin.games.fire.Portrait(this, this.movie, this.playerNicknames[seatId], this.playerEnergyLevel[seatId], screenPos);
        if (++seatId >= this.playerAmount)
        {
            seatId = 0;
        } // end if
    } // end of for
    for (q = 0; q < com.clubpenguin.games.fire.Constants.GAME_MAX_PLAYERS; q++)
    {
        mc = eval(this.movie + ".avatar" + q);
        mc.highlight_frame._visible = false;
    } // end of for
} // End of the function
function loadAsset(mc, assetURL, assetName, flagCacheAsBitmap)
{
    var _loc6 = new Object();
    var _loc10 = new MovieClipLoader();
    assetLoadDone = false;
    if (flagCacheAsBitmap == null || flagCacheAsBitmap == undefined)
    {
        flagCacheAsBitmap = false;
    } // end if
    assetList[assetName] = mc.createEmptyMovieClip(assetName, 1);
    assetList[assetName]._visible = false;
    ++assetLoadingCount;
    _loc6.onLoadInit = com.clubpenguin.util.Delegate.create(this, handleAssetLoadComplete, flagCacheAsBitmap, assetList[assetName]);
    _loc6.onLoadError = com.clubpenguin.util.Delegate.create(this, handleAssetLoadError);
    var _loc3 = mc._url.split("/");
    var _loc5 = 1;
    if (assetURL.charAt(0) == "/")
    {
        _loc5 = 2;
        assetURL = assetURL.substr(1);
    } // end if
    var _loc4 = "";
    for (var _loc2 = 0; _loc2 < _loc3.length - _loc5; ++_loc2)
    {
        _loc4 = _loc4 + (_loc3[_loc2] + "/");
    } // end of for
    _loc10.addListener(_loc6);
    _loc10.loadClip(_loc4 + assetURL, assetList[assetName]);
} // End of the function
function handleAssetLoadComplete(asset_mc, flagCache)
{
    if (--assetLoadingCount == 0)
    {
        assetLoadDone = true;
    } // end if
    asset_mc.cacheAsBitmap = flagCache;
} // End of the function
function handleAssetLoadError()
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("handleAssetLoadError");
    } // end if
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t assetLoadingCount = " + assetLoadingCount);
        this.debugTrace("CRITICAL: Can\'t finish loading assests, one or more has failed, assetLoadingCount = " + assetLoadingCount);
    } // end if
    if (--assetLoadingCount == 0)
    {
        assetLoadDone = true;
    } // end if
} // End of the function
function getPlayerMovieRef(Void)
{
    return (playerMovieRef);
} // End of the function
function getPlayerDepthList(Void)
{
    var _loc4 = new Array();
    var _loc3;
    var _loc2;
    for (var _loc3 = 0; _loc3 < playerAmount; ++_loc3)
    {
        if (playerEnergyLevel[_loc3] > 0)
        {
            _loc2 = playerObjRef[_loc3].getCurrentPos();
            if (_loc2.y < 10)
            {
                _loc2.y = "00" + _loc2.y;
            }
            else if (_loc2.y < 100)
            {
                _loc2.y = "0" + _loc2.y;
            } // end else if
            _loc2.seatId = _loc3;
            _loc4.push(_loc2);
        } // end if
    } // end of for
    _loc4.sortOn("y");
    return (_loc4);
} // End of the function
function initTimers(Void)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("initTimers:");
    } // end if
    var _loc3;
    var _loc5;
    var _loc2;
    var _loc4 = new MovieClip();
    _loc2 = playerMySeatId;
    for (var _loc3 = 0; _loc3 < playerAmount; ++_loc3)
    {
        _loc5 = "timer" + _loc2;
        _loc4 = movie.createEmptyMovieClip(_loc5, movie.getNextHighestDepth());
        _loc4.attachMovie("timer_lib", "timer_mc", 1);
        _loc4._alpha = 0;
        timerMovieRef[_loc2] = _loc4;
        timerObjectRef[_loc2] = new com.clubpenguin.games.fire.GameTimer(timerMovieRef[_loc2].timer_mc, this);
        timerObjectRef[_loc2].setPosition(timerPosition[_loc3].x, timerPosition[_loc3].y);
        timerObjectRef[_loc2].setSize(timerSize[_loc3], timerSize[_loc3]);
        timerObjectRef[_loc2].setCallback(this, timerHandler, _loc2);
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t timerMovieRef[" + _loc2 + "] = " + timerMovieRef[_loc2]);
            this.debugTrace("\t timerMovieRef[" + _loc2 + "].timer_mc = " + timerMovieRef[_loc2].timer_mc);
            this.debugTrace("\t timerObjectRef[" + _loc2 + "] = " + timerObjectRef[_loc2]);
        } // end if
        if (++_loc2 >= playerAmount)
        {
            _loc2 = 0;
        } // end if
    } // end of for
} // End of the function
function timerHandler(playerNum)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace(">>> Player " + playerNum + " has timed out!");
    } // end if
    if (!playerMyGameOver && playerNum == playerMySeatId)
    {
        if (gameCurrentPhase == com.clubpenguin.games.fire.Constants.CURRENT_PHASE_BOARD && !timeoutBoardHandled && !playerAutoplayBoard)
        {
            this.timeoutRemoveAllHandlers();
            timeoutBoardHandled = true;
        }
        else if (gameCurrentPhase == com.clubpenguin.games.fire.Constants.CURRENT_PHASE_BATTLE && !timeoutBattleHandled && !playerAutoplayBattle)
        {
            this.timeoutRemoveAllHandlers();
            timeoutBattleHandled = true;
        } // end if
    } // end else if
} // End of the function
function stopAndHideAllTimers(Void)
{
    for (var _loc2 = 0; _loc2 < playerAmount; ++_loc2)
    {
        if (playerEnergyLevel[_loc2] > 0)
        {
            timerObjectRef[_loc2].stop();
            timerMovieRef[_loc2]._alpha = 0;
        } // end if
    } // end of for
} // End of the function
function stopAllActiveTimers(Void)
{
    for (var _loc2 = 0; _loc2 < playerAmount; ++_loc2)
    {
        if (playerEnergyLevel[_loc2] > 0 && !playerObjRef[_loc2].isFinished())
        {
            timerObjectRef[_loc2].setTime(0);
            timerObjectRef[_loc2].stop();
        } // end if
    } // end of for
} // End of the function
function timeoutRemoveAllHandlers(Void)
{
    var mc;
    var q;
    this.disableSpinnerTablets();
    this.hideChoosePopup();
    this.boardObject.removeOnRelease();
    for (q = 1; q < com.clubpenguin.games.fire.Constants.GAME_MAX_PLAYERS; q++)
    {
        mc = eval(this.movie + ".avatar" + q);
        mc.highlight_frame._visible = false;
        delete mc.onRelease;
        delete mc.onRollOver;
    } // end of for
    for (q = 0; q < com.clubpenguin.games.fire.Constants.GAME_MAX_CARDS_PER_HAND; q++)
    {
        mc = eval(this.movie + ".card_depth_holder.card" + q);
        delete mc.onRelease;
        delete mc.onRollOver;
        mc = eval(this.movie + ".choose_popup.btn" + q);
        delete mc.onRelease;
        delete mc.onRollOver;
    } // end of for
    this.stopAllActiveTimers();
} // End of the function
function gameRemoveUserInterface(Void)
{
    var _loc2;
    delete movie.closeBtn.onRelease;
    movie.closeBtn.enabled = false;
    movie.closeBtn._visible = false;
    boardObject.resetHighlights();
    this.hideChoosePopup();
    this.hideCards();
    this.hideBattleCards();
    this.hideSpinner();
    for (var _loc2 = 0; _loc2 < com.clubpenguin.games.fire.Constants.GAME_MAX_PLAYERS; ++_loc2)
    {
        if (timerObjectRef[_loc2])
        {
            timerObjectRef[_loc2].stop();
            timerObjectRef[_loc2].destroy();
            timerMovieRef[_loc2].removeMovieClip();
        } // end if
        if (playerObjRef[_loc2])
        {
            playerObjRef[_loc2].hide();
            playerObjRef[_loc2].destroy();
        } // end if
        if (portraitObjectRef[_loc2])
        {
            portraitObjectRef[_loc2].hide();
            portraitObjectRef[_loc2].destroy();
        } // end if
    } // end of for
    this.bubbleDestroyAll();
    this.firepopDestroyAll();
} // End of the function
function gameCleanupAndExit(Void)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("gameCleanupAndExit:");
    } // end if
    gameState = com.clubpenguin.games.fire.Constants.STATE_GAME_OVER_PROCESSING;
    isIgnoreMode = true;
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t removing user interface...");
    } // end if
    this.gameRemoveUserInterface();
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t freeing memory...");
    } // end if
    this.freeGameMemory(com.clubpenguin.games.fire.GameEngine.instance);
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t sending abort game to netClient...");
    } // end if
    if (!hasBootedHacker)
    {
        netClient.sendLeaveGameMessage();
    } // end if
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t destroying netClient...");
    } // end if
    netClient.destroy();
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t gameCleanupAndExit is done!");
    } // end if
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t leaveRoom = " + leaveRoom);
    } // end if
    if (endOfGameStampObject.stampIds.length > 0)
    {
        dLearning.endGame(playerEnergyLevel[playerMySeatId]);
        var _loc3 = _global.getCurrentInterface();
        _loc3.showEndGameScreen(endOfGameStampObject, null, leaveRoom, true);
    }
    else
    {
        dLearning.endGame(playerEnergyLevel[playerMySeatId]);
        SHELL.sendJoinRoom(leaveRoom, 380 + Math.floor(Math.random() * 30) - 15, 285 + Math.floor(Math.random() * 30));
    } // end else if
} // End of the function
function hideAwardIntro(Void)
{
    movie.award_mc.gotoAndStop(1);
    movie.award_mc._visible = false;
} // End of the function
function showAwardIntro(Void)
{
    movie.award_mc.gotoAndPlay(1);
    movie.award_mc._visible = true;
} // End of the function
function hideChoosePopup(Void)
{
    movie.choose_popup._visible = false;
} // End of the function


function showChoosePopup(displayType, battleType, trumpSymbol)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("showChoosePopup:");
        this.debugTrace("\t displayType = " + displayType);
    } // end if
    var screenPos;
    var btn_mc;
    var avatar_mc;
    var card_mc;
    var positionId;
    var q;
    if (displayType == com.clubpenguin.games.fire.Constants.BATTLE_TYPE_TRUMP)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t BATTLE_TYPE_TRUMP:");
        } // end if
        this.movie.choose_popup.gotoAndStop("trump");
        this.movie.choose_popup._visible = true;
        this.movie.choose_popup.title_txt.text = com.clubpenguin.util.LocaleText.getText("text_choose_element_lc");
        this.movie.choose_popup.btn1.onRelease = com.clubpenguin.util.Delegate.create(this, this.handleTrumpBtnOnRelease, com.clubpenguin.games.fire.Constants.SYMBOL_FIRE, this.movie.choose_popup.btn1);
        this.movie.choose_popup.btn2.onRelease = com.clubpenguin.util.Delegate.create(this, this.handleTrumpBtnOnRelease, com.clubpenguin.games.fire.Constants.SYMBOL_SNOW, this.movie.choose_popup.btn2);
        this.movie.choose_popup.btn3.onRelease = com.clubpenguin.util.Delegate.create(this, this.handleTrumpBtnOnRelease, com.clubpenguin.games.fire.Constants.SYMBOL_WATER, this.movie.choose_popup.btn3);
        this.movie.choose_popup.btn1.onRollOver = com.clubpenguin.util.Delegate.create(this, this.displayValidCardsByTrump, com.clubpenguin.games.fire.Constants.SYMBOL_FIRE);
        this.movie.choose_popup.btn2.onRollOver = com.clubpenguin.util.Delegate.create(this, this.displayValidCardsByTrump, com.clubpenguin.games.fire.Constants.SYMBOL_SNOW);
        this.movie.choose_popup.btn3.onRollOver = com.clubpenguin.util.Delegate.create(this, this.displayValidCardsByTrump, com.clubpenguin.games.fire.Constants.SYMBOL_WATER);
        this.movie.choose_popup.btn1.onRollOut = com.clubpenguin.util.Delegate.create(this, this.showAllCards, false);
        this.movie.choose_popup.btn2.onRollOut = com.clubpenguin.util.Delegate.create(this, this.showAllCards, false);
        this.movie.choose_popup.btn3.onRollOut = com.clubpenguin.util.Delegate.create(this, this.showAllCards, false);
    }
    else if (displayType == com.clubpenguin.games.fire.Constants.BATTLE_TYPE_ENERGY)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t BATTLE_TYPE_ENERGY:");
        } // end if
        this.movie.choose_popup.gotoAndStop("opponent");
        this.movie.choose_popup._visible = true;
        for (screenPos = 1; screenPos < com.clubpenguin.games.fire.Constants.GAME_MAX_PLAYERS; screenPos++)
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t\t playerEnergyLevel[" + this.seatIdByScreenPosition[screenPos] + "] = " + this.playerEnergyLevel[this.seatIdByScreenPosition[screenPos]]);
            } // end if
            avatar_mc = eval(this.movie + ".avatar" + screenPos);
            if (this.playerEnergyLevel[this.seatIdByScreenPosition[screenPos]] > 0 && !this.portraitObjectRef[this.seatIdByScreenPosition[screenPos]].isDisabled())
            {
                if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
                {
                    this.debugTrace("\t\t Position " + screenPos + " has energy and hasn\'t ever been disabled, ENABLING opponent button");
                } // end if
                avatar_mc.onRelease = com.clubpenguin.util.Delegate.create(this, this.handleOpponentBtnOnRelease, this.seatIdByScreenPosition[screenPos]);
                avatar_mc.highlight_frame._visible = true;
                continue;
            } // end if
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t\t Position " + screenPos + " has no energy, DISABLING opponent button");
            } // end if
            avatar_mc.highlight_frame._visible = false;
            delete avatar_mc.onRelease;
        } // end of for
    }
    else if (displayType == com.clubpenguin.games.fire.Constants.CHOOSE_CARD_MESSAGE)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t CHOOSE_CARD_MESSAGE:");
        } // end if
        this.movie.choose_popup.gotoAndStop("card");
        this.movie.choose_popup._visible = true;
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t battleType = " + battleType);
            this.debugTrace("\t trumpSymbol = " + trumpSymbol);
            this.debugTrace("\t hasTrump(" + trumpSymbol + ") = " + this.hasTrump(trumpSymbol) + "\n-----------");
        } // end if
        for (positionId = 0; positionId < com.clubpenguin.games.fire.Constants.GAME_MAX_CARDS_PER_HAND; positionId++)
        {
            card_mc = eval(this.movie + ".card_depth_holder.card" + positionId);
            btn_mc = eval(this.movie + ".choose_popup.btn" + positionId);
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t playerCardList[" + positionId + "] = " + this.playerCardList[positionId]);
                this.debugTrace("\t cardSymbol[" + this.playerCardList[positionId] + "] = " + this.cardSymbol[this.playerCardList[positionId]]);
            } // end if
            if (battleType == com.clubpenguin.games.fire.Constants.BATTLE_TYPE_ENERGY || !this.hasTrump(trumpSymbol) || this.hasTrump(trumpSymbol) && this.cardSymbol[this.playerCardList[positionId]] == trumpSymbol)
            {
                btn_mc.enabled = true;
                btn_mc._visible = true;
                btn_mc.onRelease = com.clubpenguin.util.Delegate.create(this, this.handleCardBtnOnRelease, positionId, btn_mc, card_mc);
                card_mc.onRelease = com.clubpenguin.util.Delegate.create(this, this.handleCardBtnOnRelease, positionId, btn_mc, card_mc);
                card_mc.battle_anim._visible = false;
                this.displayCard(card_mc, this.playerCardList[positionId], false);
                continue;
            } // end if
            btn_mc.enabled = false;
            btn_mc._visible = false;
            delete btn_mc.onRelease;
            delete card_mc.onRelease;
            delete card_mc.onRollOver;
            card_mc.artwork.gotoAndStop("disabled");
            card_mc.artwork.mc_glow.gotoAndStop("glow_off");
            card_mc.artwork.mc_glow._visible = false;
        } // end of for
    }
    else if (displayType == com.clubpenguin.games.fire.Constants.MESSAGE_GAME_OVER)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t MESSAGE_GAME_OVER:");
        } // end if
        this.gameRemoveUserInterface();
        this.addSFX("win", 1, 100);
        this.movie.choose_popup.gotoAndStop("gameover");
        this.movie.choose_popup.scroll_mc.clips_mc.setMask(this.movie.choose_popup.scroll_mc.scrollMask_mc);
        this.movie.choose_popup._visible = true;
        this.movie.choose_popup.scroll_mc.clips_mc.gotoAndStop(battleType);
        this.movie.choose_popup.scroll_mc.starAnim_mc.gotoAndStop(battleType);
        if (this.flagSenseiMode && battleType == 2)
        {
            this.movie.choose_popup.scroll_mc.clips_mc.title_txt.text = com.clubpenguin.util.LocaleText.getText("ui_dialog_title_lose_to_sensei");
            this.movie.choose_popup.scroll_mc.clips_mc.message_txt.text = com.clubpenguin.util.LocaleText.getText("ui_dialog_haiku_lose_to_sensei");
        }
        else
        {
            this.movie.choose_popup.scroll_mc.clips_mc.title_txt.text = com.clubpenguin.util.LocaleText.getText("ui_dialog_title" + battleType);
            this.movie.choose_popup.scroll_mc.clips_mc.message_txt.text = com.clubpenguin.util.LocaleText.getText("ui_dialog_haiku" + battleType);
        } // end else if
        this.movie.choose_popup.scroll_mc.starAnim_mc.star_mc.superScript_mc.text_txt.text = com.clubpenguin.util.LocaleText.getText("ui_after_num" + battleType);
        btn_mc = eval(this.movie + ".choose_popup.scroll_mc.clips_mc.btn_watch_txt");
        btn_mc.text = "";
        btn_mc = eval(this.movie + ".choose_popup.scroll_mc.clips_mc.btn_watch");
        btn_mc.enabled = false;
        btn_mc._visible = false;
        delete btn_mc.onRelease;
        btn_mc = eval(this.movie + ".choose_popup.scroll_mc.clips_mc.btn_done_txt");
        btn_mc.text = "";
        btn_mc = eval(this.movie + ".choose_popup.scroll_mc.clips_mc.btn_done");
        btn_mc.enabled = false;
        btn_mc._visible = false;
        delete btn_mc.onRelease;
        btn_mc = eval(this.movie + ".choose_popup.scroll_mc.clips_mc.btn_ok_txt");
        btn_mc.text = com.clubpenguin.util.LocaleText.getText("ui_btn_ok");
        btn_mc = eval(this.movie + ".choose_popup.scroll_mc.clips_mc.btn_ok");
        btn_mc.enabled = true;
        btn_mc._visible = true;
        if (trumpSymbol == com.clubpenguin.games.fire.Constants.EARNED_NEW_RANK)
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t button will do: EARNED_NEW_RANK:");
            } // end if
            btn_mc.onRelease = com.clubpenguin.util.Delegate.create(this, this.okBtnHandleOnReleaseGainedRank, btn_mc);
        }
        else
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("\t button will do: CLOSE_GAME:");
            } // end if
            btn_mc.onRelease = com.clubpenguin.util.Delegate.create(this, this.closeBtnHandleOnRelease, btn_mc);
        } // end else if
    }
    else if (displayType == com.clubpenguin.games.fire.Constants.STATE_SPECTATE_OR_LEAVE)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t STATE_SPECTATE_OR_LEAVE:");
        } // end if
        this.movie.choose_popup.gotoAndStop("gameover");
        this.movie.choose_popup.scroll_mc.clips_mc.setMask(this.movie.choose_popup.scroll_mc.scrollMask_mc);
        this.movie.choose_popup._visible = true;
        this.movie.choose_popup.scroll_mc.clips_mc.gotoAndStop(battleType);
        this.movie.choose_popup.scroll_mc.starAnim_mc.gotoAndStop(battleType);
        this.movie.choose_popup.scroll_mc.clips_mc.title_txt.text = com.clubpenguin.util.LocaleText.getText("ui_dialog_title" + battleType);
        this.movie.choose_popup.scroll_mc.clips_mc.message_txt.text = com.clubpenguin.util.LocaleText.getText("ui_dialog_haiku" + battleType);
        this.movie.choose_popup.scroll_mc.starAnim_mc.star_mc.superScript_mc.text_txt.text = com.clubpenguin.util.LocaleText.getText("ui_after_num" + battleType);
        btn_mc = eval(this.movie + ".choose_popup.scroll_mc.clips_mc.btn_ok_txt");
        btn_mc.text = com.clubpenguin.util.LocaleText.getText("ui_btn_ok");
        btn_mc = eval(this.movie + ".choose_popup.scroll_mc.clips_mc.btn_ok");
        btn_mc.enabled = true;
        btn_mc._visible = true;
        btn_mc.onRelease = com.clubpenguin.util.Delegate.create(this, this.closeBtnHandleOnRelease, btn_mc);
    }
    else if (displayType == com.clubpenguin.games.fire.Constants.EXIT_ALL_QUIT)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t EXIT_ALL_QUIT:");
        } // end if
        this.gameRemoveUserInterface();
        this.movie.choose_popup.gotoAndStop("allquit");
        this.movie.choose_popup._visible = true;
        this.movie.choose_popup.blocker_btn.enabled = false;
        this.movie.choose_popup.title_txt.text = com.clubpenguin.util.LocaleText.getText("text_abort_game");
        btn_mc = eval(this.movie + ".choose_popup.btn_ok_txt");
        btn_mc.text = com.clubpenguin.util.LocaleText.getText("ui_btn_ok");
        btn_mc = eval(this.movie + ".choose_popup.btn_ok");
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("showChoosePopup: EXIT_ALL_QUIT -- btn_mc = " + btn_mc);
        } // end if
        btn_mc.enabled = true;
        btn_mc._visible = true;
        btn_mc.onRelease = com.clubpenguin.util.Delegate.create(this, this.closeBtnHandleOnRelease, btn_mc);
    }
    else if (displayType == com.clubpenguin.games.fire.Constants.GAME_LOADING)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t GAME_LOADING:");
        } // end if
        this.movie.choose_popup.gotoAndStop("game_load");
        this.movie.choose_popup._visible = true;
        this.movie.choose_popup.title_txt.text = Math.floor(this.gameLoadCountdown / 1000);
    }
    else if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("Critical: showChoosePopup -- bad value, displayType = " + displayType);
    } // end else if
} // End of the function
function hasTrump(trumpSymbol)
{
    var _loc2;
    for (var _loc2 = 0; _loc2 < com.clubpenguin.games.fire.Constants.GAME_MAX_CARDS_PER_HAND; ++_loc2)
    {
        if (cardSymbol[playerCardList[_loc2]] == trumpSymbol)
        {
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function displayValidCardsByTrump(trumpSymbol)
{
    var positionId;
    var card_mc;
    for (positionId = 0; positionId < com.clubpenguin.games.fire.Constants.GAME_MAX_CARDS_PER_HAND; positionId++)
    {
        card_mc = eval(this.movie + ".card_depth_holder.card" + positionId);
        if (trumpSymbol == this.cardSymbol[this.playerCardList[positionId]] || trumpSymbol == com.clubpenguin.games.fire.Constants.SYMBOL_NONE)
        {
            card_mc.battle_anim._visible = false;
            this.displayCard(card_mc, this.playerCardList[positionId], false);
            continue;
        } // end if
        card_mc.artwork.gotoAndStop("disabled");
        card_mc.artwork.mc_glow.gotoAndStop("glow_off");
        card_mc.artwork.mc_glow._visible = false;
    } // end of for
} // End of the function
function processAbortPlayerQueue(seatId)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("processAbortPlayerQueue");
    } // end if
    if (seatId == playerMySeatId || seatId < 0 || seatId > playerAmount)
    {
        if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
        {
            this.debugTrace("\t ERROR: bad value, seatId = " + seatId + ", playerMySeatId = " + playerMySeatId);
        } // end if
        return;
    } // end if
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t processing aborted player with seatId = " + seatId);
    } // end if
    if (playerObjRef[seatId].isFinished() == false)
    {
        playerObjRef[seatId].setIsFinished();
        if (timerObjectRef[seatId])
        {
            timerObjectRef[seatId].stop();
            timerObjectRef[seatId].destroy();
            timerMovieRef[seatId].removeMovieClip();
        } // end if
        if (playerObjRef[seatId])
        {
            playerObjRef[seatId].hide();
            playerObjRef[seatId].destroy();
        } // end if
        playerObjRef[seatId].hide();
        portraitObjectRef[seatId].disable(com.clubpenguin.games.fire.Constants.FIRE_RANK_PLAYER_QUIT);
    } // end if
    if (this.activePlayerCount() == 1)
    {
        playerMyGameOver = true;
    } // end if
} // End of the function
function handleTrumpBtnOnRelease(symbolId, btn_mc)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("handleTrumpBtnOnRelease:");
        this.debugTrace("\t Chose the " + symbolId + " symbolId");
    } // end if
    var _loc2 = new Array();
    delete btn_mc.onRelease;
    this.showAllCards(false);
    this.hideChoosePopup();
    timerObjectRef[playerMySeatId].stop();
    timerMovieRef[playerMySeatId]._alpha = 0;
    _loc2.push(com.clubpenguin.games.fire.Constants.CHOOSE_TRUMP_MESSAGE);
    _loc2.push(symbolId);
    netClient.sendPlayerActionMessage(_loc2);
} // End of the function
function handleOpponentBtnOnRelease(opponentSeatId)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("handleOpponentBtnOnRelease:");
        this.debugTrace("\t Chose opponent # " + opponentSeatId);
    } // end if
    var netData = new Array();
    var q;
    var avatar_mc;
    for (q = 1; q < com.clubpenguin.games.fire.Constants.GAME_MAX_PLAYERS; q++)
    {
        avatar_mc = eval(this.movie + ".avatar" + q);
        avatar_mc.highlight_frame._visible = false;
        delete avatar_mc.onRelease;
    } // end of for
    this.hideChoosePopup();
    this.timerObjectRef[this.playerMySeatId].stop();
    this.timerMovieRef[this.playerMySeatId]._alpha = 0;
    netData.push(com.clubpenguin.games.fire.Constants.CHOOSE_OPPONENT_MESSAGE);
    netData.push(opponentSeatId);
    this.netClient.sendPlayerActionMessage(netData);
} // End of the function
function handleCardBtnOnRelease(handPositionId, btn_mc, card_mc)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("handleCardBtnOnRelease:");
        this.debugTrace("\t Chosen card # " + handPositionId);
    } // end if
    var _loc2 = new Array();
    delete btn_mc.onRelease;
    delete card_mc.onRelease;
    timerObjectRef[playerMySeatId].stop();
    timerMovieRef[playerMySeatId]._alpha = 0;
    this.showBattleCardFace(handPositionId);
    _loc2.push(com.clubpenguin.games.fire.Constants.CHOOSE_CARD_MESSAGE);
    _loc2.push(handPositionId);
    netClient.sendPlayerActionMessage(_loc2);
} // End of the function
function showBattleCardBack(seatId)
{
    var mc;
    mc = eval(this.movie + ".battleCard_depth_holder.battle_card" + this.battleFrameBySeatId[seatId]);
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("showBattleCardBack:");
        this.debugTrace("\t seatId = " + seatId);
        this.debugTrace("\t battleFrameBySeatId[" + seatId + "] = " + this.battleFrameBySeatId[seatId]);
        this.debugTrace("\t mc = " + mc);
    } // end if
    mc.artwork.setMask(null);
    mc.artwork.gotoAndStop("back");
    mc.artwork.mc_glow._visible = false;
    mc.artwork.mc_glow.gotoAndStop("glow_off");
    mc.flame_icon._visible = false;
    mc._visible = true;
} // End of the function
function showBattleCardFace(handPositionId)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("showBattleCardFace:");
    } // end if
    var mc_hand;
    var mc_battle;
    var btn_mc;
    var q;
    for (q = 0; q < com.clubpenguin.games.fire.Constants.GAME_MAX_CARDS_PER_HAND; q++)
    {
        mc_hand = eval(this.movie + ".card_depth_holder.card" + q);
        delete mc_hand.onRelease;
        delete mc_hand.onRollOver;
        btn_mc = eval(this.movie + ".choose_popup.btn" + q);
        delete btn_mc.onRelease;
        delete btn_mc.onRollOver;
    } // end of for
    this.hideChoosePopup();
    mc_hand = eval(this.movie + ".card_depth_holder.card" + handPositionId);
    mc_hand._visible = false;
    mc_battle = eval(this.movie + ".battleCard_depth_holder.battle_card0");
    this.displayCard(mc_battle, this.playerCardList[handPositionId]);
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t handPositionId = " + handPositionId);
        this.debugTrace("\t playerCardList[" + handPositionId + "] = " + this.playerCardList[handPositionId]);
        this.debugTrace("\t mc_hand = " + mc_hand);
        this.debugTrace("\t mc_battle = " + mc_battle);
    } // end if
    mc_battle.artwork.setMask(null);
} // End of the function
function handleBoardOnRelease(Void)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("handleBoardOnRelease:");
    } // end if
    var mc;
    if (this.boardObject.getChosenMove() == this.moveClockwise)
    {
        mc = eval(this.movie.board_mc + ".space" + this.moveClockwise + ".stone_mc");
        delete mc.onRelease;
        mc.gotoAndStop("remote");
        mc = eval(this.movie.board_mc + ".space" + this.moveCounterClockwise + ".stone_mc");
        delete mc.onRelease;
        mc.gotoAndStop("normal");
    }
    else
    {
        mc = eval(this.movie.board_mc + ".space" + this.moveClockwise + ".stone_mc");
        delete mc.onRelease;
        mc.gotoAndStop("normal");
        mc = eval(this.movie.board_mc + ".space" + this.moveCounterClockwise + ".stone_mc");
        delete mc.onRelease;
        mc.gotoAndStop("remote");
    } // end else if
    var netData = new Array();
    netData.push(com.clubpenguin.games.fire.Constants.CHOOSE_BOARD_ID_MESSAGE);
    netData.push(this.boardObject.getChosenMove());
    this.netClient.sendPlayerActionMessage(netData);
} // End of the function
function watchBtnHandleOnRelease(Void)
{
    var _loc2 = this;
    delete _loc2.onRelease;
    this.hideChoosePopup();
} // End of the function
function closeBtnHandleOnRelease(btn_mc)
{
    var _loc6;
    var _loc5;
    var _loc4 = 0;
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("closeBtnHandleOnRelease: <--------------------------");
    } // end if
    delete btn_mc.onRelease;
    btn_mc.enabled = false;
    closeBtnClicked = true;
    if (endOfGameStampObject)
    {
        this.gameCleanupAndExit();
    }
    else
    {
        stampInfoAbort = _global.setTimeout(abortStampInfoRequest, 3000);
        netClient.sendLeaveGameMessage();
    } // end else if
} // End of the function
function abortStampInfoRequest()
{
    endOfGameStampObject = new Object();
    endOfGameStampObject.stampIds = new Array();
    this.gameCleanupAndExit();
} // End of the function
function nextBtnFinalRewardHandleOnRelease(step, btn_mc)
{
    delete btn_mc.onRelease;
    switch (step)
    {
        case 1:
        {
            movie.award_mc.btn_ok_txt.text = com.clubpenguin.util.LocaleText.getText("ui_btn_next");
            movie.award_mc.btn_ok.onRelease = com.clubpenguin.util.Delegate.create(this, nextBtnFinalRewardHandleOnRelease, 2, movie.award_mc.btn_ok);
            movie.award_mc.sensei_art.speech.message.text = com.clubpenguin.util.LocaleText.getText("text_award5_part" + step);
            break;
        } 
        case 2:
        {
            movie.award_mc.btn_ok_txt.text = com.clubpenguin.util.LocaleText.getText("ui_btn_next");
            movie.award_mc.btn_ok.onRelease = com.clubpenguin.util.Delegate.create(this, nextBtnFinalRewardHandleOnRelease, 3, movie.award_mc.btn_ok);
            movie.award_mc.sensei_art.speech.message.text = com.clubpenguin.util.LocaleText.getText("text_award5_part" + step);
            break;
        } 
        case 3:
        {
            movie.award_mc.btn_ok_txt.text = com.clubpenguin.util.LocaleText.getText("ui_btn_ok");
            movie.award_mc.btn_ok.onRelease = com.clubpenguin.util.Delegate.create(this, closeBtnHandleOnRelease, movie.award_mc.btn_ok);
            movie.award_mc.sensei_art.speech.message.text = com.clubpenguin.util.LocaleText.getTextReplaced("text_award5_part3", [playerNicknames[playerMySeatId]]);
            break;
        } 
        default:
        {
            if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
            {
                this.debugTrace("Incorrect Final Reward step: " + step);
            } // end if
        } 
    } // End of switch
} // End of the function
function okBtnHandleOnReleaseGainedRank(btn_mc)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("okBtnHandleOnReleaseGainedRank:");
    } // end if
    btn_mc.enabled = false;
    delete btn_mc.onRelease;
    this.gameRemoveUserInterface();
    movie.bkg_topArt.removeMovieClip();
    movie.bkg_frontArt.removeMovieClip();
    movie.board_mc.removeMovieClip();
    this.showAwardIntro();
    this.addWaitForAnimation(1);
    isIgnoreMode = false;
    gameState = com.clubpenguin.games.fire.Constants.STATE_AWARD_INTRO_WAITING;
} // End of the function
function handleGetNinjaRanks(event)
{
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("[AMULET ITEM - PAPER DOLL] handleGetNinjaRanks() -> firePathRank: " + event.firePathRank + " / waterPathRank: " + event.waterPathRank + " / snowPathRank: " + event.snowPathRank);
    } // end if
    SHELL.removeListener(SHELL.GET_NINJA_RANKS, handleGetNinjaRanks);
    hasFireGem = event.firePathRank >= com.clubpenguin.games.fire.Constants.MAX_PATH_RANK ? (true) : (false);
    hasWaterGem = event.waterPathRank >= com.clubpenguin.games.fire.Constants.MAX_PATH_RANK ? (true) : (false);
    hasSnowGem = event.snowPathRank >= com.clubpenguin.games.fire.Constants.MAX_PATH_RANK ? (true) : (false);
    if (com.clubpenguin.games.fire.GameEngine.DEBUG_LOGGING)
    {
        this.debugTrace("\t hasFireGem: " + hasFireGem);
        this.debugTrace("\t hasWaterGem: " + hasWaterGem);
        this.debugTrace("\t hasSnowGem: " + hasSnowGem);
    } // end if
} // End of the function
function validFinishCount(finishPositions, excludeSeatId, maxPosition)
{
    var _loc3 = 0;
    for (var _loc1 = 0; _loc1 < finishPositions.length; ++_loc1)
    {
        if (_loc1 != excludeSeatId && finishPositions[_loc1] != 0 && finishPositions[_loc1] <= maxPosition)
        {
            ++_loc3;
        } // end if
    } // end of for
    return (_loc3);
} // End of the function
function onStampInfoRecieved(stampInfo)
{
    _global.clearTimeout(stampInfoAbort);
    endOfGameStampObject = new Object();
    endOfGameStampObject.isCardJitsu = true;
    endOfGameStampObject.is_table = false;
    endOfGameStampObject.numberOfGameStamps = parseInt(String(stampInfo.pop()));
    endOfGameStampObject.totalNumberOfGameStampsEarned = parseInt(String(stampInfo.pop()));
    var _loc5 = new Array();
    var _loc4 = String(stampInfo[0]).split("|");
    while (_loc4.length > 0)
    {
        var _loc3 = parseInt(String(_loc4.pop()));
        if (_loc3 && !isNaN(_loc3))
        {
            _loc5.push(_loc3);
        } // end if
    } // end while
    endOfGameStampObject.stampIds = _loc5;
    if (closeBtnClicked)
    {
        this.gameCleanupAndExit();
    } // end if
} // End of the function
static var DEBUG_LOGGING = false;
var STARTER_DECK_ITEM_ID = 821;
var BLACK_BELT_ITEM_ID = 4033;
var FIRE_STARTER_DECK_ITEM_ID = 8006;
var AMULET_ITEM_ID = 3032;
var closeBtnClicked = false;
