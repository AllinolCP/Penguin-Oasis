class com.clubpenguin.games.cardjitsu.water.uielements.UIDialogGameStart extends com.clubpenguin.games.cardjitsu.water.uielements.UIDialog
{
    var number_txt, title_txt, step1_txt, step2_txt, step3_txt;
    function UIDialogGameStart()
    {
        super();
        this.setupText();
    } // End of the function
    function setData(_params)
    {
        this.setCountDown(String(_params));
    } // End of the function
    function setCountDown(tick)
    {
        number_txt.text = tick;
    } // End of the function
    function setupText()
    {
        title_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("ui_dialog_instructions_title");
        step1_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("ui_dialog_instructions_step1");
        step2_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("ui_dialog_instructions_step2");
        step3_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("ui_dialog_instructions_step3");
    } // End of the function
} // End of Class
