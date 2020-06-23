class com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterLayers extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, children, colorClips, senseiClips, ninjaClips, hostClips, onEnterFrame, _parent;
    function PlayerCharacterLayers()
    {
        super();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterLayers.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.player.PlayerCharacterLayers.$_instanceCount;
        children = new Array();
        colorClips = new Array();
        senseiClips = new Array();
        ninjaClips = new Array();
        hostClips = new Array();
        onEnterFrame = compileClips;
        this.stopAll();
    } // End of the function
    function getUniqueName()
    {
        return ("[PlayerCharacterLayers<" + __uid + ">]");
    } // End of the function
    function dispatchComplete(_action)
    {
        this.stopAll();
        (com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter)(_parent).actionComplete(_action);
    } // End of the function
    function dispatchContinue(_action)
    {
        (com.clubpenguin.games.cardjitsu.water.player.PlayerCharacter)(_parent).actionContinue(_action);
    } // End of the function
    function compileClips()
    {
        delete this.onEnterFrame;
        var _loc4;
        var _loc3;
        var _loc2;
        _loc4 = "Analyzing PlayerCharacterLayers";
        for (var _loc5 in this)
        {
            _loc2 = this[_loc5];
            if (_loc2 instanceof MovieClip)
            {
                children.push(_loc2);
                _loc3 = (MovieClip)(_loc2)._name;
                if (_loc3.indexOf("color") != -1)
                {
                    colorClips.push(_loc2);
                } // end if
                if (_loc3.indexOf("sensei") != -1)
                {
                    _loc4 = _loc4 + ("\nSENSEI: " + _loc3);
                    senseiClips.push(_loc2);
                } // end if
                if (_loc3.indexOf("ninja") != -1)
                {
                    _loc4 = _loc4 + ("\nNINJA: " + _loc3);
                    ninjaClips.push(_loc2);
                } // end if
                if (_loc3.indexOf("host") != -1)
                {
                    _loc4 = _loc4 + ("\nHOST: " + _loc3);
                    hostClips.push(_loc2);
                } // end if
                _loc4 = _loc4 + ("\nMC Child is " + (MovieClip)(_loc2)._name);
            } // end if
        } // end of for...in
        this.hideSensei();
    } // End of the function
    function startAction(_action, _param)
    {
        var _loc4;
        var _loc3;
        _loc4 = children.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            _loc3 = children[_loc2];
            _loc3.config(_param);
            _loc3.gotoAndPlay(_action);
        } // end of for
    } // End of the function
    function stopAll()
    {
        var _loc3;
        _loc3 = children.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            children[_loc2].stop();
        } // end of for
    } // End of the function
    function setColor(artColor, _dark)
    {
        var _loc4;
        var _loc5;
        var _loc3;
        _loc5 = colorClips.length;
        for (var _loc2 = 0; _loc2 < _loc5; ++_loc2)
        {
            _loc3 = colorClips[_loc2];
            _loc4 = new Color(_loc3);
            _loc4.setRGB(artColor);
        } // end of for
        if (artColor == com.clubpenguin.games.cardjitsu.water.ProjectConstants.SENSEI_COLOUR)
        {
            this.hideNinja();
            this.showSensei();
        }
        else
        {
            this.hideSensei();
            this.showNinja();
        } // end else if
        this.showHost(_dark);
    } // End of the function
    function hideSensei()
    {
        var _loc4;
        var _loc3;
        _loc4 = senseiClips.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            _loc3 = senseiClips[_loc2];
            _loc3._visible = false;
        } // end of for
    } // End of the function
    function showSensei()
    {
        var _loc4;
        var _loc3;
        _loc4 = senseiClips.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            _loc3 = senseiClips[_loc2];
            _loc3._visible = true;
        } // end of for
    } // End of the function
    function hideNinja()
    {
        var _loc4;
        var _loc3;
        _loc4 = ninjaClips.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            _loc3 = ninjaClips[_loc2];
            _loc3._visible = false;
        } // end of for
    } // End of the function
    function showNinja(_dark)
    {
        var _loc4;
        var _loc3;
        _loc4 = ninjaClips.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            _loc3 = ninjaClips[_loc2];
            _loc3._visible = true;
        } // end of for
    } // End of the function
    function showHost(_dark)
    {
        var _loc4;
        var _loc3;
        _loc4 = hostClips.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            _loc3 = hostClips[_loc2];
            _loc3._visible = !_dark;
        } // end of for
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
