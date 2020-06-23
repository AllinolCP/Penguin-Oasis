class com.clubpenguin.ui.views.AbstractView extends MovieClip implements com.clubpenguin.ui.views.IView
{
    var _shell, viewManager, _visible;
    function AbstractView()
    {
        super();
        com.clubpenguin.util.EventDispatcher.initialize(this);
    } // End of the function
    function addEventListener(type, func, scope)
    {
        return (false);
    } // End of the function
    function removeEventListener(type, func, scope)
    {
        return (false);
    } // End of the function
    function updateListeners(type, event)
    {
        return (false);
    } // End of the function
    function dispatchEvent(event)
    {
        return (false);
    } // End of the function
    function setLanguageAbbr(abbr)
    {
    } // End of the function
    function setShell(target)
    {
        _shell = target;
    } // End of the function
    function setViewManager(manager)
    {
        viewManager = manager;
    } // End of the function
    function getViewManager()
    {
        return (viewManager);
    } // End of the function
    function hide()
    {
        _visible = false;
    } // End of the function
    function show()
    {
        _visible = true;
    } // End of the function
} // End of Class
