class com.clubpenguin.shell.PuffleManager
{
    var _shell, _airtower, _modelManager, _puffleStatsForType, _roomPuffles, _myPuffles, __get__myPuffleCount;
    function PuffleManager(shell, airtower, puffleStatsForType, modelManager)
    {
        _shell = shell;
        _airtower = airtower;
        _modelManager = modelManager;
        _puffleStatsForType = puffleStatsForType;
    } // End of the function
    function init()
    {
        this.attachListeners();
    } // End of the function
    function attachListeners()
    {
        _airtower.addListener(_airtower.GET_MY_PLAYER_PUFFLES, handleGetMyPuffles, this);
        _airtower.addListener(_airtower.GET_PLAYER_PUFFLES, handleGetPufflesByPlayerId, this);
        _airtower.addListener(_airtower.PUFFLE_FRAME, handleSendPuffleFrame, this);
        _airtower.addListener(_airtower.PUFFLE_MOVE, handleSendPuffleMove, this);
        _airtower.addListener(_airtower.ADOPT_PUFFLE, handleSendAdoptPuffle, this);
        _airtower.addListener(_airtower.INTERACTION_PLAY, handleSendPlayInteraction, this);
        _airtower.addListener(_airtower.INTERACTION_REST, handleSendRestInteraction, this);
        _airtower.addListener(_airtower.INTERACTION_FEED, handleSendFeedInteraction, this);
        _airtower.addListener(_airtower.PUFFLE_INIT_INTERACTION_PLAY, handleSendPuffleInitPlayInteraction, this);
        _airtower.addListener(_airtower.PUFFLE_INIT_INTERACTION_REST, handleSendPuffleInitRestInteraction, this);
        _airtower.addListener(_airtower.PLAY_PUFFLE, handleSendPufflePlay, this);
        _airtower.addListener(_airtower.REST_PUFFLE, handleSendPuffleRest, this);
        _airtower.addListener(_airtower.BATH_PUFFLE, handleSendPuffleBath, this);
        _airtower.addListener(_airtower.FEED_PUFFLE, handleSendPuffleFood, this);
        _airtower.addListener(_airtower.TREAT_PUFFLE, handleSendPuffleTreat, this);
        _airtower.addListener(_airtower.WALK_PUFFLE, handleSendPuffleWalk, this);
        _shell.addListener(_shell.IGLOO_INIT_COMPLETE, handleIglooInitComplete, this);
        _shell.addListener(_shell.FURNITURE_INTERACTIVE_TYPES, handleFurnitureInteractiveTypes, this);
        _shell.addListener(_shell.IGLOO_EDIT_MODE, handleIglooEditMode, this);
        _shell.addListener(_shell.JOIN_ROOM, com.clubpenguin.util.Delegate.create(this, cleanUpRoomPuffles));
    } // End of the function
    function handleFurnitureInteractiveTypes(rules)
    {
        var _loc2 = rules.playInteractionAllowed || false;
        var _loc3 = rules.restInteractionAllowed || false;
        var _loc1 = rules.feedInteractionAllowed || false;
        com.clubpenguin.shell.RoomPuffle.setAllowPlayInteraction(_loc2);
        com.clubpenguin.shell.RoomPuffle.setAllowRestInteraction(_loc3);
        com.clubpenguin.shell.RoomPuffle.setAllowFeedInteraction(_loc1);
    } // End of the function
    function handleIglooEditMode(event)
    {
        var _loc4 = event.active || false;
        var _loc3 = 0;
        var _loc5 = _roomPuffles.length;
        while (_loc3 < _loc5)
        {
            var _loc2 = _roomPuffles[_loc3];
            if (_loc4)
            {
                _loc2.stopBrain();
            }
            else
            {
                _loc2.startBrain();
            } // end else if
            ++_loc3;
        } // end while
    } // End of the function
    function getMyPuffles()
    {
        if (!_pufflesFetched)
        {
            _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.GET_MY_PLAYER_PUFFLES, [], "str", _shell.getCurrentServerRoomId());
            return;
        } // end if
        _shell.$e("[SHELL] PuffleManager.getMyPuffles() -> Puffles already fetched! cant get them again");
    } // End of the function
    function handleGetMyPuffles(obj)
    {
        var _loc6 = obj.shift();
        _myPuffles = new Array();
        var _loc4;
        var _loc2;
        var _loc3;
        for (var _loc3 in obj)
        {
            _loc4 = obj[_loc3].split("|");
            _loc2 = this.makeMyPuffleFromCrumb(_loc4);
            _loc2.startStats();
            _myPuffles.push(_loc2);
        } // end of for...in
        _pufflesFetched = true;
    } // End of the function
    function getPufflesByPlayerId(player_id)
    {
        if (!isNaN(player_id))
        {
            _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.GET_PLAYER_PUFFLES, [player_id], "str", _shell.getCurrentServerRoomId());
            return;
        } // end if
        _shell.$e("[SHELL] PuffleManager.getPufflesByPlayerId() -> player id is not a valid number! player_id: " + player_id);
    } // End of the function
    function handleGetPufflesByPlayerId(obj)
    {
        var _loc6 = obj.shift();
        if (_roomPuffles != undefined)
        {
            this.cleanUpRoomPuffles();
        } // end if
        _roomPuffles = new Array();
        var _loc2;
        var _loc3;
        var _loc4;
        for (var _loc4 in obj)
        {
            _loc2 = obj[_loc4].split("|");
            _loc3 = this.makeRoomPuffleFromCrumb(_loc2);
            _roomPuffles.push(_loc3);
            if (_modelManager.isMyPuffleById(_loc3.__get__id()))
            {
                _modelManager.updatePuffleStatsById(_loc3.__get__id(), Number(_loc2[3]), Number(_loc2[4]), Number(_loc2[5]));
            } // end if
        } // end of for...in
        _shell.updateListeners(_shell.GET_IGLOO_DETAILS, null);
    } // End of the function
    function handleIglooInitComplete()
    {
        var _loc3 = _modelManager.__get__roomPuffles();
        var _loc14 = _loc3.length;
        for (var _loc2 = 0; _loc2 < _loc14; ++_loc2)
        {
            var _loc6 = _loc3[_loc2].id;
            var _loc4 = _loc3[_loc2].typeID;
            var _loc5 = _loc3[_loc2].isWalking;
            var _loc7 = _loc3[_loc2].x;
            var _loc8 = _loc3[_loc2].y;
            _shell.updateListeners(_shell.ADD_PUFFLE, {id: _loc6, typeID: _loc4, isWalking: _loc5, x: _loc7, y: _loc8});
        } // end of for
    } // End of the function
    function startRoomPuffleBrains()
    {
        var _loc3 = _roomPuffles.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            _roomPuffles[_loc2].startBrain();
        } // end of for
    } // End of the function
    function stopRoomPuffleBrains()
    {
        var _loc3 = _roomPuffles.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            _roomPuffles[_loc2].stopBrain();
        } // end of for
    } // End of the function
    function handlePuffleRequestFrame(event)
    {
        var _loc3 = event.id;
        var _loc2 = event.frame;
        if (isNaN(_loc3))
        {
            _shell.$e("[SHELL] PuffleManager.handlePuffleRequestFrame() -> Puffle id is not a real number: " + _loc3);
            return;
        } // end if
        if (isNaN(_loc2))
        {
            _shell.$e("[SHELL] PuffleManager.handlePuffleRequestFrame() -> Frame is undefined!: " + _loc2);
            return;
        } // end if
        _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.PUFFLE_FRAME, [_loc3, _loc2], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function handleSendPuffleFrame(event)
    {
        var _loc6 = event[0];
        var _loc3 = Number(event[1]);
        var _loc2 = Number(event[2]);
        if (isNaN(_loc3))
        {
            _shell.$e("[SHELL] PuffleManager.handleSendPuffleFrame() -> Puffle ID is not a real number: " + _loc3);
            return;
        } // end if
        if (isNaN(_loc2))
        {
            _shell.$e("[SHELL] PuffleManager.handleSendPuffleFrame() -> Puffle frame is not a real number. puffle_frame: " + _loc2);
            return;
        } // end if
        var _loc5 = this.getRoomPuffleById(_loc3);
        _loc5.__set__frame(_loc2);
    } // End of the function
    function handlePuffleRequestMove(puffle)
    {
        _shell.updateListeners(_shell.REQUEST_PUFFLE_MOVE, {id: puffle.__get__id()});
    } // End of the function
    function sendPuffleMove(id, xpos, ypos)
    {
        if (_shell.getPlayersInRoomCount() > 1)
        {
            _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.PUFFLE_MOVE, [id, xpos, ypos], "str", _shell.getCurrentServerRoomId());
        }
        else
        {
            var _loc2 = this.getRoomPuffleById(id);
            _loc2.moveTo(xpos, ypos);
        } // end else if
    } // End of the function
    function handleSendPuffleMove(arr)
    {
        var _loc7 = arr[0];
        var _loc3 = Number(arr[1]);
        var _loc5 = Number(arr[2]);
        var _loc6 = Number(arr[3]);
        var _loc4 = this.getRoomPuffleById(_loc3);
        if (_loc4 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.handlePuffleMove() -> Puffle was undefined! id: " + _loc3);
            return;
        } // end if
        _loc4.moveTo(_loc5, _loc6);
    } // End of the function
    function sendStartPuffleWalk(puffleID)
    {
        var _loc2 = this.getRoomPuffleById(puffleID);
        _loc2.requestStartWalk();
    } // End of the function
    function handlePuffleRequestStartWalk(puffle)
    {
        if (isNaN(puffle.__get__id()))
        {
            _shell.$e("[SHELL] PuffleManager.handlePuffleRequestStartWalk() -> Puffle Id is not a real number. id: " + puffle.__get__id());
            return;
        } // end if
        if (this.getIndexInRoomById(puffle.__get__id()) == -1)
        {
            _shell.$e("[SHELL] PuffleManager.handlePuffleRequestStartWalk() -> Puffle was not found in the room! id: " + puffle.__get__id());
            return;
        } // end if
        _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.WALK_PUFFLE, [puffle.__get__id(), com.clubpenguin.shell.PuffleManager.START_WALK], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function handlePuffleRequestStopWalk(puffle)
    {
        if (isNaN(puffle.__get__id()))
        {
            _shell.$e("[SHELL] PuffleManager.handlePuffleRequestStopWalk() -> No puffles were found that were being walked! id: " + puffle.__get__id());
            return;
        } // end if
        if (this.getIndexInRoomById(puffle.__get__id()) == -1)
        {
            _shell.$e("[SHELL] PuffleManager.handlePuffleRequestStopWalk() -> Puffle was not found in the room! id: " + puffle.__get__id());
            return;
        } // end if
        _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.WALK_PUFFLE, [puffle.__get__id(), com.clubpenguin.shell.PuffleManager.STOP_WALK], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function handleSendPuffleWalk(event)
    {
        var _loc8 = event[0];
        var _loc6 = Number(event[1]);
        var _loc4 = event[2].split("|");
        var _loc5 = Number(_loc4[0]);
        var _loc3 = Boolean(Number(_loc4[12]));
        var _loc2 = this.getRoomPuffleById(_loc5);
        if (_loc2 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.handleSendPuffleWalk() -> Puffle was not found in the room! id: " + _loc5);
            return;
        } // end if
        if (_loc3)
        {
            if (_shell.isMyPlayer(_loc6))
            {
                _shell.addPuffleToHand(_loc2.__get__typeID());
            } // end if
            _currentWalkingId = _loc2.id;
        }
        else
        {
            _currentWalkingId = undefined;
        } // end else if
        _loc2.__set__isWalking(_loc3);
    } // End of the function
    function stopAllPufflesWalking()
    {
        if (_roomPuffles == undefined)
        {
            if (_currentWalkingId == undefined)
            {
                return;
            } // end if
            _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.WALK_PUFFLE, [_currentWalkingId, 0], "str", _shell.getCurrentServerRoomId());
            _currentWalkingId = undefined;
            return;
        } // end if
        var _loc3 = _roomPuffles.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            _roomPuffles[_loc2].requestStopWalk();
        } // end of for
    } // End of the function
    function requestPufflePlay(puffleID)
    {
        var _loc2 = this.getRoomPuffleById(puffleID);
        _loc2.requestPlay();
    } // End of the function
    function handlePuffleRequestPlay(puffle)
    {
        if (isNaN(puffle.__get__id()))
        {
            _shell.$e("[SHELL] PuffleManager.sendPufflePlay() -> Puffle Id is not a real number. id: " + puffle.__get__id());
            return;
        } // end if
        if (this.getIndexInRoomById(puffle.__get__id()) == -1)
        {
            _shell.$e("[SHELL] PuffleManager.sendPufflePlay() -> Puffle was not found in the room! id: " + puffle.__get__id());
            return;
        } // end if
        _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.PLAY_PUFFLE, [puffle.__get__id()], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function handleSendPufflePlay(event)
    {
        var _loc10 = event[0];
        var _loc2 = event[1].split("|");
        var _loc5 = event[2];
        var _loc3 = _loc2[0];
        var _loc4 = this.getRoomPuffleById(_loc3);
        if (_loc4 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.PuffleManager -> handleSendPuffleRest() -> Puffle was not found in the room! id: " + _loc3);
            return;
        } // end if
        _loc4.play(_loc5);
        var _loc8 = Number(_loc2[3]);
        var _loc6 = Number(_loc2[4]);
        var _loc7 = Number(_loc2[5]);
        _modelManager.updatePuffleStatsById(_loc3, _loc8, _loc6, _loc7);
    } // End of the function
    function requestPuffleRest(puffleID)
    {
        var _loc2 = this.getRoomPuffleById(puffleID);
        _loc2.requestRest();
    } // End of the function
    function handlePuffleRequestRest(puffle)
    {
        if (isNaN(puffle.__get__id()))
        {
            _shell.$e("[SHELL] PuffleManager.sendPuffleRest() -> Puffle Id is not a real number. id: " + puffle.__get__id());
            return;
        } // end if
        if (this.getIndexInRoomById(puffle.__get__id()) == -1)
        {
            _shell.$e("[SHELL] PuffleManager.sendPuffleRest() -> Puffle was not found in the room! id: " + puffle.__get__id());
            return;
        } // end if
        _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.REST_PUFFLE, [puffle.__get__id()], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function handleSendPuffleRest(event)
    {
        var _loc8 = event[0];
        var _loc2 = event[1].split("|");
        var _loc3 = _loc2[0];
        var _loc4 = this.getRoomPuffleById(_loc3);
        if (_loc4 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.handleSendPuffleRest() -> Puffle was not found in the room! id: " + _loc3);
            return;
        } // end if
        _loc4.rest();
        var _loc7 = Number(_loc2[3]);
        var _loc5 = Number(_loc2[4]);
        var _loc6 = Number(_loc2[5]);
        _modelManager.updatePuffleStatsById(_loc3, _loc7, _loc5, _loc6);
    } // End of the function
    function requestPuffleBath(puffleID)
    {
        var _loc2 = this.getRoomPuffleById(puffleID);
        _loc2.requestBath();
    } // End of the function
    function handlePuffleRequestBath(puffle)
    {
        if (isNaN(puffle.__get__id()))
        {
            _shell.$e("[SHELL] PuffleManager.sendPuffleBath() -> Puffle Id is not a real number. id: " + puffle.__get__id());
            return;
        } // end if
        if (this.getIndexInRoomById(puffle.__get__id()) == -1)
        {
            _shell.$e("[SHELL] PuffleManager.sendPuffleBath() -> Puffle was not found in the room! id: " + puffle.__get__id());
            return;
        } // end if
        _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.BATH_PUFFLE, [puffle.__get__id()], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function handleSendPuffleBath(event)
    {
        var _loc10 = event[0];
        var _loc9 = Number(event[1]);
        var _loc2 = event[2].split("|");
        var _loc11 = Number(event[3]);
        var _loc3 = _loc2[0];
        var _loc5 = this.getRoomPuffleById(_loc3);
        if (_loc5 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.handleSendPuffleBath() -> Puffle was not found in the room! id: " + _loc3);
            return;
        } // end if
        _loc5.bath();
        var _loc8 = Number(_loc2[3]);
        var _loc6 = Number(_loc2[4]);
        var _loc7 = Number(_loc2[5]);
        _modelManager.updatePuffleStatsById(_loc3, _loc8, _loc6, _loc7);
        if (_shell.isMyIgloo())
        {
            _shell.setMyPlayerTotalCoins(_loc9);
        } // end if
    } // End of the function
    function requestPuffleFeed(puffleID)
    {
        var _loc2 = this.getRoomPuffleById(puffleID);
        _loc2.requestFeed();
    } // End of the function
    function handlePuffleRequestFeed(puffle)
    {
        if (isNaN(puffle.__get__id()))
        {
            _shell.$e("[SHELL] PuffleManager.sendPuffleFood() -> Puffle Id is not a real number. id: " + puffle.__get__id());
            return;
        } // end if
        if (this.getIndexInRoomById(puffle.__get__id()) == -1)
        {
            _shell.$e("[SHELL] PuffleManager.sendPuffleFood() -> Puffle was not found in the room! id: " + puffle.__get__id());
            return;
        } // end if
        _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.FEED_PUFFLE, [puffle.__get__id()], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function handleSendPuffleFood(event)
    {
        var _loc10 = event[0];
        var _loc9 = Number(event[1]);
        var _loc2 = event[2].split("|");
        var _loc11 = event[3];
        var _loc3 = _loc2[0];
        var _loc5 = this.getRoomPuffleById(_loc3);
        if (_loc5 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.handleSendPuffleFood() -> Puffle was not found in the room! id: " + _loc3);
            return;
        } // end if
        _loc5.feed();
        var _loc8 = Number(_loc2[3]);
        var _loc6 = Number(_loc2[4]);
        var _loc7 = Number(_loc2[5]);
        _modelManager.updatePuffleStatsById(_loc3, _loc8, _loc6, _loc7);
        if (_shell.isMyIgloo())
        {
            _shell.setMyPlayerTotalCoins(_loc9);
        } // end if
    } // End of the function
    function sendPuffleCookie(id)
    {
        if (isNaN(id))
        {
            _shell.$e("[SHELL] PuffleManager.sendPuffleTreat() -> Puffle Id is not a real number. id: " + id);
            return;
        } // end if
        if (this.getIndexInRoomById(id) == -1)
        {
            _shell.$e("[SHELL] PuffleManager.sendPuffleTreat() -> Puffle was not found in the room! id: " + id);
            return;
        } // end if
        _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.TREAT_PUFFLE, [id, com.clubpenguin.shell.RoomPuffle.TREAT_COOKIE], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function sendPuffleGum(id)
    {
        if (isNaN(id))
        {
            _shell.$e("[SHELL] PuffleManager.sendPuffleTreat() -> Puffle Id is not a real number. id: " + id);
            return;
        } // end if
        if (this.getIndexInRoomById(id) == -1)
        {
            _shell.$e("[SHELL] PuffleManager.sendPuffleTreat() -> Puffle was not found in the room! id: " + id);
            return;
        } // end if
        _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.TREAT_PUFFLE, [id, com.clubpenguin.shell.RoomPuffle.TREAT_GUM], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function handleSendPuffleTreat(event)
    {
        var _loc11 = event[0];
        var _loc8 = Number(event[1]);
        var _loc2 = event[2].split("|");
        var _loc9 = event[3];
        var _loc3 = _loc2[0];
        var _loc5 = this.getRoomPuffleById(_loc3);
        if (_loc5 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.handleSendPuffleTreat() -> Puffle was not found in the room! id: " + _loc3);
            return;
        } // end if
        _loc5.treat(_loc9);
        var _loc7 = Number(_loc2[3]);
        var _loc10 = Number(_loc2[4]);
        var _loc6 = Number(_loc2[5]);
        _modelManager.updatePuffleStatsById(_loc3, _loc7, _loc10, _loc6);
        if (_shell.isMyIgloo())
        {
            _shell.setMyPlayerTotalCoins(_loc8);
        } // end if
    } // End of the function
    function sendAdoptPuffle(typeID, puffleName)
    {
        if (this.__get__myPuffleCount() >= com.clubpenguin.shell.PuffleManager.MAX_PUFFLES)
        {
            _shell.updateListeners(_shell.ADOPT_PUFFLE, {success: false});
            return (false);
        } // end if
        if (isNaN(typeID))
        {
            _shell.$e("[SHELL] PuffleManager.sendAdoptPuffle() -> Puffle type was not a real number! puffle_type: " + typeID);
            return (false);
        } // end if
        if (!_shell.isValidString(puffleName))
        {
            _shell.$e("[SHELL] PuffleManager.sendAdoptPuffle() -> Puffle name was not a real string! puffleName: " + puffleName);
            return (false);
        } // end if
        _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _airtower.ADOPT_PUFFLE, [typeID, puffleName], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function handleSendAdoptPuffle(event)
    {
        var _loc6 = event[0];
        var _loc2 = Number(event[1]);
        _shell.setMyPlayerTotalCoins(_loc2);
        var _loc4 = event[2].split("|");
        var _loc5 = this.makeMyPuffleFromCrumb(_loc4);
        if (_myPuffles == undefined)
        {
            _myPuffles = new Array();
        } // end if
        _myPuffles.push(_loc5);
        _shell.updateListeners(_shell.ADOPT_PUFFLE, {success: true});
    } // End of the function
    function handlePuffleRequestInteraction(event)
    {
        var _loc2;
        switch (event.interactionType)
        {
            case com.clubpenguin.shell.RoomPuffle.INTERACTION_PLAY:
            {
                _loc2 = _shell.INTERACTIVE_PLAY;
                break;
            } 
            case com.clubpenguin.shell.RoomPuffle.INTERACTION_REST:
            {
                _loc2 = _shell.INTERACTIVE_REST;
                break;
            } 
            case com.clubpenguin.shell.RoomPuffle.INTERACTION_FEED:
            {
                _loc2 = _shell.INTERACTIVE_FEED;
                break;
            } 
        } // End of switch
        _shell.updateListeners(_shell.REQUEST_PUFFLE_INTERACTION, {id: event.id, interactionType: _loc2});
    } // End of the function
    function sendPuffleInteraction(success, puffleID, interactionType, xpos, ypos)
    {
        if (success)
        {
            var _loc4 = this.getRoomPuffleById(puffleID);
            if (_loc4 == undefined)
            {
                return;
            } // end if
            var _loc3;
            if (_loc4.__get__selfInteract())
            {
                if (interactionType == _shell.INTERACTIVE_PLAY)
                {
                    _loc3 = _airtower.PUFFLE_INIT_INTERACTION_PLAY;
                }
                else if (interactionType == _shell.INTERACTIVE_REST)
                {
                    _loc3 = _airtower.PUFFLE_INIT_INTERACTION_REST;
                }
                else
                {
                    _shell.$e("[SHELL] sendPuffleInteraction() -> Incorrect self initiated interaction type! interactionType: " + interactionType);
                    return;
                } // end else if
            }
            else if (interactionType == _shell.INTERACTIVE_PLAY)
            {
                _loc3 = _airtower.INTERACTION_PLAY;
            }
            else if (interactionType == _shell.INTERACTIVE_REST)
            {
                _loc3 = _airtower.INTERACTION_REST;
            }
            else if (interactionType == _shell.INTERACTIVE_FEED)
            {
                _loc3 = _airtower.INTERACTION_FEED;
            }
            else
            {
                _shell.$e("[SHELL] sendPuffleInteraction() -> Incorrect interaction type! interactionType: " + interactionType);
                return;
            } // end else if
            if (_loc3 == undefined)
            {
                return;
            } // end if
            _airtower.send(_airtower.PLAY_EXT, _airtower.PET_HANDLER + "#" + _loc3, [puffleID, xpos, ypos], "str", _shell.getCurrentServerRoomId());
        }
        else
        {
            _loc4 = this.getRoomPuffleById(puffleID);
            if (_loc4 == undefined)
            {
                return;
            } // end if
            if (_loc4.__get__selfInteract())
            {
                _loc4.cancelSelfInteraction();
                return;
            } // end if
            if (interactionType == _shell.INTERACTIVE_PLAY)
            {
                _loc4.forceNormalPlay();
            }
            else if (interactionType == _shell.INTERACTIVE_REST)
            {
                _loc4.forceNormalRest();
            }
            else if (interactionType == _shell.INTERACTIVE_FEED)
            {
                _loc4.forceNormalFeed();
            } // end else if
        } // end else if
    } // End of the function
    function handleSendPuffleInitPlayInteraction(event)
    {
        var _loc9 = Number(event[0]);
        var _loc2 = Number(event[1]);
        var _loc5 = Number(event[2]);
        var _loc6 = Number(event[3]);
        var _loc4 = this.getRoomPuffleById(_loc2);
        if (_loc4 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.handleSendPuffleInitPlayInteraction() -> Puffle was not found in the room! id: " + _loc2);
            return;
        } // end if
        _loc4.startInteraction();
        _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id: _loc2, interactionType: _shell.INTERACTIVE_PLAY, x: _loc5, y: _loc6});
    } // End of the function
    function handleSendPuffleInitRestInteraction(event)
    {
        var _loc9 = Number(event[0]);
        var _loc2 = Number(event[1]);
        var _loc5 = Number(event[2]);
        var _loc6 = Number(event[3]);
        var _loc4 = this.getRoomPuffleById(_loc2);
        if (_loc4 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.handleSendPuffleInitRestInteraction() -> Puffle was not found in the room! id: " + _loc2);
            return;
        } // end if
        _loc4.startInteraction();
        _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id: _loc2, interactionType: _shell.INTERACTIVE_REST, x: _loc5, y: _loc6});
    } // End of the function
    function handleSendPlayInteraction(event)
    {
        var _loc13 = event[0];
        var _loc2 = event[1].split("|");
        var _loc3 = Number(_loc2[0]);
        var _loc9 = Number(event[2]);
        var _loc10 = Number(event[3]);
        var _loc5 = this.getRoomPuffleById(_loc3);
        if (_loc5 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.handleSendPuffleInteraction() -> Puffle was not found in the room! id: " + _loc3);
            return;
        } // end if
        var _loc8 = Number(_loc2[3]);
        var _loc6 = Number(_loc2[4]);
        var _loc7 = Number(_loc2[5]);
        _modelManager.updatePuffleStatsById(_loc3, _loc8, _loc6, _loc7);
        _loc5.startInteraction();
        _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id: _loc3, interactionType: _shell.INTERACTIVE_PLAY, x: _loc9, y: _loc10});
    } // End of the function
    function handleSendRestInteraction(event)
    {
        var _loc13 = event[0];
        var _loc2 = event[1].split("|");
        var _loc3 = Number(_loc2[0]);
        var _loc9 = Number(event[2]);
        var _loc10 = Number(event[3]);
        var _loc5 = this.getRoomPuffleById(_loc3);
        if (_loc5 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.handleSendPuffleInteraction() -> Puffle was not found in the room! id: " + _loc3);
            return;
        } // end if
        var _loc8 = Number(_loc2[3]);
        var _loc6 = Number(_loc2[4]);
        var _loc7 = Number(_loc2[5]);
        _modelManager.updatePuffleStatsById(_loc3, _loc8, _loc6, _loc7);
        _loc5.startInteraction();
        _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id: _loc3, interactionType: _shell.INTERACTIVE_REST, x: _loc9, y: _loc10});
    } // End of the function
    function handleSendFeedInteraction(event)
    {
        var _loc14 = event[0];
        var _loc8 = Number(event[1]);
        var _loc2 = event[2].split("|");
        var _loc3 = Number(_loc2[0]);
        var _loc9 = Number(event[3]);
        var _loc10 = Number(event[4]);
        var _loc5 = this.getRoomPuffleById(_loc3);
        if (_shell.isMyIgloo())
        {
            _shell.setMyPlayerTotalCoins(_loc8);
        } // end if
        if (_loc5 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.handleSendPuffleInteraction() -> Puffle was not found in the room! id: " + _loc3);
            return;
        } // end if
        var _loc7 = Number(_loc2[3]);
        var _loc11 = Number(_loc2[4]);
        var _loc6 = Number(_loc2[5]);
        _modelManager.updatePuffleStatsById(_loc3, _loc7, _loc11, _loc6);
        _loc5.startInteraction();
        _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id: _loc3, interactionType: _shell.INTERACTIVE_FEED, x: _loc9, y: _loc10});
    } // End of the function
    function setPuffleInteractionCompleteById(id)
    {
        var _loc2 = this.getRoomPuffleById(id);
        if (_loc2 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.setPuffleInteractionCompleteById() -> Puffle was not found in the room! id: " + id);
            return;
        } // end if
        _loc2.stopInteraction();
    } // End of the function
    function disablePuffleInteractionByID(id)
    {
        var _loc2 = this.getRoomPuffleById(id);
        if (_loc2 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.disablePuffleInteractionByID() -> Puffle was not found in the room! id: " + id);
            return;
        } // end if
        _loc2.__set__interactionEnabled(false);
    } // End of the function
    function enablePuffleInteractionByID(id)
    {
        var _loc2 = this.getRoomPuffleById(id);
        if (_loc2 == undefined)
        {
            _shell.$e("[SHELL] PuffleManager.enablePuffleInteractionByID() -> Puffle was not found in the room! id: " + id);
            return;
        } // end if
        _loc2.__set__interactionEnabled(true);
    } // End of the function
    function makeMyPuffleFromCrumb(arr)
    {
        var _loc8 = Number(arr[0]);
        var _loc9 = String(arr[1]);
        var _loc3 = Number(arr[2]);
        var _loc10 = Number(arr[3]);
        var _loc14 = Number(arr[4]);
        var _loc11 = Number(arr[5]);
        var _loc6 = Number(_puffleStatsForType[_loc3].max_health);
        var _loc7 = Number(_puffleStatsForType[_loc3].max_hunger);
        var _loc5 = Number(_puffleStatsForType[_loc3].max_rest);
        var _loc4 = [_loc8, _loc9, _loc3, _loc10, _loc14, _loc11, _loc6, _loc7, _loc5];
        var _loc13 = _modelManager.makeMyPuffleModelFromArray(_loc4);
        var _loc12 = new com.clubpenguin.shell.MyPuffle(_loc13);
        return (_loc12);
    } // End of the function
    function makeRoomPuffleFromCrumb(arr)
    {
        var _loc8 = Number(arr[0]);
        var _loc4 = Number(arr[2]);
        var _loc16 = Number(arr[3]);
        var _loc15 = Number(arr[4]);
        var _loc17 = Number(arr[5]);
        var _loc6 = Number(arr[6]);
        var _loc7 = Number(arr[7]);
        var _loc5 = Number(arr[8]);
        var _loc12 = Number(arr[10]);
        var _loc9 = Number(arr[11]);
        var _loc10 = Boolean(Number(arr[12]));
        _loc6 = Number(_puffleStatsForType[_loc4].max_health);
        _loc7 = Number(_puffleStatsForType[_loc4].max_hunger);
        _loc5 = Number(_puffleStatsForType[_loc4].max_rest);
        var _loc13 = [_loc8, _loc4, _loc16, _loc15, _loc17, _loc6, _loc7, _loc5, _loc12, _loc9, _loc10];
        var _loc11 = _modelManager.makeRoomPuffleModelFromArray(_loc13);
        var _loc2 = new com.clubpenguin.shell.RoomPuffle(_loc11);
        var _loc14 = _modelManager.isMyPuffleById(_loc8);
        if (_loc14)
        {
            _loc2.__set__isMine(true);
        } // end if
        _loc2.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE, handlePuffleRequestMove, this);
        _loc2.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_FRAME, handlePuffleRequestFrame, this);
        _loc2.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_PLAY, handlePuffleRequestPlay, this);
        _loc2.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_FEED, handlePuffleRequestFeed, this);
        _loc2.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_BATH, handlePuffleRequestBath, this);
        _loc2.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_REST, handlePuffleRequestRest, this);
        _loc2.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_START_WALK, handlePuffleRequestStartWalk, this);
        _loc2.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_STOP_WALK, handlePuffleRequestStopWalk, this);
        _loc2.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_INTERACTION, handlePuffleRequestInteraction, this);
        return (_loc2);
    } // End of the function
    function getRoomPuffleById(id)
    {
        var _loc3 = _roomPuffles.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (_roomPuffles[_loc2].id == id)
            {
                return (_roomPuffles[_loc2]);
            } // end if
        } // end of for
        _shell.$e("[SHELL] PuffleManager.getRoomPuffleById() -> Could not find puffle in room! - id: " + id);
        return;
    } // End of the function
    function getIndexInRoomById(id)
    {
        var _loc3 = _roomPuffles.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (_roomPuffles[_loc2].id == id)
            {
                return (_loc2);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    function cleanUpRoomPuffles()
    {
        _modelManager.clearRoomPuffleModelArray();
        if (_roomPuffles == undefined)
        {
            return;
        } // end if
        var _loc2 = 0;
        var _loc3 = _roomPuffles.length;
        while (_loc2 < _loc3)
        {
            _roomPuffles[_loc2].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE, handlePuffleRequestMove, this);
            _roomPuffles[_loc2].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_FRAME, handlePuffleRequestFrame, this);
            _roomPuffles[_loc2].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_PLAY, handlePuffleRequestPlay, this);
            _roomPuffles[_loc2].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_FEED, handlePuffleRequestFeed, this);
            _roomPuffles[_loc2].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_BATH, handlePuffleRequestBath, this);
            _roomPuffles[_loc2].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_REST, handlePuffleRequestRest, this);
            _roomPuffles[_loc2].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_START_WALK, handlePuffleRequestStartWalk, this);
            _roomPuffles[_loc2].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_STOP_WALK, handlePuffleRequestStopWalk, this);
            _roomPuffles[_loc2].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_INTERACTION, handlePuffleRequestInteraction, this);
            _roomPuffles[_loc2].cleanUp();
            ++_loc2;
        } // end while
        _roomPuffles = undefined;
    } // End of the function
    function get myPuffleCount()
    {
        if (_myPuffles == undefined)
        {
            return (0);
        } // end if
        return (_myPuffles.length);
    } // End of the function
    static var MAX_PUFFLES = 18;
    static var PUFFLE_INVENTORY_ID = 750;
    static var START_WALK = 1;
    static var STOP_WALK = 0;
    var _pufflesFetched = false;
    var _currentWalkingId = undefined;
} // End of Class
