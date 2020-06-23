class com.clubpenguin.ui.balloons.AbstractBalloon
{
    var _mc, _mcName, __get__mc, _linkage, __get__linkage, __get__counter, __get__duration, __set__counter, __set__duration, __set__linkage, __get__name;
    function AbstractBalloon(mc)
    {
        if (mc == undefined)
        {
            return;
        } // end if
        _mc = mc;
        _mcName = mc._name;
    } // End of the function
    function setSize(width, height)
    {
        this.__get__mc().balloon_mc._width = width;
        this.__get__mc().pointer_mc._width = width;
        this.__get__mc().balloon_mc._height = height;
        this.__get__mc().balloon_mc._y = this.__get__mc().pointer_mc._y - height;
    } // End of the function
    function hide()
    {
        this.__get__mc().gotoAndStop(com.clubpenguin.ui.balloons.AbstractBalloon.PARKED_FRAME);
    } // End of the function
    function get name()
    {
        return (_mcName);
    } // End of the function
    function get mc()
    {
        return (_mc);
    } // End of the function
    function get linkage()
    {
        return (_linkage);
    } // End of the function
    function set linkage(value)
    {
        _linkage = value;
        null;
        //return (this.linkage());
        null;
    } // End of the function
    function get counter()
    {
        return (_counter);
    } // End of the function
    function set counter(value)
    {
        _counter = value;
        null;
        //return (this.counter());
        null;
    } // End of the function
    function get duration()
    {
        return (_duration);
    } // End of the function
    function set duration(value)
    {
        _duration = value;
        null;
        //return (this.duration());
        null;
    } // End of the function
    function toString()
    {
    } // End of the function
    static var PARKED_FRAME = "parked";
    var _counter = 0;
    var _duration = 125;
} // End of Class
