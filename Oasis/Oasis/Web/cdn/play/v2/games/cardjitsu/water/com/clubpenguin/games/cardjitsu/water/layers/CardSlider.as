class com.clubpenguin.games.cardjitsu.water.layers.CardSlider extends MovieClip implements com.clubpenguin.games.cardjitsu.water.motion.IMoveable
{
    var _x, _y;
    function CardSlider()
    {
        super();
    } // End of the function
    function currentMotion()
    {
        return (null);
    } // End of the function
    function setCoordinate(_pt)
    {
        _x = _pt.x;
        _y = _pt.y;
    } // End of the function
    function getCoordinate()
    {
        return (new flash.geom.Point(_x, _y));
    } // End of the function
} // End of Class
