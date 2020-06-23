class com.clubpenguin.games.fire.Player
{
    var movie, game, penguinColour, startPos, endPos, currentPos, ctrlPos, bezierTime, jumping, animating, playReaction, screenPosition, flagIsFinished, pointLookAt, stepTime, flagLanding;
    function Player(ref_mc, game_ref, screenPos)
    {
        if (ref_mc)
        {
            movie = ref_mc;
            if (game_ref)
            {
                game = game_ref;
                this.init(screenPos, penguinColour);
            }
            else if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
            {
                this.debugTrace("ERROR: Empty game reference passed to constructor");
            } // end else if
        }
        else if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("ERROR: Empty movie reference passed to constructor");
        } // end else if
    } // End of the function
    function init(screenPos)
    {
        startPos = new flash.geom.Point();
        endPos = new flash.geom.Point();
        currentPos = new flash.geom.Point();
        ctrlPos = new flash.geom.Point();
        bezierTime = 0;
        jumping = false;
        animating = false;
        playReaction = false;
        screenPosition = screenPos;
        flagIsFinished = false;
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("init:");
            this.debugTrace("\t this.flagIsFinished = " + flagIsFinished);
        } // end if
    } // End of the function
    function destroy(Void)
    {
        movie.removeMovieClip();
        false;
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
        penguinColour = newColor;
        this.changeArtColour(penguinColour);
    } // End of the function
    function changeArtColour(artColor)
    {
        var _loc2;
        _loc2 = new Color(movie.art.body_mc);
        _loc2.setRGB(artColor);
        _loc2 = new Color(movie.art.frontArm_mc);
        _loc2.setRGB(artColor);
        _loc2 = new Color(movie.art.backArm_mc);
        _loc2.setRGB(artColor);
    } // End of the function
    function jumpTo(ptEnd)
    {
        var _loc2;
        var _loc4;
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("jumpTo: this.jumping = " + jumping);
        } // end if
        if (!jumping)
        {
            movie.highlight._visible = false;
            jumping = true;
            endPos = ptEnd;
            this.setDirection(currentPos, pointLookAt);
            _loc2 = Math.round(com.clubpenguin.games.fire.Player.distance(startPos, ptEnd));
            _loc4 = com.clubpenguin.games.fire.Player.midPoint(startPos, ptEnd);
            ctrlPos = _loc4;
            if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
            {
            } // end if
            ctrlPos.y = ctrlPos.y - com.clubpenguin.games.fire.Player.constrain(50 + _loc2 / 2, 50, 200);
            bezierTime = 0;
            if (_loc2 > 240)
            {
                stepTime = 8.000000E-002;
            }
            else
            {
                stepTime = 1.000000E-001;
            } // end else if
            if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
            {
                this.debugTrace("jumpTo: starting a jump, this.jumping = " + jumping);
            } // end if
            this.startAnimation("jump_land", "jump");
        }
        else if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("jumpTo: Oops, already jumping");
        } // end else if
    } // End of the function
    function updateJump(Void)
    {
        if (jumping)
        {
            bezierTime = bezierTime + stepTime;
            if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
            {
            } // end if
            if (bezierTime >= 8.000000E-001 && !flagLanding)
            {
                flagLanding = true;
                this.startAnimation("jump_land", "land");
            } // end if
            if (bezierTime >= 1)
            {
                bezierTime = 1;
            } // end if
            currentPos = com.clubpenguin.games.fire.Player.bezierOverTime(startPos, endPos, ctrlPos, bezierTime);
            this.setPosition(currentPos);
            if (bezierTime >= 1)
            {
                jumping = false;
                startPos = currentPos;
                this.handleJumpEnd("player_sprite");
            } // end if
            this.setDirection(currentPos, pointLookAt);
        }
        else if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("updateJump: Oops, not jumping");
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
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("setBehaviour:");
            this.debugTrace("\t pointLookAt.x = " + pointLookAt.x + ", pointLookAt.y = " + pointLookAt.y);
            this.debugTrace("\t playReaction = " + playReaction);
        } // end if
        pointLookAt = ptNew;
        playReaction = flagReaction;
    } // End of the function
    function startAnimation(parentLabel, childLabel)
    {
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("startAnimation:");
            this.debugTrace("\t parentLabel = " + parentLabel + ", childLabel = " + childLabel);
            this.debugTrace("\t movie.art = " + movie.art);
            this.debugTrace("\t movie.art.misc_mc = " + movie.art.misc_mc);
        } // end if
        movie.gotoAndStop(parentLabel);
        this.changeArtColour(penguinColour);
        movie.art.misc_mc.gotoAndPlay(childLabel);
        movie.art.frontArm_mc.gotoAndPlay(childLabel);
        movie.art.frontArmLines_mc.gotoAndPlay(childLabel);
        movie.art.beak_mc.gotoAndPlay(childLabel);
        movie.art.belt_mc.gotoAndPlay(childLabel);
        movie.art.shadow_mc.gotoAndPlay(childLabel);
        movie.art.body_mc.gotoAndPlay(childLabel);
        movie.art.bodyLines_mc.gotoAndPlay(childLabel);
        movie.art.backArm_mc.gotoAndPlay(childLabel);
        movie.art.backArmLines_mc.gotoAndPlay(childLabel);
        movie.art.feet_mc.gotoAndPlay(childLabel);
    } // End of the function
    function getCurrentPos(Void)
    {
        return (new flash.geom.Point(currentPos.x, currentPos.y));
    } // End of the function
    function hide(Void)
    {
        movie._visible = false;
    } // End of the function
    function showHighlight(screenPos, isActive)
    {
        var _loc3;
        var _loc2;
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("showHighlight:");
        } // end if
        if (isActive)
        {
            _loc3 = com.clubpenguin.games.fire.Constants.HIGHLIGHT_COLOUR_ON[screenPos];
            _loc2 = 100;
        }
        else
        {
            _loc3 = com.clubpenguin.games.fire.Constants.HIGHLIGHT_COLOUR_OFF[screenPos];
            _loc2 = 75;
        } // end else if
        this.setTintColour(movie.highlight, _loc3);
        movie.highlight._alpha = _loc2;
    } // End of the function
    function hideHighlight(Void)
    {
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("hideHighlight:");
        } // end if
        movie.highlight._alpha = 75;
    } // End of the function
    function setTintColour(mc, tintValue)
    {
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("setTintColour:");
        } // end if
        var _loc2 = new Color(mc);
        _loc2.setRGB(tintValue);
    } // End of the function
    function setIsFinished(Void)
    {
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("setIsFinished:");
            this.debugTrace("\t this.flagIsFinished = " + flagIsFinished);
        } // end if
        flagIsFinished = true;
    } // End of the function
    function isFinished(Void)
    {
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("isFinished:");
            this.debugTrace("\t this.flagIsFinished = " + flagIsFinished);
        } // end if
        return (flagIsFinished);
    } // End of the function
    function setPosition(pt0)
    {
        var _loc6 = new Array();
        var _loc4 = new Array();
        var _loc2;
        var _loc3;
        var _loc5;
        movie._x = pt0.x;
        movie._y = pt0.y;
        currentPos = pt0;
        _loc6 = game.getPlayerMovieRef();
        _loc4 = game.getPlayerDepthList();
        for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
        {
            _loc3 = _loc4[_loc2].seatId;
            _loc5 = _loc6[_loc3];
            _loc5.swapDepths(com.clubpenguin.games.fire.Player.PLAYER_DEPTH_BASE + com.clubpenguin.games.fire.Player.PLAYER_DEPTH_GAP * _loc2 + _loc3);
        } // end of for
    } // End of the function
    function handleJumping(Void)
    {
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("handleJumping: jumping...");
        } // end if
    } // End of the function
    function handleJumpEnd(Void)
    {
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("handleJumpEnd: All done!");
        } // end if
        jumping = false;
        movie.highlight._visible = true;
        game.handleSpriteAnimationEnd("jump_animation_end");
        if (playReaction)
        {
            this.startAnimation("idle_react", "react");
        }
        else
        {
            this.startAnimation("idle_react", "start");
        } // end else if
    } // End of the function
    function handleAnimationEnd(Void)
    {
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            this.debugTrace("handleAnimationEnd: All done!");
        } // end if
        animating = false;
    } // End of the function
    function setDirection(pt1, pt2)
    {
        if (pt1.x < pt2.x)
        {
            movie._xscale = Math.abs(movie._xscale);
        }
        else
        {
            movie._xscale = Math.abs(movie._xscale) * -1;
        } // end else if
    } // End of the function
    static function bezierOverTime(pt0, pt1, ctrl1, time)
    {
        return (new flash.geom.Point(pt0.x + time * (2 * (1 - time) * (ctrl1.x - pt0.x) + time * (pt1.x - pt0.x)), pt0.y + time * (2 * (1 - time) * (ctrl1.y - pt0.y) + time * (pt1.y - pt0.y))));
    } // End of the function
    static function midPoint(pt0, pt1)
    {
        return (new flash.geom.Point((pt1.x + pt0.x) / 2, (pt1.y + pt0.y) / 2));
    } // End of the function
    static function distance(p0, p1)
    {
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
        } // end if
        var _loc2 = p1.x - p0.x;
        var _loc1 = p1.y - p0.y;
        return (Math.sqrt(_loc2 * _loc2 + _loc1 * _loc1));
    } // End of the function
    static function constrain(num, min, max)
    {
        return (Math.min(Math.max(num, min), max));
    } // End of the function
    function debugTrace(message)
    {
        if (com.clubpenguin.games.fire.Player.DEBUG_LOGGING)
        {
            game.debugTraceExternal("Player", message);
        } // end if
    } // End of the function
    static var DEBUG_LOGGING = false;
    static var PLAYER_DEPTH_BASE = 50;
    static var PLAYER_DEPTH_GAP = 10;
    var highlightColor = new Array();
} // End of Class
