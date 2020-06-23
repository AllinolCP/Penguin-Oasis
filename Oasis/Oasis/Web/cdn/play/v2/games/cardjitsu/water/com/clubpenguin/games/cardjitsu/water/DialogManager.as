class com.clubpenguin.games.cardjitsu.water.DialogManager implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, __displayLayer, __dialogManager, __get__dialogGroup;
    static var __instance, __get__instance;
    function DialogManager()
    {
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.DialogManager.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.DialogManager.$_instanceCount;
        __instance = this;
        this.initializeDialogLayer();
        this.prepareDialogListener();
    } // End of the function
    static function get instance()
    {
        if (com.clubpenguin.games.cardjitsu.water.DialogManager.__instance == null)
        {
            __instance = new com.clubpenguin.games.cardjitsu.water.DialogManager();
        } // end if
        return (com.clubpenguin.games.cardjitsu.water.DialogManager.__instance);
    } // End of the function
    function initializeDialogLayer()
    {
        __displayLayer = com.clubpenguin.games.cardjitsu.water.DisplayManager.getDisplayLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_UI);
        __dialogManager = (com.clubpenguin.games.cardjitsu.water.uielements.UIDialogGroupWater)(__displayLayer.attachMovie(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_DIALOG_MANAGER, "__dialogManager", __displayLayer.getNextHighestDepth()));
    } // End of the function
    function prepareDialogListener()
    {
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_DISPATCH, handleDialogDispatch, this);
    } // End of the function
    function handleDialogDispatch(_eventObj)
    {
        var _loc2;
        _loc2 = String(_eventObj.__get__data());
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.DialogEvent(this, _loc2));
    } // End of the function
    function get dialogGroup()
    {
        return (__dialogManager);
    } // End of the function
    function show(_id, _data)
    {
        this.__get__dialogGroup().show(_id, _data);
    } // End of the function
    function hideAll()
    {
        this.__get__dialogGroup().hideAll();
    } // End of the function
    function getUniqueName()
    {
        return ("[DialogManager<" + __uid + ">]");
    } // End of the function
    function dispose()
    {
        this.destroyDialogListener();
        this.clearDialogLayer();
    } // End of the function
    function clearDialogLayer()
    {
        __dialogManager.removeMovieClip();
        __displayLayer = null;
    } // End of the function
    function destroyDialogListener()
    {
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_DISPATCH, handleDialogDispatch, this);
    } // End of the function
    function setData(_id, _params)
    {
        this.__get__dialogGroup().setData(_id, _params);
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
