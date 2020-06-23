class com.clubpenguin.util.Timeout
{
    var __get__onStop, __set__onStop;
    function Timeout(time, func, params, scope)
    {
        _time = time * com.clubpenguin.util.Time.ONE_SECOND_IN_MILLISECONDS;
        _func = func;
        _params = params;
        _scope = scope;
    } // End of the function
    function start()
    {
        _id = _global.setTimeout(com.clubpenguin.util.Delegate.create(this, handler), _time, _params);
    } // End of the function
    function stop()
    {
        _global.clearTimeout(_id);
        this._onStop(this);
        this.cleanUp();
    } // End of the function
    function handler(params)
    {
        if (_scope == undefined)
        {
            this._func(params);
        }
        else
        {
            _func.call(_scope, params);
        } // end else if
        this.stop();
    } // End of the function
    function cleanUp()
    {
        _id = -1;
        _time = -1;
        _func = undefined;
        _params = undefined;
        _scope = undefined;
        _onStop = undefined;
    } // End of the function
    function set onStop(func)
    {
        _onStop = func;
        //return (this.onStop());
        null;
    } // End of the function
    function toString()
    {
        var _loc2 = "";
        _loc2 = _loc2 + "Timeout -> ";
        _loc2 = _loc2 + (" id: " + _id);
        _loc2 = _loc2 + (" time: " + _time);
        _loc2 = _loc2 + (" func: " + _func);
        _loc2 = _loc2 + (" params: " + _params);
        _loc2 = _loc2 + (" scope: " + _scope);
        _loc2 = _loc2 + (" onStop: " + _onStop);
        return (_loc2);
    } // End of the function
    var _id = -1;
    var _time = -1;
    var _func = undefined;
    var _params = undefined;
    var _scope = undefined;
    var _onStop = undefined;
} // End of Class
