class com.clubpenguin.engine.tweener.Equations
{
    function Equations()
    {
    } // End of the function
    static function init()
    {
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easenone", com.clubpenguin.engine.tweener.Equations.easeNone);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("linear", com.clubpenguin.engine.tweener.Equations.easeNone);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinquad", com.clubpenguin.engine.tweener.Equations.easeInQuad);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutquad", com.clubpenguin.engine.tweener.Equations.easeOutQuad);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutquad", com.clubpenguin.engine.tweener.Equations.easeInOutQuad);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinquad", com.clubpenguin.engine.tweener.Equations.easeOutInQuad);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeincubic", com.clubpenguin.engine.tweener.Equations.easeInCubic);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutcubic", com.clubpenguin.engine.tweener.Equations.easeOutCubic);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutcubic", com.clubpenguin.engine.tweener.Equations.easeInOutCubic);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutincubic", com.clubpenguin.engine.tweener.Equations.easeOutInCubic);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinquart", com.clubpenguin.engine.tweener.Equations.easeInQuart);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutquart", com.clubpenguin.engine.tweener.Equations.easeOutQuart);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutquart", com.clubpenguin.engine.tweener.Equations.easeInOutQuart);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinquart", com.clubpenguin.engine.tweener.Equations.easeOutInQuart);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinquint", com.clubpenguin.engine.tweener.Equations.easeInQuint);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutquint", com.clubpenguin.engine.tweener.Equations.easeOutQuint);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutquint", com.clubpenguin.engine.tweener.Equations.easeInOutQuint);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinquint", com.clubpenguin.engine.tweener.Equations.easeOutInQuint);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinsine", com.clubpenguin.engine.tweener.Equations.easeInSine);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutsine", com.clubpenguin.engine.tweener.Equations.easeOutSine);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutsine", com.clubpenguin.engine.tweener.Equations.easeInOutSine);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinsine", com.clubpenguin.engine.tweener.Equations.easeOutInSine);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeincirc", com.clubpenguin.engine.tweener.Equations.easeInCirc);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutcirc", com.clubpenguin.engine.tweener.Equations.easeOutCirc);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutcirc", com.clubpenguin.engine.tweener.Equations.easeInOutCirc);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutincirc", com.clubpenguin.engine.tweener.Equations.easeOutInCirc);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinexpo", com.clubpenguin.engine.tweener.Equations.easeInExpo);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutexpo", com.clubpenguin.engine.tweener.Equations.easeOutExpo);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutexpo", com.clubpenguin.engine.tweener.Equations.easeInOutExpo);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinexpo", com.clubpenguin.engine.tweener.Equations.easeOutInExpo);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinelastic", com.clubpenguin.engine.tweener.Equations.easeInElastic);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutelastic", com.clubpenguin.engine.tweener.Equations.easeOutElastic);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutelastic", com.clubpenguin.engine.tweener.Equations.easeInOutElastic);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinelastic", com.clubpenguin.engine.tweener.Equations.easeOutInElastic);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinback", com.clubpenguin.engine.tweener.Equations.easeInBack);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutback", com.clubpenguin.engine.tweener.Equations.easeOutBack);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutback", com.clubpenguin.engine.tweener.Equations.easeInOutBack);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinback", com.clubpenguin.engine.tweener.Equations.easeOutInBack);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinbounce", com.clubpenguin.engine.tweener.Equations.easeInBounce);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutbounce", com.clubpenguin.engine.tweener.Equations.easeOutBounce);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeinoutbounce", com.clubpenguin.engine.tweener.Equations.easeInOutBounce);
        com.clubpenguin.engine.tweener.Tweener.registerTransition("easeoutinbounce", com.clubpenguin.engine.tweener.Equations.easeOutInBounce);
    } // End of the function
    static function easeNone(t, b, c, d, p_params)
    {
        return (c * t / d + b);
    } // End of the function
    static function easeInQuad(t, b, c, d, p_params)
    {
        t = t / d;
        return (c * t * t + b);
    } // End of the function
    static function easeOutQuad(t, b, c, d, p_params)
    {
        t = t / d;
        return (-c * t * (t - 2) + b);
    } // End of the function
    static function easeInOutQuad(t, b, c, d, p_params)
    {
        t = t / (d / 2);
        if (t < 1)
        {
            return (c / 2 * t * t + b);
        } // end if
        --t;
        return (-c / 2 * (t * (t - 2) - 1) + b);
    } // End of the function
    static function easeOutInQuad(t, b, c, d, p_params)
    {
        if (t < d / 2)
        {
            return (com.clubpenguin.engine.tweener.Equations.easeOutQuad(t * 2, b, c / 2, d, p_params));
        } // end if
        return (com.clubpenguin.engine.tweener.Equations.easeInQuad(t * 2 - d, b + c / 2, c / 2, d, p_params));
    } // End of the function
    static function easeInCubic(t, b, c, d, p_params)
    {
        t = t / d;
        return (c * t * t * t + b);
    } // End of the function
    static function easeOutCubic(t, b, c, d, p_params)
    {
        t = t / d - 1;
        return (c * (t * t * t + 1) + b);
    } // End of the function
    static function easeInOutCubic(t, b, c, d, p_params)
    {
        t = t / (d / 2);
        if (t < 1)
        {
            return (c / 2 * t * t * t + b);
        } // end if
        t = t - 2;
        return (c / 2 * (t * t * t + 2) + b);
    } // End of the function
    static function easeOutInCubic(t, b, c, d, p_params)
    {
        if (t < d / 2)
        {
            return (com.clubpenguin.engine.tweener.Equations.easeOutCubic(t * 2, b, c / 2, d, p_params));
        } // end if
        return (com.clubpenguin.engine.tweener.Equations.easeInCubic(t * 2 - d, b + c / 2, c / 2, d, p_params));
    } // End of the function
    static function easeInQuart(t, b, c, d, p_params)
    {
        t = t / d;
        return (c * t * t * t * t + b);
    } // End of the function
    static function easeOutQuart(t, b, c, d, p_params)
    {
        t = t / d - 1;
        return (-c * (t * t * t * t - 1) + b);
    } // End of the function
    static function easeInOutQuart(t, b, c, d, p_params)
    {
        t = t / (d / 2);
        if (t < 1)
        {
            return (c / 2 * t * t * t * t + b);
        } // end if
        t = t - 2;
        return (-c / 2 * (t * t * t * t - 2) + b);
    } // End of the function
    static function easeOutInQuart(t, b, c, d, p_params)
    {
        if (t < d / 2)
        {
            return (com.clubpenguin.engine.tweener.Equations.easeOutQuart(t * 2, b, c / 2, d, p_params));
        } // end if
        return (com.clubpenguin.engine.tweener.Equations.easeInQuart(t * 2 - d, b + c / 2, c / 2, d, p_params));
    } // End of the function
    static function easeInQuint(t, b, c, d, p_params)
    {
        t = t / d;
        return (c * t * t * t * t * t + b);
    } // End of the function
    static function easeOutQuint(t, b, c, d, p_params)
    {
        t = t / d - 1;
        return (c * (t * t * t * t * t + 1) + b);
    } // End of the function
    static function easeInOutQuint(t, b, c, d, p_params)
    {
        t = t / (d / 2);
        if (t < 1)
        {
            return (c / 2 * t * t * t * t * t + b);
        } // end if
        t = t - 2;
        return (c / 2 * (t * t * t * t * t + 2) + b);
    } // End of the function
    static function easeOutInQuint(t, b, c, d, p_params)
    {
        if (t < d / 2)
        {
            return (com.clubpenguin.engine.tweener.Equations.easeOutQuint(t * 2, b, c / 2, d, p_params));
        } // end if
        return (com.clubpenguin.engine.tweener.Equations.easeInQuint(t * 2 - d, b + c / 2, c / 2, d, p_params));
    } // End of the function
    static function easeInSine(t, b, c, d, p_params)
    {
        return (-c * Math.cos(t / d * 1.570796) + c + b);
    } // End of the function
    static function easeOutSine(t, b, c, d, p_params)
    {
        return (c * Math.sin(t / d * 1.570796) + b);
    } // End of the function
    static function easeInOutSine(t, b, c, d, p_params)
    {
        return (-c / 2 * (Math.cos(3.141593 * t / d) - 1) + b);
    } // End of the function
    static function easeOutInSine(t, b, c, d, p_params)
    {
        if (t < d / 2)
        {
            return (com.clubpenguin.engine.tweener.Equations.easeOutSine(t * 2, b, c / 2, d, p_params));
        } // end if
        return (com.clubpenguin.engine.tweener.Equations.easeInSine(t * 2 - d, b + c / 2, c / 2, d, p_params));
    } // End of the function
    static function easeInExpo(t, b, c, d, p_params)
    {
        return (t == 0 ? (b) : (c * Math.pow(2, 10 * (t / d - 1)) + b - c * 0.001000));
    } // End of the function
    static function easeOutExpo(t, b, c, d, p_params)
    {
        return (t == d ? (b + c) : (c * 1.001000 * (-Math.pow(2, -10 * t / d) + 1) + b));
    } // End of the function
    static function easeInOutExpo(t, b, c, d, p_params)
    {
        if (t == 0)
        {
            return (b);
        } // end if
        if (t == d)
        {
            return (b + c);
        } // end if
        t = t / (d / 2);
        if (t < 1)
        {
            return (c / 2 * Math.pow(2, 10 * (t - 1)) + b - c * 0.000500);
        } // end if
        --t;
        return (c / 2 * 1.000500 * (-Math.pow(2, -10 * t) + 2) + b);
    } // End of the function
    static function easeOutInExpo(t, b, c, d, p_params)
    {
        if (t < d / 2)
        {
            return (com.clubpenguin.engine.tweener.Equations.easeOutExpo(t * 2, b, c / 2, d, p_params));
        } // end if
        return (com.clubpenguin.engine.tweener.Equations.easeInExpo(t * 2 - d, b + c / 2, c / 2, d, p_params));
    } // End of the function
    static function easeInCirc(t, b, c, d, p_params)
    {
        t = t / d;
        return (-c * (Math.sqrt(1 - t * t) - 1) + b);
    } // End of the function
    static function easeOutCirc(t, b, c, d, p_params)
    {
        t = t / d - 1;
        return (c * Math.sqrt(1 - t * t) + b);
    } // End of the function
    static function easeInOutCirc(t, b, c, d, p_params)
    {
        t = t / (d / 2);
        if (t < 1)
        {
            return (-c / 2 * (Math.sqrt(1 - t * t) - 1) + b);
        } // end if
        t = t - 2;
        return (c / 2 * (Math.sqrt(1 - t * t) + 1) + b);
    } // End of the function
    static function easeOutInCirc(t, b, c, d, p_params)
    {
        if (t < d / 2)
        {
            return (com.clubpenguin.engine.tweener.Equations.easeOutCirc(t * 2, b, c / 2, d, p_params));
        } // end if
        return (com.clubpenguin.engine.tweener.Equations.easeInCirc(t * 2 - d, b + c / 2, c / 2, d, p_params));
    } // End of the function
    static function easeInElastic(t, b, c, d, p_params)
    {
        if (t == 0)
        {
            return (b);
        } // end if
        t = t / d;
        if (t == 1)
        {
            return (b + c);
        } // end if
        var _loc3 = p_params.period == undefined ? (d * 0.300000) : (p_params.period);
        var _loc5;
        var _loc2 = p_params.amplitude;
        if (!_loc2 || _loc2 < Math.abs(c))
        {
            _loc2 = c;
            _loc5 = _loc3 / 4;
        }
        else
        {
            _loc5 = _loc3 / 6.283185 * Math.asin(c / _loc2);
        } // end else if
        t = t - 1;
        return (-_loc2 * Math.pow(2, 10 * t) * Math.sin((t * d - _loc5) * 6.283185 / _loc3) + b);
    } // End of the function
    static function easeOutElastic(t, b, c, d, p_params)
    {
        if (t == 0)
        {
            return (b);
        } // end if
        t = t / d;
        if (t == 1)
        {
            return (b + c);
        } // end if
        var _loc4 = p_params.period == undefined ? (d * 0.300000) : (p_params.period);
        var _loc5;
        var _loc1 = p_params.amplitude;
        if (!_loc1 || _loc1 < Math.abs(c))
        {
            _loc1 = c;
            _loc5 = _loc4 / 4;
        }
        else
        {
            _loc5 = _loc4 / 6.283185 * Math.asin(c / _loc1);
        } // end else if
        return (_loc1 * Math.pow(2, -10 * t) * Math.sin((t * d - _loc5) * 6.283185 / _loc4) + c + b);
    } // End of the function
    static function easeInOutElastic(t, b, c, d, p_params)
    {
        if (t == 0)
        {
            return (b);
        } // end if
        t = t / (d / 2);
        if (t == 2)
        {
            return (b + c);
        } // end if
        var _loc3 = p_params.period == undefined ? (d * 0.450000) : (p_params.period);
        var _loc5;
        var _loc2 = p_params.amplitude;
        if (!_loc2 || _loc2 < Math.abs(c))
        {
            _loc2 = c;
            _loc5 = _loc3 / 4;
        }
        else
        {
            _loc5 = _loc3 / 6.283185 * Math.asin(c / _loc2);
        } // end else if
        if (t < 1)
        {
            t = t - 1;
            return (-0.500000 * (_loc2 * Math.pow(2, 10 * t) * Math.sin((t * d - _loc5) * 6.283185 / _loc3)) + b);
        } // end if
        t = t - 1;
        return (_loc2 * Math.pow(2, -10 * t) * Math.sin((t * d - _loc5) * 6.283185 / _loc3) * 0.500000 + c + b);
    } // End of the function
    static function easeOutInElastic(t, b, c, d, p_params)
    {
        if (t < d / 2)
        {
            return (com.clubpenguin.engine.tweener.Equations.easeOutElastic(t * 2, b, c / 2, d, p_params));
        } // end if
        return (com.clubpenguin.engine.tweener.Equations.easeInElastic(t * 2 - d, b + c / 2, c / 2, d, p_params));
    } // End of the function
    static function easeInBack(t, b, c, d, p_params)
    {
        var _loc2 = p_params.overshoot == undefined ? (1.701580) : (p_params.overshoot);
        t = t / d;
        return (c * t * t * ((_loc2 + 1) * t - _loc2) + b);
    } // End of the function
    static function easeOutBack(t, b, c, d, p_params)
    {
        var _loc2 = p_params.overshoot == undefined ? (1.701580) : (p_params.overshoot);
        t = t / d - 1;
        return (c * (t * t * ((_loc2 + 1) * t + _loc2) + 1) + b);
    } // End of the function
    static function easeInOutBack(t, b, c, d, p_params)
    {
        var _loc2 = p_params.overshoot == undefined ? (1.701580) : (p_params.overshoot);
        t = t / (d / 2);
        if (t < 1)
        {
            _loc2 = _loc2 * 1.525000;
            return (c / 2 * (t * t * ((_loc2 + 1) * t - _loc2)) + b);
        } // end if
        t = t - 2;
        _loc2 = _loc2 * 1.525000;
        return (c / 2 * (t * t * ((_loc2 + 1) * t + _loc2) + 2) + b);
    } // End of the function
    static function easeOutInBack(t, b, c, d, p_params)
    {
        if (t < d / 2)
        {
            return (com.clubpenguin.engine.tweener.Equations.easeOutBack(t * 2, b, c / 2, d, p_params));
        } // end if
        return (com.clubpenguin.engine.tweener.Equations.easeInBack(t * 2 - d, b + c / 2, c / 2, d, p_params));
    } // End of the function
    static function easeInBounce(t, b, c, d, p_params)
    {
        return (c - com.clubpenguin.engine.tweener.Equations.easeOutBounce(d - t, 0, c, d) + b);
    } // End of the function
    static function easeOutBounce(t, b, c, d, p_params)
    {
        t = t / d;
        if (t < 0.363636)
        {
            return (c * (7.562500 * t * t) + b);
        }
        else if (t < 0.727273)
        {
            t = t - 0.545455;
            return (c * (7.562500 * t * t + 0.750000) + b);
        }
        else if (t < 0.909091)
        {
            t = t - 0.818182;
            return (c * (7.562500 * t * t + 0.937500) + b);
        }
        else
        {
            t = t - 0.954545;
            return (c * (7.562500 * t * t + 0.984375) + b);
        } // end else if
    } // End of the function
    static function easeInOutBounce(t, b, c, d, p_params)
    {
        if (t < d / 2)
        {
            return (com.clubpenguin.engine.tweener.Equations.easeInBounce(t * 2, 0, c, d) * 0.500000 + b);
        }
        else
        {
            return (com.clubpenguin.engine.tweener.Equations.easeOutBounce(t * 2 - d, 0, c, d) * 0.500000 + c * 0.500000 + b);
        } // end else if
    } // End of the function
    static function easeOutInBounce(t, b, c, d, p_params)
    {
        if (t < d / 2)
        {
            return (com.clubpenguin.engine.tweener.Equations.easeOutBounce(t * 2, b, c / 2, d, p_params));
        } // end if
        return (com.clubpenguin.engine.tweener.Equations.easeInBounce(t * 2 - d, b + c / 2, c / 2, d, p_params));
    } // End of the function
} // End of Class
