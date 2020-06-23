class com.clubpenguin.login.views.MoreServers extends com.clubpenguin.ui.views.AbstractView
{
    var close_btn, _moreServersCloseClip, list_mc, _moreServersListClip, select_world_txt, _pleaseSelectField, down_btn, up_btn, _visible, viewManager, _shell;
    function MoreServers()
    {
        super();
        com.clubpenguin.login.views.MoreServers.debugTrace("instantiated");
        _moreServersCloseClip = close_btn;
        _moreServersListClip = list_mc;
        _pleaseSelectField = select_world_txt;
        down_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moreServerPageDown);
        up_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moreServerPageUp);
        _moreServersCloseClip.onRelease = com.clubpenguin.util.Delegate.create(this, hideMoreServers);
    } // End of the function
    function isActive()
    {
        return (_moreServersActive);
    } // End of the function
    function show()
    {
        super.show();
        this.translateMoreServers();
        this.setupMoreServers();
        _visible = true;
        _moreServersActive = true;
    } // End of the function
    function hideMoreServers()
    {
        _visible = false;
        _moreServersActive = false;
        (com.clubpenguin.login.views.ViewManager)(viewManager).gotoWorldSelection();
    } // End of the function
    function translateMoreServers()
    {
        _pleaseSelectField.text = _shell.getLocalizedString("Please Select a Server").toUpperCase();
    } // End of the function
    function moreServerPageUp()
    {
        --_currentPage;
        if (_currentPage < 0)
        {
            _currentPage = 0;
            return;
        } // end if
        this.setupMoreServers();
    } // End of the function
    function moreServerPageDown()
    {
        ++_currentPage;
        if (_currentPage > this.getMaxMoreServerPages())
        {
            _currentPage = this.getMaxMoreServerPages();
            return;
        } // end if
        this.setupMoreServers();
    } // End of the function
    function getMaxMoreServerPages()
    {
        return (Math.ceil(_shell.getWorldList().length / com.clubpenguin.login.views.MoreServers.SERVERS_PER_PAGE) - 1);
    } // End of the function
    function setupMoreServers()
    {
        var _loc7 = _shell.getWorldList();
        var _loc11 = new Object();
        _loc7.sortOn(_sortOption, Array.CASEINSENSITIVE);
        _loc7 = _shell.paginateArray(_loc7, _currentPage, com.clubpenguin.login.views.MoreServers.SERVERS_PER_PAGE);
        var _loc3;
        var _loc9 = 10;
        var _loc10 = 2;
        var _loc8 = 0;
        var _loc4 = 2;
        var _loc2 = 0;
        if (_loc2 >= com.clubpenguin.login.views.MoreServers.SERVERS_PER_PAGE)
        {
            return;
        } // end if
        if (_loc7[_loc2] == undefined)
        {
            this.removeServer(_loc2);
        }
        else
        {
            _loc3 = this.createServer(_loc7[_loc2], _loc2);
            var _loc5 = _loc3.hover_mc._width;
            var _loc6 = _loc3.hover_mc._height;
            _loc3._x = _loc2 % _loc4 * (_loc5 + _loc9);
            _loc3._y = _loc8 * (_loc6 + _loc10);
            if (_loc2 % _loc4 == _loc4 - 1)
            {
                ++_loc8;
            } // end if
        } // end else if
        ++_loc2;
        
    } // End of the function
    function createServer(server, i)
    {
        var _loc2 = _moreServersListClip.attachMovie("world_02", "world_" + i, i);
        _loc2.name_txt.text = server.name;
        com.clubpenguin.login.Tools.ResizeTextToFit(_loc2.name_txt);
        _loc2.population = server.population;
        _loc2.pop_mc.gotoAndStop(server.population);
        if (_loc2.population == com.clubpenguin.login.views.MoreServers.FULL_POPULATION)
        {
            _loc2.pop_mc.serverFull.gotoAndStop(_shell.getLocalizedFrame());
        } // end if
        _loc2.id = server.id;
        _loc2.onRollOver = com.clubpenguin.util.Delegate.create(this, rollOverMoreServer, _loc2);
        _loc2.onDragOver = _loc2.onRollOver;
        _loc2.onRollOut = com.clubpenguin.util.Delegate.create(this, rollOffMoreServer, _loc2);
        _loc2.onDragOut = _loc2.onRollOut;
        _loc2.onRelease = com.clubpenguin.util.Delegate.create(this, connectToWorld, _loc2);
        _loc2.pop_mc.buddy_mc.gotoAndStop(1);
        if (server.has_buddies)
        {
            _loc2.pop_mc.buddy_mc.gotoAndStop(2);
        } // end if
        if (server.is_safe)
        {
            _loc2.pop_mc.safe_chat_mc._visible = true;
        }
        else
        {
            _loc2.pop_mc.safe_chat_mc._visible = false;
        } // end else if
        _loc2.hover_mc._visible = false;
        return (_loc2);
    } // End of the function
    function removeServer(i)
    {
        var _loc2 = _moreServersListClip["world_" + i];
        if (_loc2 != null)
        {
            _loc2.removeMovieClip();
        } // end if
    } // End of the function
    function rollOverMoreServer(mcServer)
    {
        mcServer.hover_mc._visible = true;
        mcServer.pop_mc.p1.gotoAndStop(2);
        mcServer.pop_mc.p2.gotoAndStop(2);
        mcServer.pop_mc.p3.gotoAndStop(2);
        mcServer.pop_mc.p4.gotoAndStop(2);
        mcServer.pop_mc.p5.gotoAndStop(2);
    } // End of the function
    function rollOffMoreServer(mcServer)
    {
        mcServer.hover_mc._visible = false;
        mcServer.pop_mc.p1.gotoAndStop(1);
        mcServer.pop_mc.p2.gotoAndStop(1);
        mcServer.pop_mc.p3.gotoAndStop(1);
        mcServer.pop_mc.p4.gotoAndStop(1);
        mcServer.pop_mc.p5.gotoAndStop(1);
    } // End of the function
    function connectToWorld(clip)
    {
        if (clip.population < com.clubpenguin.login.views.MoreServers.FULL_POPULATION)
        {
            _shell.setWorldForConnection(clip.id);
            return;
        } // end if
        _shell.$e("[login] createServer() -> Server is full!", {error_code: _shell.SERVER_FULL});
    } // End of the function
    static function debugTrace(msg)
    {
        if (!com.clubpenguin.login.views.MoreServers._debugTracesActive)
        {
            return;
        } // end if
    } // End of the function
    static var LINKAGE_ID = "com.clubpenguin.login.views.MoreServers";
    static var FULL_POPULATION = 6;
    static var SERVERS_PER_PAGE = 22;
    static var _debugTracesActive = false;
    var _currentPage = 0;
    var _sortOption = "name";
    var _moreServersActive = false;
} // End of Class
