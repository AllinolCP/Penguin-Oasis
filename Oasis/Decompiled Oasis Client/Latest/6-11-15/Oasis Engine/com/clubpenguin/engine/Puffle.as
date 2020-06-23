﻿class com.clubpenguin.engine.Puffle extends com.clubpenguin.util.EventDispatcher
{
    var _clip, _id, _clickable, _onReleaseEnabled, _isWalking, _isSpringInStep, _isStartingInteraction, _isEndingInteraction, _loader, __get__clip, _artClip, __get__clickable, updateListeners, __get__isWalking, __get__position, __set__frame, _path, __get__x, __get__y, __set__clickable, __get__interactionClip, __set__isStartingInteraction, __set__isEndingInteraction, __get__lastSafeZonePoint, _lastTraveledPath, _lastSafeZonePoint, __get__path, __get__id, _type, __get__typeID, __get__isSpringInStep, __get__isStartingInteraction, __get__isEndingInteraction, _interactionClip, _depth, __get__depth, __get__frame, __set__depth, __set__id, __set__interactionClip, __set__isSpringInStep, __set__isWalking, __set__lastSafeZonePoint, __get__lastTraveledPath, __set__path, __set__typeID;
    function Puffle(clip, id)
    {
        super();
        _clip = clip;
        _id = id;
        _clickable = false;
        _onReleaseEnabled = false;
        _isWalking = false;
        _isSpringInStep = false;
        _isStartingInteraction = false;
        _isEndingInteraction = false;
        _loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, onLoadStart));
        _loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
    } // End of the function
    function enableOnRelease()
    {
        this.__get__clip().onPress = com.clubpenguin.util.Delegate.create(this, onPress);
        _clickable = true;
        _onReleaseEnabled = true;
    } // End of the function
    function loadArtAsset(url)
    {
        if (_artClip == undefined)
        {
            _artClip = this.__get__clip().createEmptyMovieClip("artClip", this.__get__clip().getNextHighestDepth());
        } // end if
        var _loc2 = com.clubpenguin.util.URLUtils.getCacheResetURL(url);
        _loader.loadClip(_loc2, _artClip);
    } // End of the function
    function onPress()
    {
        if (!this.__get__clickable())
        {
            return;
        } // end if
        this.updateListeners(com.clubpenguin.engine.Puffle.ON_CLICK, this);
    } // End of the function
    function onLoadStart(target)
    {
        target._visible = false;
    } // End of the function
    function onLoadInit(target)
    {
        target._visible = true;
        if (this.__get__isWalking())
        {
            this.hide();
        } // end if
    } // End of the function
    function hide()
    {
        this.__get__clip()._visible = false;
    } // End of the function
    function show()
    {
        if (this.__get__isWalking())
        {
            return;
        } // end if
        this.__get__clip()._visible = true;
    } // End of the function
    function moveToPoint(to)
    {
        var _loc6 = flash.geom.Point.distance(this.__get__position(), to);
        var _loc5 = com.clubpenguin.math.MathHelper.getAngleBetweenPoints(this.__get__position(), to);
        var _loc2 = com.clubpenguin.math.MathHelper.get8DirectionByAngle(_loc5);
        if (_isSpringInStep)
        {
            this.__set__frame(_loc2 + 16);
        }
        else
        {
            this.__set__frame(_loc2 + 8);
        } // end else if
        var _loc3 = _loc6 / 4;
        if (isNaN(_loc3))
        {
            return;
        } // end if
        com.clubpenguin.engine.tweener.Tweener.addTween(this.__get__clip(), {transition: "linear", time: _loc3, _x: to.x, _y: to.y, useFrames: true, onUpdate: handleMoveUpdate, onUpdateScope: this, onComplete: handleMoveComplete, onCompleteScope: this, onCompleteParams: [_loc2]});
    } // End of the function
    function moveOnPath()
    {
        if (_path[0].x == this.__get__x() && _path[0].y == this.__get__y())
        {
            _path.shift();
        } // end if
        this.moveToPoint(_path[0]);
        _path.shift();
    } // End of the function
    function handleMoveComplete(directionFrame)
    {
        this.__set__frame(directionFrame);
        if (_path.length > 0)
        {
            this.moveOnPath();
        }
        else
        {
            this.updateListeners(com.clubpenguin.engine.Puffle.ON_MOVE_COMPLETE, this);
        } // end else if
    } // End of the function
    function handleMoveUpdate()
    {
        this.updateListeners(com.clubpenguin.engine.Puffle.ON_MOVE, this);
    } // End of the function
    function cancelInteraction()
    {
        com.clubpenguin.engine.tweener.Tweener.removeTweens(this.__get__clip());
        this.__set__clickable(true);
        this.__get__interactionClip().stopInteract();
        this.__get__interactionClip().interactionActive = false;
        this.__set__isStartingInteraction(false);
        this.__set__isEndingInteraction(false);
        this.__set__frame(1);
        this.__get__clip()._x = this.__get__lastSafeZonePoint().x;
        this.__get__clip()._y = this.__get__lastSafeZonePoint().y;
    } // End of the function
    function get clip()
    {
        return (_clip);
    } // End of the function
    function get position()
    {
        //return (new flash.geom.Point(this.x(), this.__get__y()));
    } // End of the function
    function get lastTraveledPath()
    {
        return (_lastTraveledPath);
    } // End of the function
    function get lastSafeZonePoint()
    {
        return (_lastSafeZonePoint);
    } // End of the function
    function set lastSafeZonePoint(value)
    {
        _lastSafeZonePoint = value;
        //return (this.lastSafeZonePoint());
        null;
    } // End of the function
    function set path(value)
    {
        _path = value.concat();
        _lastTraveledPath = value.concat();
        //return (this.path());
        null;
    } // End of the function
    function get id()
    {
        return (_id);
    } // End of the function
    function set id(value)
    {
        _id = value;
        //return (this.id());
        null;
    } // End of the function
    function get typeID()
    {
        return (_type);
    } // End of the function
    function set typeID(value)
    {
        _type = value;
        //return (this.typeID());
        null;
    } // End of the function
    function get isWalking()
    {
        return (_isWalking);
    } // End of the function
    function set isWalking(value)
    {
        _isWalking = value;
        if (_isWalking)
        {
            this.hide();
        }
        else
        {
            this.show();
        } // end else if
        //return (this.isWalking());
        null;
    } // End of the function
    function get clickable()
    {
        return (_clickable);
    } // End of the function
    function set clickable(value)
    {
        if (!_onReleaseEnabled)
        {
            return;
        } // end if
        _clickable = value;
        this.__get__clip().useHandCursor = value;
        //return (this.clickable());
        null;
    } // End of the function
    function get isSpringInStep()
    {
        return (_isSpringInStep);
    } // End of the function
    function set isSpringInStep(value)
    {
        _isSpringInStep = value;
        //return (this.isSpringInStep());
        null;
    } // End of the function
    function get isStartingInteraction()
    {
        return (_isStartingInteraction);
    } // End of the function
    function set isStartingInteraction(value)
    {
        _isStartingInteraction = value;
        //return (this.isStartingInteraction());
        null;
    } // End of the function
    function get isEndingInteraction()
    {
        return (_isEndingInteraction);
    } // End of the function
    function set isEndingInteraction(value)
    {
        _isEndingInteraction = value;
        //return (this.isEndingInteraction());
        null;
    } // End of the function
    function get interactionClip()
    {
        return (_interactionClip);
    } // End of the function
    function set interactionClip(clip)
    {
        _interactionClip = clip;
        //return (this.interactionClip());
        null;
    } // End of the function
    function get x()
    {
        //return (this.clip()._x);
    } // End of the function
    function get y()
    {
        //return (this.clip()._y);
    } // End of the function
    function get depth()
    {
        return (_depth);
    } // End of the function
    function set depth(value)
    {
        _depth = value;
        //return (this.depth());
        null;
    } // End of the function
    function set frame(frame)
    {
        _artClip.gotoAndStop(1);
        _artClip.gotoAndStop(frame);
        //return (this.frame());
        null;
    } // End of the function
    static var PATH_KEY_PREFIX = "puffle";
    static var ON_CLICK = "onClick";
    static var ON_MOVE = "onMove";
    static var ON_MOVE_COMPLETE = "onMoveComplete";
} // End of Class
