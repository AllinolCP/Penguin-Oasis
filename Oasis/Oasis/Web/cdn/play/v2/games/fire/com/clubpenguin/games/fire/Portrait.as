class com.clubpenguin.games.fire.Portrait
{
    var movie, game, normalColorTransform, disabledColorTransform, myMovie, energyPrevious, senseiMode, emotionMovie, avatarColour;
    function Portrait(game_ref, movie_ref, playerNickname, playerEnergy, screenPos)
    {
        if (movie_ref)
        {
            movie = movie_ref;
            if (game_ref)
            {
                game = game_ref;
                this.init(playerNickname, playerEnergy, screenPos);
            }
            else if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
            {
                this.debugTrace("ERROR: Empty game reference passed to constructor");
            } // end else if
        }
        else if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
        {
            this.debugTrace("ERROR: Empty movie reference passed to constructor");
        } // end else if
    } // End of the function
    function init(playerNickname, playerEnergy, screenPos)
    {
        if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
        {
            this.debugTrace("init:");
        } // end if
        this.normalColorTransform = new flash.geom.ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
        this.disabledColorTransform = new flash.geom.ColorTransform(5.000000E-001, 5.000000E-001, 5.000000E-001, 1, 0, 0, 0, 0);
        if (screenPos == 0)
        {
            this.flameIndex = 0;
        }
        else
        {
            this.flameIndex = 1;
        } // end else if
        this.myMovie = eval(this.movie + ".avatar" + screenPos);
        if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
        {
            this.debugTrace("\t playerNickname = " + playerNickname);
            this.debugTrace("\t playerEnergy = " + playerEnergy);
            this.debugTrace("\t screenPos = " + screenPos);
            this.debugTrace("\t myMovie = " + this.myMovie);
        } // end if
        this.hide();
        this.myMovie.gotoAndStop(1);
        this.myMovie._x = com.clubpenguin.games.fire.Portrait.FRAME_POSTION[screenPos].x;
        this.myMovie._y = com.clubpenguin.games.fire.Portrait.FRAME_POSTION[screenPos].y;
        this.setNickname(playerNickname);
        this.energyPrevious = playerEnergy;
        this.setEnergy(playerEnergy);
        this.showHighlight(screenPos, false);
        this.myMovie.flame.gotoAndPlay("burning");
        if (playerNickname == "Sensei")
        {
            this.senseiMode = true;
        }
        else
        {
            this.senseiMode = false;
        } // end else if
        this.setFrameTint(com.clubpenguin.games.fire.Constants.HIGHLIGHT_COLOUR_OFF[screenPos], 55);
    } // End of the function
    function destroy(Void)
    {
        myMovie.removeMovieClip();
        false;
    } // End of the function
    function isUsable(Void)
    {
        if (!disabled && artworkLoaded)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function isDisabled(Void)
    {
        return (disabled);
    } // End of the function
    function setNickname(nickname)
    {
        if (!disabled)
        {
            myMovie.nickname.text = nickname;
        } // end if
    } // End of the function
    function setEnergy(energyAmount)
    {
        if (!disabled)
        {
            myMovie.energy.text = "" + Math.round(Math.floor(energyAmount));
            myMovie.flame._height = 30 + energyAmount * com.clubpenguin.games.fire.Portrait.FLAME_HEIGHT_MULTIPLIER[flameIndex];
            myMovie.flame._width = 10 + energyAmount * com.clubpenguin.games.fire.Portrait.FLAME_WIDTH_MULTIPLIER[flameIndex];
            if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
            {
                this.debugTrace("\t energyAmount = " + energyAmount + ", energyPrevious = " + energyPrevious);
                this.debugTrace("\t myMovie.energy_sfx = " + myMovie.energy_sfx);
            } // end if
            if (energyAmount < energyPrevious)
            {
                myMovie.energy_sfx.gotoAndPlay("smoke");
                if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Energy has gone DOWN, playing \'smoke\' animation");
                } // end if
            }
            else if (energyAmount > energyPrevious)
            {
                myMovie.energy_sfx.gotoAndPlay("flare");
                if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
                {
                    this.debugTrace("\t Energy has gone UP, playing \'flare\' animation");
                } // end if
            } // end else if
            energyPrevious = energyAmount;
            if (energyAmount <= 0)
            {
                myMovie.flame.gotoAndPlay("extinguish");
            } // end if
        } // end if
    } // End of the function
    function setEmotion(emotionName)
    {
        var _loc3;
        var _loc4 = 0;
        if (this.isUsable())
        {
            if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
            {
                this.debugTrace("setEmotion:");
                this.debugTrace("\t emotionName = " + emotionName);
            } // end if
            if (emotionName == com.clubpenguin.games.fire.PortraitConstants.EMOTION_WAITING)
            {
                _loc4 = Math.floor(Math.random() * 4);
                switch (_loc4)
                {
                    case 0:
                    {
                        emotionName = com.clubpenguin.games.fire.PortraitConstants.EMOTION_BLINK;
                        break;
                    } 
                    case 1:
                    {
                        emotionName = com.clubpenguin.games.fire.PortraitConstants.EMOTION_LOOK_LEFT;
                        break;
                    } 
                    case 2:
                    {
                        emotionName = com.clubpenguin.games.fire.PortraitConstants.EMOTION_LOOK_RIGHT;
                        break;
                    } 
                    case 3:
                    {
                        emotionName = com.clubpenguin.games.fire.PortraitConstants.EMOTION_WAITING;
                        break;
                    } 
                    default:
                    {
                        this.debugTrace("setEmotion: impossible value for random WAITING animation (" + _loc4 + ")");
                        break;
                    } 
                } // End of switch
            } // end if
            if (senseiMode)
            {
                emotionMovie.art.sensei._visible = true;
                emotionMovie.art.mask._visible = false;
            }
            else
            {
                emotionMovie.art.sensei._visible = false;
                emotionMovie.art.mask._visible = true;
            } // end else if
            emotionMovie.art.arm_front.gotoAndPlay(emotionName);
            emotionMovie.art.arm_front_lines.gotoAndPlay(emotionName);
            emotionMovie.art.sensei.gotoAndPlay(emotionName);
            emotionMovie.art.beak.gotoAndPlay(emotionName);
            emotionMovie.art.mask.gotoAndPlay(emotionName);
            emotionMovie.art.body.gotoAndPlay(emotionName);
            emotionMovie.art.body_lines.gotoAndPlay(emotionName);
            emotionMovie.art.arm_back.gotoAndPlay(emotionName);
            emotionMovie.art.arm_back_lines.gotoAndPlay(emotionName);
            _loc3 = new Color(emotionMovie.art.body);
            _loc3.setRGB(avatarColour);
            if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
            {
                this.debugTrace("\t emotionMovie.art.body = " + emotionMovie.art.body);
            } // end if
            _loc3 = new Color(emotionMovie.art.arm_front);
            _loc3.setRGB(avatarColour);
            if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
            {
                this.debugTrace("\t emotionMovie.art.arm_front = " + emotionMovie.art.arm_front);
            } // end if
            _loc3 = new Color(emotionMovie.art.arm_back);
            _loc3.setRGB(avatarColour);
            if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
            {
                this.debugTrace("\t emotionMovie.art.arm_back = " + emotionMovie.art.arm_back);
            } // end if
        } // end if
    } // End of the function
    function getMovie(Void)
    {
        return (myMovie);
    } // End of the function
    function hide(Void)
    {
        myMovie._visible = false;
    } // End of the function
    function show(Void)
    {
        myMovie._visible = true;
    } // End of the function
    function disable(finishPosition)
    {
        if (this.isUsable())
        {
            this.setTintColour(myMovie, disabledColorTransform);
            this.setEmotion(com.clubpenguin.games.fire.PortraitConstants.EMOTION_SAD);
            this.setFinishPosition(finishPosition);
            this.setEnergy(0);
            disabled = true;
        } // end if
    } // End of the function
    function setFinishPosition(finishPosition)
    {
        if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
        {
            this.debugTrace("setFinishPosition:");
        } // end if
        if (finishPosition == com.clubpenguin.games.fire.Constants.FIRE_RANK_PLAYER_QUIT)
        {
            myMovie.finish_position.gotoAndStop("quit");
            myMovie.finish_position.level.text = com.clubpenguin.util.LocaleText.getText("text_quit");
        }
        else if (finishPosition > 0 && finishPosition <= com.clubpenguin.games.fire.Constants.PLAYERS_MAX)
        {
            myMovie.finish_position.gotoAndStop("finished");
            myMovie.finish_position.level.text = finishPosition;
            myMovie.finish_position.superscript.text = com.clubpenguin.util.LocaleText.getText("ui_after_num" + finishPosition);
        } // end else if
    } // End of the function
    function showHighlight(screenPos, isActive)
    {
        if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
        {
            this.debugTrace("showHighlight:");
        } // end if
        var _loc2;
        if (isActive)
        {
            _loc2 = com.clubpenguin.games.fire.Constants.HIGHLIGHT_COLOUR_ON[screenPos];
            myMovie.bkg.gotoAndStop("active");
            this.setFrameTint(com.clubpenguin.games.fire.Constants.HIGHLIGHT_COLOUR_ON[screenPos], 70);
        }
        else
        {
            _loc2 = com.clubpenguin.games.fire.Constants.HIGHLIGHT_COLOUR_OFF[screenPos];
            myMovie.bkg.gotoAndStop("normal");
            this.setFrameTint(com.clubpenguin.games.fire.Constants.HIGHLIGHT_COLOUR_OFF[screenPos], 55);
        } // end else if
        this.setFillColour(myMovie.highlight_ring.fill, _loc2);
    } // End of the function
    function setTintColour(mc, ct)
    {
        var _loc2 = new flash.geom.Transform(mc);
        if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
        {
            this.debugTrace("setTintColour:");
        } // end if
        _loc2.colorTransform = ct;
    } // End of the function
    function setFillColour(mc, fillValue)
    {
        var _loc2 = new Color(mc);
        if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
        {
            this.debugTrace("setFillColour:");
        } // end if
        _loc2.setRGB(fillValue);
    } // End of the function
    function setupArtwork(screenPos, colourValue)
    {
        var _loc4;
        if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
        {
            this.debugTrace("setupArtwork:");
        } // end if
        avatarColour = colourValue;
        if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
        {
            this.debugTrace("\t screenPos = " + screenPos);
            this.debugTrace("\t colourValue = " + colourValue);
        } // end if
        myMovie.anchor.emotion.gotoAndStop(1);
        if (screenPos == 0)
        {
            myMovie.anchor.emotion.facing_left._visible = false;
            myMovie.anchor.emotion._x = -1.750000E+001;
            emotionMovie = myMovie.anchor.emotion.facing_right;
        }
        else
        {
            myMovie.anchor.emotion.facing_right._visible = false;
            myMovie.anchor.emotion._x = -1.275000E+002;
            emotionMovie = myMovie.anchor.emotion.facing_left;
        } // end else if
        artworkLoaded = true;
        this.setEmotion(com.clubpenguin.games.fire.PortraitConstants.EMOTION_WAITING);
        myMovie.anchor.emotion._y = 0;
        myMovie.anchor.emotion._visible = true;
        this.show();
    } // End of the function
    function setFrameTint(rgb, percent)
    {
        var _loc2 = new flash.geom.ColorTransform();
        var _loc3;
        _loc3 = new flash.geom.Transform(myMovie.frame_top.fill);
        this.setTint(_loc2, rgb, percent);
        _loc3.colorTransform = _loc2;
        _loc3 = new flash.geom.Transform(myMovie.frame_side.fill);
        this.setTint(_loc2, rgb, percent);
        _loc3.colorTransform = _loc2;
        _loc3 = new flash.geom.Transform(myMovie.frame_bottom.fill);
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
    function debugTrace(message)
    {
        if (com.clubpenguin.games.fire.Portrait.DEBUG_LOGGING)
        {
            game.debugTraceExternal("Portrait", message);
        } // end if
    } // End of the function
    static var DEBUG_LOGGING = true;
    static var FRAME_POSTION = [{x: 5, y: 15}, {x: 710, y: 80}, {x: 710, y: 225}, {x: 710, y: 370}];
    static var FRAME_SIZE = [{w: 143, h: 1.562000E+002}, {w: 112, h: 1.303000E+002}, {w: 112, h: 1.303000E+002}, {w: 112, h: 1.303000E+002}];
    static var ARTWORK_SIZE = [{w: 90, h: 1.042000E+002}, {w: 65, h: 7.520000E+001}, {w: 65, h: 7.520000E+001}, {w: 65, h: 7.520000E+001}];
    static var FLAME_HEIGHT_MULTIPLIER = [8, 6];
    static var FLAME_WIDTH_MULTIPLIER = [2.400000E+000, 1.400000E+000];
    var artworkLoaded = false;
    var disabled = false;
    var flameIndex = 0;
} // End of Class
