﻿class com.clubpenguin.ui.PaperDoll
{
    var __get__paperDollClip, __get__colourID, __get__flagID, __get__backgroundID, __set__flagID, __set__backgroundID, __get__flagPath, __get__backgroundPath, __get__paperdollPath, __get__shell, __get__ui, __get__flagClip, __get__backgroundClip, __get__isInteractive, __get__fadeAfterLoad, __set__backgroundClip, __set__colourID, __set__fadeAfterLoad, __set__flagClip, __set__isInteractive, __set__paperDollClip, __set__shell, __set__ui;
    function PaperDoll()
    {
        _testContainer = _paperDollClip;
    } // End of the function
    function duplicate(target)
    {
        if (this.__get__paperDollClip() == null || target.__get__paperDollClip() == null)
        {
            return;
        } // end if
        target.__set__colourID(this.__get__colourID());
        target.__set__flagID(this.__get__flagID());
        target.__set__backgroundID(this.__get__backgroundID());
        for (var _loc4 in _paperDollClip)
        {
            if (typeof(_paperDollClip[_loc4]) == "movieclip" && _loc4.substr(0, com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX.length) == com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX)
            {
                var _loc2 = _paperDollClip[_loc4];
                target.addItem(_loc2.type, _loc2.id);
            } // end if
        } // end of for...in
    } // End of the function
    function clear()
    {
        if (this.__get__paperDollClip() == null)
        {
            return;
        } // end if
        for (var _loc3 in _paperDollClip)
        {
            if (typeof(_paperDollClip[_loc3]) == "movieclip" && _loc3.substr(0, com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX.length) == com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX)
            {
                var _loc2 = _paperDollClip[_loc3];
                _loc2.removeMovieClip();
            } // end if
        } // end of for...in
        this.__set__flagID(0);
        this.__set__backgroundID(0);
    } // End of the function
    function set flagID(id)
    {
        if (_flagClip == undefined)
        {
            return;
        } // end if
        if (id != undefined && id != _flagClip.flag_id)
        {
            removeMovieClip (_flagClip[com.clubpenguin.ui.PaperDoll.ART_CLIP_NAME]);
            if (id > 0)
            {
                _flagClip.createEmptyMovieClip(com.clubpenguin.ui.PaperDoll.ART_CLIP_NAME, 1);
                _flagClip[com.clubpenguin.ui.PaperDoll.ART_CLIP_NAME]._xscale = com.clubpenguin.ui.PaperDoll.FLAG_SCALE;
                _flagClip[com.clubpenguin.ui.PaperDoll.ART_CLIP_NAME]._yscale = com.clubpenguin.ui.PaperDoll.FLAG_SCALE;
                var _loc4 = this.__get__flagPath() + id + ".swf";
                var _loc3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, itemLoadInit));
                _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, itemLoadStart));
                _loc3.loadClip(_loc4, _flagClip[com.clubpenguin.ui.PaperDoll.ART_CLIP_NAME]);
            } // end if
            _flagClip.flag_id = id;
        } // end if
        this.updateFlagInteractivity();
        //return (this.flagID());
        null;
    } // End of the function
    function get flagID()
    {
        return (_flagClip.flag_id);
    } // End of the function
    function set backgroundID(id)
    {
        if (_backgroundClip == undefined)
        {
            return;
        } // end if
        if (id != undefined && id != _backgroundClip.photo_id)
        {
            removeMovieClip (_backgroundClip[com.clubpenguin.ui.PaperDoll.ART_CLIP_NAME]);
            if (id > 0)
            {
                _backgroundClip.createEmptyMovieClip(com.clubpenguin.ui.PaperDoll.ART_CLIP_NAME, 1);
                var _loc4 = this.__get__backgroundPath() + id + ".swf";
                var _loc3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, itemLoadInit));
                _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, itemLoadStart));
                _loc3.loadClip(_loc4, _backgroundClip[com.clubpenguin.ui.PaperDoll.ART_CLIP_NAME]);
                if (com.clubpenguin.hybrid.AS3Manager.isUnderAS3())
                {
                    _backgroundClip[com.clubpenguin.ui.PaperDoll.ART_CLIP_NAME]._visible = true;
                    _backgroundClip[com.clubpenguin.ui.PaperDoll.ART_CLIP_NAME]._alpha = 100;
                } // end if
            } // end if
            _backgroundClip.photo_id = id;
        } // end if
        this.updateBackgroundInteractivity();
        //return (this.backgroundID());
        null;
    } // End of the function
    function get backgroundID()
    {
        return (_backgroundClip.photo_id);
    } // End of the function
    function addItem(type, id)
    {
        if (_paperDollClip == null || type == null || id == null)
        {
            return;
        } // end if
        var _loc4 = _paperDollClip[com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX + type + com.clubpenguin.ui.PaperDoll.ATTACH_SUFFIX];
        var _loc6 = _loc4.id;
        if (id == _loc6)
        {
            return;
        } // end if
        var _loc8 = _shell.getInventoryCrumbsObject();
        var _loc7;
        if (_loc8[id].customDepth != undefined)
        {
            _loc7 = _loc8[id].customDepth;
        }
        else
        {
            _loc7 = this.getClothingDepth(type);
        } // end else if
        _loc4.removeMovieClip();
        _loc4 = _paperDollClip.createEmptyMovieClip(com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX + type + com.clubpenguin.ui.PaperDoll.ATTACH_SUFFIX, _loc7);
        var _loc11 = _loc4.createEmptyMovieClip("itemClip", _loc4.getNextHighestDepth());
        _loc4.type = type;
        _loc4.id = id;
        if (type != com.clubpenguin.ui.PaperDoll.BACK_LAYER_NAME && _shell.getInventoryObjectById(id).is_back)
        {
            this.addItem(com.clubpenguin.ui.PaperDoll.BACK_LAYER_NAME, id);
            var _loc10 = _paperDollClip[com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX + com.clubpenguin.ui.PaperDoll.BACK_LAYER_NAME + com.clubpenguin.ui.PaperDoll.ATTACH_SUFFIX];
            _loc10.parentType = type;
        }
        else if (type != com.clubpenguin.ui.PaperDoll.BACK_LAYER_NAME && _shell.getInventoryObjectById(_loc6).is_back)
        {
            this.addItem(com.clubpenguin.ui.PaperDoll.BACK_LAYER_NAME, 0);
        } // end else if
        if (id > 0)
        {
            var _loc9;
            if (type == com.clubpenguin.ui.PaperDoll.BACK_LAYER_NAME)
            {
                _loc9 = id + "_back.swf";
            }
            else
            {
                _loc9 = id + ".swf";
            } // end else if
            var _loc5 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _loc5.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, itemLoadInit));
            _loc5.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, itemLoadStart));
            _loc5.loadClip(this.__get__paperdollPath() + _loc9, _loc11);
        } // end if
        this.updateItemInteractivity(type);
    } // End of the function
    function itemLoadInit(event)
    {
        var targetClip = event.target;
        if (_fadeAfterLoad)
        {
            targetClip._alpha = com.clubpenguin.ui.PaperDoll.FADE_IN_ALPHA_START;
            targetClip.onEnterFrame = function ()
            {
                targetClip._alpha = targetClip._alpha + com.clubpenguin.ui.PaperDoll.FADE_IN_ALPHA_STEP;
                if (targetClip._alpha >= com.clubpenguin.ui.PaperDoll.FADE_IN_ALPHA_END)
                {
                    delete targetClip.onEnterFrame;
                } // end if
            };
        }
        else
        {
            targetClip._alpha = 100;
        } // end else if
    } // End of the function
    function itemLoadStart(event)
    {
        event.target._alpha = 0;
    } // End of the function
    function getClothingDepth(type)
    {
        var _loc2 = _layerDepths[type];
        if (_loc2 == null)
        {
            _shell.$e("[login] getClothingDepth() -> Invalid clothing type");
            _loc2 = _layerDepths.body;
        } // end if
        return (_loc2);
    } // End of the function
    function set shell(currentShell)
    {
        _shell = currentShell;
        _layerDepths = _shell.PAPERDOLL_DEFAULT_LAYER_DEPTHS;
        //return (this.shell());
        null;
    } // End of the function
    function set ui(currentInterface)
    {
        _interface = currentInterface;
        //return (this.ui());
        null;
    } // End of the function
    function set colourID(id)
    {
        if (_paperDollClip != null)
        {
            _colourID = id;
            var _loc2 = Number(_shell.getPlayerHexFromId(id));
            if (_loc2 != -1)
            {
                _shell.setColourFromHex(_paperDollClip.body, Number(_loc2));
            } // end if
        } // end if
        //return (this.colourID());
        null;
    } // End of the function
    function get colourID()
    {
        if (_paperDollClip != null)
        {
            return (_colourID);
        } // end if
        return (null);
    } // End of the function
    function get flagClip()
    {
        return (_flagClip);
    } // End of the function
    function set flagClip(targetClip)
    {
        if (_flagClip != targetClip)
        {
            _flagClip = targetClip;
        } // end if
        //return (this.flagClip());
        null;
    } // End of the function
    function get backgroundClip()
    {
        return (_backgroundClip);
    } // End of the function
    function set backgroundClip(targetClip)
    {
        if (_backgroundClip != targetClip)
        {
            _backgroundClip = targetClip;
        } // end if
        //return (this.backgroundClip());
        null;
    } // End of the function
    function set isInteractive(interactive)
    {
        if (_isInteractive == interactive)
        {
            return;
        } // end if
        _isInteractive = interactive;
        this.updateFlagInteractivity();
        this.updateBackgroundInteractivity();
        this.updateAllItemsInteractivity();
        //return (this.isInteractive());
        null;
    } // End of the function
    function updateFlagInteractivity()
    {
        if (_flagClip == undefined)
        {
            return;
        } // end if
        if (_isInteractive && _flagClip.flag_id > 0)
        {
            _flagClip.useHandCursor = true;
            _flagClip.onRelease = com.clubpenguin.util.Delegate.create(this, onRemoveItem, "flag_id");
        }
        else
        {
            _flagClip.useHandCursor = false;
            _flagClip.onRelease = null;
        } // end else if
    } // End of the function
    function updateBackgroundInteractivity()
    {
        if (_backgroundClip == undefined)
        {
            return;
        } // end if
        if (_isInteractive && _backgroundClip.photo_id > 0)
        {
            _backgroundClip.useHandCursor = true;
            _backgroundClip.onRelease = com.clubpenguin.util.Delegate.create(this, onRemoveItem, "photo_id");
            _paperDollClip.body.useHandCursor = false;
            _paperDollClip.body.onRelease = function ()
            {
            };
            _paperDollClip.outline.useHandCursor = false;
            _paperDollClip.outline.onRelease = function ()
            {
            };
        }
        else
        {
            _backgroundClip.useHandCursor = false;
            _backgroundClip.onRelease = null;
        } // end else if
    } // End of the function
    function updateItemInteractivity(type)
    {
        if (this.__get__paperDollClip() == null)
        {
            return;
        } // end if
        var _loc2 = _paperDollClip[com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX + type + com.clubpenguin.ui.PaperDoll.ATTACH_SUFFIX];
        if (_loc2 == null)
        {
            return;
        } // end if
        if (_isInteractive)
        {
            _loc2.onRelease = com.clubpenguin.util.Delegate.create(this, onRemoveItem, type);
        }
        else
        {
            delete _loc2.onRelease;
        } // end else if
    } // End of the function
    function updateAllItemsInteractivity()
    {
        if (this.__get__paperDollClip() == null)
        {
            return;
        } // end if
        for (var _loc4 in _paperDollClip)
        {
            if (typeof(_paperDollClip[_loc4]) == "movieclip" && _loc4.substr(0, com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX.length) == com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX)
            {
                var _loc2 = _paperDollClip[_loc4];
                if (_isInteractive)
                {
                    var _loc3 = _loc4.substr(com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX.length, _loc4.length - com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX.length - com.clubpenguin.ui.PaperDoll.ATTACH_SUFFIX.length);
                    _loc2.onRelease = com.clubpenguin.util.Delegate.create(this, onRemoveItem, _loc3);
                    continue;
                } // end if
                delete _loc2.onRelease;
            } // end if
        } // end of for...in
    } // End of the function
    function onRemoveItem(type)
    {
        if (type == com.clubpenguin.ui.PaperDoll.BACK_LAYER_NAME)
        {
            var _loc3 = _paperDollClip[com.clubpenguin.ui.PaperDoll.ATTACH_PREFIX + com.clubpenguin.ui.PaperDoll.BACK_LAYER_NAME + com.clubpenguin.ui.PaperDoll.ATTACH_SUFFIX];
            type = _loc3.parentType;
        } // end if
        if (type != null)
        {
            _interface.clickPlayerWidgetRemoveItem(type);
            this.doTestForBackgrounds(type);
        } // end if
    } // End of the function
    function doTestForBackgrounds(type)
    {
        if (com.clubpenguin.hybrid.AS3Manager.isUnderAS3() && (type == com.clubpenguin.ui.PaperDoll.PHOTO_ID || type == com.clubpenguin.ui.PaperDoll.FLAG_ID))
        {
            var _loc2 = type == com.clubpenguin.ui.PaperDoll.PHOTO_ID ? (_backgroundClip[com.clubpenguin.ui.PaperDoll.ART_CLIP_NAME]) : (_flagClip[com.clubpenguin.ui.PaperDoll.ART_CLIP_NAME]);
            _loc2._alpha = 0;
            _loc2._visible = false;
        } // end if
    } // End of the function
    function get paperDollClip()
    {
        return (_paperDollClip);
    } // End of the function
    function set paperDollClip(targetClip)
    {
        if (_paperDollClip != targetClip)
        {
            _paperDollClip = targetClip;
            _colourID = null;
        } // end if
        //return (this.paperDollClip());
        null;
    } // End of the function
    function set fadeAfterLoad(fadeIn)
    {
        _fadeAfterLoad = fadeIn;
        //return (this.fadeAfterLoad());
        null;
    } // End of the function
    function get paperdollPath()
    {
        if (_paperdollPath == null)
        {
            _paperdollPath = _shell.getPath("clothing_paper");
        } // end if
        return (_paperdollPath);
    } // End of the function
    function get flagPath()
    {
        if (_flagPath == null)
        {
            _flagPath = _shell.getPath("clothing_icons");
        } // end if
        return (_flagPath);
    } // End of the function
    function get backgroundPath()
    {
        if (_backgroundPath == null)
        {
            _backgroundPath = _shell.getPath("clothing_photos");
        } // end if
        return (_backgroundPath);
    } // End of the function
    static var ATTACH_PREFIX = "pd_";
    static var ATTACH_SUFFIX = "Clip";
    static var ART_CLIP_NAME = "art_mc";
    static var BACK_LAYER_NAME = "back";
    static var FLAG_SCALE = 66;
    static var FADE_IN_ALPHA_START = 0;
    static var FADE_IN_ALPHA_END = 100;
    static var FADE_IN_ALPHA_STEP = 20;
    static var PAPER_DOLL_IN_GAME = "paper_doll_mc";
    static var PHOTO_ID = "photo_id";
    static var FLAG_ID = "flag_id";
    var _paperDollClip = null;
    var _flagClip = null;
    var _backgroundClip = null;
    var _paperdollPath = null;
    var _flagPath = null;
    var _backgroundPath = null;
    var _fadeAfterLoad = false;
    var _isInteractive = false;
    var _shell = null;
    var _interface = null;
    var _colourID = null;
    var _layerDepths = null;
    var _loadInterval = null;
    var _iterations = null;
    var _mcl = null;
    var _listener = null;
    var _delayInterval = null;
    var _testContainer = null;
} // End of Class
