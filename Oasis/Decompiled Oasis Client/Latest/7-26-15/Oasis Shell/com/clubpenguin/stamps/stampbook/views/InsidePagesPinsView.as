class com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
{
    var _shell, _filePath, list, content_holder_mc, pinIconLoader, descriptionBox, pinLoadMc, pinIconHolder, _model, title_txt;
    function InsidePagesPinsView()
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
        content_holder_mc[com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.CONTENT_LIST_CLIP_NAME].removeMovieClip();
        list.removeEventListener("over", onItemRollOver, this);
        list.removeEventListener("out", onItemRollOut, this);
    } // End of the function
    function configUI()
    {
        pinIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        super.configUI();
    } // End of the function
    function populateUI()
    {
        descriptionBox.__set__singleLine(true);
        if (pinLoadMc)
        {
            pinLoadMc.removeMovieClip();
        } // end if
        pinLoadMc = pinIconHolder.attachMovie(com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView.BLANK_CLIP_LINKAGE_ID, "clip", 1, {_x: 0, _y: 0});
        pinIconLoader.loadClip(_filePath + _model.getID() + ".swf", pinLoadMc);
        title_txt.text = _model.getName();
        if (list)
        {
            list.__set__dataProvider(_model.getItems());
            return;
        } // end if
        list = com.clubpenguin.stamps.stampbook.controls.List(content_holder_mc.attachMovie("ListBrown", com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.CONTENT_LIST_CLIP_NAME, content_holder_mc.getNextHighestDepth()));
        list.addEventListener("over", onItemRollOver, this);
        list.addEventListener("out", onItemRollOut, this);
        list.init(com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.LIST_WIDTH, com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.LIST_HEIGHT, com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.ITEM_RENDERER, com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.RENDERER_WIDTH, com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.RENDERER_HEIGHT, com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.LIST_PADDING, false);
        list.__set__dataProvider(_model.getItems());
        list.move(0, 0);
        list.scrollBar._visible = list.__get__dataProvider().length > 0;
    } // End of the function
    function onItemRollOver(event)
    {
        descriptionBox._x = event.target._x + com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.DESCRIPTIONBOX_X_OFFSET;
        descriptionBox._y = event.target._y + com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.DESCRIPTIONBOX_Y_OFFSET;
        descriptionBox.setModel(event.data);
    } // End of the function
    function onItemRollOut(event)
    {
        descriptionBox._x = -1000;
        descriptionBox._y = -1000;
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView;
    static var LINKAGE_ID = "InsidePagesPinsView";
    static var CONTENT_LIST_CLIP_NAME = "contentList";
    static var ITEM_RENDERER = "BaseItemRenderer";
    static var RENDERER_WIDTH = 55.850000;
    static var RENDERER_HEIGHT = 51.900000;
    static var LIST_PADDING = 20;
    static var LIST_WIDTH = 560;
    static var LIST_HEIGHT = 340;
    static var DESCRIPTIONBOX_X_OFFSET = 25;
    static var DESCRIPTIONBOX_Y_OFFSET = 7;
} // End of Class
