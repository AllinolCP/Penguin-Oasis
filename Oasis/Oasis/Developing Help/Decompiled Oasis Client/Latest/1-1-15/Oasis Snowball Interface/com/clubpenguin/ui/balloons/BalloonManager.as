class com.clubpenguin.ui.balloons.BalloonManager extends MovieClip
{
    var _shell, _engine, _interface, attachMovie, onEnterFrame;
    function BalloonManager()
    {
        super();
    } // End of the function
    function setDependencies(shell, engine, _interface)
    {
        _shell = shell;
        _engine = engine;
        this._interface = _interface;
        BALLOON_TEXT_FORMAT = _interface.embeddedFontsClip.burbankSmallMedium.getTextFormat();
        com.clubpenguin.ui.balloons.BalloonManager.BALLOON_TEXT_FORMAT.leading = 0;
    } // End of the function
    function createMC(playerID, depth, init, linkageOb)
    {
        var _loc6 = "p" + playerID;
        if (this[_loc6] != undefined)
        {
            return (false);
        } // end if
        if (depth == undefined || depth < 0)
        {
            depth = _engine.findPlayerDepth(playerID);
            if (depth == _engine.SPEECH_BUBBLE_DEPTH_EMPTY_VALUE)
            {
                return (false);
            } // end if
        } // end if
        if (init == undefined)
        {
            var _loc7 = _engine.getPlayerMovieClip(playerID);
            init = {_x: _loc7._x, _y: _loc7._y};
        } // end if
        var _loc2;
        if (linkageOb.linkage == undefined)
        {
            if (_shell.isPlayerBuddyById(playerID))
            {
                _loc2 = com.clubpenguin.ui.balloons.BalloonManager.BALLOON_BUDDY_LINKAGE;
            }
            else if (_shell.isPlayerMascotById(playerID))
            {
                _loc2 = com.clubpenguin.ui.balloons.BalloonManager.BALLOON_MASCOT_LINKAGE;
            }
            else
            {
                _loc2 = com.clubpenguin.ui.balloons.BalloonManager.BALLOON_DEFAULT_LINKAGE;
            } // end else if
            linkageOb.linkage = _loc2;
        }
        else
        {
            _loc2 = linkageOb.linkage;
        } // end else if
        var _loc3 = this.attachMovie(_loc2, _loc6, depth, init);
        flash.external.ExternalInterface.call("console.debug", _loc3);
        if (_loc3 == undefined)
        {
            return (false);
        } // end if
        _loc3.type = _loc2;
        _loc3.gotoAndStop(com.clubpenguin.ui.balloons.AbstractBalloon.PARKED_FRAME);
        _loc3.cacheAsBitmap = true;
        return (true);
    } // End of the function
    function changeMC(playerID, linkageOb)
    {
        var _loc3 = "p" + playerID;
        var _loc2 = this[_loc3];
        if (_loc2 == undefined)
        {
            return (false);
        } // end if
        var _loc5 = _loc2.getDepth();
        var _loc4 = {_x: _loc2._x, _y: _loc2._y};
        this.removeMC(playerID);
        return (this.createMC(playerID, _loc5, _loc4, linkageOb));
    } // End of the function
    function removeMC(playerID)
    {
        var _loc2 = this.getBalloonByPlayerID(playerID);
        if (_loc2 != undefined)
        {
            this.remove(_loc2);
        } // end if
        var _loc3 = this.getMC(playerID);
        if (_loc3 == undefined)
        {
            return;
        } // end if
        _loc3.removeMovieClip();
    } // End of the function
    function getMC(playerID)
    {
        var _loc3 = "p" + playerID;
        var _loc2 = this[_loc3];
        if (_loc2 != undefined)
        {
            return (_loc2);
        } // end if
        return (null);
    } // End of the function
    function mcExistsByID(playerID)
    {
        if (this["p" + playerID] != undefined)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function showTextBalloon(playerID, message, linkageName)
    {
        if (!message.length)
        {
            return;
        } // end if
        var _loc6 = this.getBalloonByPlayerID(playerID).__get__linkage();
        var _loc3 = {linkage: linkageName};
        var _loc4;
        if (!this.mcExistsByID(playerID))
        {
            _loc4 = this.createMC(playerID, null, null, _loc3);
        }
        else if (_loc6 != linkageName)
        {
            _loc4 = this.changeMC(playerID, _loc3);
        }
        else
        {
            _loc4 = true;
        } // end else if
        if (_loc4)
        {
            var _loc2 = (com.clubpenguin.ui.balloons.TextBalloon)(this.getTypedBalloonByPlayerID(playerID, com.clubpenguin.ui.balloons.TextBalloon));
            _loc2.__set__linkage(_loc3.linkage);
            _loc2.__set__duration(com.clubpenguin.ui.balloons.BalloonManager.BALLOON_DURATION);
            _loc2.__set__message(message);
            _loc2.__set__textFormat(com.clubpenguin.ui.balloons.BalloonManager.BALLOON_TEXT_FORMAT);
            _loc2.__set__maxWidth(com.clubpenguin.ui.balloons.BalloonManager.BALLOON_DEFAULT_WIDTH);
            _loc2.show();
            this.add(_loc2);
        } // end if
    } // End of the function
    function showEmoteBalloon(playerID, emoteID, linkageName)
    {
        var _loc6 = this.getBalloonByPlayerID(playerID).__get__linkage();
        var _loc4 = {linkage: linkageName};
        var _loc5;
        if (!this.mcExistsByID(playerID))
        {
            _loc5 = this.createMC(playerID, null, null, _loc4);
        }
        else if (_loc6 != linkageName)
        {
            _loc5 = this.changeMC(playerID, _loc4);
        }
        else
        {
            _loc5 = true;
        } // end else if
        if (_loc5)
        {
            var _loc2 = (com.clubpenguin.ui.balloons.EmoteBalloon)(this.getTypedBalloonByPlayerID(playerID, com.clubpenguin.ui.balloons.EmoteBalloon));
            _loc2.__set__linkage(_loc4.linkage);
            _loc2.__set__duration(com.clubpenguin.ui.balloons.BalloonManager.BALLOON_DURATION);
            _loc2.__set__emoteFrame(emoteID);
            _loc2.setSize(com.clubpenguin.ui.balloons.BalloonManager.BALLOON_EMOTE_WIDTH, com.clubpenguin.ui.balloons.BalloonManager.BALLOON_EMOTE_HEIGHT);
            _loc2.show();
            this.add(_loc2);
        } // end if
        var _loc7 = _shell.getPlayerObjectById(playerID);
        _loc7.emoteIDDisplayedInCurrentRoom = emoteID;
        _shell.updateListeners(_shell.SHOW_EMOTE, {player_id: playerID, emote_id: emoteID});
    } // End of the function
    function getTypedBalloonByPlayerID(playerID, type)
    {
        var _loc3 = "p" + playerID;
        var _loc2 = _activeBalloons[_loc3] || _inactiveBalloons[_loc3];
        if (_loc2 instanceof type)
        {
            return (_loc2);
        } // end if
        this.remove(_loc2);
        _loc2 = (com.clubpenguin.ui.balloons.AbstractBalloon)(new type[undefined](this["p" + playerID]));
        return (_loc2);
    } // End of the function
    function getBalloonByPlayerID(playerID)
    {
        var _loc2 = "p" + playerID;
        return (_activeBalloons[_loc2] || _inactiveBalloons[_loc2]);
    } // End of the function
    function add(balloon)
    {
        if (!_running)
        {
            this.init();
        } // end if
        if (_activeBalloons[balloon.__get__name()] == undefined)
        {
            ++_numActiveBalloons;
        } // end if
        _activeBalloons[balloon.__get__name()] = balloon;
        if (_inactiveBalloons[balloon.__get__name()] != undefined)
        {
            _inactiveBalloons[balloon.__get__name()] = undefined;
            delete _inactiveBalloons[balloon.__get__name()];
        } // end if
    } // End of the function
    function remove(balloon)
    {
        this.deactivate(balloon);
        _inactiveBalloons[balloon.__get__name()] = null;
        delete _inactiveBalloons[balloon.__get__name()];
    } // End of the function
    function deactivate(balloon)
    {
        if (_activeBalloons[balloon.__get__name()] == null)
        {
            return;
        } // end if
        _inactiveBalloons[balloon.__get__name()] = balloon;
        _activeBalloons[balloon.__get__name()] = null;
        delete _activeBalloons[balloon.__get__name()];
        --_numActiveBalloons;
        if (_numActiveBalloons <= 0)
        {
            _numActiveBalloons = 0;
            this.halt();
        } // end if
    } // End of the function
    function handler()
    {
        var _loc2;
        for (var _loc4 in _activeBalloons)
        {
            _loc2 = _activeBalloons[_loc4];
            if (_loc2.__get__counter() >= _loc2.__get__duration())
            {
                if (_loc2 instanceof com.clubpenguin.ui.balloons.TextBalloon)
                {
                    var _loc3 = (com.clubpenguin.ui.balloons.TextBalloon)(_loc2);
                    if (!_loc3.isDone())
                    {
                        _loc3.showNextPart();
                        continue;
                    } // end if
                } // end if
                _loc2.hide();
                this.deactivate(_loc2);
            } // end if
            _loc2.__set__counter(_loc2.__get__counter() + 1);
        } // end of for...in
    } // End of the function
    function init()
    {
        _running = true;
        onEnterFrame = handler;
    } // End of the function
    function halt()
    {
        if (_numActiveBalloons > 0)
        {
            return;
        } // end if
        _running = false;
        onEnterFrame = null;
        delete this.onEnterFrame;
    } // End of the function
    function reset()
    {
        for (var _loc2 in this)
        {
            if (this[_loc2] instanceof MovieClip)
            {
                if (this[_loc2]._name.charAt(0) == "p" && this[_loc2]._parent == this)
                {
                    this[_loc2].removeMovieClip();
                } // end if
            } // end if
        } // end of for...in
        _inactiveBalloons = {};
        _activeBalloons = {};
        _numActiveBalloons = 0;
        this.halt();
    } // End of the function
    static var BALLOON_DURATION = 125;
    static var BALLOON_EMOTE_WIDTH = 64;
    static var BALLOON_EMOTE_HEIGHT = 34;
    static var BALLOON_DEFAULT_WIDTH = 128;
    static var BALLOON_TEXT_FORMAT = new TextFormat();
    static var BALLOON_DEFAULT_LINKAGE = "DefaultBalloon";
    static var BALLOON_BUDDY_LINKAGE = "DefaultBalloon";
    static var BALLOON_MASCOT_LINKAGE = "DefaultBalloon";
    static var BALLOON_BLOCKED_LINKAGE = "DefaultBalloon";
    var _activeBalloons = {};
    var _inactiveBalloons = {};
    var _numActiveBalloons = 0;
    var _running = false;
} // End of Class
