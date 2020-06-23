class com.clubpenguin.util.Heartbeat
{
    var _shell, _airtower, _timeout, _heart_interval;
    function Heartbeat(shell, airtower)
    {
        _shell = shell;
        _airtower = airtower;
        _timeout = new com.clubpenguin.util.Timeout(com.clubpenguin.util.Heartbeat.TIMEOUT_FREQUENCY, handleTimeout, [], this);
        _shell.addListener(_shell.WORLD_CONNECT_SUCCESS, startHeartbeat, this);
        _airtower.addListener(_airtower.HEARTBEAT, handleSendHeartbeat, this);
    } // End of the function
    function startHeartbeat()
    {
        _heart_interval = setInterval(com.clubpenguin.util.Delegate.create(this, sendHeartbeat), com.clubpenguin.util.Time.ONE_MINUTE_IN_MILLISECONDS);
    } // End of the function
    function sendHeartbeat()
    {
        _airtower.send(_airtower.PLAY_EXT, _airtower.PLAYER_HANDLER + "#" + _airtower.HEARTBEAT, [], "str", _shell.getCurrentServerRoomId());
        _timeout.start();
    } // End of the function
    function handleSendHeartbeat()
    {
        _timeout.stop();
    } // End of the function
    function handleTimeout()
    {
        _shell.$e("[shell] handleTimeout() -> Client has timed out! Heartbeat request was not responded to fast enough.", {error_code: _shell.CONNECTION_LOST});
        _airtower.send(_airtower.PLAY_EXT, _airtower.PLAYER_HANDLER + "#" + _airtower.TIMEOUT, [], "str", _shell.getCurrentServerRoomId());
        clearInterval(_heart_interval);
        _timeout.stop();
    } // End of the function
    static var TIMEOUT_FREQUENCY = 15;
} // End of Class
