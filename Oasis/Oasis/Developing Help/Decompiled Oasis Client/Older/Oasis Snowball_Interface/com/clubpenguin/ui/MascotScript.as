class com.clubpenguin.ui.MascotScript extends MovieClip
{
    var _categoryDisplayClip, _categoryHolderClip, _mascotChangeClip, gotoAndStop, _resizeClip, _backgroundClip, _closeClip, _scrollbarThumb, _scriptUpArrowBtn, _scriptDownArrowBtn, _categoryScrollbarThumb, _categoryUpArrowBtn, _categoryDownArrowBtn, _state, _startIndex, _categoryStartIndex, _currentlyScrolling, _data, _visible, removeMovieClip, startDrag, stopDrag, onEnterFrame, _characterIndex, _tabIndex, _mascotEntryClips, _mascotCategoryClips, _mascotScriptEntryHolderClip, _titleField, _scrollbarBackground, _pixelsPerScrollableUnit, _pixelsPerCategoryScrollableUnit, _categoryScrollbarBackground, _xmouse, _ymouse;
    function MascotScript()
    {
        super();
        _categoryHolderClip = _categoryDisplayClip._categoryHolderClip;
        _mascotChangeClip.onRelease = com.clubpenguin.util.Delegate.create(this, onChangeMascot);
        _mascotChangeClip.onRollOver = function ()
        {
            this.gotoAndStop("rollover");
        };
        _mascotChangeClip.onRollOut = function ()
        {
            this.gotoAndStop("rollout");
        };
        _resizeClip.onPress = com.clubpenguin.util.Delegate.create(this, onResize, true);
        _resizeClip.onRelease = com.clubpenguin.util.Delegate.create(this, onResize, false);
        _resizeClip.onReleaseOutside = _resizeClip.onRelease;
        _resizeClip.onRollOver = function ()
        {
            this.gotoAndStop("rollover");
        };
        _resizeClip.onRollOut = function ()
        {
            this.gotoAndStop("rollout");
        };
        _backgroundClip.onPress = com.clubpenguin.util.Delegate.create(this, onDrag, true);
        _backgroundClip.onRelease = com.clubpenguin.util.Delegate.create(this, onDrag, false);
        _backgroundClip.useHandCursor = false;
        _categoryDisplayClip._backgroundClip.onPress = _backgroundClip.onPress;
        _categoryDisplayClip._backgroundClip.onRelease = _backgroundClip.onRelease;
        _categoryDisplayClip._backgroundClip.useHandCursor = false;
        _closeClip.onRollOver = function ()
        {
            this.gotoAndStop("rollover");
        };
        _closeClip.onRollOut = function ()
        {
            this.gotoAndStop("rollout");
        };
        _closeClip.onRelease = com.clubpenguin.util.Delegate.create(this, hide);
        _scrollbarThumb.onPress = com.clubpenguin.util.Delegate.create(this, onDragThumb, true);
        _scrollbarThumb.onRelease = com.clubpenguin.util.Delegate.create(this, onDragThumb, false);
        _scrollbarThumb.onReleaseOutside = _scrollbarThumb.onRelease;
        _scriptUpArrowBtn.onPress = com.clubpenguin.util.Delegate.create(this, onScroll, -1);
        _scriptDownArrowBtn.onPress = com.clubpenguin.util.Delegate.create(this, onScroll, 1);
        _categoryScrollbarThumb.onPress = com.clubpenguin.util.Delegate.create(this, onDragCategoryThumb, true);
        _categoryScrollbarThumb.onRelease = com.clubpenguin.util.Delegate.create(this, onDragCategoryThumb, false);
        _categoryScrollbarThumb.onReleaseOutside = _categoryScrollbarThumb.onRelease;
        _categoryUpArrowBtn.onPress = com.clubpenguin.util.Delegate.create(this, onCategoryScroll, -1);
        _categoryDownArrowBtn.onPress = com.clubpenguin.util.Delegate.create(this, onCategoryScroll, 1);
        _state = com.clubpenguin.ui.MascotScript.STATE_SELECT_MASCOT;
        _startIndex = 0;
        _categoryStartIndex = 0;
        _currentlyScrolling = false;
        _data = _global.getCurrentShell().getMascotMessageArray();
        this.setupMascotCategories();
        this.setupMascotEntries();
    } // End of the function
    function show()
    {
        _visible = true;
    } // End of the function
    function hide()
    {
        this.removeMovieClip();
    } // End of the function
    function onDrag(startDragging)
    {
        if (startDragging)
        {
            this.startDrag();
        }
        else
        {
            this.stopDrag();
        } // end else if
    } // End of the function
    function onDragThumb(startDragging)
    {
        if (startDragging)
        {
            onEnterFrame = updateForScrollbarDrag;
            _currentlyScrolling = true;
        }
        else
        {
            onEnterFrame = null;
            _currentlyScrolling = false;
        } // end else if
    } // End of the function
    function onDragCategoryThumb(startDragging)
    {
        if (startDragging)
        {
            onEnterFrame = updateForCategoryScrollbarDrag;
            _currentlyScrolling = true;
        }
        else
        {
            onEnterFrame = null;
            _currentlyScrolling = false;
        } // end else if
    } // End of the function
    function onScroll(increment)
    {
        var _loc3 = _startIndex + increment;
        var _loc2 = 0;
        if (_state == com.clubpenguin.ui.MascotScript.STATE_SELECT_MASCOT)
        {
            _loc2 = _data.length;
        }
        else if (_state == com.clubpenguin.ui.MascotScript.STATE_SCRIPT)
        {
            _loc2 = _data[_characterIndex].mascotScript[_tabIndex].script.length;
        } // end else if
        if (_loc3 >= 0 && _loc3 <= _loc2 - _mascotEntryClips.length)
        {
            _startIndex = _loc3;
            this.setupMascotEntries();
        } // end if
    } // End of the function
    function onCategoryScroll(increment)
    {
        var _loc3 = _categoryStartIndex + increment;
        var _loc2 = 0;
        if (_state == com.clubpenguin.ui.MascotScript.STATE_SELECT_MASCOT)
        {
            _loc2 = 0;
        }
        else if (_state == com.clubpenguin.ui.MascotScript.STATE_SCRIPT)
        {
            var _loc4 = _data[_characterIndex].mascotScript;
            _loc2 = _loc4.length;
        } // end else if
        if (_loc3 >= 0 && _loc3 <= _loc2 - _mascotCategoryClips.length)
        {
            _categoryStartIndex = _loc3;
            this.setupMascotCategories();
        } // end if
    } // End of the function
    function onResize(startResizing)
    {
        if (startResizing)
        {
            onEnterFrame = updateForResize;
        }
        else
        {
            onEnterFrame = null;
        } // end else if
    } // End of the function
    function onChangeMascot()
    {
        _state = com.clubpenguin.ui.MascotScript.STATE_SELECT_MASCOT;
        _startIndex = 0;
        _categoryStartIndex = 0;
        this.setupMascotCategories();
        this.setupMascotEntries();
    } // End of the function
    function setupMascotCategories()
    {
        if (_state == com.clubpenguin.ui.MascotScript.STATE_SELECT_MASCOT)
        {
            _categoryDisplayClip._visible = false;
        }
        else if (_state == com.clubpenguin.ui.MascotScript.STATE_SCRIPT)
        {
            _categoryDisplayClip._visible = true;
            var _loc8 = _mascotCategoryClips.length;
            for (var _loc3 = 0; _loc3 < _loc8; ++_loc3)
            {
                _mascotCategoryClips[_loc3].removeMovieClip();
            } // end of for
            var _loc7 = _data[_characterIndex].mascotScript;
            _loc8 = _loc7.length;
            var _loc5 = 0;
            _mascotCategoryClips = new Array();
            for (var _loc3 = 0; _loc3 < _loc8; ++_loc3)
            {
                var _loc4 = _loc7[_categoryStartIndex + _loc3].category;
                var _loc6 = _loc7[_categoryStartIndex + _loc3].categoryActive;
                if (_loc4 == null)
                {
                    break;
                } // end if
                if (!_loc6)
                {
                    continue;
                } // end if
                var _loc2 = _categoryHolderClip.attachMovie("mascotScriptEntryClip", "mascotCategoryEntry" + _loc3, _categoryHolderClip.getNextHighestDepth());
                _loc2._y = _loc5;
                _loc2._scriptField.autoSize = true;
                _loc2._scriptField._width = _categoryDisplayClip._backgroundClip._width - 2 * _categoryHolderClip._x - 2 * _categoryScrollbarThumb._width;
                _loc2._scriptField.text = _loc4;
                if (_loc2._y + _loc2._height + _categoryHolderClip._y > _categoryDisplayClip._backgroundClip._height)
                {
                    _loc2.removeMovieClip();
                    break;
                } // end if
                if (_categoryStartIndex + _loc3 == _tabIndex)
                {
                    _loc2._scriptField.textColor = com.clubpenguin.ui.MascotScript.SELECTED_CATEGORY_COLOUR;
                } // end if
                _loc5 = _loc5 + _loc2._height;
                _loc2.onRollOver = com.clubpenguin.util.Delegate.create(this, onCategoryHighlight, _loc3, true);
                _loc2.onRollOut = com.clubpenguin.util.Delegate.create(this, onCategoryHighlight, _loc3, false);
                _loc2.onRelease = com.clubpenguin.util.Delegate.create(this, onCategoryRelease, _loc3);
                _mascotCategoryClips[_loc3] = _loc2;
            } // end of for
        } // end else if
        if (!_currentlyScrolling)
        {
            this.setupCategoryScrollbar();
        } // end if
    } // End of the function
    function setupMascotEntries()
    {
        if (_mascotEntryClips != null)
        {
            var _loc4 = _mascotEntryClips.length;
            for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
            {
                _mascotEntryClips[_loc2].removeMovieClip();
            } // end of for
        } // end if
        _mascotEntryClips = new Array();
        var _loc6 = 0;
        _loc2 = 0;
        var _loc5 = "";
        var _loc8 = true;
        var _loc9 = true;
        if (_state == com.clubpenguin.ui.MascotScript.STATE_SELECT_MASCOT)
        {
            _loc5 = _data[_startIndex + _loc2].mascotName;
            _loc8 = _data[_startIndex + _loc2].mascotActive;
        }
        else if (_state == com.clubpenguin.ui.MascotScript.STATE_SCRIPT)
        {
            if (_data[_characterIndex].mascotScript[_tabIndex].sharedScript)
            {
                var _loc7 = _data[_characterIndex].mascotScript[_tabIndex].script[_startIndex + _loc2];
                _loc5 = _loc7.name + ": " + _loc7.message;
                if (_loc7.name != _data[_characterIndex].mascotName)
                {
                    _loc9 = false;
                } // end if
            }
            else
            {
                _loc5 = _data[_characterIndex].mascotScript[_tabIndex].script[_startIndex + _loc2];
            } // end else if
        } // end else if
        if (_loc5 == null || _loc5.substr(0, 9) == "undefined")
        {
        }
        else
        {
            if (!_loc8)
            {
            }
            else
            {
                var _loc3 = _mascotScriptEntryHolderClip.attachMovie("mascotScriptEntryClip", "mascotScriptEntry" + _loc2, _mascotScriptEntryHolderClip.getNextHighestDepth());
                _loc3._y = _loc6;
                _loc3._scriptField.autoSize = true;
                _loc3._scriptField._width = _backgroundClip._width - 2 * _mascotScriptEntryHolderClip._x - _scriptUpArrowBtn._width - _loc3._scriptField._x;
                _loc3._scriptField.text = _loc5;
                if (_loc3._y + _loc3._height + _mascotScriptEntryHolderClip._y > _backgroundClip._height)
                {
                    _loc3.removeMovieClip();
                } // end if
                var _loc10 = 10;
                if (_loc3._scriptField.textWidth < _loc3._scriptField._width)
                {
                    _loc3._scriptField._width = _loc3._scriptField.textWidth + _loc10;
                } // end if
                _loc6 = _loc6 + _loc3._height;
                if (_loc9)
                {
                    _loc3.onRollOver = com.clubpenguin.util.Delegate.create(this, onScriptHighlight, _loc2, true);
                    _loc3.onRollOut = com.clubpenguin.util.Delegate.create(this, onScriptHighlight, _loc2, false);
                    _loc3.onRelease = com.clubpenguin.util.Delegate.create(this, onScriptRelease, _loc2);
                }
                else
                {
                    _loc3._scriptField.textColor = com.clubpenguin.ui.MascotScript.NON_INTERACTIVE_TEXT_COLOUR;
                } // end else if
                _mascotEntryClips[_loc2] = _loc3;
            } // end else if
            ++_loc2;
        } // end else if
        if (_state == com.clubpenguin.ui.MascotScript.STATE_SELECT_MASCOT)
        {
            _titleField.text = "SELECT A MASCOT";
        }
        else if (_state == com.clubpenguin.ui.MascotScript.STATE_SCRIPT)
        {
            _titleField.text = _data[_characterIndex].mascotName.toUpperCase() + " SCRIPTS";
        } // end else if
        if (!_currentlyScrolling)
        {
            this.setupScrollbar();
        } // end if
    } // End of the function
    function setupScrollbar()
    {
        var _loc3 = _mascotEntryClips.length;
        var _loc2 = 0;
        if (_state == com.clubpenguin.ui.MascotScript.STATE_SELECT_MASCOT)
        {
            _loc2 = _data.length;
        }
        else if (_state == com.clubpenguin.ui.MascotScript.STATE_SCRIPT)
        {
            _loc2 = _data[_characterIndex].mascotScript[_tabIndex].script.length;
        } // end else if
        if (_loc3 >= _loc2)
        {
            _scrollbarThumb._visible = false;
            _scrollbarBackground._visible = false;
            _scriptUpArrowBtn._visible = false;
            _scriptDownArrowBtn._visible = false;
        }
        else
        {
            _scrollbarThumb._visible = true;
            _scrollbarBackground._visible = true;
            _scriptUpArrowBtn._visible = true;
            _scriptDownArrowBtn._visible = true;
            var _loc4 = _loc2 - _loc3;
            _pixelsPerScrollableUnit = (_scrollbarBackground._height - _scrollbarThumb._height) / _loc4;
            _scrollbarThumb._y = _scrollbarBackground._y + _startIndex * _pixelsPerScrollableUnit;
        } // end else if
    } // End of the function
    function setupCategoryScrollbar()
    {
        var _loc3 = _mascotCategoryClips.length;
        var _loc2 = 0;
        if (_state == com.clubpenguin.ui.MascotScript.STATE_SELECT_MASCOT)
        {
            _loc2 = 0;
        }
        else if (_state == com.clubpenguin.ui.MascotScript.STATE_SCRIPT)
        {
            var _loc5 = _data[_characterIndex].mascotScript;
            _loc2 = _loc5.length;
        } // end else if
        if (_loc3 >= _loc2)
        {
            _categoryScrollbarThumb._visible = false;
            _categoryScrollbarBackground._visible = false;
            _categoryUpArrowBtn._visible = false;
            _categoryDownArrowBtn._visible = false;
        }
        else
        {
            _categoryScrollbarThumb._visible = true;
            _categoryScrollbarBackground._visible = true;
            _categoryUpArrowBtn._visible = true;
            _categoryDownArrowBtn._visible = true;
            var _loc4 = _loc2 - _loc3;
            _pixelsPerCategoryScrollableUnit = (_categoryScrollbarBackground._height - _categoryScrollbarThumb._height) / _loc4;
            _categoryScrollbarThumb._y = _categoryScrollbarBackground._y + _categoryStartIndex * _pixelsPerCategoryScrollableUnit;
        } // end else if
    } // End of the function
    function onScriptHighlight(clipIdx, highlightState)
    {
        if (highlightState)
        {
            _mascotEntryClips[clipIdx]._scriptField.textColor = com.clubpenguin.ui.MascotScript.HIGHLIGHTED_SCRIPT_TEXT_COLOUR;
        }
        else
        {
            _mascotEntryClips[clipIdx]._scriptField.textColor = com.clubpenguin.ui.MascotScript.UNHIGHLIGHTED_TEXT_COLOUR;
        } // end else if
    } // End of the function
    function onCategoryHighlight(clipIdx, highlightState)
    {
        if (highlightState)
        {
            _mascotCategoryClips[clipIdx]._scriptField.textColor = com.clubpenguin.ui.MascotScript.HIGHLIGHTED_CATEGORY_TEXT_COLOUR;
        }
        else if (_categoryStartIndex + clipIdx == _tabIndex)
        {
            _mascotCategoryClips[clipIdx]._scriptField.textColor = com.clubpenguin.ui.MascotScript.SELECTED_CATEGORY_COLOUR;
        }
        else
        {
            _mascotCategoryClips[clipIdx]._scriptField.textColor = com.clubpenguin.ui.MascotScript.UNHIGHLIGHTED_TEXT_COLOUR;
        } // end else if
    } // End of the function
    function onScriptRelease(clipIdx)
    {
        if (_state == com.clubpenguin.ui.MascotScript.STATE_SELECT_MASCOT)
        {
            _characterIndex = _startIndex + clipIdx;
            _tabIndex = 0;
            _startIndex = 0;
            _state = com.clubpenguin.ui.MascotScript.STATE_SCRIPT;
            this.setupMascotCategories();
            this.setupMascotEntries();
        }
        else if (_state == com.clubpenguin.ui.MascotScript.STATE_SCRIPT)
        {
            var _loc4 = _global.getCurrentInterface();
            var _loc3 = this.getMessageId(_characterIndex, _tabIndex, _startIndex + clipIdx);
            _loc4.sendMascotMessage(_loc3);
        } // end else if
    } // End of the function
    function getMessageId(chosenCharacterIdx, chosenCategoryIdx, scriptIdx)
    {
        var _loc4 = 0;
        for (var _loc3 = 0; _loc3 <= chosenCharacterIdx; ++_loc3)
        {
            var _loc6 = _data[_loc3].mascotScript;
            var _loc7 = _loc6.length;
            for (var _loc2 = 0; _loc2 < _loc7; ++_loc2)
            {
                if (_loc3 == chosenCharacterIdx && _loc2 == chosenCategoryIdx)
                {
                    return (_loc4 + scriptIdx);
                } // end if
                var _loc5 = _loc6[_loc2].script;
                _loc4 = _loc4 + _loc5.length;
            } // end of for
        } // end of for
        return (null);
    } // End of the function
    function onCategoryRelease(clipIdx)
    {
        var _loc2 = _tabIndex - _categoryStartIndex;
        _mascotCategoryClips[_loc2]._scriptField.textColor = com.clubpenguin.ui.MascotScript.UNHIGHLIGHTED_TEXT_COLOUR;
        _startIndex = 0;
        _tabIndex = _categoryStartIndex + clipIdx;
        this.setupMascotEntries();
    } // End of the function
    function updateForResize()
    {
        _resizeClip._x = _xmouse;
        _resizeClip._y = _ymouse;
        var _loc5 = _resizeClip._x - _resizeClip._width / 2;
        var _loc4 = _resizeClip._y - _resizeClip._height / 2;
        if (_loc5 < com.clubpenguin.ui.MascotScript.MIN_WIDTH)
        {
            _loc5 = com.clubpenguin.ui.MascotScript.MIN_WIDTH;
        } // end if
        if (_loc4 < com.clubpenguin.ui.MascotScript.MIN_HEIGHT)
        {
            _loc4 = com.clubpenguin.ui.MascotScript.MIN_HEIGHT;
        } // end if
        _resizeClip._x = _loc5;
        _resizeClip._y = _loc4;
        var _loc6 = _backgroundClip._width;
        var _loc7 = _backgroundClip._height;
        _backgroundClip._width = _loc5 + _resizeClip._width;
        _backgroundClip._height = _loc4 + _resizeClip._height;
        var _loc2 = _backgroundClip._width - _loc6;
        var _loc3 = _backgroundClip._height - _loc7;
        _mascotChangeClip._x = _mascotChangeClip._x + _loc2;
        _closeClip._x = _closeClip._x + _loc2;
        _scriptUpArrowBtn._x = _scriptUpArrowBtn._x + _loc2;
        _scriptDownArrowBtn._x = _scriptDownArrowBtn._x + _loc2;
        _scriptDownArrowBtn._y = _scriptDownArrowBtn._y + _loc3;
        _categoryDisplayClip._backgroundClip._height = _categoryDisplayClip._backgroundClip._height + _loc3;
        _titleField._width = _mascotChangeClip._x;
        _scrollbarBackground._height = _scrollbarBackground._height + _loc3;
        _scrollbarBackground._x = _scrollbarBackground._x + _loc2;
        _scrollbarThumb._x = _scrollbarThumb._x + _loc2;
        _categoryScrollbarBackground._height = _categoryScrollbarBackground._height + _loc3;
        _categoryDownArrowBtn._y = _categoryDownArrowBtn._y + _loc3;
        if (_loc2 != 0 || _loc3 != 0)
        {
            this.setupMascotEntries();
            this.setupMascotCategories();
            this.setupScrollbar();
            this.setupCategoryScrollbar();
        } // end if
    } // End of the function
    function updateForScrollbarDrag()
    {
        _scrollbarThumb._y = _ymouse - _scrollbarThumb._height / 2;
        if (_scrollbarThumb._y < _scrollbarBackground._y)
        {
            _scrollbarThumb._y = _scrollbarBackground._y;
        }
        else if (_scrollbarThumb._y > _scrollbarBackground._y + _scrollbarBackground._height - _scrollbarThumb._height)
        {
            _scrollbarThumb._y = _scrollbarBackground._y + _scrollbarBackground._height - _scrollbarThumb._height;
        } // end else if
        var _loc2 = Math.round((_scrollbarThumb._y - _scrollbarBackground._y) / _pixelsPerScrollableUnit);
        if (_loc2 != _startIndex)
        {
            _startIndex = _loc2;
            this.setupMascotEntries();
        } // end if
    } // End of the function
    function updateForCategoryScrollbarDrag()
    {
        _categoryScrollbarThumb._y = _ymouse - _categoryScrollbarThumb._height / 2;
        if (_categoryScrollbarThumb._y < _categoryScrollbarBackground._y)
        {
            _categoryScrollbarThumb._y = _categoryScrollbarBackground._y;
        }
        else if (_categoryScrollbarThumb._y > _categoryScrollbarBackground._y + _categoryScrollbarBackground._height - _categoryScrollbarThumb._height)
        {
            _categoryScrollbarThumb._y = _categoryScrollbarBackground._y + _categoryScrollbarBackground._height - _categoryScrollbarThumb._height;
        } // end else if
        var _loc2 = Math.round((_categoryScrollbarThumb._y - _categoryScrollbarBackground._y) / _pixelsPerCategoryScrollableUnit);
        if (_loc2 != _categoryStartIndex)
        {
            _categoryStartIndex = _loc2;
            this.setupMascotCategories();
        } // end if
    } // End of the function
    static function debugDrawVert(holder, startX, startY, height, label, col, width)
    {
        holder.lineStyle(1, col);
        holder.moveTo(startX, startY);
        holder.lineTo(startX - width, startY);
        holder.lineTo(startX - width, startY + height);
        holder.lineTo(startX, startY + height);
        holder.moveTo(startX - width, startY + height / 2);
        holder.lineTo(startX - width * 2, startY + height / 2);
    } // End of the function
    static function debugTrace(msg)
    {
        if (com.clubpenguin.ui.MascotScript.DEBUG_TRACE_ACTIVE)
        {
        } // end if
    } // End of the function
    static var DEBUG_TRACE_ACTIVE = false;
    static var MIN_WIDTH = 100;
    static var MIN_HEIGHT = 100;
    static var STATE_SELECT_MASCOT = 1;
    static var STATE_SCRIPT = 2;
    static var NON_INTERACTIVE_TEXT_COLOUR = 7829367;
    static var UNHIGHLIGHTED_TEXT_COLOUR = 13421772;
    static var HIGHLIGHTED_SCRIPT_TEXT_COLOUR = 13656160;
    static var HIGHLIGHTED_CATEGORY_TEXT_COLOUR = 6316128;
    static var SELECTED_CATEGORY_COLOUR = 1052688;
} // End of Class
