class com.clubpenguin.endgame.model.StampListModel
{
    var _shell, _stampIds, _stamps, __get__shell, __get__stampIds;
    function StampListModel(shell, stampIds)
    {
        _shell = shell;
        _stampIds = stampIds;
        var _loc5 = _shell.getStampManager();
        var _loc6 = stampIds.length;
        _stamps = [];
        for (var _loc2 = 0; _loc2 < _loc6; ++_loc2)
        {
            var _loc3 = _loc5.getStampBookItem(stampIds[_loc2], com.clubpenguin.stamps.StampBookItemType.STAMP.__get__value());
            _stamps.push(_loc3);
        } // end of for
    } // End of the function
    function get shell()
    {
        return (_shell);
    } // End of the function
    function get stampIds()
    {
        return (_stampIds);
    } // End of the function
    function getStamps()
    {
        return (_stamps);
    } // End of the function
} // End of Class
