class com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterAction extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, stop, __init, onEnterFrame, _parent, __data;
    function PlayerCharacterAction()
    {
        super();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterAction.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterAction.$_instanceCount;
        this.stop();
        __init = true;
        onEnterFrame = checkInit;
    } // End of the function
    function checkInit()
    {
        if (__init)
        {
            this.stop();
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.ClipEvent(this, com.clubpenguin.lib.event.ClipEvent.RENDERED));
            __init = false;
            delete this.onEnterFrame;
        } // end if
    } // End of the function
    function getUniqueName()
    {
        return ("[PlayerCharacterAction<" + __uid + ">]");
    } // End of the function
    function actionComplete(_action)
    {
        if (_action != null)
        {
            this.stop();
            (com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterLayers)(_parent).dispatchComplete(_action);
        } // end if
    } // End of the function
    function actionContinue(_action)
    {
        if (_action != null)
        {
            (com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterLayers)(_parent).dispatchContinue(_action);
        } // end if
    } // End of the function
    function toString()
    {
        return (this.getUniqueName());
    } // End of the function
    function config(_param)
    {
        __data = _param;
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
