class com.clubpenguin.games.fire.Board
{
    var movie, game, chosenMove, highlightMovie;
    function Board(ref_mc, game_ref)
    {
        if (ref_mc)
        {
            movie = ref_mc;
            if (game_ref)
            {
                game = game_ref;
                this.init();
            }
            else if (DEBUG_LOGGING)
            {
                this.debugTrace("ERROR: Empty game reference passed to constructor");
            } // end else if
        }
        else if (DEBUG_LOGGING)
        {
            this.debugTrace("ERROR: Empty movie reference passed to constructor");
        } // end else if
    } // End of the function
    function init()
    {
        var q;
        var mc;
        this.positionData = com.clubpenguin.games.fire.data.BoardData.getBoardData();
        this.chosenMove = com.clubpenguin.games.fire.Constants.BOARD_MOVE_UNCHOSEN;
        for (q = 0; q < com.clubpenguin.games.fire.Constants.MAX_BOARD_SPACES; q++)
        {
            mc = eval(this.movie.board_mc + ".space" + q + ".stone_mc");
            mc.spaceId = q;
        } // end of for
        this.highlightMovie = this.movie.board_mc;
        for (q = 0; q < com.clubpenguin.games.fire.Constants.MAX_BOARD_SPACES; q++)
        {
            mc = eval(this.movie.board_mc + ".space" + q + ".highlight_mc");
            mc._visible = false;
        } // end of for
        for (q = 0; q < com.clubpenguin.games.fire.Constants.MAX_BOARD_SPACES; q++)
        {
            this.spacePlayerCount[q] = 0;
            this.spacePlayerList[q] = new Array();
            this.playerSpaceId[q] = 0;
        } // end of for
    } // End of the function
    function destroy(Void)
    {
        false;
    } // End of the function
    function highlightSpaces(moveClockwise, moveCounterClockwise, isLocal, screenPos)
    {
        if (this.DEBUG_LOGGING)
        {
            this.debugTrace("highlightSpaces:");
        } // end if
        var mc = new MovieClip();
        var mc_btn = new MovieClip();
        if (this.DEBUG_LOGGING)
        {
        } // end if
        if (moveClockwise >= 0 && moveClockwise < com.clubpenguin.games.fire.Constants.MAX_BOARD_SPACES && moveCounterClockwise >= 0 && moveCounterClockwise < com.clubpenguin.games.fire.Constants.MAX_BOARD_SPACES)
        {
            mc_btn = eval(this.movie.board_mc + ".space" + moveCounterClockwise);
            mc = eval(this.movie.board_mc + ".space" + moveCounterClockwise + ".stone_mc");
            if (isLocal == true)
            {
                mc_btn.onRelease = com.clubpenguin.util.Delegate.create(this, this.handleOnRelease, mc.spaceId, mc_btn);
                mc_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, this.handleOnRollOver, mc.spaceId, mc_btn);
                mc_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, this.handleOnRollOut, mc.spaceId, mc_btn);
                mc.gotoAndStop("local");
            }
            else
            {
                mc.gotoAndStop("remote");
            } // end else if
            this.setHighlightTint(mc, com.clubpenguin.games.fire.Constants.HIGHLIGHT_COLOUR_ON[screenPos], 25);
            mc_btn = eval(this.movie.board_mc + ".space" + moveClockwise);
            mc = eval(this.movie.board_mc + ".space" + moveClockwise + ".stone_mc");
            if (isLocal == true)
            {
                mc_btn.onRelease = com.clubpenguin.util.Delegate.create(this, this.handleOnRelease, mc.spaceId, mc_btn);
                mc_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, this.handleOnRollOver, mc.spaceId, mc_btn);
                mc_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, this.handleOnRollOut, mc.spaceId, mc_btn);
                mc.gotoAndStop("local");
            }
            else
            {
                mc.gotoAndStop("remote");
            } // end else if
            this.setHighlightTint(mc, com.clubpenguin.games.fire.Constants.HIGHLIGHT_COLOUR_ON[screenPos], 25);
        }
        else if (this.DEBUG_LOGGING)
        {
            "Error: highlightSpaces -- rec\'d bad move data: moveClockwise = " + moveClockwise + ", moveCounterClockwise = " + moveCounterClockwise;
        } // end else if
    } // End of the function
    function getPositionData(spaceId, playerCount)
    {
        if (DEBUG_LOGGING)
        {
            this.debugTrace("spaceId = " + spaceId + ", playerCount = " + playerCount);
            this.debugTrace("validSpaceId(" + spaceId + ") = " + this.validSpaceId(spaceId) + ", validPlayerCount(" + playerCount + ") = " + this.validPlayerCount(playerCount));
        } // end if
        if (this.validSpaceId(spaceId) && this.validPlayerCount(playerCount))
        {
            if (DEBUG_LOGGING)
            {
                this.debugTrace("positionData.length = " + positionData.length);
                this.debugTrace("positionData[" + spaceId + "][" + (playerCount - 1) + "] = " + positionData[spaceId][playerCount - 1]);
            } // end if
            return (positionData[spaceId][playerCount - 1]);
        }
        else
        {
            if (DEBUG_LOGGING)
            {
                this.debugTrace("getPositionData -- spaceId or playerCount has a bad value");
            } // end if
            return (null);
        } // end else if
    } // End of the function
    function getPlayerCount(spaceId)
    {
        if (this.validSpaceId(spaceId))
        {
            return (spacePlayerCount[spaceId]);
        } // end if
    } // End of the function
    function getChosenMove(Void)
    {
        return (chosenMove);
    } // End of the function
    function getSpaceId(seatID)
    {
        if (this.validSeatId(seatID))
        {
            return (playerSpaceId[seatID]);
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
    function setPlayerList(spaceIdList)
    {
        playerSpaceId = spaceIdList;
    } // End of the function
    function getPlayerCountBySpaceId(spaceId)
    {
        var _loc2 = 0;
        var _loc3 = 0;
        if (this.validSpaceId(spaceId))
        {
            for (var _loc2 = 0; _loc2 < playerSpaceId.length; ++_loc2)
            {
                if (spaceId == playerSpaceId[_loc2])
                {
                    ++_loc3;
                } // end if
            } // end of for
        } // end if
        return (_loc3);
    } // End of the function
    function setHighlightTint(mc, rgb, percent)
    {
        var _loc2 = new flash.geom.ColorTransform();
        var _loc3;
        _loc3 = new flash.geom.Transform(mc);
        this.setTint(_loc2, rgb, percent);
        _loc3.colorTransform = _loc2;
        _loc3 = new flash.geom.Transform(mc);
        this.setTint(_loc2, rgb, percent);
        _loc3.colorTransform = _loc2;
        _loc3 = new flash.geom.Transform(mc);
        this.setTint(_loc2, rgb, percent);
        _loc3.colorTransform = _loc2;
    } // End of the function
    function setTint(colorTrans, rgb, percent)
    {
        var _loc5 = rgb >> 16;
        var _loc6 = rgb >> 8 & 255;
        var _loc4 = rgb & 255;
        var _loc2 = percent / 100;
        colorTrans.redOffset = _loc5 * _loc2;
        colorTrans.greenOffset = _loc6 * _loc2;
        colorTrans.blueOffset = _loc4 * _loc2;
        colorTrans.redMultiplier = colorTrans.greenMultiplier = colorTrans.blueMultiplier = (100 - percent) / 100;
    } // End of the function
    function handleOnRelease(spaceId, btn_mc)
    {
        delete btn_mc.onRelease;
        this.resetHighlights();
        this.setChoosenMove(spaceId);
        game.showAllCards(false);
        game.handleBoardOnRelease();
    } // End of the function
    function handleOnRollOver(spaceId, btn_mc)
    {
        if (this.getPlayerCountBySpaceId(spaceId) == 0)
        {
            game.displayValidCardsByTrump(com.clubpenguin.games.fire.Constants.BOARD_VALID_TRUMP[spaceId]);
        }
        else
        {
            game.displayValidCardsByTrump(com.clubpenguin.games.fire.Constants.SYMBOL_NONE);
        } // end else if
    } // End of the function
    function handleOnRollOut(spaceId, btn_mc)
    {
        game.showAllCards(false);
    } // End of the function
    function resetHighlights(Void)
    {
        var mc;
        var q;
        this.removeOnRelease();
        for (q = 0; q < com.clubpenguin.games.fire.Constants.MAX_BOARD_SPACES; q++)
        {
            mc = eval(this.movie.board_mc + ".space" + q + ".stone_mc");
            mc.gotoAndStop("normal");
            this.setHighlightTint(mc, 16777215, 0);
        } // end of for
    } // End of the function
    function removeOnRelease(Void)
    {
        var mc_btn;
        var q;
        for (q = 0; q < com.clubpenguin.games.fire.Constants.MAX_BOARD_SPACES; q++)
        {
            mc_btn = eval(this.movie.board_mc + ".space" + q);
            if (this.DEBUG_LOGGING)
            {
                this.debugTrace("removeOnRelease: mc_btn = " + mc_btn);
            } // end if
            delete mc_btn.onRelease;
            delete mc_btn.onRollOver;
            delete mc_btn.onRollOut;
        } // end of for
    } // End of the function
    function validSpaceId(spaceId)
    {
        if (spaceId != null && spaceId >= 0 && spaceId < com.clubpenguin.games.fire.Constants.MAX_BOARD_SPACES)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function validSeatId(seatId)
    {
        if (seatId != null && seatId >= 0 && seatId < com.clubpenguin.games.fire.Constants.GAME_MAX_PLAYERS - 1)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function validPlayerCount(playerCount)
    {
        if (playerCount != null && playerCount > 0 && playerCount <= com.clubpenguin.games.fire.Constants.GAME_MAX_PLAYERS)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function setChoosenMove(spaceId)
    {
        if (this.validSpaceId(spaceId))
        {
            chosenMove = spaceId;
        } // end if
    } // End of the function
    function updateGameStatus(gameEventID)
    {
    } // End of the function
    function debugTrace(message)
    {
        if (DEBUG_LOGGING)
        {
            game.debugTraceExternal("Board", message);
        } // end if
    } // End of the function
    var DEBUG_LOGGING = false;
    var GAME_EVENT_WAITING = 0;
    var GAME_EVENT_START_TURN = 1;
    var GAME_EVENT_BATTLE_FIRE_TRUMP = 10;
    var GAME_EVENT_BATTLE_SNOW_TRUMP = 11;
    var GAME_EVENT_BATTLE_WATER_TRUMP = 12;
    var GAME_EVENT_BATTLE_CHOOSE_SYMBOL = 13;
    var GAME_EVENT_BATTLE_CHOOSE_OPPONENT = 14;
    var positionData = new Array(new Array(new Array()));
    var spacePlayerCount = new Array();
    var spacePlayerList = new Array(new Array());
    var playerSpaceId = new Array();
} // End of Class
