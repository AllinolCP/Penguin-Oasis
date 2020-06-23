class com.clubpenguin.lib.data.SaveGameData
{
    var __gameId, __localSharedObj;
    function SaveGameData(_gameId)
    {
        if (_gameId == null || _gameId == "")
        {
            return;
        } // end if
        __gameId = _gameId;
        __localSharedObj = SharedObject.getLocal(__gameId);
    } // End of the function
    function send(_penguinId, _data)
    {
        __localSharedObj.data[_penguinId] = _data;
        return (this.write());
    } // End of the function
    function request(_penguinId)
    {
        var _loc2;
        _loc2 = __localSharedObj.data[_penguinId];
        if (_loc2 != null)
        {
            return (_loc2);
        } // end if
        return ("");
    } // End of the function
    function clear(_penguinId)
    {
        __localSharedObj.data[_penguinId].clear();
        return (this.write());
    } // End of the function
    function write(Void)
    {
        var _loc2 = false;
        _loc2 = Boolean(__localSharedObj.flush());
        if (!_loc2)
        {
        } // end if
        return (_loc2);
    } // End of the function
    static var CLASS_NAME = "SaveGameData";
} // End of Class
