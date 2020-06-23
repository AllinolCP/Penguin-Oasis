class com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher, com.clubpenguin.games.cardjitsu.water.motion.IMoveable, com.clubpenguin.game.engine.IEngineUpdateable
{
    var __uid, name_mc, _visible, __init, __flagLanding, onEnterFrame, idle_react, __currentAnimator, _y, _x, startPos, endPos, currentPos, ctrlPos, bezierTime, jumping, animating, playReaction, screenPosition, flagIsFinished, __actionQueue, __currentPlayerData, __darkMode, removeMovieClip, __activeMotion, penguinColour, transform, pointLookAt, __currentAction, highlight, _xscale, __activeElement, stop, __jumpStartPoint, __jumpEndPoint, __jumpControlPoint;
    function PlayerCharacter()
    {
        super();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.$_instanceCount;
        name_mc._visible = false;
        _visible = false;
        __init = true;
        __flagLanding = false;
        onEnterFrame = checkInit;
    } // End of the function
    function getUniqueName()
    {
        return ("[PlayerCharacter<" + __uid + ">]");
    } // End of the function
    function checkInit()
    {
        if (__init)
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.ClipEvent(this, com.clubpenguin.lib.event.ClipEvent.RENDERED));
            __init = false;
            __currentAnimator = idle_react;
            this.init();
            delete this.onEnterFrame;
        } // end if
    } // End of the function
    function init()
    {
        com.clubpenguin.ProjectGlobals.__get__host().register(this, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.$_updateFrequency);
        startPos = new flash.geom.Point(_x, _y);
        endPos = new flash.geom.Point(_x, _y);
        currentPos = new flash.geom.Point(_x, _y);
        ctrlPos = new flash.geom.Point();
        bezierTime = 0;
        jumping = false;
        animating = false;
        playReaction = false;
        screenPosition = 1;
        flagIsFinished = false;
        __actionQueue = new Array();
        this.stopAll();
    } // End of the function
    function config(_data)
    {
        __currentPlayerData = _data;
        if (_data != null)
        {
            __darkMode = _data.darkMode;
            this.setColour(_data.__get__color());
            if (_data.__get__currentSummon() == -1)
            {
                this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_IDLE);
            }
            else
            {
                this.summonElement(_data.__get__currentSummon());
            } // end else if
            _visible = true;
        }
        else
        {
            _visible = false;
            name_mc.__set__text("");
        } // end else if
    } // End of the function
    function destroy(Void)
    {
        __actionQueue = null;
        this.removeMovieClip();
        false;
    } // End of the function
    function currentMotion()
    {
        return (__activeMotion);
    } // End of the function
    function setStartPosition(pt0)
    {
        startPos = pt0;
        currentPos = pt0;
        this.setPosition(pt0);
        this.setDirection(pt0, new flash.geom.Point(380, 249));
    } // End of the function
    function setColour(newColor)
    {
        if (newColor != null)
        {
            penguinColour = newColor;
        } // end if
        this.changeArtColour(penguinColour);
    } // End of the function
    function changeArtColour(artColor)
    {
        __currentAnimator.setColor(artColor, __darkMode);
        var _loc2;
        if (__darkMode)
        {
            _loc2 = transform.colorTransform;
            _loc2.redOffset = -50;
            _loc2.greenOffset = -50;
            _loc2.blueOffset = -50;
            transform.colorTransform = _loc2;
        }
        else
        {
            _loc2 = new flash.geom.ColorTransform();
            transform.colorTransform = _loc2;
        } // end else if
    } // End of the function
    function isJumping(Void)
    {
        if (jumping == true)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function setBehaviour(ptNew, flagReaction)
    {
        pointLookAt = ptNew;
        playReaction = flagReaction;
    } // End of the function
    function startAnimation(_actionGroup, _action, _param)
    {
        __currentAction = _action;
        __currentAnimator = idle_react;
        this.changeArtColour(penguinColour, __darkMode);
        __currentAnimator.startAction(_action, _param);
    } // End of the function
    function getCurrentPos(Void)
    {
        return (new flash.geom.Point(currentPos.x, currentPos.y));
    } // End of the function
    function getCoordinates()
    {
        return (new flash.geom.Point(currentPos.x, currentPos.y));
    } // End of the function
    function hide(Void)
    {
        _visible = false;
    } // End of the function
    function showHighlight(screenPos, isActive)
    {
        var _loc3;
        var _loc2;
        if (isActive)
        {
            _loc3 = com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.HIGHLIGHT_COLOUR_ON[screenPos];
            _loc2 = 100;
        }
        else
        {
            _loc3 = com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.HIGHLIGHT_COLOUR_OFF[screenPos];
            _loc2 = 75;
        } // end else if
        this.setTintColour(highlight, _loc3);
        highlight._alpha = _loc2;
    } // End of the function
    function hideHighlight(Void)
    {
        highlight._alpha = 75;
    } // End of the function
    function setTintColour(mc, tintValue)
    {
        var _loc1 = new Color(mc);
        _loc1.setRGB(tintValue);
    } // End of the function
    function setIsFinished(Void)
    {
        flagIsFinished = true;
    } // End of the function
    function isFinished(Void)
    {
        return (flagIsFinished);
    } // End of the function
    function setCoordinate(pt0)
    {
        var _loc6 = new Array();
        var _loc4 = new Array();
        var _loc2;
        var _loc3;
        var _loc5;
        _x = pt0.x;
        _y = pt0.y;
        currentPos = pt0;
        for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
        {
            _loc3 = _loc4[_loc2].seatId;
            _loc5 = _loc6[_loc3];
            _loc5.swapDepths(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.PLAYER_DEPTH_BASE + com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.PLAYER_DEPTH_GAP * _loc2 + _loc3);
        } // end of for
    } // End of the function
    function setPosition(pt0)
    {
        var _loc6 = new Array();
        var _loc4 = new Array();
        var _loc2;
        var _loc3;
        var _loc5;
        _x = pt0.x;
        _y = pt0.y;
        currentPos = pt0;
        for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
        {
            _loc3 = _loc4[_loc2].seatId;
            _loc5 = _loc6[_loc3];
            _loc5.swapDepths(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.PLAYER_DEPTH_BASE + com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.PLAYER_DEPTH_GAP * _loc2 + _loc3);
        } // end of for
    } // End of the function
    function handleJumping(Void)
    {
    } // End of the function
    function handleJumpEnd(Void)
    {
        jumping = false;
        highlight._visible = true;
        if (playReaction)
        {
            this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_REACT);
        }
        else
        {
            this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_START);
        } // end else if
    } // End of the function
    function handleAnimationEnd(Void)
    {
        animating = false;
    } // End of the function
    function setDirection(pt1, pt2)
    {
        if (pt1.x < pt2.x)
        {
            _xscale = Math.abs(_xscale);
        }
        else
        {
            _xscale = Math.abs(_xscale) * -1;
        } // end else if
    } // End of the function
    static function constrain(num, min, max)
    {
        return (Math.min(Math.max(num, min), max));
    } // End of the function
    function handleActionComplete(_eventObj)
    {
        var _loc4;
        var _loc2;
        var _loc1;
        _loc1 = (com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterLayers)(_eventObj.__get__target());
    } // End of the function
    function actionComplete(_action)
    {
        var _loc2;
        var _loc3;
        switch (__currentAction)
        {
            case com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_JUMP:
            case com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_SPIN:
            {
                _loc2 = new com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterCommand("Spin", com.clubpenguin.util.Delegate.create(this, spin));
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_SUMMON_ELEMENT:
            case com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_SUMMON_IDLE:
            {
                _loc2 = new com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterCommand("SummonIdle", com.clubpenguin.util.Delegate.create(this, summonIdle));
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_DROP:
            {
                _loc2 = new com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterCommand("Continue Falling", com.clubpenguin.util.Delegate.create(this, drop));
                break;
            } 
            default:
            {
                _loc2 = new com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterCommand("Idle", com.clubpenguin.util.Delegate.create(this, idle));
            } 
        } // End of switch
        _loc3 = (com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterCommand)(__actionQueue.shift());
        if (_loc3 != null)
        {
            _loc3.command();
        }
        else
        {
            _loc2.command();
        } // end else if
    } // End of the function
    function actionContinue(_action)
    {
        var _loc2;
        switch (_action)
        {
            case com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_KICK_GONG:
            {
                _loc2 = new com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterCommand("Kick Gong", com.clubpenguin.util.Delegate.create(this, kickGong));
                break;
            } 
            default:
            {
                _loc2 = null;
            } 
        } // End of switch
        if (_loc2 != null)
        {
            _loc2.command();
        } // end if
    } // End of the function
    function summonElement(_element)
    {
        __activeElement = com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.__summons[_element];
        __actionQueue = [new com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterCommand("SummonComplete", com.clubpenguin.util.Delegate.create(this, summonComplete))];
        this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_SUMMON_ELEMENT, _element);
    } // End of the function
    function throwElement()
    {
        __actionQueue = [new com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterCommand("throwComplete After Throw", com.clubpenguin.util.Delegate.create(this, throwComplete))];
        this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, __activeElement + com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_THROW);
    } // End of the function
    function summonAndThrowElement(_element)
    {
        __activeElement = com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.__summons[_element];
        if (!(__currentAction == com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_SUMMON_ELEMENT || __currentAction == com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_SUMMON_IDLE))
        {
            this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_SUMMON_ELEMENT, _element);
            __actionQueue = [new com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterCommand("Throw Element after SummonAndThrow", com.clubpenguin.util.Delegate.create(this, throwElement))];
        }
        else
        {
            this.throwElement();
        } // end else if
    } // End of the function
    function summonComplete()
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.PlayerEvent(this, com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_SUMMON_FINISH));
    } // End of the function
    function throwComplete()
    {
        __activeElement = null;
        this.idle();
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.PlayerEvent(this, com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_THROW_FINISH));
    } // End of the function
    function idle()
    {
        this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_IDLE);
    } // End of the function
    function spin()
    {
        this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_SPIN);
    } // End of the function
    function summonIdle()
    {
        this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_SUMMON_IDLE);
    } // End of the function
    function drop()
    {
        __actionQueue = [new com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterCommand("Make drop the next action too", com.clubpenguin.util.Delegate.create(this, drop))];
        this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_DROP);
    } // End of the function
    function land()
    {
        this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_LAND);
    } // End of the function
    function jump()
    {
        this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_JUMP);
    } // End of the function
    function initiateMove()
    {
        this.idle();
    } // End of the function
    function celebrateVictory()
    {
        __actionQueue = [new com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterCommand("Win Complete after Victory", com.clubpenguin.util.Delegate.create(this, playerWinComplete))];
        this.startAnimation(com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ANIMATION_GROUP_STAND, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.ACTION_VICTORY);
    } // End of the function
    function playerWinComplete()
    {
        this.stop();
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.PlayerEvent(this, com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_WIN_COMPLETE, __currentPlayerData));
    } // End of the function
    function kickGong()
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.PlayerEvent(this, com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_KICK_GONG, __currentPlayerData));
    } // End of the function
    function dropComplete()
    {
        _visible = false;
        this.stop();
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.PlayerEvent(this, com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_DROP_FINISH));
    } // End of the function
    function stopAll()
    {
        __currentAnimator.stopAll();
        __actionQueue = [];
    } // End of the function
    function update(_tick, _currUpdate)
    {
    } // End of the function
    function jumpTo(_direction)
    {
        var _loc4;
        var _loc3;
        __jumpStartPoint = new flash.geom.Point(_x, _y);
        if (!jumping)
        {
            jumping = true;
            __jumpEndPoint = _direction.clone();
            _direction = _direction.subtract(__jumpStartPoint);
            _loc4 = Math.round(_direction.length);
            _direction.normalize(_direction.length / 2);
            _loc3 = __jumpStartPoint.add(_direction);
            __jumpControlPoint = _loc3;
            __jumpControlPoint.y = __jumpControlPoint.y - com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.constrain(50 + _loc4 / 2, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.JUMP_HEIGHT_MIN, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.JUMP_HEIGHT_MAX);
            __activeMotion = new com.clubpenguin.games.cardjitsu.water.motion.BezierArc(this, com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.JUMP_TIME, __jumpStartPoint, __jumpEndPoint, _loc3);
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.PROGRESS, onJumpMotionProgress, this, __activeMotion);
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.COMPLETE, onJumpMotionComplete, this, __activeMotion);
            this.jump();
            this.setCoordinate(__jumpStartPoint);
            __activeMotion.startMotion();
            
        } // end if
    } // End of the function
    function onJumpMotionProgress(_eventObj)
    {
        var _loc2;
        _loc2 = Number(_eventObj.__get__data());
        if (com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.JUMP_TIME - com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.JUMP_TIME * _loc2 <= com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter.LAND_TRIGGER && !__flagLanding)
        {
            __flagLanding = true;
            this.land();
        } // end if
    } // End of the function
    function onJumpMotionComplete()
    {
        __flagLanding = false;
        __activeMotion.dispose();
        __activeMotion = null;
        jumping = false;
        this.setCoordinate(new flash.geom.Point(_x, _y));
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.PROGRESS, onJumpMotionProgress, this);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.COMPLETE, onJumpMotionComplete, this);
    } // End of the function
    function getCoordinate()
    {
        return (new flash.geom.Point(_x, _y));
    } // End of the function
    static var $_updateFrequency = 42;
    static var $_instanceCount = 0;
    static var __summons = ["f", "f", "f", "f"];
    static var ANIMATION_GROUP_JUMP = "idle_react";
    static var ANIMATION_GROUP_STAND = "idle_react";
    static var ACTION_START = "start";
    static var ACTION_IDLE = "idle";
    static var ACTION_REACT = "react";
    static var ACTION_DROP = "d";
    static var ACTION_VICTORY = "v";
    static var ACTION_KICK_GONG = "kickGong";
    static var ACTION_THROW = "throw";
    static var ACTION_SUMMON_IDLE = "summonIdle";
    static var ACTION_SUMMON_ELEMENT = "f";
    static var ACTION_JUMP = "jump";
    static var ACTION_LAND = "land";
    static var ACTION_SPIN = "spin";
    static var PENGUIN_COLOURS = [9674916, 13158, 36864, 16724889, 3355443, 13369344, 16737792, 16763904, 6684825, 10053120, 16737894, 26112, 39372, 9102082, 173975];
    static var COLOUR_INDEX_DEFAULT = 0;
    static var COLOUR_INDEX_SENSEI = 0;
    static var COLOUR_INDEX_BLUE = 1;
    static var COLOUR_INDEX_GREEN = 2;
    static var COLOUR_INDEX_FUSCIA = 3;
    static var COLOUR_INDEX_BLACK = 4;
    static var COLOUR_INDEX_RED = 5;
    static var COLOUR_INDEX_ORANGE = 6;
    static var COLOUR_INDEX_YELLOW = 7;
    static var COLOUR_INDEX_PURPLE = 8;
    static var COLOUR_INDEX_BROWN = 9;
    static var COLOUR_INDEX_PINK = 10;
    static var COLOUR_INDEX_DARKGREEN = 11;
    static var COLOUR_INDEX_LIGHTBLUE = 12;
    static var COLOUR_INDEX_LIGHTGREEN = 13;
    static var COLOUR_INDEX_AQUA = 14;
    static var SENSEI_COLOUR = 9674916;
    static var HIGHLIGHT_COLOUR_ON = [16776960, 65280, 16711935, 65535];
    static var HIGHLIGHT_COLOUR_OFF = [16750080, 32512, 8323199, 32639];
    static var JUMP_HEIGHT_MAX = 200;
    static var JUMP_HEIGHT_MIN = 50;
    static var JUMP_TIME = 3000;
    static var LAND_TRIGGER = 100;
    static var PLAYER_DEPTH_BASE = 50;
    static var PLAYER_DEPTH_GAP = 10;
    var highlightColor = new Array();
} // End of Class
