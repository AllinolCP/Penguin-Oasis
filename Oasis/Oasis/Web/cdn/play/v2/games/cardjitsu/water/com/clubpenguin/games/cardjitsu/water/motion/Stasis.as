class com.clubpenguin.games.cardjitsu.water.motion.Stasis extends com.clubpenguin.games.cardjitsu.water.motion.Motion implements com.clubpenguin.lib.IDisposable, com.clubpenguin.game.engine.IEngineUpdateable
{
    var __duration, __motionProgress, __timeMotionStep, __uid, __get__uniqueName;
    function Stasis(_duration)
    {
        super();
        __duration = _duration;
        __motionProgress = 0;
        __timeMotionStep = __duration / com.clubpenguin.games.cardjitsu.water.motion.Stasis.$_updateInterval;
    } // End of the function
    function startMotion()
    {
        com.clubpenguin.ProjectGlobals.__get__host().register(this, com.clubpenguin.games.cardjitsu.water.motion.Stasis.$_updateInterval);
    } // End of the function
    function update(_tick, _currUpdate)
    {
        this.updateMotion();
    } // End of the function
    function get uniqueName()
    {
        return ("[Stasis<" + __uid + ">]");
    } // End of the function
    function updateMotion()
    {
        __motionProgress = __motionProgress + 1 / __timeMotionStep;
        if (__motionProgress == 1)
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.MotionEvent(this, com.clubpenguin.games.cardjitsu.water.event.MotionEvent.COMPLETE, __motionProgress));
        }
        else
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.MotionEvent(this, com.clubpenguin.games.cardjitsu.water.event.MotionEvent.PROGRESS, __motionProgress));
        } // end else if
    } // End of the function
    function dispose()
    {
        com.clubpenguin.ProjectGlobals.__get__host().unregister(this);
    } // End of the function
    function toString()
    {
        //return (this.uniqueName());
    } // End of the function
    static var $_updateInterval = 50;
} // End of Class
