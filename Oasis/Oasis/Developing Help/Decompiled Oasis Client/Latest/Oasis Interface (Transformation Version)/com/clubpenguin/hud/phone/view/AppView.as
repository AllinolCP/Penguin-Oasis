class com.clubpenguin.hud.phone.view.AppView extends MovieClip
{
    var closed, closeButton, _visible;
    function AppView()
    {
        super();
        closed = new org.osflash.signals.Signal();
        closeButton.button.onRelease = com.clubpenguin.util.Delegate.create(closed, closed.dispatch);
    } // End of the function
    function open()
    {
        _visible = true;
    } // End of the function
    function close()
    {
        _visible = false;
    } // End of the function
} // End of Class
