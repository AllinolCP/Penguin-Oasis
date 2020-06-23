class com.clubpenguin.scrollinglist.ScrollingList
{
    var view, scrollBarMediator, contentOriginY;
    function ScrollingList(view)
    {
        this.view = view;
        view.content.setMask(view.mask);
        scrollBarMediator = new com.clubpenguin.scrollinglist.ScrollBarMediator(view.scrollBar);
        scrollBarMediator.__get__dragged().add(scrollContent, this);
        contentOriginY = view.mask._y;
    } // End of the function
    function scrollContent(yPositionScale)
    {
        var _loc2 = view.content._height - view.mask._height;
        if (_loc2 <= 0)
        {
            return;
        } // end if
        view.content._y = contentOriginY - _loc2 * yPositionScale;
    } // End of the function
} // End of Class
