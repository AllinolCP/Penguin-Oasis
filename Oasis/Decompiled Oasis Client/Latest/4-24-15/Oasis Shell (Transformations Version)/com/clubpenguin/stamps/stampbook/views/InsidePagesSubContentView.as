class com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
{
    var _shell, _filePath, list, content_holder_mc, stampIconLoader, load_mc, stampIconHolder, _model, title_txt, dispatchEvent;
    function InsidePagesSubContentView()
    {
        super();
        _filePath = _shell.getPath("stampbook_categoryHeader");
    } // End of the function
    function reset()
    {
        list.reset();
    } // End of the function
    function cleanUp()
    {
        content_holder_mc[com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.CONTENT_LIST_CLIP_NAME].removeMovieClip();
        list.removeEventListener("itemClick", onListItemClick, this);
    } // End of the function
    function configUI()
    {
        stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        super.configUI();
    } // End of the function
    function populateUI()
    {
        if (load_mc)
        {
            load_mc.removeMovieClip();
        } // end if
        load_mc = stampIconHolder.attachMovie(com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView.BLANK_CLIP_LINKAGE_ID, "clip", 1, {_x: 0, _y: 0});
        stampIconLoader.loadClip(_filePath + _model.getID() + ".swf", load_mc);
        title_txt.text = _model.getName();
        if (list)
        {
            list.__set__dataProvider(_model.getSubCategories());
            return;
        } // end if
        list = com.clubpenguin.stamps.stampbook.controls.ContentList(content_holder_mc.attachMovie("ContentList", com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.CONTENT_LIST_CLIP_NAME, content_holder_mc.getNextHighestDepth()));
        list.init(com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.LIST_WIDTH, com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.LIST_HEIGHT, com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.ITEM_RENDERER, com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.RENDERER_WIDTH, com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.RENDERER_HEIGHT, com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.LIST_PADDING);
        list.addEventListener("itemClick", onListItemClick, this);
        list.__set__dataProvider(_model.getSubCategories());
        list.move(0, 0);
    } // End of the function
    function onListItemClick(event)
    {
        this.dispatchEvent(event);
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView;
    static var LINKAGE_ID = "InsidePagesSubContentView";
    static var CONTENT_LIST_CLIP_NAME = "contentList";
    static var ITEM_RENDERER = "ListButton";
    static var RENDERER_WIDTH = 164;
    static var RENDERER_HEIGHT = 30;
    static var LIST_PADDING = 15;
    static var LIST_WIDTH = 545;
    static var LIST_HEIGHT = 225;
} // End of Class
