class com.clubpenguin.games.cardjitsu.water.cell.ElementBurst extends MovieClip
{
    var stop, burstSprites, currCharge, nextCharge, onEnterFrame, gotoAndPlay, gotoAndStop;
    function ElementBurst()
    {
        super();
        this.stop();
        burstSprites = new Array();
        currCharge = new Array();
        nextCharge = new Array();
        onEnterFrame = collectEffects;
    } // End of the function
    function collectEffects()
    {
        delete this.onEnterFrame;
        var _loc3;
        var _loc2;
        var _loc4;
        var _loc5;
        for (var _loc6 in this)
        {
            _loc3 = this[_loc6];
            if (_loc3 instanceof MovieClip)
            {
                _loc2 = (MovieClip)(_loc3);
                _loc4 = _loc2._name.substring(_loc2._name.length - 1, _loc2._name.length);
                _loc5 = parseInt(_loc4);
                burstSprites[_loc5] = _loc2;
                _loc2._visible = false;
            } // end if
        } // end of for...in
    } // End of the function
    function charge(_index, _type)
    {
        var _loc2;
        _loc2 = burstSprites[_index];
        if (_loc2 != null)
        {
            _loc2.config(_type);
            nextCharge.push(_loc2);
        } // end if
    } // End of the function
    function ignite()
    {
        var _loc2;
        var _loc4;
        if (nextCharge.length > 0)
        {
            currCharge = nextCharge.concat();
            nextCharge = new Array();
        }
        else
        {
            currCharge = burstSprites.concat();
        } // end else if
        _loc4 = currCharge.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            var _loc3;
            _loc3 = currCharge[_loc2];
            _loc3._visible = true;
        } // end of for
        this.gotoAndPlay("burst");
    } // End of the function
    function burstComplete()
    {
        var _loc2;
        var _loc4;
        _loc4 = currCharge.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            var _loc3;
            _loc3 = currCharge[_loc2];
            _loc3._visible = false;
        } // end of for
        currCharge = new Array();
        this.gotoAndStop("idle");
    } // End of the function
} // End of Class
