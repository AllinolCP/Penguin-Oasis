class com.clubpenguin.games.cardjitsu.water.uielements.UIDialogGameAward extends com.clubpenguin.games.cardjitsu.water.uielements.UIDialog
{
    var __data, __rank, __gems, __onConfig, sensei_art, btn_ok, stop, __btnFunc, btn_ok_txt;
    function UIDialogGameAward()
    {
        super();
    } // End of the function
    function enableDialog()
    {
        __rank = __data.rankAward;
        __gems = __data.amuletGems;
        switch (__rank)
        {
            case 5:
            {
                __onConfig = awardFinalItemSequence;
                break;
            } 
            default:
            {
                __onConfig = awardItemSequence;
            } 
        } // End of switch
        this.__onConfig();
        sensei_art.speechBubble_mc._visible = true;
        this.setupButton();
    } // End of the function
    function setupButton()
    {
        btn_ok.onRelease = com.clubpenguin.util.Delegate.create(this, handleButtonRelease);
    } // End of the function
    function shown()
    {
        this.stop();
        super.shown();
        this.enableDialog();
    } // End of the function
    function doConfig()
    {
        sensei_art.speechBubble_mc._visible = false;
        this.__onConfig();
    } // End of the function
    function handleButtonRelease()
    {
        if (__btnFunc != null)
        {
            this.__btnFunc();
            __btnFunc = null;
        }
        else
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.DialogEvent(this, com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_DISPATCH, com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_CONTINUE));
        } // end else if
    } // End of the function
    function awardItemSequence()
    {
        sensei_art.items_mc.gotoAndStop("rank" + __rank);
        sensei_art.speechBubble_mc.message.text = com.clubpenguin.lib.locale.LocaleText.getText("text_award" + __rank);
        this.setButtonLabel(com.clubpenguin.lib.locale.LocaleText.getText("ui_btn_ok"));
    } // End of the function
    function setButtonLabel(_str)
    {
        btn_ok_txt.text = _str;
    } // End of the function
    function awardFinalItemSequence()
    {
        sensei_art.items_mc.gotoAndStop("rank" + __rank);
        this.setButtonLabel(com.clubpenguin.lib.locale.LocaleText.getText("ui_btn_next"));
        sensei_art.speechBubble_mc.message.text = com.clubpenguin.lib.locale.LocaleText.getText("text_award5_part1");
        __btnFunc = com.clubpenguin.util.Delegate.create(this, doSequence2Step2);
        var _loc2;
        _loc2 = sensei_art.items_mc.item_art.amulet.icon;
        _loc2.setGems(__gems);
        _loc2.award(com.clubpenguin.games.cardjitsu.amulet.NinjaAmulet.GEM_WATER);
    } // End of the function
    function doSequence2Step2()
    {
        this.setButtonLabel(com.clubpenguin.lib.locale.LocaleText.getText("ui_btn_next"));
        __btnFunc = com.clubpenguin.util.Delegate.create(this, doSequence2Step3);
        sensei_art.speechBubble_mc.message.text = com.clubpenguin.lib.locale.LocaleText.getText("text_award5_part2");
    } // End of the function
    function doSequence2Step3()
    {
        this.setButtonLabel(com.clubpenguin.lib.locale.LocaleText.getText("ui_btn_ok"));
        sensei_art.speechBubble_mc.message.text = com.clubpenguin.lib.locale.LocaleText.getTextReplaced("text_award5_part3", [__data.nickname]);
    } // End of the function
} // End of Class
