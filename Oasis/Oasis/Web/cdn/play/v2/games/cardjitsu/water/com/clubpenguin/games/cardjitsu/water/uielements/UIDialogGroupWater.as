class com.clubpenguin.games.cardjitsu.water.uielements.UIDialogGroupWater extends com.clubpenguin.games.cardjitsu.water.uielements.UIDialogGroup
{
    var __availableDialogs, __totalDialogs, _visible, uiDialogGameOverDisconnect_mc, uiDialogGameWon_mc, uiDialogGameFailed_mc, uiDialogGameOverLose_mc, uiDialogGameStart_mc, uiDialogGameOverResult_mc, uiDialogGameOverAward_mc, uiDialogError_mc, __activeDialog;
    function UIDialogGroupWater()
    {
        super();
        __availableDialogs = 0;
        __totalDialogs = 2;
        _visible = false;
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.event.ClipEvent.RENDERED, onDialogRendered, this);
    } // End of the function
    function onDialogRendered(_eventObj)
    {
        var _loc2;
        _loc2 = (com.clubpenguin.games.cardjitsu.water.uielements.UIDialog)(_eventObj.__get__target());
        if (_loc2 != null)
        {
            ++__availableDialogs;
            if (__availableDialogs == __totalDialogs)
            {
                _visible = true;
                com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.DialogEvent(this, com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_READY));
            } // end if
        } // end if
    } // End of the function
    function getDialogByID(_dlgID)
    {
        var _loc2;
        switch (_dlgID)
        {
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_DICSONNECT:
            {
                _loc2 = uiDialogGameOverDisconnect_mc;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_WON:
            {
                _loc2 = uiDialogGameWon_mc;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_FAILED:
            {
                _loc2 = uiDialogGameFailed_mc;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_OVER_LOSE:
            {
                _loc2 = uiDialogGameOverLose_mc;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_START:
            {
                _loc2 = uiDialogGameStart_mc;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_OVER_RESULT:
            {
                _loc2 = uiDialogGameOverResult_mc;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_OVER_AWARD:
            {
                _loc2 = uiDialogGameOverAward_mc;
                break;
            } 
            default:
            {
                _loc2 = uiDialogError_mc;
            } 
        } // End of switch
        return (_loc2);
    } // End of the function
    function hideAll()
    {
        uiDialogGameOverResult_mc.hide();
        uiDialogGameOverAward_mc.hide();
        uiDialogGameOverDisconnect_mc.hide();
        uiDialogGameWon_mc.hide();
        uiDialogGameFailed_mc.hide();
        uiDialogGameOverLose_mc.hide();
        uiDialogGameStart_mc.hide();
        __activeDialog = null;
    } // End of the function
    function setTitle(_msg)
    {
        __activeDialog.title_txt.text = _msg;
    } // End of the function
    static var dlg = ["GAME_START", "GAME_OVER_LOSE", "GAME_FAILED", "GAME_WON", "GAME_OVER_RESULT", "GAME_OVER_AWARD", "GAME_DISCONNECT"];
} // End of Class
