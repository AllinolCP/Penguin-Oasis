class com.clubpenguin.games.cardjitsu.water.motion.WigglePop extends com.clubpenguin.games.cardjitsu.water.motion.Motion implements com.clubpenguin.lib.IDisposable, com.clubpenguin.game.engine.IEngineUpdateable
{
    var __subject, __timeBezier, __durationWiggle, __durationPop, __origin, __destination, __tracking, __trackContext, __motionQueue, __activeMotion, __uid, __get__uniqueName;
    function WigglePop(_subject, _durationWiggle, _durationPop, _origin, _destination, _trackClip, _trackContext)
    {
        super();
        __subject = _subject;
        __timeBezier = 0;
        __durationWiggle = _durationWiggle;
        __durationPop = _durationPop;
        __origin = _origin.clone();
        __destination = _destination.clone();
        __tracking = _trackClip;
        __trackContext = _trackContext;
        __motionQueue = new Array();
        this.createWiggle();
        this.createStasis();
        this.createPop();
    } // End of the function
    function createWiggle()
    {
        __motionQueue.push(new com.clubpenguin.games.cardjitsu.water.motion.Wiggle(__subject, __durationWiggle, 2));
    } // End of the function
    function createStasis()
    {
        __motionQueue.push(new com.clubpenguin.games.cardjitsu.water.motion.Stasis(100));
    } // End of the function
    function createPop()
    {
        __motionQueue.push(new com.clubpenguin.games.cardjitsu.water.motion.PopTo(__subject, __durationPop, __origin, __destination));
    } // End of the function
    function onMotionProgress(_eventObj)
    {
    } // End of the function
    function onMotionComplete(_eventObj)
    {
        if (__activeMotion != null)
        {
            com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.PROGRESS, onMotionProgress, this, __activeMotion);
            com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.COMPLETE, onMotionComplete, this, __activeMotion);
            __activeMotion.dispose();
            __activeMotion = null;
        } // end if
        this.startNextMotion();
    } // End of the function
    function startNextMotion()
    {
        if (__motionQueue.length > 0)
        {
            __activeMotion = (com.clubpenguin.games.cardjitsu.water.motion.Motion)(__motionQueue.shift());
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.PROGRESS, onMotionProgress, this, __activeMotion);
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.COMPLETE, onMotionComplete, this, __activeMotion);
            __activeMotion.startMotion();
        }
        else
        {
            __motionQueue = null;
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.MotionEvent(this, com.clubpenguin.games.cardjitsu.water.event.MotionEvent.COMPLETE, __timeBezier));
        } // end else if
    } // End of the function
    function startMotion()
    {
        this.startNextMotion();
    } // End of the function
    function update(_tick, _currUpdate)
    {
    } // End of the function
    function get uniqueName()
    {
        return ("[WigglePop<" + __uid + ">]");
    } // End of the function
    function dispose()
    {
        com.clubpenguin.ProjectGlobals.__get__host().unregister(this);
        __subject = null;
        __origin = null;
        __destination = null;
    } // End of the function
    function toString()
    {
        //return (this.uniqueName());
    } // End of the function
} // End of Class
