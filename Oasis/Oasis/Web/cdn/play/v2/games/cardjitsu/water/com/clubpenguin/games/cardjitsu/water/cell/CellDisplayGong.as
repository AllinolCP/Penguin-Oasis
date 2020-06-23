class com.clubpenguin.games.cardjitsu.water.cell.CellDisplayGong extends com.clubpenguin.games.cardjitsu.water.cell.CellDisplay
{
    var setDataReference, _visible, __uid, stop, player, onEnterFrame, __gameRoot, gong, fg_tsunami, bg_tsunami;
    function CellDisplayGong(Void)
    {
        super();
        this.setDataReference(new com.clubpenguin.games.cardjitsu.water.cell.CellDataGong());
        _visible = true;
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.cell.CellDisplayGong.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.cell.CellDisplayGong.$_instanceCount;
        this.stop();
        player._visible = false;
        player.gotoAndStop(com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_EMPTY_LETTER);
        onEnterFrame = checkInit;
        __gameRoot = com.clubpenguin.games.cardjitsu.water.DisplayManager.getInstance().getGameRoot();
    } // End of the function
    function getUniqueName()
    {
        return ("[CellDisplayGong<" + __uid + ">]");
    } // End of the function
    function checkInit()
    {
        delete this.onEnterFrame;
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.ClipEvent(this, com.clubpenguin.lib.event.ClipEvent.RENDERED));
    } // End of the function
    function getCoordinate()
    {
        return (new flash.geom.Point(92, 64));
    } // End of the function
    function celebrateVictory()
    {
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_KICK_GONG, onPlayerKickGong, this, player.character);
        player.celebrateVictory();
    } // End of the function
    function onPlayerKickGong()
    {
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_KICK_GONG, onPlayerKickGong, this);
        gong.trigger("kicked");
    } // End of the function
    function onPlayerWinComplete()
    {
        fg_tsunami.trigger();
        bg_tsunami.trigger();
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.TsunamiEvent.SWING_GONG, onSwingGong, this, bg_tsunami);
        com.clubpenguin.games.cardjitsu.water.SoundManager.getInstance().add("sfx_bigwave", 1, 100);
    } // End of the function
    function onSwingGong()
    {
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.TsunamiEvent.SWING_GONG, onSwingGong, this);
        gong.trigger("swing");
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
