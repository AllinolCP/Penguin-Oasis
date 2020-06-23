class com.clubpenguin.hud.phone.view.AgentStatusView extends com.clubpenguin.hud.phone.view.AppView
{
    var itemsList3, itemsList2, itemsList, instructions, itemConfirmation, insufficientPoints, itemExists, agentStatusTitle, fieldOpStatus, localizedAssets, layout, radarAnimation, fieldOpIconAnimation, _visible;
    function AgentStatusView()
    {
        super();
        localizedAssets = [fieldOpStatus, agentStatusTitle, itemExists.itemExistsText, insufficientPoints.insufficientPointsText, itemConfirmation.itemConfirmationText, instructions.instructionsText, itemsList.content, itemsList2.content, itemsList3.content];
        layout = com.clubpenguin.hud.phone.model.PhoneLayout.LANDSCAPE_LARGE;
    } // End of the function
    function open()
    {
        radarAnimation.gotoAndPlay(2);
        fieldOpIconAnimation.gotoAndPlay(2);
        _visible = true;
    } // End of the function
    function close()
    {
        radarAnimation.gotoAndStop(1);
        fieldOpIconAnimation.gotoAndStop(1);
        _visible = false;
    } // End of the function
} // End of Class
