class com.clubpenguin.hud.phone.mediator.HUDIconMediator
{
    var view, phoneOpened, context, fieldOpStatus;
    function HUDIconMediator(hudIconView, context)
    {
        view = hudIconView;
        phoneOpened = context.phoneOpened;
        this.context = context;
        context.phoneClosed.add(onPhoneClosed, this);
        context.epfService.__get__fieldOpStatusReceived().add(onFieldOpStatusReceived, this);
        context.fieldOpTriggered.add(onFieldOpTriggered, this);
        context.ENGINE.playerMoved.add(onPlayerMoved, this);
        context.SHELL.playerJoinedRoom.add(onPlayerJoinedRoom, this);
        view.onPress = com.clubpenguin.util.Delegate.create(this, onHudIconPressed);
        view.onRollOver = com.clubpenguin.util.Delegate.create(this, onHudIconRollOver);
        view.onRollOut = com.clubpenguin.util.Delegate.create(this, onHudIconRollOut);
    } // End of the function
    function onHudIconRollOver()
    {
        view.epf_icon_mc.gotoAndStop("_over");
    } // End of the function
    function onHudIconRollOut()
    {
        view.epf_icon_mc.gotoAndStop("_up");
    } // End of the function
    function onHudIconPressed()
    {
        this.onHudIconRollOut();
        view._visible = false;
        phoneOpened.dispatch();
    } // End of the function
    function onPlayerJoinedRoom()
    {
        view.gotoAndStop(com.clubpenguin.hud.phone.mediator.HUDIconMediator.NORMAL_FRAME);
    } // End of the function
    function onPhoneClosed()
    {
        view._visible = true;
        if (!context.ENGINE.isPlayerOnFieldOpTrigger())
        {
            view.gotoAndStop(com.clubpenguin.hud.phone.mediator.HUDIconMediator.NORMAL_FRAME);
        } // end if
    } // End of the function
    function onFieldOpStatusReceived(fieldOpStatus)
    {
        this.fieldOpStatus = fieldOpStatus;
        switch (fieldOpStatus)
        {
            case com.clubpenguin.hud.phone.model.FieldOpStatus.PENDING:
            {
                view.gotoAndStop(com.clubpenguin.hud.phone.mediator.HUDIconMediator.ALERT_FRAME);
                break;
            } 
            default:
            {
                view.gotoAndStop(com.clubpenguin.hud.phone.mediator.HUDIconMediator.NORMAL_FRAME);
            } 
        } // End of switch
    } // End of the function
    function onFieldOpTriggered()
    {
        view.gotoAndStop(com.clubpenguin.hud.phone.mediator.HUDIconMediator.FIELDOP_FRAME);
    } // End of the function
    function onPlayerMoved()
    {
        this.onFieldOpStatusReceived(fieldOpStatus);
    } // End of the function
    static var ALERT_FRAME = "alert";
    static var NORMAL_FRAME = "normal";
    static var FIELDOP_FRAME = "fieldop";
} // End of Class
