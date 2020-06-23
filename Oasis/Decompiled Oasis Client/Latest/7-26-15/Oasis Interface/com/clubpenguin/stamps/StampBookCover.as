class com.clubpenguin.stamps.StampBookCover implements com.clubpenguin.stamps.IStampBookCover
{
    var coverItems, colourID, highlightID, patternID, claspIconArtID;
    function StampBookCover(coverItems, colourID, highlightID, patternID, claspIconArtID)
    {
        this.coverItems = coverItems;
        this.colourID = colourID;
        this.highlightID = highlightID;
        this.patternID = patternID;
        this.claspIconArtID = claspIconArtID;
    } // End of the function
    function getColourID()
    {
        return (colourID);
    } // End of the function
    function setColourID(id)
    {
        colourID = id;
    } // End of the function
    function getHighlightID()
    {
        return (highlightID);
    } // End of the function
    function setHighlightID(id)
    {
        highlightID = id;
    } // End of the function
    function getPatternID()
    {
        return (patternID);
    } // End of the function
    function setPatternID(id)
    {
        patternID = id;
    } // End of the function
    function getClaspIconArtID()
    {
        return (claspIconArtID);
    } // End of the function
    function setClaspIconArtID(id)
    {
        claspIconArtID = id;
    } // End of the function
    function getCoverItems()
    {
        return (coverItems);
    } // End of the function
    function setCoverItems(coverItems)
    {
        this.coverItems = coverItems;
    } // End of the function
} // End of Class
