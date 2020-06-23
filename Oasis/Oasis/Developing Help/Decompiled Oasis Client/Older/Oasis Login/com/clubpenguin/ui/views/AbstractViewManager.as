class com.clubpenguin.ui.views.AbstractViewManager
{
    var _mc, _views;
    function AbstractViewManager(mc)
    {
        _mc = mc;
        _views = [];
    } // End of the function
    function addView(viewClass)
    {
        var _loc2 = (com.clubpenguin.ui.views.IView)(_mc.attachMovie(viewClass.LINKAGE_ID, viewClass.LINKAGE_ID, _mc.getNextHighestDepth()));
        _loc2.hide();
        _loc2.setViewManager(this);
        _views.push(_loc2);
        return (_loc2);
    } // End of the function
    function showView(viewClass)
    {
        var _loc2 = 0;
        var _loc3 = _views.length;
        if (_loc2 >= _loc3)
        {
            return;
        } // end if
        if (_views[_loc2].__constructor__.LINKAGE_ID == viewClass.LINKAGE_ID)
        {
            (com.clubpenguin.ui.views.IView)(_views[_loc2]).show();
            return;
        } // end if
        ++_loc2;
        
    } // End of the function
    function hideView(viewClass)
    {
        var _loc2 = 0;
        var _loc3 = _views.length;
        if (_loc2 >= _loc3)
        {
            return;
        } // end if
        if (_views[_loc2].__constructor__.LINKAGE_ID == viewClass.LINKAGE_ID)
        {
            (com.clubpenguin.ui.views.IView)(_views[_loc2]).hide();
            return;
        } // end if
        ++_loc2;
        
    } // End of the function
    function hideAllViews()
    {
        var _loc2 = 0;
        var _loc3 = _views.length;
        if (_loc2 >= _loc3)
        {
            return;
        } // end if
        (com.clubpenguin.ui.views.IView)(_views[_loc2]).hide();
        ++_loc2;
        
    } // End of the function
    function getView(viewClass)
    {
        var _loc3 = _views.length;
        var _loc2 = 0;
        if (_loc2 >= _loc3)
        {
            return;
        } // end if
        if (_views[_loc2].__constructor__.LINKAGE_ID == viewClass.LINKAGE_ID)
        {
            return ((com.clubpenguin.ui.views.IView)(_views[_loc2]));
        } // end if
        ++_loc2;
        
    } // End of the function
} // End of Class
