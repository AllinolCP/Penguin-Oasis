class com.clubpenguin.stamps.StampBookCoverCrumbs
{
    var _coverCrumbs, __get__pattern, __get__clasp, __get__colour;
    function StampBookCoverCrumbs(webServiceManager)
    {
        _coverCrumbs = webServiceManager.getServiceData(com.clubpenguin.net.WebServiceType.STAMPBOOK_COVER);
        this.setColourCrumb();
        var _loc3 = this.__get__pattern();
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            if (_loc3[_loc2] == com.clubpenguin.stamps.StampManager.COVER_PATTERN_NONE_ID)
            {
                _loc3.splice(_loc2, 1);
                break;
            } // end if
        } // end of for
    } // End of the function
    function get pattern()
    {
        return (_coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_PATTERN]);
    } // End of the function
    function get clasp()
    {
        return (_coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_CLASP]);
    } // End of the function
    function get colour()
    {
        return (_coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_COLOUR]);
    } // End of the function
    function getTextHighlightByHighlightID(highlightID)
    {
        return (Number(_coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_HIGHLIGHT][String(highlightID)]));
    } // End of the function
    function getHighlightByColourID(colourID)
    {
        return (_coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_COLOUR_HIGHLIGHT][String(colourID)]);
    } // End of the function
    function getLogoByColourID(colourID)
    {
        return (Number(_coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_COLOUR_LOGO][String(colourID)][0]));
    } // End of the function
    function setColourCrumb()
    {
        _coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_COLOUR] = [];
        var _loc2 = _coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_COLOUR_HIGHLIGHT];
        var _loc4 = _coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_COLOUR];
        var _loc3 = 0;
        for (var _loc5 in _loc2)
        {
            _loc4[_loc3++] = _loc5;
        } // end of for...in
    } // End of the function
    static var CRUMB_CATEGORY_PATTERN = "pattern";
    static var CRUMB_CATEGORY_CLASP = "clasp";
    static var CRUMB_CATEGORY_COLOUR = "color";
    static var CRUMB_CATEGORY_HIGHLIGHT = "highlight";
    static var CRUMB_CATEGORY_COLOUR_HIGHLIGHT = "color_highlight";
    static var CRUMB_CATEGORY_COLOUR_LOGO = "color_logo";
} // End of Class
