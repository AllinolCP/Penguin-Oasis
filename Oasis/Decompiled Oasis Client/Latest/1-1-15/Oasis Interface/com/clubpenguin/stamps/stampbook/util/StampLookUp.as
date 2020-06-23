class com.clubpenguin.stamps.stampbook.util.StampLookUp extends MovieClip
{
    var _userObject, _masterList, _userStamps, _coverStamps, _stampManager, _userStampsHash, _coverStampsHash, _selectedCategoryHash, _stampsHash, _pageList;
    static var _instance;
    function StampLookUp()
    {
        super();
    } // End of the function
    static function getInstance()
    {
        if (com.clubpenguin.stamps.stampbook.util.StampLookUp._instance == null)
        {
            _instance = new com.clubpenguin.stamps.stampbook.util.StampLookUp();
        } // end if
        return (com.clubpenguin.stamps.stampbook.util.StampLookUp._instance);
    } // End of the function
    function initialize(userObject, masterList, userStamps, coverStamps, stampManager)
    {
        _userObject = userObject;
        _masterList = masterList;
        _userStamps = userStamps;
        _coverStamps = coverStamps;
        _stampManager = stampManager;
        _userStampsHash = {};
        _coverStampsHash = {};
        _selectedCategoryHash = {};
        _stampsHash = {};
        var _loc15 = _userStamps.length;
        for (var _loc7 = 0; _loc7 < _loc15; ++_loc7)
        {
            _userStampsHash[_userStamps[_loc7].getID()] = true;
        } // end of for
        var _loc13 = _coverStamps.getCoverItems();
        var _loc14 = _loc13.length;
        for (var _loc7 = 0; _loc7 < _loc14; ++_loc7)
        {
            var _loc12 = _loc13[_loc7].getItem();
            _coverStampsHash[_loc12.getID()] = true;
        } // end of for
        var _loc18;
        var _loc22;
        _pageList = [];
        var _loc16 = _masterList.length;
        for (var _loc7 = 0; _loc7 < _loc16; ++_loc7)
        {
            var _loc6 = _masterList[_loc7].getSubCategories();
            if (_loc6 != undefined && _loc6.length > 0)
            {
                var _loc11 = _loc6.length;
                _pageList.push(_masterList[_loc7]);
                for (var _loc3 = 0; _loc3 < _loc11; ++_loc3)
                {
                    _pageList.push(_loc6[_loc3]);
                    var _loc5 = _loc6[_loc3].getItems();
                    var _loc8 = _loc5.length;
                    for (var _loc4 = 0; _loc4 < _loc8; ++_loc4)
                    {
                        var _loc2 = _loc5[_loc4];
                        _stampsHash[_loc2.getID()] = _loc2;
                    } // end of for
                } // end of for
                continue;
            } // end if
            _pageList.push(_masterList[_loc7]);
            var _loc9 = _masterList[_loc7].getItems();
            var _loc10 = _loc9.length;
            for (var _loc4 = 0; _loc4 < _loc10; ++_loc4)
            {
                _loc2 = _loc9[_loc4];
                _stampsHash[_loc2.getID()] = _loc2;
            } // end of for
        } // end of for
    } // End of the function
    function isOwned(id)
    {
        return (_userStampsHash[id]);
    } // End of the function
    function isCover(id)
    {
        return (_coverStampsHash[id]);
    } // End of the function
    function removeStampFromCover(id)
    {
        _coverStampsHash[id] = false;
    } // End of the function
    function addStampToCover(id)
    {
        _coverStampsHash[id] = true;
    } // End of the function
    function setCategorySelected(categoryID)
    {
        for (var _loc2 in _selectedCategoryHash)
        {
            _selectedCategoryHash[_loc2] = false;
        } // end of for...in
        _selectedCategoryHash[categoryID] = true;
    } // End of the function
    function isCategorySelected(categoryID)
    {
        if (_selectedCategoryHash[categoryID] != undefined)
        {
            return (_selectedCategoryHash[categoryID]);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function getStampByID(stampID)
    {
        return (_stampsHash[stampID]);
    } // End of the function
    function addStampsForSection(section, flag)
    {
        var _loc2;
        var _loc5 = section.length;
        if (_loc5)
        {
            var _loc4 = Array(section);
            _loc2 = this.addStamps(_loc4[0], flag);
        }
        else
        {
            var _loc3 = [section];
            _loc2 = this.addStamps(_loc3, flag);
        } // end else if
        return (_loc2);
    } // End of the function
    function addStamps(section, flag)
    {
        var _loc4 = [];
        var _loc11 = section.length;
        var _loc9 = com.clubpenguin.stamps.StampManager.PIN_CATEGORY_ID;
        for (var _loc6 = 0; _loc6 < _loc11; ++_loc6)
        {
            var _loc5 = section[_loc6];
            if (_loc5.getID() == _loc9)
            {
                if (flag != com.clubpenguin.stamps.stampbook.util.StampLookUp.USER_NONCOVER_STAMPS)
                {
                    continue;
                } // end if
            } // end if
            var _loc10 = _loc5.getSubCategories();
            _loc4 = _loc4.concat(this.addStamps(_loc10, flag));
            var _loc3 = _loc5.getItems();
            var _loc8 = _loc3.length;
            for (var _loc2 = 0; _loc2 < _loc8; ++_loc2)
            {
                switch (flag)
                {
                    case com.clubpenguin.stamps.stampbook.util.StampLookUp.USER_STAMPS:
                    {
                        if (this.isOwned(_loc3[_loc2].getID()))
                        {
                            _loc4.push(_loc3[_loc2]);
                        } // end if
                        break;
                    } 
                    case com.clubpenguin.stamps.stampbook.util.StampLookUp.TOTAL_STAMPS:
                    {
                        _loc4.push(_loc3[_loc2]);
                        break;
                    } 
                    case com.clubpenguin.stamps.stampbook.util.StampLookUp.USER_NONCOVER_STAMPS:
                    {
                        if (_loc5.getID() == _loc9)
                        {
                            if (!this.isCover(_loc3[_loc2].getID()))
                            {
                                _loc4.push(_loc3[_loc2]);
                            } // end if
                        }
                        else if (this.isOwned(_loc3[_loc2].getID()) && !this.isCover(_loc3[_loc2].getID()))
                        {
                            _loc4.push(_loc3[_loc2]);
                        } // end else if
                        break;
                    } 
                    default:
                    {
                        break;
                    } 
                } // End of switch
            } // end of for
        } // end of for
        return (_loc4);
    } // End of the function
    function getStampsForCategory(section)
    {
        return (this.addStampsForSection(section, com.clubpenguin.stamps.stampbook.util.StampLookUp.USER_NONCOVER_STAMPS));
    } // End of the function
    function getNumberOfTotalStampsForCategory(section)
    {
        var _loc2 = this.addStampsForSection(section, com.clubpenguin.stamps.stampbook.util.StampLookUp.TOTAL_STAMPS);
        return (_loc2.length);
    } // End of the function
    function getNumberOfUserStampsForCategory(section)
    {
        var _loc2 = this.addStampsForSection(section, com.clubpenguin.stamps.stampbook.util.StampLookUp.USER_STAMPS);
        return (_loc2.length);
    } // End of the function
    function getNumberOfUserStamps()
    {
        return (_userStamps.length);
    } // End of the function
    function getPageList()
    {
        return (_pageList);
    } // End of the function
    function getMasterList()
    {
        return (_masterList);
    } // End of the function
    function getPlayerNickname()
    {
        return (_userObject.nickname);
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.util.StampLookUp;
    static var LINKAGE_ID = "StampLookUp";
    static var USER_STAMPS = "userStamps";
    static var TOTAL_STAMPS = "totalStamps";
    static var USER_NONCOVER_STAMPS = "userNoncoverStamps";
} // End of Class
