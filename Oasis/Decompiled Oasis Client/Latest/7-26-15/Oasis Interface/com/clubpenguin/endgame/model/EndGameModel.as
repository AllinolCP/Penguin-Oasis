class com.clubpenguin.endgame.model.EndGameModel
{
    var _shell, _params, _isJustCompleted, _gameName, __get__endGameParams, __get__gameName, __get__isJustCompleted, __get__shell;
    function EndGameModel(shell, endGameParams)
    {
        _shell = shell;
        _params = endGameParams;
        _isJustCompleted = _params.newStamps.length >= 1 && _params.numCompletedStamps == _params.numTotalStamps;
        var _loc2 = _params.isTable ? (_shell.getGameCrumbsByName(_params.activeTable.name)) : (_shell.getGameCrumbsById(_params.gameRoomId));
        _gameName = _loc2.name;
    } // End of the function
    function get shell()
    {
        return (_shell);
    } // End of the function
    function get endGameParams()
    {
        return (_params);
    } // End of the function
    function get gameName()
    {
        return (_gameName);
    } // End of the function
    function get isJustCompleted()
    {
        return (_isJustCompleted);
    } // End of the function
} // End of Class
