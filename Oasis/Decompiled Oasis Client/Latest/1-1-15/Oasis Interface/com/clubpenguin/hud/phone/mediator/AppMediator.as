class com.clubpenguin.hud.phone.mediator.AppMediator
{
    var view, appClosed;
    function AppMediator(view, appClosed, languageCode)
    {
        this.view = view;
        view.close();
        view.closed.add(onClosed, this);
        this.appClosed = appClosed;
        this.setLanguageCode(languageCode);
    } // End of the function
    function setLanguageCode(code)
    {
        for (var _loc2 = 0; _loc2 < view.localizedAssets.length; ++_loc2)
        {
            (MovieClip)(view.localizedAssets[_loc2]).gotoAndStop(code);
        } // end of for
    } // End of the function
    function onClosed()
    {
        appClosed.dispatch(view._name);
    } // End of the function
    static var DELAY_AMOUNT = 500;
} // End of Class
