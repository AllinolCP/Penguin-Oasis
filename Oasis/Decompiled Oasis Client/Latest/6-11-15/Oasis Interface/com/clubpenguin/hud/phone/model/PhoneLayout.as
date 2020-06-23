class com.clubpenguin.hud.phone.model.PhoneLayout extends com.clubpenguin.util.Enumeration
{
    var x, y, scale, rotation, draggable, time, __get__tweenProperties;
    function PhoneLayout(x, y, scale, rotation, transition, draggable, time)
    {
        super();
        this.x = x || 0;
        this.y = y || 0;
        this.scale = scale || 100;
        this.rotation = rotation || 0;
        if (transition.length)
        {
            this.transition = transition;
        } // end if
        this.draggable = draggable || false;
        this.time = time || 0.500000;
    } // End of the function
    function get tweenProperties()
    {
        return ({_x: x, _y: y, _xscale: scale, _yscale: scale, _rotation: rotation, transition: transition, time: time});
    } // End of the function
    static var CLOSED = new com.clubpenguin.hud.phone.model.PhoneLayout(0, 0, 15, 0, "easeinoutquart");
    static var PORTRAIT = new com.clubpenguin.hud.phone.model.PhoneLayout(290, 70, 60, 0, "easeoutback", true);
    static var LANDSCAPE = new com.clubpenguin.hud.phone.model.PhoneLayout(640, 90, 100, 90, "easeoutback", false);
    static var LANDSCAPE_LARGE = new com.clubpenguin.hud.phone.model.PhoneLayout(700, 30, 140, 90, "easeoutback", false);
    var transition = "easeoutback";
} // End of Class
