class com.clubpenguin.games.cardjitsu.water.cell.CellDataGong extends com.clubpenguin.games.cardjitsu.water.cell.CellData
{
    var __uid, __playerRef, __displayRef, __get__renderer, __cellPosition, __get__location, __get__position, __set__renderer;
    function CellDataGong()
    {
        super();
    } // End of the function
    function getUniqueName()
    {
        return ("[CellDataGong<" + __uid + ">]");
    } // End of the function
    function init(Void)
    {
        __playerRef = null;
    } // End of the function
    function set renderer(_dref)
    {
        __displayRef = _dref;
        __displayRef.__set__selected(false);
        if (!__displayRef.rendered)
        {
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.event.ClipEvent.RENDERED, onRender, this, __displayRef);
        }
        else
        {
            this.onRender();
        } // end else if
        //return (this.renderer());
        null;
    } // End of the function
    function onRender(_eventObj)
    {
        if (_eventObj.__get__target() != undefined && _eventObj.__get__target().getUniqueName() == __displayRef.getUniqueName())
        {
            com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.lib.event.ClipEvent.RENDERED, onRender, this);
        } // end if
    } // End of the function
    function getPlayer(Void)
    {
        return (__playerRef);
    } // End of the function
    function addPlayer(_playerRef)
    {
        if (!_playerRef)
        {
            return;
        } // end if
        __playerRef = _playerRef;
        __displayRef.player.show(__playerRef);
    } // End of the function
    function getDisplay()
    {
        return (__displayRef);
    } // End of the function
    function setDisplay(_displayRef)
    {
        if (_displayRef == undefined)
        {
            return;
        } // end if
        __displayRef = __displayRef;
    } // End of the function
    function get location()
    {
        //return (__displayRef.location().clone());
    } // End of the function
    function get position()
    {
        return (__cellPosition.clone());
    } // End of the function
    function dispose()
    {
    } // End of the function
    function toString(Void)
    {
        return ("[CellDataGong] " + __displayRef._name);
    } // End of the function
    function showPlayer()
    {
        __displayRef.showPlayer(__playerRef);
    } // End of the function
    function isOccupied()
    {
        return (__playerRef != null);
    } // End of the function
} // End of Class
