class com.clubpenguin.games.cardjitsu.water.card.GameCardArtwork extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, hitarea, assetList, _visible, onEnterFrame, __gcDef, mc_atr, mc_pt, mc_col, mc_glow, __icon, mc_art, assetLoadDone, assetLoadingCount;
    function GameCardArtwork()
    {
        super();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.card.GameCardArtwork.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.card.GameCardArtwork.$_instanceCount;
        hitarea._visible = false;
        assetList = new Array();
        this.gotoAndStop("front");
        _visible = false;
        onEnterFrame = checkInit;
    } // End of the function
    function getUniqueName()
    {
        return ("[GameCardArtwork<" + __uid + ">]");
    } // End of the function
    function checkInit()
    {
        if (__init)
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.ClipEvent(this, com.clubpenguin.lib.event.ClipEvent.RENDERED));
            __init = false;
            delete this.onEnterFrame;
        } // end if
    } // End of the function
    function applyDefinition(_gcDef)
    {
        _visible = true;
        __gcDef = _gcDef;
        var _loc2;
        mc_atr.gotoAndStop(__gcDef.__get__element().__get__letter());
        mc_pt.tf_pt.text = __gcDef.__get__element().__get__amount().toString();
        _loc2 = new Color(mc_col);
        _loc2.setRGB(__gcDef.__get__rgbColor());
        _loc2 = new Color(mc_glow);
        _loc2.setTransform(__gcDef.__get__rgbGlow());
        this.enableGlow();
        this.loadIcon();
    } // End of the function
    function loadIcon(_path)
    {
        var _loc2;
        _loc2 = _path == undefined ? ("../../card/icons/") : (_path);
        if (__icon != _loc2 + __gcDef.__get__uid() + ".swf")
        {
            __icon = _loc2 + __gcDef.__get__uid() + ".swf";
            this.loadAsset(mc_art, __icon, "cardArt", true);
        } // end if
    } // End of the function
    function gotoAndStop(_frame)
    {
        switch (_frame)
        {
            case "front":
            case "pow":
            case "over":
            {
                this.enableGlow();
                mc_pt._visible = true;
                break;
            } 
            case "disabled":
            {
                this.disableGlow();
                mc_pt._visible = true;
                break;
            } 
        } // End of switch
        super.gotoAndStop(_frame);
    } // End of the function
    function enableGlow()
    {
        if (__gcDef.__get__special() > 0)
        {
            mc_glow.gotoAndPlay("glow_on");
            mc_glow._visible = true;
        }
        else
        {
            this.disableGlow();
        } // end else if
    } // End of the function
    function disableGlow()
    {
        mc_glow._visible = false;
        mc_glow.gotoAndStop("glow_off");
    } // End of the function
    function loadAsset(mc, assetURL, assetName, flagCacheAsBitmap)
    {
        var _loc6 = new Object();
        var _loc11 = new MovieClipLoader();
        assetLoadDone = false;
        if (flagCacheAsBitmap == null || flagCacheAsBitmap == undefined)
        {
            flagCacheAsBitmap = false;
        } // end if
        assetList[assetName] = mc.createEmptyMovieClip(assetName, 1);
        assetList[assetName]._visible = false;
        ++assetLoadingCount;
        _loc6.onLoadInit = com.clubpenguin.util.Delegate.create(mc, handleAssetLoadComplete, flagCacheAsBitmap, assetList[assetName]);
        _loc6.onLoadError = com.clubpenguin.util.Delegate.create(mc, handleAssetLoadError);
        var _loc3 = mc._url.split("/");
        var _loc5 = 1;
        if (assetURL.charAt(0) == "/")
        {
            _loc5 = 2;
            assetURL = assetURL.substr(1);
        } // end if
        var _loc4 = "";
        for (var _loc2 = 0; _loc2 < _loc3.length - _loc5; ++_loc2)
        {
            _loc4 = _loc4 + (_loc3[_loc2] + "/");
        } // end of for
        _loc11.addListener(_loc6);
        _loc11.loadClip(_loc4 + assetURL, assetList[assetName]);
    } // End of the function
    function handleAssetLoadComplete(asset_mc, flagCache)
    {
        if (--assetLoadingCount == 0)
        {
            assetLoadDone = true;
        } // end if
        mc_art.cacheAsBitmap = true;
    } // End of the function
    function handleAssetLoadError()
    {
        if (--assetLoadingCount == 0)
        {
            assetLoadDone = true;
        } // end if
    } // End of the function
    var __init = true;
    static var $_instanceCount = 0;
} // End of Class
