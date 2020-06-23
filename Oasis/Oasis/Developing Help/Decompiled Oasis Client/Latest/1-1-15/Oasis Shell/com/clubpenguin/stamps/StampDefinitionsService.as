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
                for (var _loc3 = 0; _loc3 < _loc10; ++_loc3)
                {
                    var _loc2 = _loc7[_loc3];
                    var _loc8 = Number(_loc2.polaroid_id);
                    var _loc4 = Number(_loc2.stamp_count);
                    var _loc9 = "";
                    var _loc5 = String(_loc2.description);
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
            for (var _loc28 in stampDefinitions)
            {
                var _loc21;
                var _loc3 = stampDefinitions[_loc28];
                var _loc22 = Number(_loc3.parent_group_id);
                var _loc14;
                var _loc17 = com.clubpenguin.stamps.StampDefinitionsService.INVALID_CATEGORY_ID;
                var _loc5 = Number(_loc28);
                var _loc24 = String(_loc3.name);
                var _loc11 = [];
                var _loc25 = categoryIDsToPolariodItems[_loc28];
                if (_loc22 == com.clubpenguin.stamps.StampDefinitionsService.NO_PARENT_GROUP_ID)
                {
                    _loc14 = _loc5;
                }
                else
                {
                    _loc14 = _loc22;
                    _loc17 = _loc5;
                } // end else if
                for (var _loc26 in _loc3.stamps)
                {
                    var _loc2 = _loc3.stamps[_loc26];
                    var _loc4 = Number(_loc26);
                    var _loc12 = _loc14;
                    var _loc13 = Number(_loc2.rank);
                    var _loc7 = String(_loc2.name);
                    var _loc10 = String(_loc2.description);
                    var _loc8 = Boolean(_loc2.is_member);
                    var _loc6;
                    if (_loc5 == com.clubpenguin.stamps.StampManager.AWARD_CATEGORY_ID)
                    {
                        _loc6 = new com.clubpenguin.stamps.AwardItem(_loc4, _loc7, _loc10, _loc8);
                    }
                    else
                    {
                        _loc6 = new com.clubpenguin.stamps.StampItem(_loc4, _loc12, _loc13, _loc7, _loc10, _loc8);
                    } // end else if
                    _loc11.push(_loc6);
                    ++numStamps;
                } // end of for...in
                if (_loc5 == com.clubpenguin.stamps.StampManager.AWARD_CATEGORY_ID)
                {
                    _loc11.sort(stampManager.stampBookItemComparisonByID);
                }
                else
                {
                    _loc11.sort(stampManager.stampItemComparisonByDifficultyThenID);
                } // end else if
                _loc21 = new com.clubpenguin.stamps.StampBookCategory(_loc5, _loc24, null, _loc11, _loc25);
                _loc20[_loc28] = _loc21;
                if (_loc17 != com.clubpenguin.stamps.StampDefinitionsService.INVALID_CATEGORY_ID)
                {
                    var _loc30 = String(_loc14);
                    if (_loc16[_loc30] == undefined)
                    {
                        _loc16[_loc30] = [];
                    } // end if
                    _loc16[_loc30].push(_loc17);
                    continue;
                } // end if
                _loc27.push(_loc21);
            } // end of for...in
            for (var _loc30 in _loc16)
            {
                var _loc18 = _loc20[_loc30];
                var _loc19 = _loc16[_loc30];
                var _loc23 = _loc19.length;
                for (var _loc9 = 0; _loc9 < _loc23; ++_loc9)
                {
                    var _loc15 = _loc20[String(_loc19[_loc9])];
                    _loc18.addSubCategory(_loc15);
                } // end of for
                _loc18.getSubCategories().sort(stampManager.stampBookCategoryComparisonByID);
            } // end of for...in
        } // end if
        _loc27.sort(stampManager.stampBookCategoryComparisonByID);
        return (_loc27);
    } // End of the function
    static var NO_PARENT_GROUP_ID = 0;
    static var INVALID_CATEGORY_ID = -1;
} // End of Class
