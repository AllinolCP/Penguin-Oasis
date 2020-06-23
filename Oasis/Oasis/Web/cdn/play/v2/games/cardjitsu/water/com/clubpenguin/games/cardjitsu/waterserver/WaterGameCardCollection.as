class com.clubpenguin.games.cardjitsu.waterserver.WaterGameCardCollection extends com.clubpenguin.lib.data.Collection
{
    var __reserve, __subCollections, __subCollectionProperty, __collection, clear, __itemSum, __get__length, __get__sum;
    function WaterGameCardCollection()
    {
        super();
        __reserve = new com.clubpenguin.lib.data.Collection();
    } // End of the function
    function createSubgroups(_property, _values)
    {
        var _loc2;
        var _loc3;
        var _loc5;
        if (__subCollections == null)
        {
            __subCollections = new Array();
        } // end if
        __subCollectionProperty = _property;
        if (__collection.length > 0)
        {
            _loc5 = __collection.concat();
            this.clear();
        } // end if
        this.addItems(_values);
        for (var _loc2 = 0; _loc2 < _values.length; ++_loc2)
        {
            _loc3 = new com.clubpenguin.games.cardjitsu.waterserver.WaterGameCardCollection();
            __subCollections[_values[_loc2]] = _loc3;
        } // end of for
        if (_loc5 != null)
        {
            this.addItems(_loc5);
        } // end if
    } // End of the function
    function subgroupCollection(_property, _values)
    {
        var _loc2;
        var _loc7;
        var _loc5;
        var _loc3;
        _loc5 = new com.clubpenguin.games.cardjitsu.waterserver.WaterGameCardCollection();
        _loc5.addItems(__collection);
        this.clear();
        for (var _loc2 = 0; _loc2 < _values.length; ++_loc2)
        {
            _loc3 = _loc5.subCollection(_property, _values[_loc2]);
            this.addItems(_loc3);
        } // end of for
        return (_loc7);
    } // End of the function
    function subCollection(property, value, _condition)
    {
        var _loc4;
        var _loc3;
        if (__subCollections != null)
        {
            _loc4 = new com.clubpenguin.games.cardjitsu.waterserver.WaterGameCardCollection();
            for (var _loc8 in __subCollections)
            {
                _loc3 = __subCollections[_loc8].subCollection(property, value, _condition);
                _loc4.addItems(_loc3);
            } // end of for...in
        }
        else
        {
            _loc4 = (com.clubpenguin.games.cardjitsu.waterserver.WaterGameCardCollection)(super.subCollection(property, value, _condition));
        } // end else if
        return (_loc4);
    } // End of the function
    function subCollectBy(_func)
    {
        var _loc7;
        var _loc4;
        var _loc3;
        if (__subCollections != null)
        {
            _loc4 = new com.clubpenguin.games.cardjitsu.waterserver.WaterGameCardCollection();
            for (var _loc6 in __subCollections)
            {
                _loc3 = __subCollections[_loc6].subCollectBy(_func);
                _loc4.addItems(_loc3);
            } // end of for...in
        }
        else
        {
            _loc4 = (com.clubpenguin.games.cardjitsu.waterserver.WaterGameCardCollection)(super.subCollectBy(_func));
        } // end else if
        return (_loc4);
    } // End of the function
    function getCollection()
    {
        return (new com.clubpenguin.games.cardjitsu.waterserver.WaterGameCardCollection());
    } // End of the function
    function addItems()
    {
        var _loc4;
        var _loc6;
        for (var _loc5 in arguments)
        {
            _loc4 = arguments[_loc5];
            if (_loc4[__subCollectionProperty] != undefined)
            {
                __subCollections[_loc4[__subCollectionProperty]].addItems(_loc4);
                continue;
            } // end if
            if (!isNaN(_loc4.value))
            {
                __itemSum = __itemSum + _loc4.value;
            } // end if
            super.addItems(_loc4);
        } // end of for...in
        //return (this.length());
    } // End of the function
    function removeItems()
    {
        var _loc4;
        for (var _loc5 in arguments)
        {
            _loc4 = super.removeItems(arguments[_loc5]);
        } // end of for...in
        if (!isNaN(_loc4.value))
        {
            __itemSum = __itemSum - _loc4.value;
        } // end if
        return (_loc4);
    } // End of the function
    function containsCard(_cardID)
    {
        var _loc3;
        var _loc2;
        _loc3 = false;
        for (var _loc4 in __collection)
        {
            _loc2 = __collection[_loc4];
            if (_loc2.id == _cardID)
            {
                _loc3 = true;
                break;
            } // end if
        } // end of for...in
        return (_loc3);
    } // End of the function
    function extractCardByID(_cardID)
    {
        var _loc3;
        var _loc6;
        var _loc7;
        _loc6 = new com.clubpenguin.games.cardjitsu.waterserver.WaterGameCard(_cardID);
        var _loc2;
        if (__subCollections != null)
        {
            _loc7 = __subCollections[_loc6.__get__suitValue()];
            _loc7.extractCardByID(_cardID);
        }
        else
        {
            for (var _loc5 in __collection)
            {
                _loc2 = __collection[_loc5];
                if (_loc2.id == _cardID)
                {
                    _loc3 = _loc2;
                    break;
                } // end if
            } // end of for...in
        } // end else if
        this.removeItems(_loc3);
        return (_loc3);
    } // End of the function
    function addCardsByID()
    {
        var _loc3;
        for (var _loc4 in arguments)
        {
            _loc3 = arguments[_loc4];
            if (typeof(_loc3) == "number")
            {
                if (!this.contains(_loc3))
                {
                    this.addCard(new com.clubpenguin.games.cardjitsu.waterserver.WaterGameCard(_loc3));
                } // end if
            } // end if
        } // end of for...in
        //return (this.length());
    } // End of the function
    function contains(item)
    {
        var _loc3;
        if (item[__subCollectionProperty] != undefined)
        {
            _loc3 = __subCollections[item[__subCollectionProperty]].contains(item);
        }
        else
        {
            _loc3 = super.contains(item);
        } // end else if
        return (_loc3);
    } // End of the function
    function addCard(_card)
    {
        var _loc3;
        if (_card[__subCollectionProperty] != undefined)
        {
            __subCollections[_card[__subCollectionProperty]].addCard(_card);
        }
        else
        {
            this.addItems(_card);
        } // end else if
    } // End of the function
    function subDeck(_value)
    {
        var _loc2;
        _loc2 = __subCollections[_value];
        return (_loc2);
    } // End of the function
    function toString()
    {
        var _loc2;
        var _loc4;
        var _loc7;
        var _loc3;
        _loc2 = (__subCollections ? ("PARENT ") : ("   ")) + "DECK ";
        for (var _loc6 in __collection)
        {
            _loc4 = __collection[_loc6];
            _loc2 = _loc2 + _loc4;
        } // end of for...in
        if (__subCollections != null)
        {
            for (var _loc5 in __subCollections)
            {
                _loc3 = __subCollections[_loc5];
                _loc2 = _loc2 + ("\n" + _loc3);
            } // end of for...in
        } // end if
        return (_loc2);
    } // End of the function
    function removeItemAt(_index)
    {
        var _loc2;
        var _loc4;
        if (_index < 0 || _index > __collection.length)
        {
            return;
        } // end if
        _loc2 = __collection.splice(_index, 1)[0];
        __reserve.addItems(_loc2);
        if (__subCollections)
        {
            _loc4 = __subCollections[_loc2];
            _loc2 = _loc4.deal();
        } // end if
        return (_loc2);
    } // End of the function
    function deal()
    {
        if (__collection.length == 0 && __reserve.__get__length() > 0)
        {
            this.shuffle();
        } // end if
        var _loc3 = Math.floor(Math.random() * this.__get__length());
        var _loc2;
        _loc2 = this.removeItemAt(_loc3);
        return (_loc2);
    } // End of the function
    function get sum()
    {
        var _loc4;
        var _loc3;
        if (__subCollections != null)
        {
            _loc4 = 0;
            for (var _loc5 in __subCollections)
            {
                _loc3 = __subCollections[_loc5];
                _loc4 = _loc4 + _loc3.sum;
            } // end of for...in
        }
        else
        {
            _loc4 = super.sum;
        } // end else if
        return (_loc4);
    } // End of the function
    function sumOf(_subCol)
    {
        var _loc2;
        var _loc3;
        if (__subCollections != null)
        {
            _loc3 = __subCollections[_subCol];
            _loc2 = _loc3.sum;
        }
        else
        {
            _loc2 = sum;
        } // end else if
        return (_loc2);
    } // End of the function
    function shuffle(Void)
    {
        this.addItems(__reserve);
        __reserve.clear();
    } // End of the function
} // End of Class
