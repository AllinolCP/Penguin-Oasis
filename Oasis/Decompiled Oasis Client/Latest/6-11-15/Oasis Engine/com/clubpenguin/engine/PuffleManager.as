class com.clubpenguin.engine.PuffleManager
{
    var _shell, _engine, _interface, _puffles, _pathEngine;
    function PuffleManager(shell, engine, _interface)
    {
        _shell = shell;
        _engine = engine;
        this._interface = _interface;
        _puffles = [];
        _pathEngine = new com.clubpenguin.engine.pathfinding.PathEngine();
    } // End of the function
    function setupPathEngine()
    {
        _pathEngine.__set__blockedAreaClip(_engine.getRoomBlockMovieClip());
        _pathEngine.__set__waypointsClip(_engine.getRoomWaypointsClip());
    } // End of the function
    function clearPuffles()
    {
        _puffles = [];
    } // End of the function
    function addPuffleData(object)
    {
        var _loc4;
        if (!object.x || !object.y)
        {
            _loc4 = this.getRandomSafeZonePoint();
        }
        else
        {
            _loc4 = new flash.geom.Point(object.x, object.y);
        } // end else if
        var _loc6 = _engine.addPlayerDepth("puffle" + object.id);
        var _loc8 = _shell.getPath(com.clubpenguin.engine.Puffle.PATH_KEY_PREFIX + object.typeID);
        var _loc7 = _engine.getRoomMovieClip();
        var _loc5 = _loc7.createEmptyMovieClip("puffle" + object.id, _loc6);
        _loc5._x = _loc4.x;
        _loc5._y = _loc4.y;
        _engine.updatePuffleDepth(_loc5, _loc6);
        var _loc2 = new com.clubpenguin.engine.Puffle(_loc5, object.id);
        _loc2.__set__depth(_loc6);
        _loc2.__set__typeID(object.typeID);
        _loc2.__set__isWalking(object.isWalking);
        _loc2.loadArtAsset(_loc8);
        _loc2.__set__lastSafeZonePoint(_loc4);
        _loc2.addEventListener(com.clubpenguin.engine.Puffle.ON_MOVE, handlePuffleMove, this);
        _loc2.addEventListener(com.clubpenguin.engine.Puffle.ON_MOVE_COMPLETE, handlePuffleMoveComplete, this);
        if (_shell.isMyIgloo())
        {
            _loc2.enableOnRelease();
            _loc2.addEventListener(com.clubpenguin.engine.Puffle.ON_CLICK, handlePuffleClick, this);
        } // end if
        _puffles.push(_loc2);
    } // End of the function
    function getRandomSafeZonePoint()
    {
        var _loc3 = _engine.getPuffleSafeZoneClip();
        if (_loc3 == undefined)
        {
            var _loc2 = _engine.getRoomMovieClip();
            return (new flash.geom.Point(_loc2.start_x, _loc2.start_y));
        } // end if
        return (_pathEngine.getRandomPointInCircleWithClip(_loc3));
    } // End of the function
    function movePuffleToPointByID(id, point, happiness)
    {
        var _loc4 = _engine.getRoomBlockMovieClip();
        if (_loc4.hitTest(point.x, point.y, true))
        {
            return;
        } // end if
        var _loc2 = this.getPuffleByID(id);
        if (happiness > 50)
        {
            _loc2.__set__isSpringInStep(true);
        } // end if
        _loc2.__set__path([point]);
        _loc2.__set__lastSafeZonePoint(point);
        _loc2.moveOnPath();
    } // End of the function
    function makePuffleInteractWithFurnitureByID(id, furnitureItem)
    {
        var _loc2 = this.getPuffleByID(id);
        var _loc3 = _pathEngine.getPathBetween(_loc2.__get__position(), new flash.geom.Point(furnitureItem.x, furnitureItem.y));
        if (_loc3 == undefined)
        {
            _shell.sendPuffleInteraction(false, id, furnitureItem.interactive);
            return;
        } // end if
        _loc3[_loc3.length - 1].y = _loc3[_loc3.length - 1].y + com.clubpenguin.engine.PuffleManager.DEPTH_SORTING_Y_PADDING;
        _loc2.__set__isStartingInteraction(true);
        _loc2.__set__clickable(false);
        _loc2.__set__interactionClip(furnitureItem.mc.item);
        _loc2.__get__interactionClip().interactionActive = true;
        _loc2.__set__path(_loc3);
        _loc2.moveOnPath();
    } // End of the function
    function handlePuffleMove(puffle)
    {
        _engine.updatePuffleDepth(puffle.__get__clip(), puffle.__get__depth());
    } // End of the function
    function handlePuffleMoveComplete(puffle)
    {
        if (puffle.__get__isStartingInteraction())
        {
            puffle.hide();
            puffle.__get__interactionClip().puffleID = puffle.id;
            puffle.__get__interactionClip().interactionCompleteCallback = com.clubpenguin.util.Delegate.create(this, handlePuffleInteractionComplete);
            puffle.__get__interactionClip().interact(this.getPuffleColorByTypeID(puffle.__get__typeID()));
        }
        else if (puffle.__get__isEndingInteraction())
        {
            _shell.setPuffleInteractionCompleteById(puffle.__get__id());
            puffle.__set__isEndingInteraction(false);
            puffle.__set__clickable(true);
        } // end else if
    } // End of the function
    function handlePuffleInteractionComplete(id)
    {
        var _loc2 = this.getPuffleByID(id);
        _loc2.__set__isStartingInteraction(false);
        _loc2.__set__isEndingInteraction(true);
        _loc2.__get__interactionClip().interactionActive = false;
        _loc2.show();
        var _loc3 = _loc2.__get__lastTraveledPath().concat();
        _loc3.reverse();
        _loc2.__set__path(_loc3);
        _loc2.moveOnPath();
    } // End of the function
    function cancelAllPuffleInteractions()
    {
        var _loc3 = 0;
        var _loc4 = _puffles.length;
        while (_loc3 < _loc4)
        {
            var _loc2 = (com.clubpenguin.engine.Puffle)(_puffles[_loc3]);
            if (_loc2.__get__isStartingInteraction() || _loc2.__get__isEndingInteraction())
            {
                _loc2.cancelInteraction();
            } // end if
            ++_loc3;
        } // end while
    } // End of the function
    function showPuffleByID(id)
    {
        var _loc2 = this.getPuffleByID(id);
        _loc2.show();
    } // End of the function
    function showAllPuffles()
    {
        var _loc2 = 0;
        var _loc3 = _puffles.length;
        while (_loc2 < _loc3)
        {
            (com.clubpenguin.engine.Puffle)(_puffles[_loc2]).show();
            ++_loc2;
        } // end while
    } // End of the function
    function walkPuffleByID(id)
    {
        var _loc2 = this.getPuffleByID(id);
        _loc2.__set__isWalking(true);
    } // End of the function
    function stopWalkingPuffleByID(id)
    {
        var _loc2 = this.getPuffleByID(id);
        _loc2.__set__isWalking(false);
    } // End of the function
    function hidePuffleByID(id)
    {
        var _loc2 = this.getPuffleByID(id);
        _loc2.hide();
    } // End of the function
    function hideAllPuffles()
    {
        var _loc2 = 0;
        var _loc3 = _puffles.length;
        while (_loc2 < _loc3)
        {
            (com.clubpenguin.engine.Puffle)(_puffles[_loc2]).hide();
            ++_loc2;
        } // end while
    } // End of the function
    function getPuffleByID(id)
    {
        var _loc3 = 0;
        var _loc4 = _puffles.length;
        while (_loc3 < _loc4)
        {
            var _loc2 = (com.clubpenguin.engine.Puffle)(_puffles[_loc3]);
            if (_loc2.__get__id() == id)
            {
                return (_loc2);
            } // end if
            ++_loc3;
        } // end while
    } // End of the function
    function getPuffleColorByTypeID(typeID)
    {
        var _loc3 = _shell.getPuffleCrumbs();
        var _loc2 = _loc3[typeID].colour;
        if (!isNaN(_loc2))
        {
            return (_loc2);
        } // end if
        return (_loc3[0].colour);
    } // End of the function
    function updatePuffleFrameByID(id, frame)
    {
        var _loc2 = this.getPuffleByID(id);
        com.clubpenguin.engine.tweener.Tweener.removeTweens(_loc2.__get__clip());
        _loc2.__set__frame(frame);
    } // End of the function
    function handlePuffleClick(puffle)
    {
        _interface.showPuffleWidget(puffle.__get__id());
    } // End of the function
    static var DEPTH_SORTING_Y_PADDING = 2;
} // End of Class
