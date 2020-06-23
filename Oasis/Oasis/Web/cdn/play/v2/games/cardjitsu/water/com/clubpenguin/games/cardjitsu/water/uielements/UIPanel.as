class com.clubpenguin.games.cardjitsu.water.uielements.UIPanel extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, __onActionComplete, __hideCompleteCallback, __init, __rendered, onEnterFrame, __data, _visible, _totalframes, __showing, __shown, __hiding, gotoAndPlay, __hidden, stop, __get__isDialog, __get__rendered;
    function UIPanel()
    {
        super();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.uielements.UIPanel.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.uielements.UIPanel.$_instanceCount;
        __onActionComplete = null;
        __hideCompleteCallback = null;
        __init = true;
        __rendered = false;
        this.hidden();
        onEnterFrame = checkInit;
    } // End of the function
    function checkInit()
    {
        if (__init)
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.ClipEvent(this, com.clubpenguin.lib.event.ClipEvent.RENDERED));
            __init = false;
            __rendered = true;
            delete this.onEnterFrame;
        } // end if
    } // End of the function
    function get rendered()
    {
        return (__rendered);
    } // End of the function
    function get isDialog()
    {
        return (true);
    } // End of the function
    function show(_data)
    {
        __data = _data;
        _visible = true;
        if (_totalframes > 1)
        {
            if (!__showing && !__shown && !__hiding)
            {
                __showing = true;
                this.gotoAndPlay("show");
            } // end if
        }
        else
        {
            this.shown();
        } // end else if
    } // End of the function
    function hide(_hideCompleteCallback)
    {
        if (_hideCompleteCallback != null)
        {
            __hideCompleteCallback = _hideCompleteCallback;
        } // end if
        if (!__hidden && !__showing && !__hiding)
        {
            if (_totalframes > 1)
            {
                __hiding = true;
                this.gotoAndPlay("hide");
            }
            else
            {
                this.hidden();
            } // end else if
        }
        else if (!__hidden)
        {
            __onActionComplete = com.clubpenguin.util.Delegate.create(this, nextHide);
        } // end else if
    } // End of the function
    function nextHide()
    {
        __onActionComplete = null;
        this.hide(__hideCompleteCallback);
    } // End of the function
    function enableDialog()
    {
    } // End of the function
    function disableDialog()
    {
    } // End of the function
    function shown()
    {
        var _loc2;
        this.stop();
        __hiding = false;
        __hidden = false;
        __showing = false;
        __shown = true;
        _loc2 = __onActionComplete;
        __onActionComplete = null;
        if (_loc2 != null)
        {
            _loc2();
        } // end if
    } // End of the function
    function hidden()
    {
        var _loc2;
        this.stop();
        _visible = false;
        __shown = false;
        __showing = false;
        __hiding = false;
        __hidden = true;
        _loc2 = __onActionComplete;
        __onActionComplete = null;
        if (_loc2 != null)
        {
            _loc2();
        }
        else
        {
            _loc2 = __hideCompleteCallback;
            __hideCompleteCallback = null;
            if (_loc2 != null)
            {
                _loc2();
            } // end if
        } // end else if
    } // End of the function
    function getUniqueName()
    {
        return ("[UIPanel<" + __uid + ">]");
    } // End of the function
    function setData(params)
    {
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
