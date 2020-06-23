class com.clubpenguin.ui.balloons.EmoteBalloon extends com.clubpenguin.ui.balloons.AbstractBalloon
{
    var hide, __get__mc, __get__emoteFrame, __set__emoteFrame;
    function EmoteBalloon(mc)
    {
        super(mc);
    } // End of the function
    function show()
    {
        this.hide();
        this.__get__mc().gotoAndStop(com.clubpenguin.ui.balloons.EmoteBalloon.UNPARKED_FRAME);
        this.__get__mc().icon_mc.gotoAndStop(this.__get__emoteFrame());
    } // End of the function
    function get emoteFrame()
    {
        return (_emoteFrame);
    } // End of the function
    function set emoteFrame(frame)
    {
        _emoteFrame = frame;
        this.__get__mc().icon_mc.gotoAndStop(this.__get__emoteFrame());
        //return (this.emoteFrame());
        null;
    } // End of the function
    function toString()
    {
        //return ("Emote" + super.toString() + "emoteFrame: " + this.emoteFrame());
    } // End of the function
    static var UNPARKED_FRAME = "emote";
    var _emoteFrame = 0;
} // End of Class
