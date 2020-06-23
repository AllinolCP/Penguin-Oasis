class com.clubpenguin.games.cardjitsu.water.motion.PopTo extends com.clubpenguin.games.cardjitsu.water.motion.Motion implements com.clubpenguin.lib.IDisposable, com.clubpenguin.game.engine.IEngineUpdateable
{
    var __subject, __motionProgress, __duration, __origin, __destination, __tracking, __trackContext, __timeMotionStep, __uid, __get__uniqueName;
    function PopTo(_subject, _duration, _origin, _destination, _trackClip, _trackContext)
    {
        super();
        __subject = _subject;
        __motionProgress = 0;
        __duration = _duration;
        __origin = _origin.clone();
        __destination = _destination.clone();
        __tracking = _trackClip;
        __trackContext = _trackContext;
        __timeMotionStep = __duration / com.clubpenguin.games.cardjitsu.water.motion.PopTo.$_updateInterval;
    } // End of the function
    function startMotion()
    {
        com.clubpenguin.ProjectGlobals.__get__host().register(this, com.clubpenguin.games.cardjitsu.water.motion.PopTo.$_updateInterval);
    } // End of the function
    function update(_tick, _currUpdate)
    {
        this.updateMotion();
    } // End of the function
    function get uniqueName()
    {
        return ("[PopTo<" + __uid + ">]");
    } // End of the function
    function updateMotion()
    {
        var _loc2;
        var _loc3;
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
        _loc2 = com.clubpenguin.games.cardjitsu.water.motion.PopTo.popOverTime(__origin, __destination, __motionProgress);
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
    static function popOverTime(pt0, pt1, time)
    {
        var _loc1;
        _loc1 = pt1.subtract(pt0);
        _loc1.normalize(_loc1.length * time);
        return (_loc1.add(pt0));
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
    static var $_updateInterval = 50;
} // End of Class
