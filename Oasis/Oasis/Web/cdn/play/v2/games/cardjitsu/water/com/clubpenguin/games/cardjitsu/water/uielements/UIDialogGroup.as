class com.clubpenguin.games.cardjitsu.water.uielements.UIDialogGroup extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, __passthroughData, __nextDialog, __activeDialog, __get__busy;
    function UIDialogGroup()
    {
        super();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.uielements.UIDialogGroup.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.uielements.UIDialogGroup.$_instanceCount;
        this.hideAll();
    } // End of the function
    function hideAll()
    {
    } // End of the function
    function show(_dlgID, _passthroughData)
    {
        __passthroughData = _passthroughData;
        __nextDialog = this.getDialogByID(_dlgID);
        if (__activeDialog != null && __activeDialog != __nextDialog)
        {
            __activeDialog.hide(com.clubpenguin.util.Delegate.create(this, showAfterHide));
        }
        else
        {
            this.showAfterHide();
        } // end else if
    } // End of the function
    function showAfterHide()
    {
        __activeDialog = __nextDialog;
        __nextDialog = null;
        __activeDialog.show(__passthroughData);
    } // End of the function
    function get busy()
    {
        return (__nextDialog != null);
    } // End of the function
    function getDialogByID(_dlgID)
    {
        var _loc1;
        return (_loc1);
    } // End of the function
    function getUniqueName()
    {
        return ("[UIDialogGroup<" + __uid + ">]");
    } // End of the function
    function setData(_id, _params)
    {
        var _loc2 = this.getDialogByID(_id);
        _loc2.setData(_params);
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
