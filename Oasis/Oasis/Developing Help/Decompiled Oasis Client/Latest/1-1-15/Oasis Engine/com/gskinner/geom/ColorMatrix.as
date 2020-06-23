class com.gskinner.geom.ColorMatrix extends Array
{
    var join, slice, _loc2;
    function ColorMatrix(p_matrix)
    {
        super();
        p_matrix = this.fixMatrix(p_matrix);
        this.copyMatrix(p_matrix.length == com.gskinner.geom.ColorMatrix.LENGTH ? (p_matrix) : (com.gskinner.geom.ColorMatrix.IDENTITY_MATRIX));
    } // End of the function
    function adjustColor(p_brightness, p_contrast, p_saturation, p_hue)
    {
        this.adjustHue(p_hue);
        this.adjustContrast(p_contrast);
        this.adjustBrightness(p_brightness);
        this.adjustSaturation(p_saturation);
    } // End of the function
    function adjustBrightness(p_val)
    {
        p_val = this.cleanValue(p_val, 100);
        if (p_val == 0 || isNaN(p_val))
        {
            return;
        } // end if
        this.multiplyMatrix([1, 0, 0, 0, p_val, 0, 1, 0, 0, p_val, 0, 0, 1, 0, p_val, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1]);
    } // End of the function
    function adjustContrast(p_val)
    {
        p_val = this.cleanValue(p_val, 100);
        if (p_val == 0 || isNaN(p_val))
        {
            return;
        } // end if
        var _loc2;
        if (p_val < 0)
        {
            _loc2 = 127 + p_val / 100 * 127;
        }
        else
        {
            _loc2 = p_val % 1;
            if (_loc2 == 0)
            {
                _loc2 = com.gskinner.geom.ColorMatrix.DELTA_INDEX[p_val];
            }
            else
            {
                _loc2 = com.gskinner.geom.ColorMatrix.DELTA_INDEX[p_val << 0] * (1 - _loc2) + com.gskinner.geom.ColorMatrix.DELTA_INDEX[(p_val << 0) + 1] * _loc2;
            } // end else if
            _loc2 = _loc2 * 127 + 127;
        } // end else if
        this.multiplyMatrix([_loc2 / 127, 0, 0, 0, 0.500000 * (127 - _loc2), 0, _loc2 / 127, 0, 0, 0.500000 * (127 - _loc2), 0, 0, _loc2 / 127, 0, 0.500000 * (127 - _loc2), 0, 0, 0, 1, 0, 0, 0, 0, 0, 1]);
    } // End of the function
    function adjustSaturation(p_val)
    {
        p_val = this.cleanValue(p_val, 100);
        if (p_val == 0 || isNaN(p_val))
        {
            return;
        } // end if
        var _loc2 = 1 + (p_val > 0 ? (3 * p_val / 100) : (p_val / 100));
        var _loc5 = 0.308600;
        var _loc4 = 0.609400;
        var _loc6 = 0.082000;
        this.multiplyMatrix([_loc5 * (1 - _loc2) + _loc2, _loc4 * (1 - _loc2), _loc6 * (1 - _loc2), 0, 0, _loc5 * (1 - _loc2), _loc4 * (1 - _loc2) + _loc2, _loc6 * (1 - _loc2), 0, 0, _loc5 * (1 - _loc2), _loc4 * (1 - _loc2), _loc6 * (1 - _loc2) + _loc2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1]);
    } // End of the function
    function adjustHue(p_val)
    {
        p_val = this.cleanValue(p_val, 180) / 180 * 3.141593;
        if (p_val == 0 || isNaN(p_val))
        {
            return;
        } // end if
        var _loc3 = Math.cos(p_val);
        var _loc2 = Math.sin(p_val);
        var _loc5 = 0.213000;
        var _loc4 = 0.715000;
        var _loc6 = 0.072000;
        this.multiplyMatrix([_loc5 + _loc3 * (1 - _loc5) + _loc2 * -_loc5, _loc4 + _loc3 * -_loc4 + _loc2 * -_loc4, _loc6 + _loc3 * -_loc6 + _loc2 * (1 - _loc6), 0, 0, _loc5 + _loc3 * -_loc5 + _loc2 * 0.143000, _loc4 + _loc3 * (1 - _loc4) + _loc2 * 0.140000, _loc6 + _loc3 * -_loc6 + _loc2 * -0.283000, 0, 0, _loc5 + _loc3 * -_loc5 + _loc2 * -(1 - _loc5), _loc4 + _loc3 * -_loc4 + _loc2 * _loc4, _loc6 + _loc3 * (1 - _loc6) + _loc2 * _loc6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1]);
    } // End of the function
    function concat(p_matrix)
    {
        p_matrix = this.fixMatrix(p_matrix);
        if (p_matrix.length != com.gskinner.geom.ColorMatrix.LENGTH)
        {
            return;
        } // end if
        this.multiplyMatrix(p_matrix);
    } // End of the function
    function clone()
    {
        return (new com.gskinner.geom.ColorMatrix(this));
    } // End of the function
    function toString()
    {
        return ("ColorMatrix [ " + this.join(" , ") + " ]");
    } // End of the function
    function toArray()
    {
        return (this.slice(0, 20));
    } // End of the function
    function copyMatrix(p_matrix)
    {
        var _loc3 = com.gskinner.geom.ColorMatrix.LENGTH;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            this[_loc2] = p_matrix[_loc2];
        } // end of for
    } // End of the function
    function multiplyMatrix(p_matrix)
    {
        var _loc6 = [];
        for (var _loc5 = 0; _loc5 < 5; ++_loc5)
        {
            for (var _loc3 = 0; _loc3 < 5; ++_loc3)
            {
                _loc6[_loc3] = this[_loc3 + _loc5 * 5];
            } // end of for
            for (var _loc3 = 0; _loc3 < 5; ++_loc3)
            {
                var _loc4 = 0;
                for (var _loc2 = 0; _loc2 < 5; ++_loc2)
                {
                    _loc4 = _loc4 + p_matrix[_loc3 + _loc2 * 5] * _loc6[_loc2];
                } // end of for
                set(_loc3 + _loc5 * 5, _loc4);
            } // end of for
        } // end of for
    } // End of the function
    function cleanValue(p_val, p_limit)
    {
        return (Math.min(p_limit, Math.max(-p_limit, p_val)));
    } // End of the function
    function fixMatrix(p_matrix)
    {
        if (p_matrix instanceof com.gskinner.geom.ColorMatrix)
        {
            p_matrix = p_matrix.slice(0);
        } // end if
        if (p_matrix.length < com.gskinner.geom.ColorMatrix.LENGTH)
        {
            p_matrix = p_matrix.slice(0, p_matrix.length).concat(com.gskinner.geom.ColorMatrix.IDENTITY_MATRIX.slice(p_matrix.length, com.gskinner.geom.ColorMatrix.LENGTH));
        }
        else if (p_matrix.length > com.gskinner.geom.ColorMatrix.LENGTH)
        {
            p_matrix = p_matrix.slice(0, com.gskinner.geom.ColorMatrix.LENGTH);
        } // end else if
        return (p_matrix);
    } // End of the function
    static var DELTA_INDEX = [0, 0.010000, 0.020000, 0.040000, 0.050000, 0.060000, 0.070000, 0.080000, 0.100000, 0.110000, 0.120000, 0.140000, 0.150000, 0.160000, 0.170000, 0.180000, 0.200000, 0.210000, 0.220000, 0.240000, 0.250000, 0.270000, 0.280000, 0.300000, 0.320000, 0.340000, 0.360000, 0.380000, 0.400000, 0.420000, 0.440000, 0.460000, 0.480000, 0.500000, 0.530000, 0.560000, 0.590000, 0.620000, 0.650000, 0.680000, 0.710000, 0.740000, 0.770000, 0.800000, 0.830000, 0.860000, 0.890000, 0.920000, 0.950000, 0.980000, 1, 1.060000, 1.120000, 1.180000, 1.240000, 1.300000, 1.360000, 1.420000, 1.480000, 1.540000, 1.600000, 1.660000, 1.720000, 1.780000, 1.840000, 1.900000, 1.960000, 2, 2.120000, 2.250000, 2.370000, 2.500000, 2.620000, 2.750000, 2.870000, 3, 3.200000, 3.400000, 3.600000, 3.800000, 4, 4.300000, 4.700000, 4.900000, 5, 5.500000, 6, 6.500000, 6.800000, 7, 7.300000, 7.500000, 7.800000, 8, 8.400000, 8.700000, 9, 9.400000, 9.600000, 9.800000, 10];
    static var IDENTITY_MATRIX = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
    static var LENGTH = com.gskinner.geom.ColorMatrix.IDENTITY_MATRIX.length;
} // End of Class
