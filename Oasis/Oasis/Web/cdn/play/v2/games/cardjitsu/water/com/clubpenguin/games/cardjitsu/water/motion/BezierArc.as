class com.clubpenguin.games.cardjitsu.water.motion.BezierArc extends com.clubpenguin.games.cardjitsu.water.motion.Motion implements com.clubpenguin.lib.IDisposable, com.clubpenguin.game.engine.IEngineUpdateable
{
    var __subject, __timeBezier, __duration, __origin, __destination, __bezierApex, __tracking, __trackContext, __timeBezierStep, __uid, __get__uniqueName;
    function BezierArc(_subject, _duration, _origin, _destination, _apex, _trackClip, _trackContext)
    {
        super();
        __subject = _subject;
        __timeBezier = 0;
        __duration = _duration;
        __origin = _origin.clone();
        __destination = _destination.clone();
        __bezierApex = _apex.clone();
        __tracking = _trackClip;
        __trackContext = _trackContext;
        __timeBezierStep = __duration / com.clubpenguin.games.cardjitsu.water.motion.BezierArc.$_updateInterval;
    } // End of the function
    function get uniqueName()
    {
        return ("[BezierArc<" + __uid + ">]");
    } // End of the function
    function startMotion()
    {
        com.clubpenguin.ProjectGlobals.__get__host().register(this, com.clubpenguin.games.cardjitsu.water.motion.BezierArc.$_updateInterval);
    } // End of the function
    function update(_tick, _currUpdate)
    {
        this.updateMotion();
    } // End of the function
    function updateMotion()
    {
        var _loc2;
        __timeBezier = __timeBezier + 1 / __timeBezierStep;
        if (__timeBezier >= 1)
        {
            __timeBezier = 1;
        } // end if
        if (__tracking != null)
        {
            __destination = new flash.geom.Point(__tracking._x, __tracking._y);
            __trackContext.localToGlobal(__destination);
        } // end if
        _loc2 = com.clubpenguin.games.cardjitsu.water.motion.BezierArc.bezierOverTime(__origin, __destination, __bezierApex, __timeBezier);
        __subject.setCoordinate(_loc2);
        if (__timeBezier == 1)
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.MotionEvent(this, com.clubpenguin.games.cardjitsu.water.event.MotionEvent.COMPLETE, __timeBezier));
        }
        else
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.MotionEvent(this, com.clubpenguin.games.cardjitsu.water.event.MotionEvent.PROGRESS, __timeBezier));
        } // end else if
    } // End of the function
    static function bezierOverTime(pt0, pt1, ctrl1, time)
    {
        return (new flash.geom.Point(pt0.x + time * (2 * (1 - time) * (ctrl1.x - pt0.x) + time * (pt1.x - pt0.x)), pt0.y + time * (2 * (1 - time) * (ctrl1.y - pt0.y) + time * (pt1.y - pt0.y))));
    } // End of the function
    function dispose()
    {
        com.clubpenguin.ProjectGlobals.__get__host().unregister(this);
        __subject = null;
        __origin = null;
        __destination = null;
        __bezierApex = null;
    } // End of the function
    function toString()
    {
        //return (this.uniqueName());
    } // End of the function
    static var $_updateInterval = 40;
} // End of Class
