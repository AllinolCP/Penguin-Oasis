class com.clubpenguin.stamps.StampManager
{
    var shell, _numClubPenguinStamps, clubPenguinStampCategories, _myStamps, pinCategoryName, stampDefinitionsParsed, stampDefinitionsService, _stampBookCoverCrumbs, pinsService, awardsService, epfService, stampsService, _usersStampCategories, _activeUsersStampList, _hasModifiedStampCover, __get__myStamps, __get__numClubPenguinStamps, __get__stampBookCoverCrumbs;
    static var MONTH_STRING, AWARD_STAMP_IDS_TO_DB_IDS, EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID;
    function StampManager(shell, connection)
    {
        this.shell = shell;
        if (com.clubpenguin.stamps.StampManager.MONTH_STRING == undefined)
        {
            MONTH_STRING = [];
            com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("January"));
            com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("February"));
            com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("March"));
            com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("April"));
            com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("May"));
            com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("June"));
            com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("July"));
            com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("August"));
            com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("September"));
            com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("October"));
            com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("November"));
            com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("December"));
        } // end if
        if (com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS == undefined)
        {
            AWARD_STAMP_IDS_TO_DB_IDS = [];
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[159] = 801;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[160] = 802;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[161] = 803;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[162] = 804;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[163] = 805;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[164] = 806;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[165] = 808;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[166] = 809;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[167] = 810;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[168] = 811;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[169] = 813;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[170] = 814;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[171] = 815;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[172] = 816;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[173] = 817;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[174] = 818;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[175] = 819;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[176] = 820;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[177] = 822;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[178] = 823;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[179] = 8007;
            com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[180] = 8008;
        } // end if
        if (com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID == undefined)
        {
            EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID = [];
            com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[1] = 197;
            com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[5] = 198;
            com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[10] = 199;
            com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[25] = 200;
            com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[50] = 201;
        } // end if
        _numClubPenguinStamps = 0;
        clubPenguinStampCategories = [];
        _myStamps = [];
        pinCategoryName = shell.getLocalizedString("pins_category_title");
        stampDefinitionsParsed = new org.osflash.signals.Signal(Array, Number);
        stampDefinitionsParsed.addOnce(handleStampDefinitionsParsed, this);
        stampDefinitionsService = new com.clubpenguin.stamps.StampDefinitionsService(this, stampDefinitionsParsed, shell.getWebServiceManager());
        _stampBookCoverCrumbs = new com.clubpenguin.stamps.StampBookCoverCrumbs(shell.getWebServiceManager());
        pinsService = new com.clubpenguin.services.PinsService(connection);
        pinsService.__get__pinsListReceived().add(handleQueryPlayersPins, this);
        awardsService = new com.clubpenguin.services.AwardsService(connection);
        awardsService.__get__awardsListReceived().add(handleQueryPlayersAwards, this);
        epfService = new com.clubpenguin.services.EPFService(connection);
        epfService.__get__pointsReceived().add(handleEPFPoints, this);
        stampsService = new com.clubpenguin.services.StampsService(connection);
        stampsService.__get__playersStampsReceived().add(handleGetPlayersStamps, this);
        stampsService.__get__recentlyEarnedStampsReceived().add(handleGetMyRecentlyEarnedStamps, this);
        stampsService.__get__playersStampBookCoverDetailsReceived().add(handleGetStampBookCoverDetails, this);
        stampsService.__get__playerEarnedStampReceived().add(handlePlayerEarnedStampReceived, this);
    } // End of the function
    function destroy()
    {
        var _loc3 = clubPenguinStampCategories.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            clubPenguinStampCategories[_loc2].destroy();
        } // end of for
        delete this.clubPenguinStampCategories;
        delete this._myStamps;
        pinsService.__get__pinsListReceived().remove(handleQueryPlayersPins, this);
        awardsService.__get__awardsListReceived().remove(handleQueryPlayersAwards, this);
        epfService.__get__pointsReceived().remove(handleEPFPoints, this);
        stampsService.__get__playersStampsReceived().remove(handleGetPlayersStamps, this);
        stampsService.__get__recentlyEarnedStampsReceived().remove(handleGetMyRecentlyEarnedStamps, this);
        stampsService.__get__playersStampBookCoverDetailsReceived().remove(handleGetStampBookCoverDetails, this);
        stampsService.__get__playerEarnedStampReceived().remove(handlePlayerEarnedStampReceived, this);
    } // End of the function
    function stampItemComparisonByDifficultyThenID(stampBookItemA, stampBookItemB)
    {
        if (stampBookItemA.getType() != com.clubpenguin.stamps.StampBookItemType.STAMP || stampBookItemB.getType() != com.clubpenguin.stamps.StampBookItemType.STAMP)
        {
            return (0);
        } // end if
        var _loc2 = (com.clubpenguin.stamps.IStampItem)(stampBookItemA);
        var _loc1 = (com.clubpenguin.stamps.IStampItem)(stampBookItemB);
        var _loc3 = _loc2.getDifficulty();
        var _loc4 = _loc1.getDifficulty();
        var _loc5 = _loc2.getID();
        var _loc6 = _loc1.getID();
        if (_loc3 < _loc4)
        {
            return (-1);
        }
        else if (_loc3 > _loc4)
        {
            return (1);
        }
        else if (_loc5 < _loc6)
        {
            return (-1);
        }
        else if (_loc5 > _loc6)
        {
            return (1);
        }
        else
        {
            return (0);
        } // end else if
    } // End of the function
    function stampBookItemComparisonByID(stampBookItemA, stampBookItemB)
    {
        var _loc1 = stampBookItemA.getID();
        var _loc2 = stampBookItemB.getID();
        if (_loc1 < _loc2)
        {
            return (-1);
        }
        else if (_loc1 > _loc2)
        {
            return (1);
        }
        else
        {
            return (0);
        } // end else if
    } // End of the function
    function stampBookCategoryComparisonByID(stampBookCategoryA, stampBookCategoryB)
    {
        var _loc1 = stampBookCategoryA.getID();
        var _loc2 = stampBookCategoryB.getID();
        if (_loc1 < _loc2)
        {
            return (-1);
        }
        else if (_loc1 > _loc2)
        {
            return (1);
        }
        else
        {
            return (0);
        } // end else if
    } // End of the function
    function checkForEPFFieldOpsMedalStamps(totalPoints)
    {
        if (totalPoints == undefined || totalPoints == null)
        {
            epfService.getPoints();
        }
        else
        {
            var _loc3 = [];
            for (var _loc2 in com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID)
            {
                if (Number(_loc2) <= totalPoints)
                {
                    _loc3.push(com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[Number(_loc2)]);
                } // end if
            } // end of for...in
            var _loc4 = _loc3.length;
            for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
            {
                shell.stampEarned(_loc3[_loc2]);
            } // end of for
        } // end else if
    } // End of the function
    function getAwardStampID(dbAwardID)
    {
        for (var _loc3 in com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS)
        {
            var _loc1 = Number(_loc3);
            if (com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[_loc1] == dbAwardID)
            {
                return (_loc1);
            } // end if
        } // end of for...in
        return (-1);
    } // End of the function
    function setRecentlyEarnedStamp(stampID, isServerSide)
    {
        if (!isServerSide)
        {
            stampsService.sendStampEarned(stampID);
        } // end if
        var _loc2 = this.getStampBookItem(stampID, com.clubpenguin.stamps.StampBookItemType.STAMP.__get__value());
        if (_loc2 != undefined)
        {
            _myStamps.push(_loc2);
        } // end if
    } // End of the function
    function get stampBookCoverCrumbs()
    {
        return (_stampBookCoverCrumbs);
    } // End of the function
    function get myStamps()
    {
        return (_myStamps);
    } // End of the function
    function get numClubPenguinStamps()
    {
        return (_numClubPenguinStamps);
    } // End of the function
    function getStampBookItem(id, typeValue)
    {
        var _loc9 = _usersStampCategories.length;
        for (var _loc5 = 0; _loc5 < _loc9; ++_loc5)
        {
            var _loc2 = this.findStampBookItemInItemsList(id, _usersStampCategories[_loc5].getItems(), typeValue);
            if (_loc2 != undefined)
            {
                return (_loc2);
                continue;
            } // end if
            var _loc4 = _usersStampCategories[_loc5].getSubCategories();
            if (_loc4 != undefined)
            {
                var _loc6 = _loc4.length;
                for (var _loc3 = 0; _loc3 < _loc6; ++_loc3)
                {
                    _loc2 = this.findStampBookItemInItemsList(id, _loc4[_loc3].getItems(), typeValue);
                    if (_loc2 != undefined)
                    {
                        return (_loc2);
                    } // end if
                } // end of for
            } // end if
        } // end of for
        return;
    } // End of the function
    function stampIsOwnedByMe(stampID)
    {
        if (_myStamps != undefined)
        {
            var _loc3 = _myStamps.length;
            for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
            {
                if (_myStamps[_loc2].getID() == stampID)
                {
                    return (true);
                } // end if
            } // end of for
        } // end if
        return (false);
    } // End of the function
    function getPlayersStampBookCategories(playerID)
    {
        pinsService.queryPlayersPins(playerID);
    } // End of the function
    function getPlayersStamps(playerID)
    {
        stampsService.getPlayersStamps(playerID);
    } // End of the function
    function getMyRecentlyEarnedStamps()
    {
        stampsService.getMyRecentlyEarnedStamps();
    } // End of the function
    function getStampBookCoverDetails(playerID)
    {
        stampsService.getStampBookCoverDetails(playerID);
    } // End of the function
    function saveMyStampBookCover(stampBookCover)
    {
        var _loc17 = stampBookCover.getColourID();
        var _loc16 = stampBookCover.getHighlightID();
        var _loc14 = stampBookCover.getPatternID();
        var _loc15 = stampBookCover.getClaspIconArtID();
        var _loc11 = [];
        var _loc10 = stampBookCover.getCoverItems();
        var _loc12 = _loc10.length;
        for (var _loc7 = 0; _loc7 < _loc12; ++_loc7)
        {
            var _loc2 = _loc10[_loc7];
            var _loc5 = _loc2.getItem();
            var _loc4 = _loc5.getType().__get__value();
            var _loc3 = _loc5.getID();
            var _loc6 = _loc2.getItemPosition();
            var _loc8 = _loc2.getItemRotation();
            var _loc9 = _loc2.getItemDepth();
            if (_loc4 == com.clubpenguin.stamps.StampBookItemType.AWARD.__get__value())
            {
                _loc3 = com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[_loc3];
            } // end if
            _loc11.push(_loc4 + com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER + _loc3 + com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER + _loc6.x + com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER + _loc6.y + com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER + _loc8 + com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER + _loc9);
        } // end of for
        stampsService.setStampBookCoverDetails(_loc17, _loc16, _loc14, _loc15, _loc11);
    } // End of the function
    function handleEPFPoints(unusedPoints, totalPoints)
    {
        this.checkForEPFFieldOpsMedalStamps(totalPoints);
    } // End of the function
    function handleQueryPlayersPins(serverEventData)
    {
        _usersStampCategories = [];
        var _loc15 = Number(serverEventData.shift());
        var _loc10 = [];
        var _loc12 = serverEventData.length;
        for (var _loc7 = 0; _loc7 < _loc12; ++_loc7)
        {
            var _loc4 = serverEventData[_loc7].split(com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER);
            var _loc5 = Number(_loc4[0]);
            var _loc6 = shell.getInventoryObjectById(_loc5);
            if (_loc6 != undefined)
            {
                var _loc8 = _loc6.name;
                var _loc3 = new Date(Number(_loc4[1]) * com.clubpenguin.stamps.StampManager.MILLISECONDS);
                var _loc2 = shell.getLocalizedString("pin_release_date");
                var _loc9 = Number(_loc4[2]) == 1 ? (true) : (false);
                _loc2 = com.clubpenguin.util.StringUtils.replaceString("%month%", com.clubpenguin.stamps.StampManager.MONTH_STRING[_loc3.getMonth()], _loc2);
                _loc2 = com.clubpenguin.util.StringUtils.replaceString("%day%", String(_loc3.getDate()), _loc2);
                _loc2 = com.clubpenguin.util.StringUtils.replaceString("%year%", String(_loc3.getFullYear()), _loc2);
                _loc10.push(new com.clubpenguin.stamps.PinItem(_loc5, _loc8, _loc2, _loc9));
            } // end if
        } // end of for
        var _loc13 = new com.clubpenguin.stamps.StampBookCategory(com.clubpenguin.stamps.StampManager.PIN_CATEGORY_ID, pinCategoryName, [], _loc10, []);
        _usersStampCategories = clubPenguinStampCategories.concat(_loc13);
        var _loc14 = new com.clubpenguin.stamps.StampBookCategory(com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID, com.clubpenguin.stamps.StampManager.MYSTERY_PAGE_TITLE, [], [], []);
        _usersStampCategories.push(_loc14);
        shell.updateListeners(shell.PLAYERS_STAMP_BOOK_CATEGORIES, _usersStampCategories);
    } // End of the function
    function handleGetPlayersStamps(serverEventData)
    {
        var _loc4 = Number(serverEventData.shift());
        var _loc2 = Number(serverEventData.shift());
        _activeUsersStampList = this.createStampBookItemListFromServerData(serverEventData, com.clubpenguin.stamps.StampBookItemType.STAMP.__get__value());
        if (shell.isMyPlayer(_loc2))
        {
            _myStamps = _activeUsersStampList;
        } // end if
        awardsService.queryPlayersAwards(_loc2);
    } // End of the function
    function handleQueryPlayersAwards(serverEventData)
    {
        var _loc8 = Number(serverEventData.shift());
        var _loc7 = Number(serverEventData.shift());
        var _loc5 = serverEventData[0].split(com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER);
        var _loc4 = _loc5.length;
        var _loc6;
        serverEventData[0] = "";
        for (var _loc3 = 0; _loc3 < _loc4; ++_loc3)
        {
            serverEventData[0] = serverEventData[0] + this.getAwardStampID(_loc5[_loc3]);
            if (_loc3 < _loc4 - 1)
            {
                serverEventData[0] = serverEventData[0] + com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER;
            } // end if
        } // end of for
        _loc6 = this.createStampBookItemListFromServerData(serverEventData, com.clubpenguin.stamps.StampBookItemType.AWARD.__get__value());
        _activeUsersStampList = _activeUsersStampList.concat(_loc6);
        if (shell.isMyPlayer(_loc7))
        {
            _myStamps = _activeUsersStampList;
        } // end if
        shell.updateListeners(shell.PLAYERS_STAMPS, _activeUsersStampList);
    } // End of the function
    function handleGetMyRecentlyEarnedStamps(serverEventData)
    {
        var _loc3 = Number(serverEventData.shift());
        shell.updateListeners(shell.MY_RECENTLY_EARNED_STAMPS, this.createStampBookItemListFromServerData(serverEventData, com.clubpenguin.stamps.StampBookItemType.STAMP.__get__value()));
    } // End of the function
    function handleGetStampBookCoverDetails(serverEventData)
    {
        var _loc14 = Number(serverEventData.shift());
        var _loc12 = Number(serverEventData.shift());
        var _loc9 = Number(serverEventData.shift());
        var _loc13 = Number(serverEventData.shift());
        var _loc11 = Number(serverEventData.shift());
        var _loc10;
        var _loc7 = [];
        var _loc8 = serverEventData.length;
        for (var _loc4 = 0; _loc4 < _loc8; ++_loc4)
        {
            var _loc2 = serverEventData[_loc4].split(com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER);
            var _loc3;
            if (_loc2[0] == com.clubpenguin.stamps.StampBookItemType.AWARD.__get__value())
            {
                _loc2[1] = this.getAwardStampID(_loc2[1]);
            } // end if
            _loc3 = this.getStampBookItem(_loc2[1], _loc2[0]);
            if (_loc3 != undefined)
            {
                var _loc5 = new com.clubpenguin.stamps.StampBookCoverItem(_loc3, new flash.geom.Point(_loc2[2], _loc2[3]), _loc2[4], _loc2[5]);
                _loc7.push(_loc5);
            } // end if
        } // end of for
        _loc10 = new com.clubpenguin.stamps.StampBookCover(_loc7, _loc12, _loc9, _loc13, _loc11);
        shell.updateListeners(shell.STAMP_BOOK_COVER_DETAILS, _loc10);
    } // End of the function
    function handlePlayerEarnedStampReceived(serverEventData)
    {
        var _loc4 = Number(serverEventData[0]);
        var _loc2 = Number(serverEventData[1]);
        shell.stampEarned(_loc2, true);
    } // End of the function
    function handleStampDefinitionsParsed(clubPenguinStampCategories, numClubPenguinStamps)
    {
        if (clubPenguinStampCategories != undefined)
        {
            this.clubPenguinStampCategories = clubPenguinStampCategories;
            _usersStampCategories = clubPenguinStampCategories;
            _numClubPenguinStamps = numClubPenguinStamps;
        } // end if
    } // End of the function
    function findStampBookItemInItemsList(id, items, typeValue)
    {
        if (items != undefined)
        {
            var _loc3 = items.length;
            for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
            {
                if (items[_loc1].getType().value == typeValue && items[_loc1].getID() == id)
                {
                    return (items[_loc1]);
                } // end if
            } // end of for
        } // end if
        return;
    } // End of the function
    function createStampBookItemListFromServerData(serverEventData, typeValue)
    {
        var _loc5 = [];
        var _loc4 = serverEventData[0].split(com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER);
        var _loc6 = _loc4.length;
        for (var _loc3 = 0; _loc3 < _loc6; ++_loc3)
        {
            var _loc2 = this.getStampBookItem(_loc4[_loc3], typeValue);
            if (_loc2 != undefined)
            {
                _loc5.push(_loc2);
            } // end if
        } // end of for
        return (_loc5);
    } // End of the function
    function getHasModifiedStampCover()
    {
        return (_hasModifiedStampCover);
    } // End of the function
    function setHasModifiedStampCover(hasModifiedStampCover)
    {
        _hasModifiedStampCover = hasModifiedStampCover;
    } // End of the function
    static var ALL_CATEGORY_ID = 9000;
    static var AWARD_CATEGORY_ID = 22;
    static var PIN_CATEGORY_ID = 9001;
    static var MYSTERY_CATEGORY_ID = 10000;
    static var MYSTERY_PAGE_TITLE = "Mystery Page";
    static var MAX_STAMPBOOK_COVER_ITEMS = 6;
    static var STAMP_ICON_BOX_WIDTH = 80;
    static var STAMP_ICON_BOX_HEIGHT = 70;
    static var STAMPBOOK_SWF_FILENAME = "stampbook.swf";
    static var COVER_PATTERN_NONE_ID = -1;
    static var SOCKET_SERVER_DATA_DELIMITER = "|";
    static var MILLISECONDS = 1000;
} // End of Class
