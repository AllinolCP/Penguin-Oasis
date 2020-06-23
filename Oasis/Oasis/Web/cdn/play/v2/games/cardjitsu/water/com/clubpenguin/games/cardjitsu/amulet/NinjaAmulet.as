class com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet extends MovieClip
{
    var onEnterFrame, gem_fire, gem_water, gem_snow, __state;
    function NinjaAmulet()
    {
        super();
        onEnterFrame = init;
    } // End of the function
    function init()
    {
        delete this.onEnterFrame;
        gem_fire.__set__name("FIRE");
        gem_water.__set__name("WATER");
        gem_snow.__set__name("SNOW");
    } // End of the function
    function addGem(_gem)
    {
        __state = __state | _gem;
        this.updateState();
    } // End of the function
    function removeGem(_gem)
    {
        __state = __state & com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_ALL - _gem;
        this.updateState();
    } // End of the function
    function setGems(_gems)
    {
        __state = _gems;
        this.updateState();
    } // End of the function
    function empty()
    {
        __state = com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_NONE;
        this.updateState();
    } // End of the function
    function award(_gem)
    {
        switch (_gem)
        {
            case com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_FIRE:
            {
                gem_fire.award(com.clubpenguin.util.Delegate.create(this, awardComplete));
                gem_water.stopPulse();
                gem_snow.stopPulse();
                break;
            } 
            case com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_WATER:
            {
                gem_fire.stopPulse();
                gem_water.award(com.clubpenguin.util.Delegate.create(this, awardComplete));
                gem_snow.stopPulse();
                break;
            } 
            case com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_SNOW:
            {
                gem_fire.stopPulse();
                gem_water.stopPulse();
                gem_snow.award(com.clubpenguin.util.Delegate.create(this, awardComplete));
                break;
            } 
        } // End of switch
        __state = __state | _gem;
    } // End of the function
    function awardComplete()
    {
        this.updateState();
    } // End of the function
    function updateState()
    {
        var _loc3 = false;
        var _loc4 = false;
        var _loc2 = false;
        var _loc6 = false;
        var _loc5 = false;
        var _loc7 = false;
        switch (__state)
        {
            case com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_NONE:
            {
                this.hideAll();
                break;
            } 
            case com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_FIRE:
            {
                _loc3 = true;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_WATER:
            {
                _loc4 = true;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_SNOW:
            {
                _loc2 = true;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_FIRE | com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_WATER:
            {
                _loc3 = true;
                _loc4 = true;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_FIRE | com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_SNOW:
            {
                _loc3 = true;
                _loc2 = true;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_WATER | com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_SNOW:
            {
                _loc4 = true;
                _loc2 = true;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_FIRE | com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_WATER | com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_SNOW:
            {
                _loc6 = true;
                _loc5 = true;
                _loc7 = true;
                break;
            } 
        } // End of switch
        if (_loc3 || _loc6)
        {
            if (_loc3)
            {
                gem_fire.show();
            } // end if
            if (_loc6)
            {
                gem_fire.pulse();
            } // end if
        }
        else
        {
            gem_fire.hide();
        } // end else if
        if (_loc4 || _loc5)
        {
            if (_loc4)
            {
                gem_water.show();
            } // end if
            if (_loc5)
            {
                gem_water.pulse();
            } // end if
        }
        else
        {
            gem_water.hide();
        } // end else if
        if (_loc2 || _loc7)
        {
            if (_loc2)
            {
                gem_snow.show();
            } // end if
            if (_loc7)
            {
                gem_snow.pulse();
            } // end if
        }
        else
        {
            gem_snow.hide();
        } // end else if
    } // End of the function
    function hideAll()
    {
        gem_fire.hide();
        gem_water.hide();
        gem_snow.hide();
    } // End of the function
    function toString()
    {
        var _loc2;
        _loc2 = "";
        if (gem_fire.__get__active())
        {
            _loc2 = _loc2 + gem_fire.name;
        } // end if
        if (gem_fire.__get__active() && (gem_water.__get__active() || gem_snow.__get__active()))
        {
            _loc2 = _loc2 + " & ";
        } // end if
        if (gem_water.__get__active())
        {
            _loc2 = _loc2 + gem_water.name;
        } // end if
        if (gem_water.__get__active() && gem_snow.__get__active())
        {
            _loc2 = _loc2 + " & ";
        } // end if
        if (gem_snow.__get__active())
        {
            _loc2 = _loc2 + gem_snow.name;
        } // end if
        if (!(gem_fire.__get__active() || gem_water.__get__active() || gem_snow.__get__active()))
        {
            _loc2 = _loc2 + "EMPTY";
        } // end if
        return (_loc2);
    } // End of the function
    static var GEM_NONE = 0;
    static var GEM_FIRE = 1;
    static var GEM_WATER = 2;
    static var GEM_SNOW = 4;
    static var GEM_ALL = 7;
} // End of Class
