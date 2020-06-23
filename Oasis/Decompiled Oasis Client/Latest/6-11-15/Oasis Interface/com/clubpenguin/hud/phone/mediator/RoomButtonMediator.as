class com.clubpenguin.hud.phone.mediator.RoomButtonMediator
{
    var view, teleportRoom, _pressed, __get__pressed;
    function RoomButtonMediator(view, teleportRoom)
    {
        this.view = view;
        this.teleportRoom = teleportRoom;
        _pressed = new org.osflash.signals.Signal(com.clubpenguin.hud.phone.model.TeleportRoom);
        view.onPress = com.clubpenguin.util.Delegate.create(this, onMouseUp);
        view.name.text = teleportRoom.localizedName;
    } // End of the function
    function get pressed()
    {
        return (_pressed);
    } // End of the function
    function onMouseUp()
    {
        _pressed.dispatch(teleportRoom);
    } // End of the function
} // End of Class
