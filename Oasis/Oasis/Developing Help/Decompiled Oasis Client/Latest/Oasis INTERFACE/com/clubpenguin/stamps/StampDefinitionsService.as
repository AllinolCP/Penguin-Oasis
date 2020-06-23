class com.clubpenguin.stamps.StampDefinitionsService
{
    var stampManager, numStamps, stampDefinitionsParsed, stampDefinitions, polaroidDefinitions;
    function StampDefinitionsService(stampManager, stampDefinitionsParsed, webServiceManager)
    {
        this.stampManager = stampManager;
        numStamps = 0;
        this.stampDefinitionsParsed = stampDefinitionsParsed;
        stampDefinitions = webServiceManager.getServiceData(com.clubpenguin.net.WebServiceType.STAMPS);
        polaroidDefinitions = webServiceManager.getServiceData(com.clubpenguin.net.WebServiceType.POLAROIDS);
        var _loc3 = this.parsePolaroidDefinitions();
        var _loc2 = this.parseStampDefinitions(_loc3);
        stampDefinitionsParsed.dispatch(_loc2, numStamps);
    } // End of the function
    function parsePolaroidDefinitions()
    {
        var _loc11 = {};
        if (polaroidDefinitions != undefined)
        {
            for (var _loc12 in polaroidDefinitions)
            {
                var _loc7 = polaroidDefinitions[_loc12].polaroids;
                var _loc10 = _loc7 == undefined ? (0) : (_loc7.length);
                _loc11[_loc12] = [];
                for (var _loc2 = 0; _loc2 < _loc10; ++_loc2)
                {
                    var _loc3 = _loc7[_loc2];
                    var _loc8 = Number(_loc3.polaroid_id);
                    var _loc4 = Number(_loc3.stamp_count);
                    var _loc9 = "";
                    var _loc5 = String(_loc3.description);
                    var _loc6 = new com.clubpenguin.stamps.PolaroidItem(_loc8, _loc4, _loc9, _loc5);
                    _loc11[_loc12].push(_loc6);
                } // end of for
            } // end of for...in
        } // end if
        return (_loc11);
    } // End of the function
    function parseStampDefinitions(categoryIDsToPolariodItems)
    {
        var _loc27 = [];
        if (stampDefinitions != undefined)
        {
            var _loc20 = {};
            var _loc16 = {};
            for (var _loc30 in stampDefinitions)
            {
                var _loc22;
                var _loc4 = stampDefinitions[_loc30];
                var _loc21 = Number(_loc4.parent_group_id);
                var _loc12;
                var _loc18 = com.clubpenguin.stamps.StampDefinitionsService.INVALID_CATEGORY_ID;
                var _loc7 = Number(_loc30);
                var _loc25 = String(_loc4.name);
                var _loc11 = [];
                var _loc24 = categoryIDsToPolariodItems[_loc30];
                if (_loc21 == com.clubpenguin.stamps.StampDefinitionsService.NO_PARENT_GROUP_ID)
                {
                    _loc12 = _loc7;
                }
                else
                {
                    _loc12 = _loc21;
                    _loc18 = _loc7;
                } // end else if
                for (var _loc26 in _loc4.stamps)
                {
                    var _loc2 = _loc4.stamps[_loc26];
                    var _loc6 = Number(_loc26);
                    var _loc14 = _loc12;
                    var _loc13 = Number(_loc2.rank);
                    var _loc9 = String(_loc2.name);
                    var _loc5 = String(_loc2.description);
                    var _loc10 = Boolean(_loc2.is_member);
                    var _loc8;
                    if (_loc7 == com.clubpenguin.stamps.StampManager.AWARD_CATEGORY_ID)
                    {
                        _loc8 = new com.clubpenguin.stamps.AwardItem(_loc6, _loc9, _loc5, _loc10);
                    }
                    else
                    {
                        _loc8 = new com.clubpenguin.stamps.StampItem(_loc6, _loc14, _loc13, _loc9, _loc5, _loc10);
                    } // end else if
                    _loc11.push(_loc8);
                    ++numStamps;
                } // end of for...in
                if (_loc7 == com.clubpenguin.stamps.StampManager.AWARD_CATEGORY_ID)
                {
                    _loc11.sort(stampManager.stampBookItemComparisonByID);
                }
                else
                {
                    _loc11.sort(stampManager.stampItemComparisonByDifficultyThenID);
                } // end else if
                _loc22 = new com.clubpenguin.stamps.StampBookCategory(_loc7, _loc25, null, _loc11, _loc24);
                _loc20[_loc30] = _loc22;
                if (_loc18 != com.clubpenguin.stamps.StampDefinitionsService.INVALID_CATEGORY_ID)
                {
                    var _loc29 = String(_loc12);
                    if (_loc16[_loc29] == undefined)
                    {
                        _loc16[_loc29] = [];
                    } // end if
                    _loc16[_loc29].push(_loc18);
                    continue;
                } // end if
                _loc27.push(_loc22);
            } // end of for...in
            for (var _loc29 in _loc16)
            {
                var _loc17 = _loc20[_loc29];
                var _loc19 = _loc16[_loc29];
                var _loc23 = _loc19.length;
                for (var _loc3 = 0; _loc3 < _loc23; ++_loc3)
                {
                    var _loc15 = _loc20[String(_loc19[_loc3])];
                    _loc17.addSubCategory(_loc15);
                } // end of for
                _loc17.getSubCategories().sort(stampManager.stampBookCategoryComparisonByID);
            } // end of for...in
        } // end if
        _loc27.sort(stampManager.stampBookCategoryComparisonByID);
        return (_loc27);
    } // End of the function
    static var NO_PARENT_GROUP_ID = 0;
    static var INVALID_CATEGORY_ID = -1;
} // End of Class
