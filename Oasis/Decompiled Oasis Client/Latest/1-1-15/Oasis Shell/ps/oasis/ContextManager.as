class ps.oasis.ContextManager
{
    function ContextManager()
    {
        (ps.oasis.OasisLogger)("Starting ContextManager");
        _root.menu = new ContextMenu();
        _root.menu.hideBuiltInItems();
    } // End of the function
    function SetContext(STATE)
    {
        var _loc5 = _global.GetConfiguration();
        for (var _loc8 in _loc5.tuning.context[this["STATE_" + STATE.toUpperCase()]])
        {
            _global.getCurrentShell().currentContext[_loc8] = _loc5.tuning.context[this["STATE_" + STATE.toUpperCase()]][_loc8];
            var _loc4 = new ContextMenuItem(_loc5.tuning.context[this["STATE_" + STATE.toUpperCase()]][_loc8].lbl);
            _loc4.contextId = _loc8;
            _loc4.onSelect = function (obj, contextItem)
            {
                _global["getCurrent" + _global.getCurrentShell().currentContext[contextItem.contextId].env]()[_global.getCurrentShell().currentContext[contextItem.contextId].func.name].apply(null, _global.getCurrentShell().currentContext[contextItem.contextId].func.args);
            };
            _loc4.enabled = _loc5.tuning.context[this["STATE_" + STATE.toUpperCase()]][_loc8].enabled;
            var _loc7 = _root.menu.customItems.push(_loc4);
            contextMenus[_loc7 - 1] = _root.menu.customItems[_loc7 - 1];
        } // end of for...in
    } // End of the function
    var contextMenus = new Object();
    var STATE_LOGIN = "L1";
    var STATE_WORLD = "L2";
} // End of Class
