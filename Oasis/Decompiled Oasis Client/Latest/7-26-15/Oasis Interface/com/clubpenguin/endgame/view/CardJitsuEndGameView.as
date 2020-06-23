class com.clubpenguin.endgame.view.CardJitsuEndGameView extends com.clubpenguin.endgame.view.BaseEndGameView
{
    var _shell, _model;
    function CardJitsuEndGameView()
    {
        super();
    } // End of the function
    function createCongratsMessage()
    {
        var _loc2 = _shell.getLocalizedString("end_game_no_coins_congrats");
        _loc2 = com.clubpenguin.util.StringUtils.replaceString("%game_name%", String(_model.__get__gameName()), _loc2);
        return (_loc2);
    } // End of the function
    static var LINKAGE_ID = "com.clubpenguin.endgame.view.CardJitsuEndGameView";
} // End of Class
