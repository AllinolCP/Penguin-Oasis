class com.clubpenguin.games.cardjitsu.water.cell.CellRow extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher, com.clubpenguin.game.engine.IEngineUpdateable
{
    var __uid, _visible, __index, __cells, __unusedCells, __maxCells, __get__index, getNextHighestDepth, attachMovie, __rowPosition, _y, _x, swapDepths, __rowLocation, __set__index, __get__location;
    static var $_vectorFragment;
    function CellRow()
    {
        super();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.cell.CellRow.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.cell.CellRow.$_instanceCount;
        _visible = false;
        __index = 0;
        __cells = new Array();
        __unusedCells = 0;
        com.clubpenguin.ProjectGlobals.__get__host().register(this, com.clubpenguin.games.cardjitsu.water.cell.CellRow.$_updateFrequency);
    } // End of the function
    function getUniqueName()
    {
        return ("[CellRow<" + __uid + ">]");
    } // End of the function
    static function updateVector(_controlVector)
    {
        $_vectorFragment = _controlVector.clone();
        var _loc1;
        var _loc2;
        _loc1 = com.clubpenguin.games.cardjitsu.water.cell.CellRow.$_vectorFragment.length / com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_SECOND;
        _loc2 = com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_SECOND / com.clubpenguin.games.cardjitsu.water.cell.CellRow.$_updateFrequency;
        com.clubpenguin.games.cardjitsu.water.cell.CellRow.$_vectorFragment.normalize(_loc1);
        com.clubpenguin.games.cardjitsu.water.cell.CellRow.$_vectorFragment.normalize(com.clubpenguin.games.cardjitsu.water.cell.CellRow.$_vectorFragment.length / _loc2);
    } // End of the function
    function configRow(_cellData)
    {
        __maxCells = _cellData.length;
        if (__cells.length == 0)
        {
            this.makeCells(__maxCells);
        } // end if
        this.populateCells(_cellData);
        this.setupListeners();
    } // End of the function
    function set index(_val)
    {
        __index = _val;
        //return (this.index());
        null;
    } // End of the function
    function get index()
    {
        return (__index);
    } // End of the function
    function makeCells(_qty)
    {
        var _loc4;
        var _loc2;
        var _loc3;
        for (var _loc4 = 1; _loc4 <= _qty; ++_loc4)
        {
            _loc3 = _qty - _loc4;
            _loc2 = (com.clubpenguin.games.cardjitsu.water.cell.CellDisplay)(this.attachMovie(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_CELL, "cell" + (100 + __index * 100) + _loc3, this.getNextHighestDepth()));
            _loc2._x = _loc3 * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_WIDTH / 2;
            _loc2._y = -_loc3 * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_HEIGHT / 2;
            __cells.unshift(_loc2);
            ++__unusedCells;
        } // end of for
    } // End of the function
    function populateCells(_cellData)
    {
        var _loc2;
        var _loc3;
        for (var _loc2 = 0; _loc2 < _cellData.length; ++_loc2)
        {
            _loc3 = this["cell" + (100 + __index * 100) + _loc2];
            _loc3.setDataReference(_cellData[_loc2], this, _loc2);
            --__unusedCells;
        } // end of for
    } // End of the function
    function setupListeners()
    {
    } // End of the function
    function update(_tick, _currUpdate)
    {
        __rowPosition = __rowPosition.add(com.clubpenguin.games.cardjitsu.water.cell.CellRow.$_vectorFragment);
        this.setPosition();
    } // End of the function
    function getCoordinate(Void)
    {
        return (new flash.geom.Point(_x, _y));
    } // End of the function
    function setLocation(_locY, _locX)
    {
        var _loc2;
        var _loc3;
        _loc2 = _locY * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_WIDTH / 2;
        _loc3 = _locY * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_HEIGHT / 2;
        _loc2 = _loc2 + _locY * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_PADDINGW;
        _loc3 = _loc3 + _locY * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_PADDINGH;
        _loc2 = _loc2 + com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_LEFT;
        _loc3 = _loc3 + com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_TOP;
        if (__maxCells == com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_COLS_MIN)
        {
            _loc2 = _loc2 + (com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_WIDTH / 2 + com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_PADDINGW);
            _loc3 = _loc3 - (com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_HEIGHT / 2 + com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_PADDINGH);
        } // end if
        this.swapDepths(_locY * 100 + __index);
        __rowLocation = new flash.geom.Point(_loc2, _locY);
        __rowPosition = new flash.geom.Point(_loc2, _loc3);
        this.setPosition();
    } // End of the function
    function updatePosition(_immediate)
    {
    } // End of the function
    function setPosition()
    {
        _x = Math.round(__rowPosition.x * com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_SECOND) / com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_SECOND;
        _y = Math.round(__rowPosition.y * com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_SECOND) / com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_SECOND;
    } // End of the function
    function drop()
    {
        var _loc3;
        var _loc2;
        for (var _loc2 = 0; _loc2 < __cells.length; ++_loc2)
        {
            _loc3 = (com.clubpenguin.games.cardjitsu.water.cell.CellDisplay)(__cells[_loc2]).data;
            _loc3.drop();
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_DROP_COMPLETE, onDropCompleteHandler, this, _loc3);
        } // end of for
    } // End of the function
    function onDropCompleteHandler(_eventObj)
    {
        var _loc2;
        _loc2 = (com.clubpenguin.games.cardjitsu.water.cell.CellData)(_eventObj.__get__target());
        var _loc4;
        _loc4 = (MovieClip)(_eventObj.__get__data());
        ++__unusedCells;
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_DROP_COMPLETE, onDropCompleteHandler, this, _loc2);
        if (__unusedCells == __maxCells)
        {
            _visible = false;
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CellRowEvent(this, com.clubpenguin.games.cardjitsu.water.event.CellRowEvent.CELLROW_DROP_COMPLETE));
        } // end if
    } // End of the function
    function get location()
    {
        return (__rowLocation);
    } // End of the function
    function disableInput()
    {
        var _loc2;
        var _loc3;
        for (var _loc2 = 0; _loc2 < __cells.length; ++_loc2)
        {
            _loc3 = __cells[_loc2];
            _loc3.disableInput();
        } // end of for
    } // End of the function
    static var $_updateFrequency = 50;
    static var $_instanceCount = 0;
} // End of Class
