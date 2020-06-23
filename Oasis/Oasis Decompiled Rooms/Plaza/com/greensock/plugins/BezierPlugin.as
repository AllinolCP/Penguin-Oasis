class com.greensock.plugins.BezierPlugin extends com.greensock.plugins.TweenPlugin
{
    var propName, overwriteProps, _future, _target, _orientData, _orient, _beziers, round, __set__changeFactor, __get__changeFactor;
    function BezierPlugin()
    {
        super();
        propName = "bezier";
        overwriteProps = [];
        _future = {};
    } // End of the function
    function onInitTween(target, value, tween)
    {
        if (!(value instanceof Array))
        {
            return (false);
        } // end if
        this.init(tween, [value][0], false);
        return (true);
    } // End of the function
    function init(tween, beziers, through)
    {
        _target = tween.target;
        var _loc6 = tween.vars;
        if (_loc6.orientToBezier == true)
        {
            _orientData = [["_x", "_y", "_rotation", 0, 0.010000]];
            _orient = true;
        }
        else if (_loc6.orientToBezier instanceof Array)
        {
            _orientData = _loc6.orientToBezier;
            _orient = true;
        } // end else if
        var _loc3 = {};
        var _loc2;
        var _loc8;
        var _loc7;
        for (var _loc2 = 0; _loc2 < beziers.length; ++_loc2)
        {
            for (var _loc8 in beziers[_loc2])
            {
                if (_loc3[_loc8] == undefined)
                {
                    _loc3[_loc8] = [tween.target[_loc8]];
                } // end if
                if (typeof(beziers[_loc2][_loc8]) == "number")
                {
                    _loc3[_loc8].push(beziers[_loc2][_loc8]);
                    continue;
                } // end if
                _loc3[_loc8].push(tween.target[_loc8] + Number(beziers[_loc2][_loc8]));
            } // end of for...in
        } // end of for
        for (var _loc8 in _loc3)
        {
            overwriteProps[overwriteProps.length] = _loc8;
            if (_loc6[_loc8] != undefined)
            {
                if (typeof(_loc6[_loc8]) == "number")
                {
                    _loc3[_loc8].push(_loc6[_loc8]);
                }
                else
                {
                    _loc3[_loc8].push(tween.target[_loc8] + Number(_loc6[_loc8]));
                } // end else if
                _loc7 = {};
                _loc7[_loc8] = true;
                tween.killVars(_loc7, false);
                delete _loc6[_loc8];
            } // end if
        } // end of for...in
        _beziers = com.greensock.plugins.BezierPlugin.parseBeziers(_loc3, through);
    } // End of the function
    static function parseBeziers(props, through)
    {
        var _loc3;
        var _loc1;
        var _loc2;
        var _loc6;
        var _loc5 = {};
        if (through == true)
        {
            for (var _loc6 in props)
            {
                _loc1 = props[_loc6];
                _loc2 = [];
                _loc5[_loc6] = [];
                if (_loc1.length > 2)
                {
                    _loc2[_loc2.length] = [_loc1[0], _loc1[1] - (_loc1[2] - _loc1[0]) / 4, _loc1[1]];
                    for (var _loc3 = 1; _loc3 < _loc1.length - 1; ++_loc3)
                    {
                        _loc2[_loc2.length] = [_loc1[_loc3], _loc1[_loc3] + (_loc1[_loc3] - _loc2[_loc3 - 1][1]), _loc1[_loc3 + 1]];
                    } // end of for
                    continue;
                } // end if
                _loc2[_loc2.length] = [_loc1[0], (_loc1[0] + _loc1[1]) / 2, _loc1[1]];
            } // end of for...in
        }
        else
        {
            for (var _loc6 in props)
            {
                _loc1 = props[_loc6];
                _loc2 = [];
                _loc5[_loc6] = [];
                if (_loc1.length > 3)
                {
                    _loc2[_loc2.length] = [_loc1[0], _loc1[1], (_loc1[1] + _loc1[2]) / 2];
                    for (var _loc3 = 2; _loc3 < _loc1.length - 2; ++_loc3)
                    {
                        _loc2[_loc2.length] = [_loc2[_loc3 - 2][2], _loc1[_loc3], (_loc1[_loc3] + _loc1[_loc3 + 1]) / 2];
                    } // end of for
                    _loc2[_loc2.length] = [_loc2[_loc2.length - 1][2], _loc1[_loc1.length - 2], _loc1[_loc1.length - 1]];
                    continue;
                } // end if
                if (_loc1.length == 3)
                {
                    _loc2[_loc2.length] = [_loc1[0], _loc1[1], _loc1[2]];
                    continue;
                } // end if
                if (_loc1.length == 2)
                {
                    _loc2[_loc2.length] = [_loc1[0], (_loc1[0] + _loc1[1]) / 2, _loc1[1]];
                } // end if
            } // end of for...in
        } // end else if
        return (_loc5);
    } // End of the function
    function killProps(lookup)
    {
        for (var _loc4 in _beziers)
        {
            if (lookup[_loc4] != undefined)
            {
                delete _beziers[_loc4];
            } // end if
        } // end of for...in
        super.killProps(lookup);
    } // End of the function
    function set changeFactor(n)
    {
        var _loc3;
        var _loc13;
        var _loc4;
        var _loc5;
        var _loc6;
        var _loc16;
        var _loc15;
        if (n == 1)
        {
            for (var _loc13 in _beziers)
            {
                _loc3 = _beziers[_loc13].length - 1;
                _target[_loc13] = _beziers[_loc13][_loc3][2];
            } // end of for...in
        }
        else
        {
            for (var _loc13 in _beziers)
            {
                _loc6 = _beziers[_loc13].length;
                if (n < 0)
                {
                    _loc3 = 0;
                }
                else if (n >= 1)
                {
                    _loc3 = _loc6 - 1;
                }
                else
                {
                    _loc3 = _loc6 * n >> 0;
                } // end else if
                _loc5 = (n - _loc3 * (1 / _loc6)) * _loc6;
                _loc4 = _beziers[_loc13][_loc3];
                if (round)
                {
                    _target[_loc13] = Math.round(_loc4[0] + _loc5 * (2 * (1 - _loc5) * (_loc4[1] - _loc4[0]) + _loc5 * (_loc4[2] - _loc4[0])));
                    continue;
                } // end if
                _target[_loc13] = _loc4[0] + _loc5 * (2 * (1 - _loc5) * (_loc4[1] - _loc4[0]) + _loc5 * (_loc4[2] - _loc4[0]));
            } // end of for...in
        } // end else if
        if (_orient == true)
        {
            _loc3 = _orientData.length;
            var _loc8 = {};
            var _loc10;
            var _loc11;
            var _loc2;
            var _loc9;
            while (_loc3-- > 0)
            {
                _loc2 = _orientData[_loc3];
                _loc8[_loc2[0]] = _target[_loc2[0]];
                _loc8[_loc2[1]] = _target[_loc2[1]];
            } // end while
            var _loc12 = _target;
            var _loc14 = round;
            _target = _future;
            round = false;
            _orient = false;
            _loc3 = _orientData.length;
            while (_loc3-- > 0)
            {
                _loc2 = _orientData[_loc3];
                this.__set__changeFactor(n + (_loc2[4] || 0.010000));
                _loc9 = _loc2[3] || 0;
                _loc10 = _future[_loc2[0]] - _loc8[_loc2[0]];
                _loc11 = _future[_loc2[1]] - _loc8[_loc2[1]];
                _loc12[_loc2[2]] = Math.atan2(_loc11, _loc10) * com.greensock.plugins.BezierPlugin._RAD2DEG + _loc9;
            } // end while
            _target = _loc12;
            round = _loc14;
            _orient = true;
        } // end if
        null;
        //return (this.changeFactor());
        null;
    } // End of the function
    static var API = 1;
    static var _RAD2DEG = 57.295780;
} // End of Class
