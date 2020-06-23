class com.clubpenguin.stamps.stampbook.util.ColorHelper extends com.clubpenguin.util.EventDispatcher
{
    var _colourIndex, dispatchEvent, _highlightIndex, _patternIndex, _iconIndex;
    static var _instance;
    function ColorHelper()
    {
        super();
    } // End of the function
    static function getInstance()
    {
        if (com.clubpenguin.stamps.stampbook.util.ColorHelper._instance == null)
        {
            _instance = new com.clubpenguin.stamps.stampbook.util.ColorHelper();
        } // end if
        return (com.clubpenguin.stamps.stampbook.util.ColorHelper._instance);
    } // End of the function
    function getColourIndex()
    {
        return (_colourIndex);
    } // End of the function
    function setColourIndex(colour)
    {
        _colourIndex = colour;
        this.dispatchEvent({type: "colorChange", colour: _colourIndex});
    } // End of the function
    function getHighlightIndex()
    {
        return (_highlightIndex);
    } // End of the function
    function setHighlightIndex(highlightIndex)
    {
        _highlightIndex = highlightIndex;
        this.dispatchEvent({type: "highlightChange", highlight: _highlightIndex});
    } // End of the function
    function getPatternIndex()
    {
        return (_patternIndex);
    } // End of the function
    function setPatternIndex(patternIndex)
    {
        _patternIndex = patternIndex;
    } // End of the function
    function getIconIndex()
    {
        return (_iconIndex);
    } // End of the function
    function setIconIndex(iconIndex)
    {
        _iconIndex = iconIndex;
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.util.ColorHelper;
    static var LINKAGE_ID = "ColorHelper";
} // End of Class
