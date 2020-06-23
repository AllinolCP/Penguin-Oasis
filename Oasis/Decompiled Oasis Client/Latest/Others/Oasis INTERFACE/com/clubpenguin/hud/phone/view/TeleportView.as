class com.clubpenguin.hud.phone.view.TeleportView extends com.clubpenguin.hud.phone.view.AppView
{
    var cancelTeleport, teleportingTo, title, localizedAssets, roomList, teleportSwirl, destination, cancelTeleportButton, _visible;
    function TeleportView()
    {
        super();
        localizedAssets = [title, teleportingTo, cancelTeleport];
    } // End of the function
    function reset()
    {
        roomList._visible = true;
        teleportSwirl._visible = false;
        teleportingTo._visible = false;
        destination._visible = false;
        cancelTeleport._visible = false;
        cancelTeleportButton._visible = false;
    } // End of the function
    function showTeleportCountDown()
    {
        roomList._visible = false;
        teleportSwirl._visible = true;
        teleportingTo._visible = true;
        destination._visible = true;
        cancelTeleport._visible = true;
        cancelTeleportButton._visible = true;
    } // End of the function
    function open()
    {
        this.reset();
        teleportSwirl.swirlAnimation.gotoAndPlay(2);
        _visible = true;
    } // End of the function
    function close()
    {
        teleportSwirl.swirlAnimation.gotoAndStop(1);
        _visible = false;
    } // End of the function
} // End of Class
