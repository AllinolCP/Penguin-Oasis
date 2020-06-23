class com.clubpenguin.games.cardjitsu.water.uielements.UIDialogGameOverDisconnect extends com.clubpenguin.games.cardjitsu.water.uielements.UIDialog
{
    var title_txt, btn_ok_txt, btn_ok;
    function UIDialogGameOverDisconnect()
    {
        super();
    } // End of the function
    function handleButtonRelease()
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.DialogEvent(this, com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_DISPATCH, com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_CONTINUE));
    } // End of the function
    function shown()
    {
        super.shown();
        title_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("text_abort_game");
        btn_ok_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("ui_btn_ok");
        btn_ok.onRelease = com.clubpenguin.util.Delegate.create(this, handleButtonRelease);
    } // End of the function
} // End of Class
