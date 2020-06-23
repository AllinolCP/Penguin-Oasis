class com.clubpenguin.games.fire.GameEngineBase extends com.clubpenguin.games.generic.GenericGameEngine
{
    var movieBase, movieSFX, spriteAnimationCount, cardTotalAmount, playerNewRank, flagAnimateBubbles, flagAnimateFirepops, playerMyGameOver, gameIsReady, playerAutoplayBoard, playerAutoplayBattle, timeoutBoardHandled, timeoutBattleHandled, gameCurrentPhase, flagSenseiMode, debugLogArray, hasFireGem, hasWaterGem, hasSnowGem, movie, playerMySeatId, playerActiveSeatId, spinAmount, playerAmount, debugTraceLastMessage;
    static var instanceBase;
    function GameEngineBase(Void)
    {
        super();
    } // End of the function
    function init(movie_ref)
    {
        var i = 0;
        var cardAttribute = new Array();
        instanceBase = this;
        super(movie_ref);
        this.movieBase = movie_ref;
        this.movieSFX = eval(movie_ref + ".attachSFX");
        this.spriteAnimationCount = 0;
        this.cardIndex = com.clubpenguin.game.cardjitsu.data.CardData.getCardData();
        this.cardTotalAmount = this.cardIndex.length;
        if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
        {
            this.debugTrace("gameEngineBase, init:");
            this.debugTrace("\t cardTotalAmount = " + this.cardTotalAmount);
        } // end if
        for (i = 1; i < this.cardTotalAmount; i++)
        {
            cardAttribute = this.cardIndex[i].split("|");
            this.cardSymbol[i] = cardAttribute[1];
            this.cardValue[i] = cardAttribute[2];
        } // end of for
        this.battleEnergyAnimOffsetNormal[com.clubpenguin.games.fire.Constants.SYMBOL_FIRE] = -20;
        this.battleEnergyAnimOffsetFlip[com.clubpenguin.games.fire.Constants.SYMBOL_FIRE] = 260;
        this.battleEnergyAnimOffsetNormal[com.clubpenguin.games.fire.Constants.SYMBOL_SNOW] = -20;
        this.battleEnergyAnimOffsetFlip[com.clubpenguin.games.fire.Constants.SYMBOL_SNOW] = 255;
        this.battleEnergyAnimOffsetNormal[com.clubpenguin.games.fire.Constants.SYMBOL_WATER] = -22;
        this.battleEnergyAnimOffsetFlip[com.clubpenguin.games.fire.Constants.SYMBOL_WATER] = 257;
        this.cardBorderColour.r = 14826534;
        this.cardBorderColour.g = 6404422;
        this.cardBorderColour.b = 1132705;
        this.cardBorderColour.p = 10721738;
        this.cardBorderColour.o = 16225579;
        this.cardBorderColour.y = 16509741;
        this.cardGlowColour.r = {ra: 45, rb: 153, ga: 45, gb: 30, ba: 45, bb: 5, aa: 80, ab: 0};
        this.cardGlowColour.g = {ra: 50, rb: 49, ga: 50, gb: 93, ba: 50, bb: 35, aa: 80, ab: 0};
        this.cardGlowColour.b = {ra: 55, rb: 12, ga: 55, gb: 41, ba: 55, bb: 158, aa: 80, ab: 0};
        this.cardGlowColour.p = {ra: 45, rb: 102, ga: 45, gb: 77, ba: 45, bb: 101, aa: 80, ab: 0};
        this.cardGlowColour.o = {ra: 45, rb: 153, ga: 45, gb: 86, ba: 45, bb: 15, aa: 80, ab: 0};
        this.cardGlowColour.y = {ra: 35, rb: 150, ga: 35, gb: 153, ba: 35, bb: 15, aa: 80, ab: 0};
        if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
        {
            this.debugTrace("init:");
            this.debugTrace("\t movieBase = " + this.movieBase);
        } // end if
        this.playerNewRank = -1;
        this.flagAnimateBubbles = true;
        this.flagAnimateFirepops = true;
        this.playerMyGameOver = false;
        this.gameIsReady = false;
        this.playerAutoplayBoard = false;
        this.playerAutoplayBattle = false;
        this.timeoutBoardHandled = false;
        this.timeoutBattleHandled = false;
        this.gameCurrentPhase = com.clubpenguin.games.fire.Constants.CURRENT_PHASE_BOARD;
        this.flagSenseiMode = false;
        this.debugLogArray = new Array();
        this.debugLogArray.push("Version: " + com.clubpenguin.games.fire.Constants.VERSION_NUMBER + "\n");
        this.hasFireGem = false;
        this.hasWaterGem = false;
        this.hasSnowGem = false;
        this.serverMessageLock = new Array();
    } // End of the function
    function destroy(Void)
    {
        false;
    } // End of the function
    function hideCards(Void)
    {
        var mc;
        var q;
        for (q = 0; q < com.clubpenguin.games.fire.Constants.GAME_MAX_CARDS_PER_HAND; q++)
        {
            mc = eval(this.movie + ".card_depth_holder.card" + q);
            mc._visible = false;
            mc.disappear_mask._visible = false;
            mc.disappear_mask.unloadMovie();
        } // end of for
    } // End of the function
    function hideBattleCards(Void)
    {
        var q;
        var mc;
        for (q = 0; q < com.clubpenguin.games.fire.Constants.GAME_MAX_PLAYERS; q++)
        {
            mc = eval(this.movie + ".battleCard_depth_holder.battle_card" + q);
            mc._visible = false;
            mc.battle_mask._visible = false;
            mc.battle_anim._visible = false;
            mc.artwork.hitarea_mc._visible = false;
            mc.flame_icon._visible = false;
        } // end of for
        this.hideBattleFrames();
    } // End of the function
    function hideBattleFrames(Void)
    {
        var q;
        var mc;
        for (q = 0; q < com.clubpenguin.games.fire.Constants.GAME_MAX_PLAYERS; q++)
        {
            mc = eval(this.movie + ".battleFrame_depth_holder.battle_frame" + q);
            mc._visible = false;
        } // end of for
    } // End of the function
    function handleSpriteAnimationEnd(animData)
    {
        if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
        {
            this.debugTrace("handleSpriteAnimationEnd called");
        } // end if
        --spriteAnimationCount;
        if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
        {
            this.debugTrace("\t animData = " + animData);
            this.debugTrace("\t spriteAnimationCount = " + spriteAnimationCount);
        } // end if
    } // End of the function
    function addWaitForAnimation(amount)
    {
        spriteAnimationCount = spriteAnimationCount + Math.floor(Math.abs(amount));
        if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
        {
            this.debugTrace("addWaitForAnimation:");
            this.debugTrace("\t spriteAnimationCount = " + spriteAnimationCount);
        } // end if
    } // End of the function
    function isAnimationComplete(Void)
    {
        if (spriteAnimationCount != 0)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    function setStatusText(textData)
    {
        if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
        {
            this.debugTrace("setStatusText:");
            this.debugTrace("\t textData = " + textData);
        } // end if
        movie.status_mc.holder.glow.content.text = textData;
        movie.status_mc.gotoAndPlay(1);
        this.addWaitForAnimation(1);
    } // End of the function
    function isMovieLoaded(mc)
    {
        if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
        {
            this.debugTrace("isMovieLoaded");
        } // end if
        if (!mc)
        {
            if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
            {
                this.debugTrace("\t returned false");
            } // end if
            return (false);
        } // end if
        if (mc.getBytesLoaded() < mc.getBytesTotal())
        {
            if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
            {
                this.debugTrace("\t returned false");
            } // end if
            return (false);
        } // end if
        if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
        {
            this.debugTrace("\t returned true");
        } // end if
        return (true);
    } // End of the function
    function bubbleStart(Void)
    {
        var mc;
        mc = eval(this.movie + ".bubbles.bubble" + Math.floor(Math.random() * com.clubpenguin.games.fire.Constants.BUBBLE_AMOUNT));
        mc.gotoAndPlay(2);
    } // End of the function
    function bubbleDestroyAll(Void)
    {
        var mc;
        this.flagAnimateBubbles = false;
        var i = 0;
        while (i < com.clubpenguin.games.fire.Constants.BUBBLE_AMOUNT)
        {
            mc = eval(this.movie + ".bubbles.bubble" + i);
            mc.removeMovieClip();
            ++i;
        } // end while
    } // End of the function
    function firepopStart(Void)
    {
        var mc;
        mc = eval(this.movie + ".firepops.firepop" + Math.floor(Math.random() * com.clubpenguin.games.fire.Constants.FIREPOP_AMOUNT));
        mc.gotoAndPlay(2);
    } // End of the function
    function firepopDestroyAll(Void)
    {
        var mc;
        this.flagAnimateFirepops = false;
        var i = 0;
        while (i < com.clubpenguin.games.fire.Constants.FIREPOP_AMOUNT)
        {
            mc = eval(this.movie + ".firepops.firepop" + i);
            mc.removeMovieClip();
            ++i;
        } // end while
    } // End of the function
    function isLocalPlayerTurn(Void)
    {
        if (playerMySeatId == playerActiveSeatId)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function getSpinAmount(Void)
    {
        return (spinAmount);
    } // End of the function
    function activePlayerCount(Void)
    {
        var _loc3 = 0;
        for (var _loc2 = 0; _loc2 < playerAmount; ++_loc2)
        {
            if (playerEnergyLevel[_loc2] > 0)
            {
                ++_loc3;
            } // end if
        } // end of for
        return (_loc3);
    } // End of the function
    function freeGameMemory(base_obj)
    {
        this.debugTrace("====================");
        this.debugTrace("freeGameMemory:");
        this.freeMemory(base_obj);
        this.debugTrace("--------------------");
        this.freeMemory(this);
        this.debugTrace("====================");
    } // End of the function
    function freeMemory(base_obj)
    {
        var _loc2;
        for (var _loc2 in serverMessageData)
        {
            serverMessageData[_loc2] = null;
            delete serverMessageData[_loc2];
        } // end of for...in
        serverMessageData = [];
    } // End of the function
    function addSFX(soundName, loopCount, volume)
    {
        if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
        {
            this.debugTrace("addSFX:");
            this.debugTrace("\t adding sound: " + soundName + ", " + loopCount + ", " + volume);
        } // end if
        if (loopCount == undefined)
        {
            loopCount = 1;
        } // end if
        if (volume == undefined)
        {
            volume = 100;
        } // end if
        movieSFX[soundName + "Sound"] = new Sound(movieSFX.createEmptyMovieClip(soundName + "Sfx", movieSFX.getNextHighestDepth()));
        movieSFX[soundName + "Sound"].setVolume(volume);
        movieSFX[soundName + "Sound"].attachSound(soundName);
        movieSFX[soundName + "Sound"].start(0, loopCount);
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
    function resetAutoPlay(Void)
    {
        serverMessageData[com.clubpenguin.games.fire.Constants.MESSAGE_TIMEOUT_BOARD] = null;
        serverMessageData[com.clubpenguin.games.fire.Constants.MESSAGE_TIMEOUT_BATTLE] = null;
        playerAutoplayBoard = false;
        playerAutoplayBattle = false;
        timeoutBoardHandled = false;
        timeoutBattleHandled = false;
    } // End of the function
    function randomRange(min, max)
    {
        if (min > max)
        {
            return (Math.floor(Math.random() * (min - max)) + max);
        } // end if
        return (Math.floor(Math.random() * (max - min)) + min);
    } // End of the function
    function debugTrace(message)
    {
        if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
        {
            if (debugTraceLastMessage != message)
            {
                var _loc2 = new Date();
                var _loc3 = "" + _loc2.getFullYear();
                _loc3 = _loc3 + ("/" + (_loc2.getMonth() + 1 < 10 ? ("0") : ("")) + (_loc2.getMonth() + 1));
                _loc3 = _loc3 + ("/" + (_loc2.getDate() < 10 ? ("0") : ("")) + _loc2.getDate());
                _loc3 = _loc3 + (" " + (_loc2.getHours() < 10 ? ("0") : ("")) + _loc2.getHours());
                _loc3 = _loc3 + (":" + (_loc2.getMinutes() < 10 ? ("0") : ("")) + _loc2.getMinutes());
                _loc3 = _loc3 + (":" + (_loc2.getSeconds() < 10 ? ("0") : ("")) + _loc2.getSeconds());
                debugLogArray.push(_loc3 + " (GameEngine) " + message + "\n");
                if (movie.debug_mc._visible)
                {
                    movie.debug_mc.debugText.text = debugLogArray.join("");
                } // end if
            } // end if
            debugTraceLastMessage = message;
        } // end if
    } // End of the function
    function debugTraceExternal(header, message)
    {
        if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
        {
            if (debugTraceLastMessage != message)
            {
                var _loc2 = new Date();
                var _loc3 = "" + _loc2.getFullYear();
                _loc3 = _loc3 + ("/" + (_loc2.getMonth() + 1 < 10 ? ("0") : ("")) + (_loc2.getMonth() + 1));
                _loc3 = _loc3 + ("/" + (_loc2.getDate() < 10 ? ("0") : ("")) + _loc2.getDate());
                _loc3 = _loc3 + (" " + (_loc2.getHours() < 10 ? ("0") : ("")) + _loc2.getHours());
                _loc3 = _loc3 + (":" + (_loc2.getMinutes() < 10 ? ("0") : ("")) + _loc2.getMinutes());
                _loc3 = _loc3 + (":" + (_loc2.getSeconds() < 10 ? ("0") : ("")) + _loc2.getSeconds());
                debugLogArray.push(_loc3 + " (" + header + ") " + message + "\n");
                if (movie.debug_mc._visible)
                {
                    movie.debug_mc.debugText.text = debugLogArray.join("");
                } // end if
            } // end if
        } // end if
    } // End of the function
    function debugObject(strName, resArray)
    {
        if (com.clubpenguin.games.fire.GameEngineBase.DEBUG_LOGGING)
        {
            var _loc4 = resArray.length;
            if (_loc4 == 0)
            {
                this.debugTrace("\t" + strName + " is empty");
            }
            else
            {
                for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
                {
                    this.debugTrace("\t" + strName + "[" + _loc2 + "] = " + resArray[_loc2] + " (" + typeof(resArray[_loc2]) + ")");
                } // end of for
            } // end if
        } // end else if
    } // End of the function
    function debugButtonOnRelease()
    {
        movie.debug_mc._visible = !movie.debug_mc._visible;
        if (movie.debug_mc._visible)
        {
            movie.debug_mc.debugText.text = debugLogArray.join("");
        } // end if
        movie.debug_copy_btn._visible = !movie.debug_copy_btn._visible;
        movie.debug_clear_btn._visible = !movie.debug_clear_btn._visible;
        movie.debug_btn.text_fld.text = "Debug " + (movie.debug_mc._visible ? ("off") : ("on"));
    } // End of the function
    function debugCopyButtonOnRelease()
    {
        var _loc2 = debugLogArray.join("");
        Selection.setFocus(movie.debug_mc.debugText);
        Selection.setSelection(0, _loc2.length);
        System.setClipboard(_loc2);
    } // End of the function
    function debugClearButtonOnRelease()
    {
        debugLogArray = new Array();
        this.debugTrace("[ cleared ]");
        this.debugTrace("Version: " + com.clubpenguin.games.fire.Constants.VERSION_NUMBER);
    } // End of the function
    static var DEBUG_LOGGING = false;
    var bubbleTimerCount = 0;
    var firepopTimerCount = 0;
    var energyJumpPortrait = [{x: 49, y: 133}, {x: 750, y: 150}, {x: 750, y: 295}, {x: 750, y: 440}];
    var energyJumpLava = [{x: 256, y: 282}, {x: 557, y: 280}, {x: 557, y: 280}, {x: 557, y: 280}];
    var cardJumpFrom_Local = [{x: 15, y: 175}, {x: 15, y: 225}, {x: 15, y: 275}, {x: 15, y: 325}, {x: 15, y: 375}];
    var cardJumpFrom_Remote = [{x: null, y: null}, {x: 670, y: 95}, {x: 670, y: 225}, {x: 670, y: 355}];
    var cardJumpTo = [[null], [null], [{x: 275, y: 210}, {x: 395, y: 210}], [{x: 275, y: 210}, {x: 395, y: 140}, {x: 395, y: 280}], [{x: 275, y: 210}, {x: 395, y: 80}, {x: 395, y: 210}, {x: 395, y: 340}]];
    var playerNicknames = new Array();
    var playerColorList = new Array();
    var playerStateList = new Array();
    var playerEnergyLevel = new Array();
    var playerCurrentBoardId = new Array();
    var playerCardList = new Array();
    var playerFinishPositionList = new Array();
    var playerRank = new Array();
    var playerScore = new Array();
    var playerBattleList = new Array();
    var playerAbortQueue = new Array();
    var seatIdByScreenPosition = new Array();
    var screenPositionBySeatId = new Array();
    var portraitObjectRef = new Array();
    var playerMovieRef = new Array();
    var playerObjRef = new Array();
    var serverMessageData = new Array();
    var serverMessageLock = new Array();
    var assetList = new Array();
    var assetLoadingCount = 0;
    var assetLoadStarted = false;
    var assetLoadDone = false;
    var gameState = com.clubpenguin.games.fire.Constants.STATE_PRESTART;
    var timerPosition = [{x: 121, y: 14}, {x: 601, y: 50}, {x: 601, y: 194}, {x: 601, y: 341}];
    var timerSize = [80, 64, 64, 64];
    var timerMovieRef = new Array();
    var timerObjectRef = new Array();
    var cardIndex = new Array();
    var cardValue = new Array();
    var cardSymbol = new Array();
    var cardBorderColour = new Array();
    var cardGlowColour = new Array();
    var battleFrameBySeatId = new Array();
    var battleEnergyAnimOffsetNormal = new Array();
    var battleEnergyAnimOffsetFlip = new Array();
} // End of Class
