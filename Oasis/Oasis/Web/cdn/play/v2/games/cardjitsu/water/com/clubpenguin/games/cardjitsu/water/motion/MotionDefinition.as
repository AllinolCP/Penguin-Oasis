class com.clubpenguin.games.cardjitsu.water.motion.MotionDefinition
{
    var __origin, __get__origin, __target, __get__target, __subject, __get__subject, __context, __get__context, __set__context, __set__origin, __set__subject, __set__target;
    function MotionDefinition()
    {
    } // End of the function
    function set origin(_pt)
    {
        __origin = _pt.clone();
        //return (this.origin());
        null;
    } // End of the function
    function set target(_pt)
    {
        __target = _pt.clone();
        //return (this.target());
        null;
    } // End of the function
    function set subject(_sub)
    {
        __subject = _sub;
        //return (this.subject());
        null;
    } // End of the function
    function set context(_con)
    {
        __context = _con;
        //return (this.context());
        null;
    } // End of the function
    function get origin()
    {
        return (__origin);
    } // End of the function
    function get target()
    {
        return (__target);
    } // End of the function
    function get subject()
    {
        return (__subject);
    } // End of the function
    function get context()
    {
        return (__context);
    } // End of the function
} // End of Class
