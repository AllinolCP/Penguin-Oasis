class com.clubpenguin.engine.tweener.Tweener
{
    static var _specialPropertySplitterList, _specialPropertyModifierList, _specialPropertyList, _transitionList, _currentTimeFrame, _currentTime, _tweenList, handleError;
    function Tweener()
    {
    } // End of the function
    static function addTween(p_scopes, p_parameters)
    {
        if (p_scopes == undefined)
        {
            return (false);
        } // end if
        var _loc3;
        var _loc8;
        var _loc2;
        var _loc11;
        if (p_scopes instanceof Array)
        {
            _loc11 = p_scopes.concat();
        }
        else
        {
            _loc11 = [p_scopes];
        } // end else if
        var _loc5 = com.clubpenguin.engine.tweener.TweenListObj.makePropertiesChain(p_parameters);
        if (!com.clubpenguin.engine.tweener.Tweener._inited)
        {
            com.clubpenguin.engine.tweener.Tweener.init();
        } // end if
        if (!com.clubpenguin.engine.tweener.Tweener._engineExists || _root[com.clubpenguin.engine.tweener.Tweener.getControllerName()] == undefined)
        {
            com.clubpenguin.engine.tweener.Tweener.startEngine();
        } // end if
        var _loc19 = isNaN(_loc5.time) ? (0) : (_loc5.time);
        var _loc12 = isNaN(_loc5.delay) ? (0) : (_loc5.delay);
        var _loc4 = new Object();
        var _loc24 = {time: true, delay: true, useFrames: true, skipUpdates: true, transition: true, transitionParams: true, onStart: true, onUpdate: true, onComplete: true, onOverwrite: true, onError: true, rounded: true, onStartParams: true, onUpdateParams: true, onCompleteParams: true, onOverwriteParams: true, onStartScope: true, onUpdateScope: true, onCompleteScope: true, onOverwriteScope: true, onErrorScope: true, quickAdd: true};
        var _loc13 = new Object();
        for (var _loc2 in _loc5)
        {
            if (!_loc24[_loc2])
            {
                if (com.clubpenguin.engine.tweener.Tweener._specialPropertySplitterList[_loc2] != undefined)
                {
                    var _loc7 = com.clubpenguin.engine.tweener.Tweener._specialPropertySplitterList[_loc2].splitValues(_loc5[_loc2], com.clubpenguin.engine.tweener.Tweener._specialPropertySplitterList[_loc2].parameters);
                    for (var _loc3 = 0; _loc3 < _loc7.length; ++_loc3)
                    {
                        if (com.clubpenguin.engine.tweener.Tweener._specialPropertySplitterList[_loc7[_loc3].name] != undefined)
                        {
                            var _loc9 = com.clubpenguin.engine.tweener.Tweener._specialPropertySplitterList[_loc7[_loc3].name].splitValues(_loc7[_loc3].value, com.clubpenguin.engine.tweener.Tweener._specialPropertySplitterList[_loc7[_loc3].name].parameters);
                            for (var _loc8 = 0; _loc8 < _loc9.length; ++_loc8)
                            {
                                _loc4[_loc9[_loc8].name] = {valueStart: undefined, valueComplete: _loc9[_loc8].value, arrayIndex: _loc9[_loc8].arrayIndex, isSpecialProperty: false};
                            } // end of for
                            continue;
                        } // end if
                        _loc4[_loc7[_loc3].name] = {valueStart: undefined, valueComplete: _loc7[_loc3].value, arrayIndex: _loc7[_loc3].arrayIndex, isSpecialProperty: false};
                    } // end of for
                    continue;
                } // end if
                if (com.clubpenguin.engine.tweener.Tweener._specialPropertyModifierList[_loc2] != undefined)
                {
                    var _loc10 = com.clubpenguin.engine.tweener.Tweener._specialPropertyModifierList[_loc2].modifyValues(_loc5[_loc2]);
                    for (var _loc3 = 0; _loc3 < _loc10.length; ++_loc3)
                    {
                        _loc13[_loc10[_loc3].name] = {modifierParameters: _loc10[_loc3].parameters, modifierFunction: com.clubpenguin.engine.tweener.Tweener._specialPropertyModifierList[_loc2].getValue};
                    } // end of for
                    continue;
                } // end if
                _loc4[_loc2] = {valueStart: undefined, valueComplete: _loc5[_loc2]};
            } // end if
        } // end of for...in
        for (var _loc2 in _loc4)
        {
            if (com.clubpenguin.engine.tweener.Tweener._specialPropertyList[_loc2] != undefined)
            {
                _loc4[_loc2].isSpecialProperty = true;
                continue;
            } // end if
            if (_loc11[0][_loc2] == undefined)
            {
                com.clubpenguin.engine.tweener.Tweener.printError("The property \'" + _loc2 + "\' doesn\'t seem to be a normal object property of " + _loc11[0].toString() + " or a registered special property.");
            } // end if
        } // end of for...in
        for (var _loc2 in _loc13)
        {
            if (_loc4[_loc2] != undefined)
            {
                _loc4[_loc2].modifierParameters = _loc13[_loc2].modifierParameters;
                _loc4[_loc2].modifierFunction = _loc13[_loc2].modifierFunction;
            } // end if
        } // end of for...in
        var _loc21;
        if (typeof(_loc5.transition) == "string")
        {
            var _loc26 = _loc5.transition.toLowerCase();
            _loc21 = com.clubpenguin.engine.tweener.Tweener._transitionList[_loc26];
        }
        else
        {
            _loc21 = _loc5.transition;
        } // end else if
        if (_loc21 == undefined)
        {
            _loc21 = com.clubpenguin.engine.tweener.Tweener._transitionList.easeoutexpo;
        } // end if
        var _loc14;
        var _loc6;
        var _loc20;
        for (var _loc3 = 0; _loc3 < _loc11.length; ++_loc3)
        {
            _loc14 = new Object();
            for (var _loc2 in _loc4)
            {
                _loc14[_loc2] = new com.clubpenguin.engine.tweener.PropertyInfoObj(_loc4[_loc2].valueStart, _loc4[_loc2].valueComplete, _loc4[_loc2].valueComplete, _loc4[_loc2].arrayIndex, {}, _loc4[_loc2].isSpecialProperty, _loc4[_loc2].modifierFunction, _loc4[_loc2].modifierParameters);
            } // end of for...in
            if (_loc5.useFrames == true)
            {
                _loc6 = new com.clubpenguin.engine.tweener.TweenListObj(_loc11[_loc3], com.clubpenguin.engine.tweener.Tweener._currentTimeFrame + _loc12 / com.clubpenguin.engine.tweener.Tweener._timeScale, com.clubpenguin.engine.tweener.Tweener._currentTimeFrame + (_loc12 + _loc19) / com.clubpenguin.engine.tweener.Tweener._timeScale, true, _loc21, _loc5.transitionParams);
            }
            else
            {
                _loc6 = new com.clubpenguin.engine.tweener.TweenListObj(_loc11[_loc3], com.clubpenguin.engine.tweener.Tweener._currentTime + _loc12 * 1000 / com.clubpenguin.engine.tweener.Tweener._timeScale, com.clubpenguin.engine.tweener.Tweener._currentTime + (_loc12 * 1000 + _loc19 * 1000) / com.clubpenguin.engine.tweener.Tweener._timeScale, false, _loc21, _loc5.transitionParams);
            } // end else if
            _loc6.properties = _loc14;
            _loc6.onStart = _loc5.onStart;
            _loc6.onUpdate = _loc5.onUpdate;
            _loc6.onComplete = _loc5.onComplete;
            _loc6.onOverwrite = _loc5.onOverwrite;
            _loc6.onError = _loc5.onError;
            _loc6.onStartParams = _loc5.onStartParams;
            _loc6.onUpdateParams = _loc5.onUpdateParams;
            _loc6.onCompleteParams = _loc5.onCompleteParams;
            _loc6.onOverwriteParams = _loc5.onOverwriteParams;
            _loc6.onStartScope = _loc5.onStartScope;
            _loc6.onUpdateScope = _loc5.onUpdateScope;
            _loc6.onCompleteScope = _loc5.onCompleteScope;
            _loc6.onOverwriteScope = _loc5.onOverwriteScope;
            _loc6.onErrorScope = _loc5.onErrorScope;
            _loc6.rounded = _loc5.rounded;
            _loc6.skipUpdates = _loc5.skipUpdates;
            if (!_loc5.quickAdd)
            {
                com.clubpenguin.engine.tweener.Tweener.removeTweensByTime(_loc6.scope, _loc6.properties, _loc6.timeStart, _loc6.timeComplete);
            } // end if
            com.clubpenguin.engine.tweener.Tweener._tweenList.push(_loc6);
            if (_loc19 == 0 && _loc12 == 0)
            {
                _loc20 = com.clubpenguin.engine.tweener.Tweener._tweenList.length - 1;
                com.clubpenguin.engine.tweener.Tweener.updateTweenByIndex(_loc20);
                com.clubpenguin.engine.tweener.Tweener.removeTweenByIndex(_loc20);
            } // end if
        } // end of for
        return (true);
    } // End of the function
    static function addCaller(p_scopes, p_parameters)
    {
        if (p_scopes == undefined)
        {
            return (false);
        } // end if
        var _loc5;
        var _loc6;
        if (p_scopes instanceof Array)
        {
            _loc6 = p_scopes.concat();
        }
        else
        {
            _loc6 = [p_scopes];
        } // end else if
        var _loc3 = p_parameters;
        if (!com.clubpenguin.engine.tweener.Tweener._inited)
        {
            com.clubpenguin.engine.tweener.Tweener.init();
        } // end if
        if (!com.clubpenguin.engine.tweener.Tweener._engineExists || _root[com.clubpenguin.engine.tweener.Tweener.getControllerName()] == undefined)
        {
            com.clubpenguin.engine.tweener.Tweener.startEngine();
        } // end if
        var _loc7 = isNaN(_loc3.time) ? (0) : (_loc3.time);
        var _loc4 = isNaN(_loc3.delay) ? (0) : (_loc3.delay);
        var _loc9;
        if (typeof(_loc3.transition) == "string")
        {
            var _loc11 = _loc3.transition.toLowerCase();
            _loc9 = com.clubpenguin.engine.tweener.Tweener._transitionList[_loc11];
        }
        else
        {
            _loc9 = _loc3.transition;
        } // end else if
        if (_loc9 == undefined)
        {
            _loc9 = com.clubpenguin.engine.tweener.Tweener._transitionList.easeoutexpo;
        } // end if
        var _loc2;
        var _loc8;
        for (var _loc5 = 0; _loc5 < _loc6.length; ++_loc5)
        {
            if (_loc3.useFrames == true)
            {
                _loc2 = new com.clubpenguin.engine.tweener.TweenListObj(_loc6[_loc5], com.clubpenguin.engine.tweener.Tweener._currentTimeFrame + _loc4 / com.clubpenguin.engine.tweener.Tweener._timeScale, com.clubpenguin.engine.tweener.Tweener._currentTimeFrame + (_loc4 + _loc7) / com.clubpenguin.engine.tweener.Tweener._timeScale, true, _loc9, _loc3.transitionParams);
            }
            else
            {
                _loc2 = new com.clubpenguin.engine.tweener.TweenListObj(_loc6[_loc5], com.clubpenguin.engine.tweener.Tweener._currentTime + _loc4 * 1000 / com.clubpenguin.engine.tweener.Tweener._timeScale, com.clubpenguin.engine.tweener.Tweener._currentTime + (_loc4 * 1000 + _loc7 * 1000) / com.clubpenguin.engine.tweener.Tweener._timeScale, false, _loc9, _loc3.transitionParams);
            } // end else if
            _loc2.properties = undefined;
            _loc2.onStart = _loc3.onStart;
            _loc2.onUpdate = _loc3.onUpdate;
            _loc2.onComplete = _loc3.onComplete;
            _loc2.onOverwrite = _loc3.onOverwrite;
            _loc2.onStartParams = _loc3.onStartParams;
            _loc2.onUpdateParams = _loc3.onUpdateParams;
            _loc2.onCompleteParams = _loc3.onCompleteParams;
            _loc2.onOverwriteParams = _loc3.onOverwriteParams;
            _loc2.onStartScope = _loc3.onStartScope;
            _loc2.onUpdateScope = _loc3.onUpdateScope;
            _loc2.onCompleteScope = _loc3.onCompleteScope;
            _loc2.onOverwriteScope = _loc3.onOverwriteScope;
            _loc2.onErrorScope = _loc3.onErrorScope;
            _loc2.isCaller = true;
            _loc2.count = _loc3.count;
            _loc2.waitFrames = _loc3.waitFrames;
            com.clubpenguin.engine.tweener.Tweener._tweenList.push(_loc2);
            if (_loc7 == 0 && _loc4 == 0)
            {
                _loc8 = com.clubpenguin.engine.tweener.Tweener._tweenList.length - 1;
                com.clubpenguin.engine.tweener.Tweener.updateTweenByIndex(_loc8);
                com.clubpenguin.engine.tweener.Tweener.removeTweenByIndex(_loc8);
            } // end if
        } // end of for
        return (true);
    } // End of the function
    static function removeTweensByTime(p_scope, p_properties, p_timeStart, p_timeComplete)
    {
        var _loc5 = false;
        var _loc4;
        var _loc1;
        var _loc7 = com.clubpenguin.engine.tweener.Tweener._tweenList.length;
        var _loc2;
        _loc1 = 0;
        if (_loc1 < _loc7)
        {
            if (p_scope == com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].scope)
            {
                if (p_timeComplete > com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].timeStart && p_timeStart < com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].timeComplete)
                {
                    _loc4 = false;
                    _loc2 = com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].properties;
                    if (p_properties[_loc2] != undefined)
                    {
                        if (com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].onOverwrite != undefined)
                        {
                            var _loc3 = com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].onOverwriteScope != undefined ? (com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].onOverwriteScope) : (com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].scope);
                            try
                            {
                                com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].onOverwrite.apply(_loc3, com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].onOverwriteParams);
                            } // End of try
                            catch ()
                            {
                            } // End of catch
                        } // end if
                        com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].properties[_loc2] = undefined;
                        delete com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].properties[_loc2];
                        _loc4 = true;
                        _loc5 = true;
                    } // end if
                    if (_loc4)
                    {
                        if (com.clubpenguin.engine.tweener.AuxFunctions.getObjectLength(com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].properties) == 0)
                        {
                            com.clubpenguin.engine.tweener.Tweener.removeTweenByIndex(_loc1);
                        } // end if
                    } // end if
                } // end if
            } // end if
            ++_loc1;
        } // end if
        return (_loc5);
    } // End of the function
    static function removeTweens(p_scope)
    {
        var _loc5 = new Array();
        var _loc3;
        for (var _loc3 = 1; _loc3 < arguments.length; ++_loc3)
        {
            if (typeof(arguments[_loc3]) == "string" && !com.clubpenguin.engine.tweener.AuxFunctions.isInArray(arguments[_loc3], _loc5))
            {
                if (com.clubpenguin.engine.tweener.Tweener._specialPropertySplitterList[arguments[_loc3]])
                {
                    var _loc6 = com.clubpenguin.engine.tweener.Tweener._specialPropertySplitterList[arguments[_loc3]];
                    var _loc4 = _loc6.splitValues(p_scope, null);
                    for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
                    {
                        _loc5.push(_loc4[_loc2].name);
                    } // end of for
                    continue;
                } // end if
                _loc5.push(arguments[_loc3]);
            } // end if
        } // end of for
        return (com.clubpenguin.engine.tweener.Tweener.affectTweens(com.clubpenguin.engine.tweener.Tweener.removeTweenByIndex, p_scope, _loc5));
    } // End of the function
    static function removeAllTweens()
    {
        var _loc2 = false;
        var _loc1;
        for (var _loc1 = 0; _loc1 < com.clubpenguin.engine.tweener.Tweener._tweenList.length; ++_loc1)
        {
            com.clubpenguin.engine.tweener.Tweener.removeTweenByIndex(_loc1);
            _loc2 = true;
        } // end of for
        return (_loc2);
    } // End of the function
    static function pauseTweens(p_scope)
    {
        var _loc3 = new Array();
        var _loc2;
        for (var _loc2 = 1; _loc2 < arguments.length; ++_loc2)
        {
            if (typeof(arguments[_loc2]) == "string" && !com.clubpenguin.engine.tweener.AuxFunctions.isInArray(arguments[_loc2], _loc3))
            {
                _loc3.push(arguments[_loc2]);
            } // end if
        } // end of for
        return (com.clubpenguin.engine.tweener.Tweener.affectTweens(com.clubpenguin.engine.tweener.Tweener.pauseTweenByIndex, p_scope, _loc3));
    } // End of the function
    static function pauseAllTweens()
    {
        var _loc2 = false;
        var _loc1;
        for (var _loc1 = 0; _loc1 < com.clubpenguin.engine.tweener.Tweener._tweenList.length; ++_loc1)
        {
            com.clubpenguin.engine.tweener.Tweener.pauseTweenByIndex(_loc1);
            _loc2 = true;
        } // end of for
        return (_loc2);
    } // End of the function
    static function resumeTweens(p_scope)
    {
        var _loc3 = new Array();
        var _loc2;
        for (var _loc2 = 1; _loc2 < arguments.length; ++_loc2)
        {
            if (typeof(arguments[_loc2]) == "string" && !com.clubpenguin.engine.tweener.AuxFunctions.isInArray(arguments[_loc2], _loc3))
            {
                _loc3.push(arguments[_loc2]);
            } // end if
        } // end of for
        return (com.clubpenguin.engine.tweener.Tweener.affectTweens(com.clubpenguin.engine.tweener.Tweener.resumeTweenByIndex, p_scope, _loc3));
    } // End of the function
    static function resumeAllTweens()
    {
        var _loc2 = false;
        var _loc1;
        for (var _loc1 = 0; _loc1 < com.clubpenguin.engine.tweener.Tweener._tweenList.length; ++_loc1)
        {
            com.clubpenguin.engine.tweener.Tweener.resumeTweenByIndex(_loc1);
            _loc2 = true;
        } // end of for
        return (_loc2);
    } // End of the function
    static function affectTweens(p_affectFunction, p_scope, p_properties)
    {
        var _loc5 = false;
        var _loc2;
        if (!com.clubpenguin.engine.tweener.Tweener._tweenList)
        {
            return (false);
        } // end if
        for (var _loc2 = 0; _loc2 < com.clubpenguin.engine.tweener.Tweener._tweenList.length; ++_loc2)
        {
            if (com.clubpenguin.engine.tweener.Tweener._tweenList[_loc2].scope == p_scope)
            {
                if (p_properties.length == 0)
                {
                    p_affectFunction(_loc2);
                    _loc5 = true;
                    continue;
                } // end if
                var _loc4 = new Array();
                var _loc1;
                for (var _loc1 = 0; _loc1 < p_properties.length; ++_loc1)
                {
                    if (com.clubpenguin.engine.tweener.Tweener._tweenList[_loc2].properties[p_properties[_loc1]] != undefined)
                    {
                        _loc4.push(p_properties[_loc1]);
                    } // end if
                } // end of for
                if (_loc4.length > 0)
                {
                    var _loc7 = com.clubpenguin.engine.tweener.AuxFunctions.getObjectLength(com.clubpenguin.engine.tweener.Tweener._tweenList[_loc2].properties);
                    if (_loc7 == _loc4.length)
                    {
                        p_affectFunction(_loc2);
                        _loc5 = true;
                        continue;
                    } // end if
                    var _loc6 = com.clubpenguin.engine.tweener.Tweener.splitTweens(_loc2, _loc4);
                    p_affectFunction(_loc6);
                    _loc5 = true;
                } // end if
            } // end if
        } // end of for
        return (_loc5);
    } // End of the function
    static function splitTweens(p_tween, p_properties)
    {
        var _loc5 = com.clubpenguin.engine.tweener.Tweener._tweenList[p_tween];
        var _loc6 = _loc5.clone(false);
        var _loc1;
        var _loc2;
        for (var _loc1 = 0; _loc1 < p_properties.length; ++_loc1)
        {
            _loc2 = p_properties[_loc1];
            if (_loc5.properties[_loc2] != undefined)
            {
                _loc5.properties[_loc2] = undefined;
                delete _loc5.properties[_loc2];
            } // end if
        } // end of for
        var _loc4;
        for (var _loc2 in _loc6.properties)
        {
            _loc4 = false;
            for (var _loc1 = 0; _loc1 < p_properties.length; ++_loc1)
            {
                if (p_properties[_loc1] == _loc2)
                {
                    _loc4 = true;
                    break;
                } // end if
            } // end of for
            if (!_loc4)
            {
                _loc6.properties[_loc2] = undefined;
                delete _loc6.properties[_loc2];
            } // end if
        } // end of for...in
        com.clubpenguin.engine.tweener.Tweener._tweenList.push(_loc6);
        return (com.clubpenguin.engine.tweener.Tweener._tweenList.length - 1);
    } // End of the function
    static function updateTweens()
    {
        if (com.clubpenguin.engine.tweener.Tweener._tweenList.length == 0)
        {
            return (false);
        } // end if
        var _loc1;
        for (var _loc1 = 0; _loc1 < com.clubpenguin.engine.tweener.Tweener._tweenList.length; ++_loc1)
        {
            if (!com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].isPaused)
            {
                if (!com.clubpenguin.engine.tweener.Tweener.updateTweenByIndex(_loc1))
                {
                    com.clubpenguin.engine.tweener.Tweener.removeTweenByIndex(_loc1);
                } // end if
                if (com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1] == null)
                {
                    com.clubpenguin.engine.tweener.Tweener.removeTweenByIndex(_loc1, true);
                    --_loc1;
                } // end if
            } // end if
        } // end of for
        return (true);
    } // End of the function
    static function removeTweenByIndex(p_tween, p_finalRemoval)
    {
        com.clubpenguin.engine.tweener.Tweener._tweenList[p_tween] = null;
        if (p_finalRemoval)
        {
            com.clubpenguin.engine.tweener.Tweener._tweenList.splice(p_tween, 1);
        } // end if
        return (true);
    } // End of the function
    static function pauseTweenByIndex(p_tween)
    {
        var _loc1 = com.clubpenguin.engine.tweener.Tweener._tweenList[p_tween];
        if (_loc1 == null || _loc1.isPaused)
        {
            return (false);
        } // end if
        _loc1.timePaused = com.clubpenguin.engine.tweener.Tweener.getCurrentTweeningTime(_loc1);
        _loc1.isPaused = true;
        return (true);
    } // End of the function
    static function resumeTweenByIndex(p_tween)
    {
        var _loc1 = com.clubpenguin.engine.tweener.Tweener._tweenList[p_tween];
        if (_loc1 == null || !_loc1.isPaused)
        {
            return (false);
        } // end if
        var _loc2 = com.clubpenguin.engine.tweener.Tweener.getCurrentTweeningTime(_loc1);
        _loc1.timeStart = _loc1.timeStart + (_loc2 - _loc1.timePaused);
        _loc1.timeComplete = _loc1.timeComplete + (_loc2 - _loc1.timePaused);
        _loc1.timePaused = undefined;
        _loc1.isPaused = false;
        return (true);
    } // End of the function
    static function updateTweenByIndex(i)
    {
        var _loc1 = com.clubpenguin.engine.tweener.Tweener._tweenList[i];
        if (_loc1 == null || !_loc1.scope)
        {
            return (false);
        } // end if
        var _loc13 = false;
        var _loc14;
        var _loc3;
        var _loc6;
        var _loc10;
        var _loc9;
        var _loc7;
        var _loc2;
        var _loc12;
        var _loc5;
        var _loc8 = com.clubpenguin.engine.tweener.Tweener.getCurrentTweeningTime(_loc1);
        var _loc4;
        if (_loc8 >= _loc1.timeStart)
        {
            _loc5 = _loc1.scope;
            if (_loc1.isCaller)
            {
                do
                {
                    _loc6 = (_loc1.timeComplete - _loc1.timeStart) / _loc1.count * (_loc1.timesCalled + 1);
                    _loc10 = _loc1.timeStart;
                    _loc9 = _loc1.timeComplete - _loc1.timeStart;
                    _loc7 = _loc1.timeComplete - _loc1.timeStart;
                    _loc3 = _loc1.transition(_loc6, _loc10, _loc9, _loc7, _loc1.transitionParams);
                    if (_loc8 >= _loc3)
                    {
                        if (_loc1.onUpdate != undefined)
                        {
                            _loc12 = _loc1.onUpdateScope != undefined ? (_loc1.onUpdateScope) : (_loc5);
                            try
                            {
                                _loc1.onUpdate.apply(_loc12, _loc1.onUpdateParams);
                            } // End of try
                            catch ()
                            {
                            } // End of catch
                        } // end if
                        ++_loc1.timesCalled;
                        if (_loc1.timesCalled >= _loc1.count)
                        {
                            _loc13 = true;
                            break;
                        } // end if
                        if (_loc1.waitFrames)
                        {
                            break;
                        } // end if
                    } // end if
                } while (_loc8 >= _loc3)
            }
            else
            {
                _loc14 = _loc1.skipUpdates < 1 || _loc1.skipUpdates == undefined || _loc1.updatesSkipped >= _loc1.skipUpdates;
                if (_loc8 >= _loc1.timeComplete)
                {
                    _loc13 = true;
                    _loc14 = true;
                } // end if
                if (!_loc1.hasStarted)
                {
                    if (_loc1.onStart != undefined)
                    {
                        _loc12 = _loc1.onStartScope != undefined ? (_loc1.onStartScope) : (_loc5);
                        try
                        {
                            _loc1.onStart.apply(_loc12, _loc1.onStartParams);
                        } // End of try
                        catch ()
                        {
                        } // End of catch
                    } // end if
                    var _loc11;
                    for (var _loc2 in _loc1.properties)
                    {
                        if (_loc1.properties[_loc2].isSpecialProperty)
                        {
                            if (com.clubpenguin.engine.tweener.Tweener._specialPropertyList[_loc2].preProcess != undefined)
                            {
                                _loc1.properties[_loc2].valueComplete = com.clubpenguin.engine.tweener.Tweener._specialPropertyList[_loc2].preProcess(_loc5, com.clubpenguin.engine.tweener.Tweener._specialPropertyList[_loc2].parameters, _loc1.properties[_loc2].originalValueComplete, _loc1.properties[_loc2].extra);
                            } // end if
                            _loc11 = com.clubpenguin.engine.tweener.Tweener._specialPropertyList[_loc2].getValue(_loc5, com.clubpenguin.engine.tweener.Tweener._specialPropertyList[_loc2].parameters, _loc1.properties[_loc2].extra);
                        }
                        else
                        {
                            _loc11 = _loc5[_loc2];
                        } // end else if
                        _loc1.properties[_loc2].valueStart = isNaN(_loc11) ? (_loc1.properties[_loc2].valueComplete) : (_loc11);
                    } // end of for...in
                    _loc14 = true;
                    _loc1.hasStarted = true;
                } // end if
                if (_loc14)
                {
                    for (var _loc2 in _loc1.properties)
                    {
                        _loc4 = _loc1.properties[_loc2];
                        if (_loc13)
                        {
                            _loc3 = _loc4.valueComplete;
                        }
                        else if (_loc4.hasModifier)
                        {
                            _loc6 = _loc8 - _loc1.timeStart;
                            _loc7 = _loc1.timeComplete - _loc1.timeStart;
                            _loc3 = _loc1.transition(_loc6, 0, 1, _loc7, _loc1.transitionParams);
                            _loc3 = _loc4.modifierFunction(_loc4.valueStart, _loc4.valueComplete, _loc3, _loc4.modifierParameters);
                        }
                        else
                        {
                            _loc6 = _loc8 - _loc1.timeStart;
                            _loc10 = _loc4.valueStart;
                            _loc9 = _loc4.valueComplete - _loc4.valueStart;
                            _loc7 = _loc1.timeComplete - _loc1.timeStart;
                            _loc3 = _loc1.transition(_loc6, _loc10, _loc9, _loc7, _loc1.transitionParams);
                        } // end else if
                        if (_loc1.rounded)
                        {
                            _loc3 = Math.round(_loc3);
                        } // end if
                        if (_loc4.isSpecialProperty)
                        {
                            com.clubpenguin.engine.tweener.Tweener._specialPropertyList[_loc2].setValue(_loc5, _loc3, com.clubpenguin.engine.tweener.Tweener._specialPropertyList[_loc2].parameters, _loc1.properties[_loc2].extra);
                            continue;
                        } // end if
                        _loc5[_loc2] = _loc3;
                    } // end of for...in
                    _loc1.updatesSkipped = 0;
                    if (_loc1.onUpdate != undefined)
                    {
                        _loc12 = _loc1.onUpdateScope != undefined ? (_loc1.onUpdateScope) : (_loc5);
                        try
                        {
                            _loc1.onUpdate.apply(_loc12, _loc1.onUpdateParams);
                        } // End of try
                        catch ()
                        {
                        } // End of catch
                    } // end if
                }
                else
                {
                    ++_loc1.updatesSkipped;
                } // end else if
            } // end else if
            if (_loc13 && _loc1.onComplete != undefined)
            {
                _loc12 = _loc1.onCompleteScope != undefined ? (_loc1.onCompleteScope) : (_loc5);
                try
                {
                    _loc1.onComplete.apply(_loc12, _loc1.onCompleteParams);
                } // End of try
                catch ()
                {
                } // End of catch
            } // end if
            return (!_loc13);
        } // end if
        return (true);
    } // End of the function
    static function init()
    {
        _inited = true;
        _transitionList = new Object();
        com.clubpenguin.engine.tweener.Equations.init();
        _specialPropertyList = new Object();
        _specialPropertyModifierList = new Object();
        _specialPropertySplitterList = new Object();
    } // End of the function
    static function registerTransition(p_name, p_function)
    {
        if (!com.clubpenguin.engine.tweener.Tweener._inited)
        {
            com.clubpenguin.engine.tweener.Tweener.init();
        } // end if
        com.clubpenguin.engine.tweener.Tweener._transitionList[p_name] = p_function;
    } // End of the function
    static function registerSpecialProperty(p_name, p_getFunction, p_setFunction, p_parameters, p_preProcessFunction)
    {
        if (!com.clubpenguin.engine.tweener.Tweener._inited)
        {
            com.clubpenguin.engine.tweener.Tweener.init();
        } // end if
        var _loc1 = new com.clubpenguin.engine.tweener.SpecialProperty(p_getFunction, p_setFunction, p_parameters, p_preProcessFunction);
        com.clubpenguin.engine.tweener.Tweener._specialPropertyList[p_name] = _loc1;
    } // End of the function
    static function registerSpecialPropertyModifier(p_name, p_modifyFunction, p_getFunction)
    {
        if (!com.clubpenguin.engine.tweener.Tweener._inited)
        {
            com.clubpenguin.engine.tweener.Tweener.init();
        } // end if
        var _loc1 = new com.clubpenguin.engine.tweener.SpecialPropertyModifier(p_modifyFunction, p_getFunction);
        com.clubpenguin.engine.tweener.Tweener._specialPropertyModifierList[p_name] = _loc1;
    } // End of the function
    static function registerSpecialPropertySplitter(p_name, p_splitFunction, p_parameters)
    {
        if (!com.clubpenguin.engine.tweener.Tweener._inited)
        {
            com.clubpenguin.engine.tweener.Tweener.init();
        } // end if
        var _loc1 = new com.clubpenguin.engine.tweener.SpecialPropertySplitter(p_splitFunction, p_parameters);
        com.clubpenguin.engine.tweener.Tweener._specialPropertySplitterList[p_name] = _loc1;
    } // End of the function
    static function startEngine()
    {
        _engineExists = true;
        _tweenList = new Array();
        var _loc3 = Math.floor(Math.random() * 999999);
        var _loc2 = _root.createEmptyMovieClip(com.clubpenguin.engine.tweener.Tweener.getControllerName(), 31338 + _loc3);
        _loc2.onEnterFrame = function ()
        {
            com.clubpenguin.engine.tweener.Tweener.onEnterFrame();
        };
        _currentTimeFrame = 0;
        com.clubpenguin.engine.tweener.Tweener.updateTime();
    } // End of the function
    static function stopEngine()
    {
        _engineExists = false;
        _tweenList = null;
        _currentTime = 0;
        _currentTimeFrame = 0;
        delete _root[com.clubpenguin.engine.tweener.Tweener.getControllerName()].onEnterFrame;
        _root[com.clubpenguin.engine.tweener.Tweener.getControllerName()].removeMovieClip();
    } // End of the function
    static function updateTime()
    {
        _currentTime = getTimer();
    } // End of the function
    static function updateFrame()
    {
        _currentTimeFrame = ++com.clubpenguin.engine.tweener.Tweener._currentTimeFrame;
    } // End of the function
    static function onEnterFrame()
    {
        com.clubpenguin.engine.tweener.Tweener.updateTime();
        com.clubpenguin.engine.tweener.Tweener.updateFrame();
        var _loc1 = false;
        _loc1 = com.clubpenguin.engine.tweener.Tweener.updateTweens();
        if (!_loc1)
        {
            com.clubpenguin.engine.tweener.Tweener.stopEngine();
        } // end if
    } // End of the function
    static function setTimeScale(p_time)
    {
        var _loc1;
        var _loc2;
        if (isNaN(p_time))
        {
            p_time = 1;
        } // end if
        if (p_time < 0.000010)
        {
            p_time = 0.000010;
        } // end if
        if (p_time != com.clubpenguin.engine.tweener.Tweener._timeScale)
        {
            for (var _loc1 = 0; _loc1 < com.clubpenguin.engine.tweener.Tweener._tweenList.length; ++_loc1)
            {
                _loc2 = com.clubpenguin.engine.tweener.Tweener.getCurrentTweeningTime(com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1]);
                com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].timeStart = _loc2 - (_loc2 - com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].timeStart) * com.clubpenguin.engine.tweener.Tweener._timeScale / p_time;
                com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].timeComplete = _loc2 - (_loc2 - com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].timeComplete) * com.clubpenguin.engine.tweener.Tweener._timeScale / p_time;
                if (com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].timePaused != undefined)
                {
                    com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].timePaused = _loc2 - (_loc2 - com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].timePaused) * com.clubpenguin.engine.tweener.Tweener._timeScale / p_time;
                } // end if
            } // end of for
            _timeScale = p_time;
        } // end if
    } // End of the function
    static function isTweening(p_scope)
    {
        var _loc1;
        for (var _loc1 = 0; _loc1 < com.clubpenguin.engine.tweener.Tweener._tweenList.length; ++_loc1)
        {
            if (com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].scope == p_scope)
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static function getTweens(p_scope)
    {
        var _loc1;
        var _loc2;
        var _loc3 = new Array();
        for (var _loc1 = 0; _loc1 < com.clubpenguin.engine.tweener.Tweener._tweenList.length; ++_loc1)
        {
            if (com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].scope == p_scope)
            {
                for (var _loc2 in com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].properties)
                {
                    _loc3.push(_loc2);
                } // end of for...in
            } // end if
        } // end of for
        return (_loc3);
    } // End of the function
    static function getTweenCount(p_scope)
    {
        var _loc1;
        var _loc2 = 0;
        for (var _loc1 = 0; _loc1 < com.clubpenguin.engine.tweener.Tweener._tweenList.length; ++_loc1)
        {
            if (com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].scope == p_scope)
            {
                _loc2 = _loc2 + com.clubpenguin.engine.tweener.AuxFunctions.getObjectLength(com.clubpenguin.engine.tweener.Tweener._tweenList[_loc1].properties);
            } // end if
        } // end of for
        return (_loc2);
    } // End of the function
    null[] = !(pTweening.onError != undefined && typeof(pTweening.onError == "function")) ? (// End of catc, if (pTweening.onError != undefined) goto 1966, com.clubpenguin.engine.tweener.Tweener.printError(pTweening.scope.toString() + " raised an error while executing the \'" + pCallBackName.toString() + "\'handler. \n" + pError), function (pTweening, pError, pCallBackName)
    {
        if (pTweening.onError == undefined)
        {
        } // end if
    }) : (var _loc3 = pTweening.onErrorScope != undefined ? (pTweening.onErrorScope) : (pTweening.scope), tr, pTweening.onError.apply(_loc3, [pTweening.scope, pError]), // Jump to 1954, // End of tr, catch (, "handleError");
    static function getCurrentTweeningTime(p_tweening)
    {
        return (p_tweening.useFrames ? (com.clubpenguin.engine.tweener.Tweener._currentTimeFrame) : (com.clubpenguin.engine.tweener.Tweener._currentTime));
    } // End of the function
    static function getVersion()
    {
        return ("AS2 1.31.74");
    } // End of the function
    static function getControllerName()
    {
        return ("__tweener_controller__" + com.clubpenguin.engine.tweener.Tweener.getVersion());
    } // End of the function
    static function printError(p_message)
    {
    } // End of the function
    static var _engineExists = false;
    static var _inited = false;
    static var _timeScale = 1;
} // End of Class
