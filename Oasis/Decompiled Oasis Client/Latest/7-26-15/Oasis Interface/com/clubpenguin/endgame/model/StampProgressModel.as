class com.clubpenguin.endgame.model.StampProgressModel
{
    var _shell, _numStampsEarned, _numTotalStamps, _completedPercent, __get__completedPercent, __get__shell;
    function StampProgressModel(shell, numStampsEarned, numTotalStamps)
    {
        _shell = shell;
        _numStampsEarned = numStampsEarned;
        _numTotalStamps = numTotalStamps;
        _completedPercent = Math.floor(100 * (_numStampsEarned / _numTotalStamps));
    } // End of the function
    function get shell()
    {
        return (_shell);
    } // End of the function
    function get completedPercent()
    {
        return (_completedPercent);
    } // End of the function
} // End of Class
