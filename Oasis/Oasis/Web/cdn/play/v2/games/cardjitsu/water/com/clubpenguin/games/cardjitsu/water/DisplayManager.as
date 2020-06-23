class com.clubpenguin.games.cardjitsu.water.DisplayManager implements com.clubpenguin.game.engine.IEngineUpdateable
{
    var __worldRoot, __layers, __gameRoot;
    static var __instance;
    function DisplayManager()
    {
    } // End of the function
    static function getInstance()
    {
        if (com.clubpenguin.games.cardjitsu.water.DisplayManager.__instance == null)
        {
            __instance = new com.clubpenguin.games.cardjitsu.water.DisplayManager();
        } // end if
        return (com.clubpenguin.games.cardjitsu.water.DisplayManager.__instance);
    } // End of the function
    function initalize(_world)
    {
        if (_world == undefined)
        {
            return;
        } // end if
        __worldRoot = _world;
        __worldRoot.tabEnabled = false;
        __worldRoot.tabChildren = false;
        Stage.align = "";
        Stage.scaleMode = "showAll";
        __layers = new Array();
        this.createGameRoot();
        this.addLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_SFX);
        this.addLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_BACKGROUND, com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_BACKGROUND);
        this.addLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_BOARD);
        this.addLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_CELL);
        this.addLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_BRIDGE, com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_BRIDGE);
        this.addLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_EFFECT, com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_EFFECT_LAYER);
        this.addLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_PLAYERS, com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_ACTION);
        this.addLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_FOREGROUND, com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_FOREGROUND);
        this.addLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_CARDS);
        this.addLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_UI);
        this.addLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_CURSOR);
    } // End of the function
    static function getDisplayLayer(_layerName)
    {
        return (com.clubpenguin.games.cardjitsu.water.DisplayManager.__instance.getLayer(_layerName));
    } // End of the function
    function getLayer(_layerName)
    {
        return (__layers[_layerName]);
    } // End of the function
    function addLayer(_layerName, _linkage)
    {
        if (__layers[_layerName])
        {
            return;
        }
        else if (_linkage != null)
        {
            __layers[_layerName] = __gameRoot.attachMovie(_linkage, _layerName, __gameRoot.getNextHighestDepth());
        }
        else
        {
            __layers[_layerName] = __gameRoot.createEmptyMovieClip(_layerName, __gameRoot.getNextHighestDepth());
        } // end else if
    } // End of the function
    function toString(Void)
    {
        var _loc2;
        var _loc3;
        _loc3 = new String();
        for (var _loc2 in __layers)
        {
            _loc3 = _loc3 + ("layer[" + _loc2 + "] = " + __layers[_loc2] + "\n");
        } // end of for...in
        return (_loc3);
    } // End of the function
    function createGameRoot(Void)
    {
        __gameRoot = __worldRoot.game_holder;
    } // End of the function
    function getGameRoot(Void)
    {
        return (__gameRoot);
    } // End of the function
    function registerTo(_timer)
    {
        _timer.register(this, com.clubpenguin.games.cardjitsu.water.DisplayManager.$_updateInterval);
    } // End of the function
    function update(_tick, _currUpdate)
    {
    } // End of the function
    function dispose()
    {
        this.removeLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_SFX);
        this.removeLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_BACKGROUND);
        this.removeLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_BOARD);
        this.removeLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_CELL);
        this.removeLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_BRIDGE);
        this.removeLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_EFFECT);
        this.removeLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_PLAYERS);
        this.removeLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_CARDS);
        this.removeLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_UI);
        this.removeLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_CURSOR);
        __layers = null;
        this.destroyGameRoot();
        __worldRoot = null;
    } // End of the function
    function destroyGameRoot()
    {
        __gameRoot = null;
    } // End of the function
    function removeLayer(_layerName)
    {
        if (__layers[_layerName] != null)
        {
            __layers[_layerName].dispose();
            __layers[_layerName].removeMovieClip();
            __layers[_layerName] = null;
        } // end if
    } // End of the function
    static var $_updateInterval = 30;
} // End of Class
