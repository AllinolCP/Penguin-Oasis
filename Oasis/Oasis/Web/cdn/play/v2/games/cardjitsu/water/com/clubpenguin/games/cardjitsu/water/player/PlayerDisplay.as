class com.clubpenguin.games.cardjitsu.water.player.PlayerDisplay extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, _visible, onEnterFrame, __init, _x, _y, character, __playerData, _alpha, __get__data;
    function PlayerDisplay(Void)
    {
        super();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.player.PlayerDisplay.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.player.PlayerDisplay.$_instanceCount;
        _visible = false;
        onEnterFrame = checkInit;
    } // End of the function
    function getUniqueName()
    {
        return ("[PlayerDisplay<" + __uid + ">]");
    } // End of the function
    function checkInit()
    {
        if (__init)
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.ClipEvent(this, com.clubpenguin.lib.event.ClipEvent.RENDERED));
            __init = false;
            delete this.onEnterFrame;
        } // end if
    } // End of the function
    function setCoordinate(_pt)
    {
        _x = _pt.x;
        _y = _pt.y;
    } // End of the function
    function startAnimation(_actionGroup, _action)
    {
        character.startAnimation(_actionGroup, _action);
    } // End of the function
    function get data()
    {
        return (__playerData);
    } // End of the function
    function summonElement(_element)
    {
        character.summonElement(_element);
    } // End of the function
    function throwElement(_targetCoord)
    {
        character.throwElement();
    } // End of the function
    function celebrateVictory()
    {
        character.celebrateVictory();
    } // End of the function
    function summonAndThrowElement(_element)
    {
        character.summonAndThrowElement(_element);
    } // End of the function
    function drop()
    {
        character.drop();
    } // End of the function
    function land()
    {
        character.land();
    } // End of the function
    function show(_data)
    {
        __playerData = _data;
        character.config(_data);
        _visible = true;
        if (_alpha != 100)
        {
            _alpha = 100;
        } // end if
    } // End of the function
    function hide()
    {
        character.stopAll();
        _visible = false;
        __playerData = null;
    } // End of the function
    function jump()
    {
        character.jump();
    } // End of the function
    function toString()
    {
        return (this.getUniqueName());
    } // End of the function
    function unsummon()
    {
        character.idle();
    } // End of the function
    function getCoordinate()
    {
        return (new flash.geom.Point(_x, _y));
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
