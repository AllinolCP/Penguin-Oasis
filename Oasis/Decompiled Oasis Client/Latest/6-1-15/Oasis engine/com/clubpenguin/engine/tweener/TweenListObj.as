class com.clubpenguin.engine.tweener.TweenListObj
{
    var scope, timeStart, timeComplete, useFrames, transition, transitionParams, properties, isPaused, timePaused, isCaller, updatesSkipped, timesCalled, skipUpdates, hasStarted, onStart, onUpdate, onComplete, onOverwrite, onError, onStartParams, onUpdateParams, onCompleteParams, onOverwriteParams, onStartScope, onUpdateScope, onCompleteScope, onOverwriteScope, onErrorScope, rounded, count, waitFrames;
    function TweenListObj(p_scope, p_timeStart, p_timeComplete, p_useFrames, p_transition, p_transitionParams)
    {
        scope = p_scope;
        timeStart = p_timeStart;
        timeComplete = p_timeComplete;
        useFrames = p_useFrames;
        transition = p_transition;
        transitionParams = p_transitionParams;
        properties = new Object();
        isPaused = false;
        timePaused = undefined;
        isCaller = false;
        updatesSkipped = 0;
        timesCalled = 0;
        skipUpdates = 0;
        hasStarted = false;
    } // End of the function
    function clone(omitEvents)
    {
        var _loc2 = new com.clubpenguin.engine.tweener.TweenListObj(scope, timeStart, timeComplete, useFrames, transition, transitionParams);
        _loc2.properties = new Object();
        for (var _loc3 in properties)
        {
            _loc2.properties[_loc3] = properties[_loc3].clone();
        } // end of for...in
        _loc2.skipUpdates = skipUpdates;
        _loc2.updatesSkipped = updatesSkipped;
        if (!omitEvents)
        {
            _loc2.onStart = onStart;
            _loc2.onUpdate = onUpdate;
            _loc2.onComplete = onComplete;
            _loc2.onOverwrite = onOverwrite;
            _loc2.onError = onError;
            _loc2.onStartParams = onStartParams;
            _loc2.onUpdateParams = onUpdateParams;
            _loc2.onCompleteParams = onCompleteParams;
            _loc2.onOverwriteParams = onOverwriteParams;
            _loc2.onStartScope = onStartScope;
            _loc2.onUpdateScope = onUpdateScope;
            _loc2.onCompleteScope = onCompleteScope;
            _loc2.onOverwriteScope = onOverwriteScope;
            _loc2.onErrorScope = onErrorScope;
        } // end if
        _loc2.rounded = rounded;
        _loc2.isPaused = isPaused;
        _loc2.timePaused = timePaused;
        _loc2.isCaller = isCaller;
        _loc2.count = count;
        _loc2.timesCalled = timesCalled;
        _loc2.waitFrames = waitFrames;
        _loc2.hasStarted = hasStarted;
        return (_loc2);
    } // End of the function
    function toString()
    {
        var _loc2 = "\n[TweenListObj ";
        _loc2 = _loc2 + ("scope:" + String(scope));
        _loc2 = _loc2 + ", properties:";
        var _loc3 = true;
        for (var _loc4 in properties)
        {
            if (!_loc3)
            {
                _loc2 = _loc2 + ",";
            } // end if
            _loc2 = _loc2 + ("[name:" + properties[_loc4].name);
            _loc2 = _loc2 + (",valueStart:" + properties[_loc4].valueStart);
            _loc2 = _loc2 + (",valueComplete:" + properties[_loc4].valueComplete);
            _loc2 = _loc2 + "]";
            _loc3 = false;
        } // end of for...in
        _loc2 = _loc2 + (", timeStart:" + String(timeStart));
        _loc2 = _loc2 + (", timeComplete:" + String(timeComplete));
        _loc2 = _loc2 + (", useFrames:" + String(useFrames));
        _loc2 = _loc2 + (", transition:" + String(transition));
        _loc2 = _loc2 + (", transitionParams:" + String(transitionParams));
        if (skipUpdates)
        {
            _loc2 = _loc2 + (", skipUpdates:" + String(skipUpdates));
        } // end if
        if (updatesSkipped)
        {
            _loc2 = _loc2 + (", updatesSkipped:" + String(updatesSkipped));
        } // end if
        if (onStart)
        {
            _loc2 = _loc2 + (", onStart:" + String(onStart));
        } // end if
        if (onUpdate)
        {
            _loc2 = _loc2 + (", onUpdate:" + String(onUpdate));
        } // end if
        if (onComplete)
        {
            _loc2 = _loc2 + (", onComplete:" + String(onComplete));
        } // end if
        if (onOverwrite)
        {
            _loc2 = _loc2 + (", onOverwrite:" + String(onOverwrite));
        } // end if
        if (onError)
        {
            _loc2 = _loc2 + (", onError:" + String(onError));
        } // end if
        if (onStartParams)
        {
            _loc2 = _loc2 + (", onStartParams:" + String(onStartParams));
        } // end if
        if (onUpdateParams)
        {
            _loc2 = _loc2 + (", onUpdateParams:" + String(onUpdateParams));
        } // end if
        if (onCompleteParams)
        {
            _loc2 = _loc2 + (", onCompleteParams:" + String(onCompleteParams));
        } // end if
        if (onOverwriteParams)
        {
            _loc2 = _loc2 + (", onOverwriteParams:" + String(onOverwriteParams));
        } // end if
        if (onStartScope)
        {
            _loc2 = _loc2 + (", onStartScope:" + String(onStartScope));
        } // end if
        if (onUpdateScope)
        {
            _loc2 = _loc2 + (", onUpdateScope:" + String(onUpdateScope));
        } // end if
        if (onCompleteScope)
        {
            _loc2 = _loc2 + (", onCompleteScope:" + String(onCompleteScope));
        } // end if
        if (onOverwriteScope)
        {
            _loc2 = _loc2 + (", onOverwriteScope:" + String(onOverwriteScope));
        } // end if
        if (onErrorScope)
        {
            _loc2 = _loc2 + (", onErrorScope:" + String(onErrorScope));
        } // end if
        if (rounded)
        {
            _loc2 = _loc2 + (", rounded:" + String(rounded));
        } // end if
        if (isPaused)
        {
            _loc2 = _loc2 + (", isPaused:" + String(isPaused));
        } // end if
        if (timePaused)
        {
            _loc2 = _loc2 + (", timePaused:" + String(timePaused));
        } // end if
        if (isCaller)
        {
            _loc2 = _loc2 + (", isCaller:" + String(isCaller));
        } // end if
        if (count)
        {
            _loc2 = _loc2 + (", count:" + String(count));
        } // end if
        if (timesCalled)
        {
            _loc2 = _loc2 + (", timesCalled:" + String(timesCalled));
        } // end if
        if (waitFrames)
        {
            _loc2 = _loc2 + (", waitFrames:" + String(waitFrames));
        } // end if
        if (hasStarted)
        {
            _loc2 = _loc2 + (", hasStarted:" + String(hasStarted));
        } // end if
        _loc2 = _loc2 + "]\n";
        return (_loc2);
    } // End of the function
    static function makePropertiesChain(p_obj)
    {
        var _loc5 = p_obj.base;
        if (_loc5)
        {
            var _loc6 = {};
            var _loc2;
            if (_loc5 instanceof Array)
            {
                _loc2 = [];
                for (var _loc3 = 0; _loc3 < _loc5.length; ++_loc3)
                {
                    _loc2.push(_loc5[_loc3]);
                } // end of for
            }
            else
            {
                _loc2 = [_loc5];
            } // end else if
            _loc2.push(p_obj);
            var _loc4;
            var _loc7 = _loc2.length;
            for (var _loc1 = 0; _loc1 < _loc7; ++_loc1)
            {
                if (_loc2[_loc1].base)
                {
                    _loc4 = com.clubpenguin.engine.tweener.AuxFunctions.concatObjects(com.clubpenguin.engine.tweener.TweenListObj.makePropertiesChain(_loc2[_loc1].base), _loc2[_loc1]);
                }
                else
                {
                    _loc4 = _loc2[_loc1];
                } // end else if
                _loc6 = com.clubpenguin.engine.tweener.AuxFunctions.concatObjects(_loc6, _loc4);
            } // end of for
            if (_loc6.base)
            {
                delete _loc6.base;
            } // end if
            return (_loc6);
        }
        else
        {
            return (p_obj);
        } // end else if
    } // End of the function
} // End of Class
