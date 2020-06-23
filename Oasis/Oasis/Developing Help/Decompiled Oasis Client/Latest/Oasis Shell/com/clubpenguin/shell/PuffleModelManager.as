class com.clubpenguin.shell.PuffleModelManager
{
    var _shell, _roomModels, _myModels, __get__myPuffles, __get__roomPuffles;
    function PuffleModelManager(shell)
    {
        _shell = shell;
        _roomModels = [];
        _myModels = [];
    } // End of the function
    function makeMyPuffleModelFromArray(arr)
    {
        var _loc4 = Number(arr[0]);
        var _loc2 = this.getMyPuffleById(_loc4);
        if (_loc2 == undefined)
        {
            _loc2 = new com.clubpenguin.shell.MyPuffleModel();
            _myModels.push(_loc2);
        } // end if
        _loc2.__set__id(_loc4);
        _loc2.__set__name(arr[1]);
        _loc2.__set__typeID(arr[2]);
        _loc2.__set__health(arr[3]);
        _loc2.__set__hunger(arr[4]);
        _loc2.__set__rest(arr[5]);
        _loc2.__set__maxHealth(arr[6]);
        _loc2.__set__maxHunger(arr[7]);
        _loc2.__set__maxRest(arr[8]);
        return (_loc2);
    } // End of the function
    function makeRoomPuffleModelFromArray(arr)
    {
        var _loc4 = arr[0];
        var _loc2 = this.getRoomPuffleById(_loc4);
        if (_loc2 == undefined)
        {
            _loc2 = new com.clubpenguin.shell.RoomPuffleModel();
            _loc2.addEventListener(com.clubpenguin.shell.RoomPuffleModel.WALK, handlePuffleWalk, this);
            _loc2.addEventListener(com.clubpenguin.shell.RoomPuffleModel.FRAME, handlePuffleFrame, this);
            _loc2.addEventListener(com.clubpenguin.shell.RoomPuffleModel.MOVE, handlePuffleMove, this);
            _roomModels.push(_loc2);
        } // end if
        _loc2.__set__id(_loc4);
        _loc2.__set__typeID(arr[1]);
        _loc2.__set__health(arr[2]);
        _loc2.__set__hunger(arr[3]);
        _loc2.__set__rest(arr[4]);
        _loc2.__set__maxHealth(arr[5]);
        _loc2.__set__maxHunger(arr[6]);
        _loc2.__set__maxRest(arr[7]);
        _loc2.__set__x(arr[8]);
        _loc2.__set__y(arr[9]);
        _loc2.__set__isWalking(arr[10]);
        return (_loc2);
    } // End of the function
    function handlePuffleWalk(puffle)
    {
        var _loc3 = puffle.__get__id();
        var _loc2 = puffle.__get__isWalking();
        _shell.updateListeners(_shell.PUFFLE_WALK, {id: _loc3, isWalking: _loc2});
    } // End of the function
    function handlePuffleFrame(puffle)
    {
        var _loc3 = puffle.__get__id();
        var _loc2 = puffle.__get__frame();
        _shell.updateListeners(_shell.PUFFLE_FRAME, {id: _loc3, frame: _loc2});
    } // End of the function
    function handlePuffleMove(puffle)
    {
        var _loc4 = puffle.__get__id();
        var _loc5 = puffle.__get__x();
        var _loc6 = puffle.__get__y();
        var _loc3 = puffle.__get__happy();
        _shell.updateListeners(_shell.PUFFLE_MOVE, {id: _loc4, x: _loc5, y: _loc6, happy: _loc3});
    } // End of the function
    function updatePuffleStatsById(id, health, hunger, rest)
    {
        var _loc2 = this.getRoomPuffleById(id);
        if (_loc2 == undefined)
        {
            return;
        } // end if
        _loc2.__set__health(health);
        _loc2.__set__hunger(hunger);
        _loc2.__set__rest(rest);
        _loc2 = this.getMyPuffleById(id);
        if (_loc2 == undefined)
        {
            return;
        } // end if
        _loc2.__set__health(health);
        _loc2.__set__hunger(hunger);
        _loc2.__set__rest(rest);
    } // End of the function
    function getRoomPuffleById(id)
    {
        var _loc3 = _roomModels.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (_roomModels[_loc2].id == id)
            {
                return (_roomModels[_loc2]);
            } // end if
        } // end of for
        return;
    } // End of the function
    function getMyPuffleById(id)
    {
        var _loc3 = _myModels.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (_myModels[_loc2].id == id)
            {
                return (_myModels[_loc2]);
            } // end if
        } // end of for
        return;
    } // End of the function
    function isMyPuffleById(id)
    {
        var _loc3 = _myModels.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (_myModels[_loc2].id == id)
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    function clearRoomPuffleModelArray()
    {
        var _loc3 = _roomModels.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            _roomModels[_loc2].removeEventListener(com.clubpenguin.shell.RoomPuffleModel.WALK, handlePuffleWalk, this);
            _roomModels[_loc2].removeEventListener(com.clubpenguin.shell.RoomPuffleModel.FRAME, handlePuffleFrame, this);
            _roomModels[_loc2].removeEventListener(com.clubpenguin.shell.RoomPuffleModel.MOVE, handlePuffleMove, this);
            _roomModels[_loc2].cleanUp();
        } // end of for
        _roomModels = [];
    } // End of the function
    function get roomPuffles()
    {
        return (_roomModels.slice());
    } // End of the function
    function get myPuffles()
    {
        return (_myModels.slice());
    } // End of the function
    function toString()
    {
        return ("PuffleModelManager. Shell reference: " + _shell + ", room models: " + _roomModels + ", my models: " + _myModels);
    } // End of the function
} // End of Class
