class com.clubpenguin.games.cardjitsu.water.cell.CellEffect extends MovieClip implements com.clubpenguin.lib.IDisposable
{
    var onEnterFrame, poof_small, poof_same, poof_big, removeMovieClip;
    function CellEffect()
    {
        super();
        onEnterFrame = setUp;
    } // End of the function
    function setUp()
    {
        delete this.onEnterFrame;
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.event.ClipEvent.COMPLETE, handleEffectDone, this, poof_small);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.event.ClipEvent.COMPLETE, handleEffectDone, this, poof_same);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.event.ClipEvent.COMPLETE, handleEffectDone, this, poof_big);
    } // End of the function
    function change(_mod)
    {
        switch (_mod)
        {
            case -1:
            {
                poof_small.trigger();
                break;
            } 
            case 0:
            {
                poof_same.trigger();
                break;
            } 
            case 1:
            {
                poof_big.trigger();
                break;
            } 
        } // End of switch
    } // End of the function
    function handleEffectDone(_eventObj)
    {
        var _loc2 = (com.clubpenguin.games.cardjitsu.water.layers.EffectLayer)(com.clubpenguin.games.cardjitsu.water.DisplayManager.getDisplayLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_EFFECT));
        _loc2.returnEffect(this);
    } // End of the function
    function dispose()
    {
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.lib.event.ClipEvent.COMPLETE, handleEffectDone, this, poof_small);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.lib.event.ClipEvent.COMPLETE, handleEffectDone, this, poof_same);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.lib.event.ClipEvent.COMPLETE, handleEffectDone, this, poof_big);
        this.removeMovieClip();
        this.removeMovieClip();
        this.removeMovieClip();
    } // End of the function
} // End of Class
