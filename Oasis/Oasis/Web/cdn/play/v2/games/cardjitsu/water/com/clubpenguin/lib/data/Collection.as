class com.clubpenguin.lib.data.Collection extends Object
{
    var __collection, __itemSum, __get__length, __get__itemList, __get__sum;
    function Collection()
    {
        super();
        __collection = new Array();
        __itemSum = 0;
    } // End of the function
    function addItems()
    {
        var _loc3;
        var _loc4;
        for (var _loc6 in arguments)
        {
            _loc3 = arguments[_loc6];
            if (_loc3 instanceof Array)
            {
                for (var _loc5 in _loc3)
                {
                    _loc4 = _loc3[_loc5];
                    this.addItems(_loc4);
                } // end of for...in
                continue;
            } // end if
            if (_loc3 instanceof com.clubpenguin.lib.data.Collection)
            {
                for (var _loc5 in _loc3.itemList)
                {
                    _loc4 = _loc3.itemList[_loc5];
                    this.addItems(_loc4);
                } // end of for...in
                continue;
            } // end if
            if (!this.contains(_loc3))
            {
                if (!isNaN(_loc3))
                {
                    __itemSum = __itemSum + _loc3;
                } // end if
                __collection.push(_loc3);
            } // end if
        } // end of for...in
        //return (this.length());
    } // End of the function
    function removeItems()
    {
        var _loc6;
        var _loc3;
        var _loc4;
        for (var _loc8 in arguments)
        {
            _loc3 = arguments[_loc8];
            if (_loc3 instanceof Array)
            {
                for (var _loc5 in _loc3)
                {
                    _loc4 = _loc3[_loc5];
                    _loc6 = this.removeItems(_loc4);
                } // end of for...in
                continue;
            } // end if
            if (_loc3 instanceof com.clubpenguin.lib.data.Collection)
            {
                for (var _loc5 in _loc3.itemList)
                {
                    _loc4 = _loc3.itemList[_loc5];
                    _loc6 = this.removeItems(_loc4);
                } // end of for...in
                continue;
            } // end if
            if (this.contains(_loc3))
            {
                var _loc7 = this.indexOf(__collection, _loc3);
                if (!isNaN(__collection[_loc7]))
                {
                    __itemSum = __itemSum - __collection[_loc7];
                } // end if
                _loc6 = __collection.splice(_loc7, 1)[0];
            } // end if
        } // end of for...in
        return (_loc6);
    } // End of the function
    function contains(item)
    {
        var _loc2;
        if (item instanceof Array || item instanceof com.clubpenguin.lib.data.Collection)
        {
            _loc2 = this.containsAll(item);
        }
        else
        {
            var _loc4 = this.indexOf(__collection, item);
            if (_loc4 > -1 || this === item)
            {
                _loc2 = true;
            }
            else
            {
                _loc2 = false;
            } // end else if
        } // end else if
        return (_loc2);
    } // End of the function
    function indexOf(_arr, item)
    {
        var _loc4;
        var _loc1;
        var _loc2;
        _loc4 = -1;
        for (var _loc1 = 0; _loc1 < _arr.length; ++_loc1)
        {
            _loc2 = _arr[_loc1];
            if (_loc2 == item)
            {
                _loc4 = _loc1;
                break;
            } // end if
        } // end of for
        return (_loc4);
    } // End of the function
    function containsAll()
    {
        var _loc6;
        var _loc3;
        var _loc5 = true;
        for (var _loc6 in arguments)
        {
            if (_loc6 instanceof Array)
            {
                for (var _loc4 in _loc6)
                {
                    _loc3 = _loc6[_loc4];
                    if (!__collection.containsAll(_loc3))
                    {
                        _loc5 = false;
                    } // end if
                } // end of for...in
                continue;
            } // end if
            if (_loc6 instanceof com.clubpenguin.lib.data.Collection)
            {
                for (var _loc4 in _loc6.itemList)
                {
                    _loc3 = _loc6.itemList[_loc4];
                    if (!__collection.containsAll(_loc3))
                    {
                        _loc5 = false;
                    } // end if
                } // end of for...in
                continue;
            } // end if
            if (!__collection.contains(_loc6))
            {
                _loc5 = false;
            } // end if
        } // end of for...in
        return (_loc5);
    } // End of the function
    function containsAny()
    {
        var _loc3;
        var _loc4;
        var _loc6 = false;
        for (var _loc7 in arguments)
        {
            _loc3 = arguments[_loc7];
            if (_loc3 instanceof Array)
            {
                for (var _loc5 in _loc3)
                {
                    _loc4 = _loc3[_loc5];
                    if (!__collection.containsAny(_loc4))
                    {
                        _loc6 = true;
                        break;
                    } // end if
                } // end of for...in
                continue;
            } // end if
            if (_loc3 instanceof com.clubpenguin.lib.data.Collection)
            {
                for (var _loc5 in _loc3.itemList)
                {
                    _loc4 = _loc3.itemList[_loc5];
                    if (!__collection.containsAny(_loc4))
                    {
                        _loc6 = true;
                        break;
                    } // end if
                } // end of for...in
                continue;
            } // end if
            if (!__collection.contains(_loc3))
            {
                _loc6 = true;
                break;
            } // end if
        } // end of for...in
        return (_loc6);
    } // End of the function
    function filter(callback, thisObject)
    {
        var _loc2 = new com.clubpenguin.lib.data.Collection();
        _loc2.addItems(__collection.filter(callback, thisObject));
        return (_loc2);
    } // End of the function
    function forEach(callback, thisObject)
    {
        __collection.forEach(callback, thisObject);
    } // End of the function
    function join(sep)
    {
        return (__collection.join(sep));
    } // End of the function
    function map(callback, thisObject)
    {
        var _loc3;
        var _loc2 = __collection.map(callback, thisObject);
        var _loc4 = new com.clubpenguin.lib.data.Collection();
        for (var _loc5 in _loc2)
        {
            _loc3 = _loc2[_loc5];
            _loc4.addItems(_loc3);
        } // end of for...in
        return (_loc4);
    } // End of the function
    function some(callback, thisObject)
    {
        return (__collection.some(callback, thisObject));
    } // End of the function
    function every(callback, thisObject)
    {
        return (__collection.every(callback, thisObject));
    } // End of the function
    function subCollection(property, value, _condition)
    {
        var _loc2;
        if (isNaN(_condition))
        {
            _condition = com.clubpenguin.lib.data.Collection.COND_EQ;
        } // end if
        var _loc3;
        _loc3 = this.getCollection();
        for (var _loc7 in __collection)
        {
            _loc2 = __collection[_loc7];
            try
            {
                switch (_condition)
                {
                    case com.clubpenguin.lib.data.Collection.COND_EQ:
                    {
                        if (_loc2[property] == value)
                        {
                            _loc3.addItems(_loc2);
                        } // end if
                        break;
                    } 
                    case com.clubpenguin.lib.data.Collection.COND_GT:
                    {
                        if (_loc2[property] > value)
                        {
                            _loc3.addItems(_loc2);
                        } // end if
                        break;
                    } 
                    case com.clubpenguin.lib.data.Collection.COND_GE:
                    {
                        if (_loc2[property] >= value)
                        {
                            _loc3.addItems(_loc2);
                        } // end if
                        break;
                    } 
                    case com.clubpenguin.lib.data.Collection.COND_LT:
                    {
                        if (_loc2[property] < value)
                        {
                            _loc3.addItems(_loc2);
                        } // end if
                        break;
                    } 
                    case com.clubpenguin.lib.data.Collection.COND_LE:
                    {
                        if (_loc2[property] <= value)
                        {
                            _loc3.addItems(_loc2);
                        } // end if
                        break;
                    } 
                    case com.clubpenguin.lib.data.Collection.COND_NE:
                    {
                        if (_loc2[property] != value)
                        {
                            _loc3.addItems(_loc2);
                        } // end if
                        break;
                    } 
                } // End of switch
            } // End of try
            catch (err)
            {
                break;
            } // end of for...in
        } // end while
        return (_loc3);
    } // End of the function
    function subCollectBy(_func)
    {
        var _loc2;
        var _loc3;
        _loc3 = this.getCollection();
        for (var _loc4 in __collection)
        {
            _loc2 = __collection[_loc4];
            if (_func(_loc2))
            {
                _loc3.addItems(_loc2);
            } // end if
        } // end of for...in
        return (_loc3);
    } // End of the function
    function getCollection()
    {
        return (new com.clubpenguin.lib.data.Collection());
    } // End of the function
    function intersection(coll)
    {
        var _loc2;
        var _loc4 = new com.clubpenguin.lib.data.Collection();
        for (var _loc5 in coll.__get__itemList())
        {
            _loc2 = coll.__get__itemList()[_loc5];
            if (this.contains(_loc2))
            {
                _loc4.addItems(_loc2);
            } // end if
        } // end of for...in
        return (_loc4);
    } // End of the function
    function intersectMany()
    {
        var _loc3;
        var _loc4 = new com.clubpenguin.lib.data.Collection();
        _loc4.addItems(__collection);
        for (var _loc5 in arguments)
        {
            _loc3 = arguments[_loc5];
            if (_loc3 instanceof com.clubpenguin.lib.data.Collection)
            {
                _loc4 = _loc4.intersection(_loc3);
            } // end if
        } // end of for...in
        return (_loc4);
    } // End of the function
    function union(coll)
    {
        var _loc2 = new com.clubpenguin.lib.data.Collection();
        _loc2.addItems(this.__get__itemList(), coll);
        return (_loc2);
    } // End of the function
    function unionMany()
    {
        var _loc3;
        var _loc4 = new com.clubpenguin.lib.data.Collection();
        _loc4.addItems(__collection);
        for (var _loc5 in arguments)
        {
            _loc3 = arguments[_loc5];
            if (_loc3 instanceof com.clubpenguin.lib.data.Collection)
            {
                _loc4 = _loc4.union(_loc3);
            } // end if
        } // end of for...in
        return (_loc4);
    } // End of the function
    function relComp(coll)
    {
        var _loc2 = new com.clubpenguin.lib.data.Collection();
        _loc2.addItems(__collection);
        _loc2.removeItems(coll);
        return (_loc2);
    } // End of the function
    function relCompMany()
    {
        var _loc3;
        var _loc4 = new com.clubpenguin.lib.data.Collection();
        _loc4.addItems(__collection);
        for (var _loc5 in arguments)
        {
            _loc3 = arguments[_loc5];
            if (_loc3 instanceof com.clubpenguin.lib.data.Collection)
            {
                _loc4.removeItems(_loc3);
            } // end if
        } // end of for...in
        return (_loc4);
    } // End of the function
    function clear()
    {
        __collection = new Array();
    } // End of the function
    function get length()
    {
        return (__collection.length);
    } // End of the function
    function get sum()
    {
        return (__itemSum);
    } // End of the function
    function get itemList()
    {
        return (__collection);
    } // End of the function
    static var COND_EQ = 1;
    static var COND_GT = 2;
    static var COND_GE = 3;
    static var COND_LT = 4;
    static var COND_LE = 5;
    static var COND_NE = 6;
} // End of Class
