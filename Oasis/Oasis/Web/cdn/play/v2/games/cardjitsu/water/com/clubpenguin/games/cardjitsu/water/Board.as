class com.clubpenguin.games.cardjitsu.water.Board implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, __boardData, __cellPool, __rowPool, __rows, __cellsByID, __columns, __cellCount, __rowCount, __isMoving;
    function Board(_cols)
    {
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.Board.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.Board.$_instanceCount;
        if (!this.validColumns(_cols))
        {
            return;
        } // end if
        this.init(_cols);
    } // End of the function
    function init(_cols)
    {
        __boardData = new Array();
        __cellPool = new Array();
        __rowPool = new Array();
        __rows = new Array();
        __cellsByID = new Array();
        __columns = _cols;
        __cellCount = 0;
        __rowCount = 0;
    } // End of the function
    function setVelocity(_vel)
    {
        com.clubpenguin.games.cardjitsu.water.cell.CellRow.updateVector(_vel);
    } // End of the function
    function update()
    {
        if (__isMoving)
        {
        } // end if
    } // End of the function
    function addRow(_data)
    {
        if (_data == undefined)
        {
            return;
        } // end if
        if (_data.length < com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_COLS_MIN || _data.length > com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_COLS_MAX)
        {
            return;
        } // end if
        __boardData.unshift(_data);
        var _loc3;
        _loc3 = this.getRow();
        _loc3.configRow(_data);
        __rows.unshift(_loc3);
        this.reposition();
    } // End of the function
    function getRow()
    {
        var _loc3;
        var _loc2;
        _loc3 = com.clubpenguin.games.cardjitsu.water.DisplayManager.getDisplayLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_CELL);
        if (__rowPool.length == 0)
        {
            _loc2 = (com.clubpenguin.games.cardjitsu.water.cell.CellRow)(_loc3.attachMovie(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_ROW, "row" + __rowCount++, __rowCount * 100 + __rowCount));
            _loc2.__set__index(__rowCount);
        }
        else
        {
            _loc2 = (com.clubpenguin.games.cardjitsu.water.cell.CellRow)(__rowPool.shift());
            _loc2.swapDepths(_loc2.__get__index() * 100 + _loc2.__get__index());
        } // end else if
        _loc2._visible = false;
        return (_loc2);
    } // End of the function
    function deleteRow()
    {
        var _loc5;
        var _loc4;
        var _loc3;
        if (__rows.length <= com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_ROWS_MAX)
        {
        }
        else
        {
            _loc5 = (com.clubpenguin.games.cardjitsu.water.cell.CellRow)(__rows.pop());
            _loc3 = __boardData.pop().concat();
            for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
            {
                _loc4 = _loc3[_loc2];
                __cellsByID[_loc4.__get__id()] = null;
            } // end of for
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CellRowEvent.CELLROW_DROP_COMPLETE, onDropCompleteHandler, this, _loc5);
            _loc5.drop();
        } // end else if
    } // End of the function
    function onDropCompleteHandler(_eventObj)
    {
        var _loc2;
        _loc2 = (com.clubpenguin.games.cardjitsu.water.cell.CellRow)(_eventObj.__get__target());
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.CellRowEvent.CELLROW_DROP_COMPLETE, onDropCompleteHandler, this, _loc2);
        __rowPool.push(_loc2);
    } // End of the function
    function selectCell(_row, _col)
    {
        __boardData[_row][_col].selected = true;
    } // End of the function
    function cellVacatedHandler(_cell)
    {
        var _loc3;
        var _loc5;
        _loc3 = _cell;
        var _loc4;
        var _loc2;
        for (var _loc4 = _loc3.__get__location().y - 1; _loc4 <= _loc3.__get__location().y + 1; ++_loc4)
        {
            if (_loc4 >= 0)
            {
                for (var _loc2 = _loc3.__get__location().x - 1; _loc2 <= _loc3.__get__location().x + 1; ++_loc2)
                {
                    if (_loc2 >= 0 && _loc2 < __columns)
                    {
                        _loc5 = __boardData[_loc4][_loc2];
                        _loc5.__set__selected(false);
                        _loc5.__set__enabled(false);
                    } // end if
                } // end of for
            } // end if
        } // end of for
    } // End of the function
    function getSurroundingCells(_cell)
    {
        var _loc6;
        var _loc2;
        if (!this.validCoordinates(_cell.__get__location().x, _cell.__get__location().y))
        {
            return;
        } // end if
        _loc6 = new Array();
        var _loc5;
        var _loc3;
        for (var _loc5 = _cell.__get__location().y - 1; _loc5 <= _cell.__get__location().y + 1; ++_loc5)
        {
            if (_loc5 >= 0 && _loc5 < com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_ROWS_MAX)
            {
                for (var _loc3 = _cell.__get__location().x - 1; _loc3 <= _cell.__get__location().x + 1; ++_loc3)
                {
                    if (_loc3 >= 0 && _loc3 < com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_COLS_MAX)
                    {
                        _loc2 = __boardData[_loc5][_loc3];
                        _loc2.__set__selected(false);
                        _loc2.__set__enabled(false);
                        _loc2.setHitArea(_cell.__get__location().y - _loc5, _cell.__get__location().x - _loc3);
                        if (_loc2.__get__element().__get__type() != com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_OBSTACLE && _loc2.getPlayer() == null)
                        {
                            _loc2.__set__selected(true);
                            _loc2.__set__enabled(true);
                            _loc6.push(_loc2);
                        } // end if
                    } // end if
                } // end of for
            } // end if
        } // end of for
        return (_loc6);
    } // End of the function
    function updateInSurround(_tCell, _pCell)
    {
        var _loc4;
        var _loc3;
        var _loc2;
        _loc4 = _pCell.__get__location().clone();
        _loc3 = _tCell.__get__location().clone();
        _loc2 = _loc4.subtract(_loc3);
        if (Math.abs(_loc2.x) <= 1 && Math.abs(_loc2.y) <= 1)
        {
            if (!(_loc2.x == 0 && _loc2.y == 0))
            {
                if (!_tCell.isOccupied())
                {
                    _tCell.__set__selected(true);
                    _tCell.__set__enabled(true);
                }
                else
                {
                    _tCell.__set__selected(false);
                    _tCell.__set__enabled(false);
                } // end if
            } // end if
        } // end else if
    } // End of the function
    function build(_boardLayout)
    {
        var _loc3;
        var _loc4;
        var _loc2;
        _loc3 = _boardLayout.split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_GROUP);
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            _loc4 = _loc3[_loc2];
            this.newRow(_loc4);
        } // end of for
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.BoardEvent(this, com.clubpenguin.games.cardjitsu.water.event.BoardEvent.BOARD_INIT_COMPLETE));
    } // End of the function
    function newRow(_boardRow)
    {
        if (aborted)
        {
            return;
        } // end if
        var _loc6;
        var _loc3;
        var _loc2;
        var _loc5;
        var _loc4;
        _loc3 = _boardRow.split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_VAL);
        _loc6 = new Array();
        while (_loc3.length > 0)
        {
            _loc5 = String(_loc3.pop());
            _loc4 = _loc5.split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PROP);
            _loc2 = this.getCell();
            _loc2.__set__selected(false);
            _loc2.config(_loc4);
            _loc6.unshift(_loc2);
            __cellsByID[_loc2.__get__id()] = _loc2;
            ++__cellCount;
        } // end while
        this.addRow(_loc6);
    } // End of the function
    function getCell()
    {
        var _loc2;
        if (__cellPool.length == 0)
        {
            _loc2 = new com.clubpenguin.games.cardjitsu.water.cell.CellData();
        }
        else
        {
            _loc2 = (com.clubpenguin.games.cardjitsu.water.cell.CellData)(__cellPool.shift());
        } // end else if
        return (_loc2);
    } // End of the function
    function getCellAt(_ptx, _pty)
    {
        var _loc2;
        _loc2 = (com.clubpenguin.games.cardjitsu.water.cell.CellData)(__boardData[_pty][_ptx]);
        return (_loc2);
    } // End of the function
    function getCellByID(_cellID)
    {
        var _loc2;
        _loc2 = __cellsByID[_cellID];
        return (_loc2);
    } // End of the function
    function reposition()
    {
        var _loc5;
        var _loc2;
        var _loc4;
        var _loc3;
        _loc5 = "";
        for (var _loc2 = 0; _loc2 < __boardData.length; ++_loc2)
        {
            _loc4 = _loc2;
            _loc3 = __rows[_loc2];
            _loc3.setLocation(_loc2, 0);
            if (_loc2 == 2)
            {
                _loc3._visible = true;
            } // end if
        } // end of for
        this.deleteRow();
    } // End of the function
    function stop()
    {
        __isMoving = false;
    } // End of the function
    function validColumns(_cols)
    {
        if (_cols == undefined)
        {
            return (false);
        } // end if
        if (_cols < com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_COLS_MIN || _cols > com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_COLS_MAX)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    function validCoordinates(_col, _row)
    {
        if (_row == undefined || _col == undefined)
        {
            return (false);
        } // end if
        if (_row < 0 || _row >= com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_ROWS_MAX || _col < 0 || _col > com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_COLS_MAX)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    function toString()
    {
        var _loc1;
        _loc1 = "[Board]";
        return (_loc1);
    } // End of the function
    function getUniqueName()
    {
        return ("[Board<" + __uid + ">]");
    } // End of the function
    function getRowAt(_n)
    {
        return (__boardData[_n]);
    } // End of the function
    function killRow(deadRow)
    {
        var _loc2;
        _loc2 = __rows[deadRow];
        _loc2._visible = false;
    } // End of the function
    function abortNewRow()
    {
        aborted = true;
    } // End of the function
    function disableInput()
    {
        var _loc2;
        var _loc3;
        for (var _loc2 = 0; _loc2 < __boardData.length; ++_loc2)
        {
            _loc3 = __rows[_loc2];
            _loc3.disableInput();
        } // end of for
    } // End of the function
    static var $_instanceCount = 0;
    var aborted = false;
} // End of Class
