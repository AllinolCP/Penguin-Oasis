class com.clubpenguin.endgame.view.CoinEndGameView extends com.clubpenguin.endgame.view.BaseEndGameView
{
    var coins_mc, _earnedCoinsTxt, _earnedCoinsShadowTxt, _totalCoinsTxt, _currentFrameLabel, _params, _shell;
    function CoinEndGameView()
    {
        super();
    } // End of the function
    function initReferences()
    {
        super.initReferences();
        _earnedCoinsTxt = coins_mc.earned_txt;
        _earnedCoinsShadowTxt = coins_mc.earned_shadow_txt;
        _totalCoinsTxt = coins_mc.total_txt;
        this.setupCoins();
    } // End of the function
    function setupCoins()
    {
        if (_currentFrameLabel == com.clubpenguin.endgame.view.BaseEndGameView.FRAME_HOWTO)
        {
            return;
        } // end if
        var _loc2;
        if (_params.numCompletedStamps == _params.numTotalStamps && _params.numTotalStamps > 0)
        {
            _loc2 = "end_game_coins_earned_double";
            _loc2 = _shell.getLocalizedString(_loc2);
            _loc2 = com.clubpenguin.util.StringUtils.replaceString("%num%", String(_params.earnedCoins / 2), _loc2);
            _loc2 = com.clubpenguin.util.StringUtils.replaceString("%num_x2%", String(_params.earnedCoins), _loc2);
        }
        else
        {
            _loc2 = _params.earnedCoins == 1 ? ("end_game_one_coin_earned") : ("end_game_coins_earned");
            _loc2 = _shell.getLocalizedString(_loc2);
            if (_params.earnedCoins != 1)
            {
                _loc2 = com.clubpenguin.util.StringUtils.replaceString("%num%", String(_params.earnedCoins), _loc2);
            } // end if
        } // end else if
        var _loc3 = _shell.getLocalizedString("end_game_total_coins");
        _loc3 = com.clubpenguin.util.StringUtils.replaceString("%num%", String(_params.totalCoins), _loc3);
        _earnedCoinsTxt.text = _loc2;
        _earnedCoinsShadowTxt.text = _loc2;
        _totalCoinsTxt.text = _loc3;
    } // End of the function
    static var LINKAGE_ID = "com.clubpenguin.endgame.view.CoinEndGameView";
} // End of Class
