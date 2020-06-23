class com.clubpenguin.games.cardjitsu.water.layers.EffectLayer extends MovieClip implements com.clubpenguin.lib.IDisposable
{
    var __effectPool, getNextHighestDepth, attachMovie;
    function EffectLayer()
    {
        super();
        __effectPool = new Array();
        for (var _loc3 = 0; _loc3 < com.clubpenguin.games.cardjitsu.water.layers.EffectLayer.NUMBER_START_EFFECTS; ++_loc3)
        {
            __effectPool.push(this.attachMovie(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_EFFECT, com.clubpenguin.games.cardjitsu.water.layers.EffectLayer.$_NAME + __uid++, this.getNextHighestDepth()));
        } // end of for
    } // End of the function
    function playEffect(_mod, _cell)
    {
        var _loc3 = this.getEffect();
        var _loc2 = new flash.geom.Point();
        _cell.__get__playerRef().localToGlobal(_loc2);
        _loc3._x = _loc2.x;
        _loc3._y = _loc2.y;
        _loc3.change(_mod);
    } // End of the function
    function getEffect()
    {
        if (__effectPool.length < 2)
        {
            __effectPool.push(this.attachMovie(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_EFFECT, com.clubpenguin.games.cardjitsu.water.layers.EffectLayer.$_NAME + __uid++, this.getNextHighestDepth()));
        } // end if
        return ((com.clubpenguin.games.cardjitsu.water.cell.CellEffect)(__effectPool.shift()));
    } // End of the function
    function returnEffect(_effect)
    {
        __effectPool.push(_effect);
    } // End of the function
    function dispose()
    {
        var _loc3;
        for (var _loc2 = 0; _loc2 < __uid; ++_loc2)
        {
            _loc3 = this[com.clubpenguin.games.cardjitsu.water.layers.EffectLayer.$_NAME + _loc2];
            _loc3.dispose();
        } // end of for
        _loc3 = null;
        __effectPool = null;
    } // End of the function
    var __uid = 0;
    static var $_NAME = "effect_";
    static var NUMBER_START_EFFECTS = 18;
} // End of Class
