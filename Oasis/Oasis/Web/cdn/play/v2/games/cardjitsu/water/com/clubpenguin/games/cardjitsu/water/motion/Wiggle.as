class com.clubpenguin.games.cardjitsu.water.motion.Wiggle extends com.clubpenguin.games.cardjitsu.water.motion.Motion implements com.clubpenguin.lib.IDisposable, com.clubpenguin.game.engine.IEngineUpdateable
{
    var __subject, __motionProgress, __state, __duration, __shift, __destination, __tracking, __trackContext, __timeMotionStep, __uid, __get__uniqueName;
    function Wiggle(_subject, _duration, _shift, _trackClip, _trackContext)
    {
        super();
        __subject = _subject;
        __motionProgress = 0;
        __state = 1;
        __duration = _duration;
        __shift = _shift;
        __destination = _subject.getCoordinate();
        __tracking = _trackClip;
        __trackContext = _trackContext;
        __timeMotionStep = __duration / com.clubpenguin.games.cardjitsu.water.motion.Wiggle.$_updateInterval;
    } // End of the function
    function startMotion()
    {
        com.clubpenguin.ProjectGlobals.__get__host().register(this, com.clubpenguin.games.cardjitsu.water.motion.Wiggle.$_updateInterval);
    } // End of the function
    function update(_tick, _currUpdate)
    {
        this.updateMotion();
    } // End of the function
    function get uniqueName()
    {
        return ("[Wiggle<" + __uid + ">]");
    } // End of the function
    function updateMotion()
    {
        var _loc2;
        __motionProgress = __motionProgress + 1 / __timeMotionStep;
        if (__motionProgress >= 1)
        {
            __motionProgress = 1;
        } // end if
        if (__tracking != null)
        {
            __destination = new flash.geom.Point(__tracking._x, __tracking._y);
            __trackContext.localToGlobal(__destination);
        } // end if
        _loc2 = com.clubpenguin.games.cardjitsu.water.motion.Wiggle.wiggleOverTime(__destination, __shift, __state, __motionProgress);
        __state = __state * -1;
        __subject.setCoordinate(_loc2);
        if (__motionProgress == 1)
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.MotionEvent(this, com.clubpenguin.games.cardjitsu.water.event.MotionEvent.COMPLETE, __motionProgress));
        }
        else
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.MotionEvent(this, com.clubpenguin.games.cardjitsu.water.event.MotionEvent.PROGRESS, __motionProgress));
        } // end else if
    } // End of the function
    static function wiggleOverTime(pt0, _shift, _state, time)
    {
        var _loc1;
        if (time < 1)
        {
            _loc1 = pt0.add(new flash.geom.Point(_shift * _state, 0));
        }
        else
        {
            _loc1 = pt0.clone();
        } // end else if
        return (_loc1);
    } // End of the function
    function dispose()
    {
        com.clubpenguin.ProjectGlobals.__get__host().unregister(this);
        __subject = null;
        __destination = null;
    } // End of the function
    function toString()
    {
        //return (this.uniqueName());
    } // End of the function
    static var $_updateInterval = 50;
} // End of Class
