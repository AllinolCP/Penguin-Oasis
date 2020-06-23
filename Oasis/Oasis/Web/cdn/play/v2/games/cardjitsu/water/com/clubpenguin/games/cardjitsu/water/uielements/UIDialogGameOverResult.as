class com.clubpenguin.games.cardjitsu.water.uielements.UIDialogGameOverResult extends com.clubpenguin.games.cardjitsu.water.uielements.UIDialog
{
    var __data, __finishPosition, __vsSensei, scrollImage_mc, starAnim_mc, btn_ok, btn_ok_txt;
    function UIDialogGameOverResult()
    {
        super();
    } // End of the function
    function handleButtonRelease()
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.DialogEvent(this, com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_DISPATCH, com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_CONTINUE));
    } // End of the function
    function onShowConfig()
    {
        __finishPosition = Number(__data.position);
        var _loc2;
        _loc2 = __finishPosition + 1;
        __vsSensei = __data.vsSensei;
        scrollImage_mc.gotoAndStop(_loc2);
        starAnim_mc.gotoAndStop(_loc2);
        var _loc3;
        _loc3 = com.clubpenguin.lib.locale.LocaleText.getText("ui_after_num" + __finishPosition);
        if (!__vsSensei || __finishPosition == 0)
        {
            scrollImage_mc.title_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("ui_dialog_title" + __finishPosition);
            scrollImage_mc.message_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("ui_dialog_haiku" + __finishPosition);
        }
        else
        {
            scrollImage_mc.title_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("ui_dialog_title_lose_to_sensei");
            scrollImage_mc.message_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("ui_dialog_haiku_lose_to_sensei");
        } // end else if
        starAnim_mc.star_mc.superScript_mc.text_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("ui_after_num" + __finishPosition);
        btn_ok = scrollImage_mc.btn_ok;
        btn_ok_txt = scrollImage_mc.btn_ok_txt;
        btn_ok_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("ui_btn_ok");
        btn_ok.onRelease = com.clubpenguin.util.Delegate.create(this, handleButtonRelease);
    } // End of the function
} // End of Class
