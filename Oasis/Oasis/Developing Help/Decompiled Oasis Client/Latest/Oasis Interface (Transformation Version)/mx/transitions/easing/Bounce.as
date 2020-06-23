class mx.transitions.easing.Bounce
{
    function Bounce()
    {
    } // End of the function
    static function easeOut(t, b, c, d)
    {
        t = t / d;
        if (t < 0.363636)
        {
            return (c * (7.562500 * t * t) + b);
        }
        else if (t < 0.727273)
        {
            t = t - 0.545455;
            return (c * (7.562500 * (t) * t + 0.750000) + b);
        }
        else if (t < 0.909091)
        {
            t = t - 0.818182;
            return (c * (7.562500 * (t) * t + 0.937500) + b);
        }
        else
        {
            t = t - 0.954545;
            return (c * (7.562500 * (t) * t + 0.984375) + b);
        } // end else if
    } // End of the function
    static function easeIn(t, b, c, d)
    {
        return (c - mx.transitions.easing.Bounce.easeOut(d - t, 0, c, d) + b);
    } // End of the function
    static function easeInOut(t, b, c, d)
    {
        if (t < d / 2)
        {
            return (mx.transitions.easing.Bounce.easeIn(t * 2, 0, c, d) * 0.500000 + b);
        }
        else
        {
            return (mx.transitions.easing.Bounce.easeOut(t * 2 - d, 0, c, d) * 0.500000 + c * 0.500000 + b);
        } // end else if
    } // End of the function
    static var version = "1.1.0.52";
} // End of Class
