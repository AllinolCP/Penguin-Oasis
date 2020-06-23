class com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
{
    var _shell, _filePath, list, content_holder_mc, stampIconLoader, stampIconHolder, _model, title_txt, polaroidsPanel, attachMovie, descriptionBox;
    function InsidePagesStampsView()
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
        content_holder_mc[com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.CONTENT_LIST_CLIP_NAME].removeMovieClip();
        list.removeEventListener("over", onItemRollOver, this);
        list.removeEventListener("out", onItemRollOut, this);
    } // End of the function
    function configUI()
    {
        stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        super.configUI();
    } // End of the function
    function populateUI()
    {
        if (stampIconHolder.load_mc)
        {
            stampIconHolder.load_mc.removeMovieClip();
        } // end if
        stampIconHolder.createEmptyMovieClip("load_mc", 1);
        stampIconLoader.loadClip(_filePath + _model.getID() + ".swf", stampIconHolder.load_mc);
        title_txt.text = _model.getName();
        if (polaroidsPanel)
        {
            polaroidsPanel.removeMovieClip();
        } // end if
        this.attachMovie("PolaroidsPanel", "polaroidsPanel", 1, {_x: 463, _y: 98});
        polaroidsPanel.setModel(_model);
        if (list)
        {
            list.__set__dataProvider(_model.getItems());
            return;
        } // end if
        list = com.clubpenguin.stamps.stampbook.controls.List(content_holder_mc.attachMovie("ListBrown", com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.CONTENT_LIST_CLIP_NAME, content_holder_mc.getNextHighestDepth()));
        list.addEventListener("over", onItemRollOver, this);
        list.addEventListener("out", onItemRollOut, this);
        list.init(com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.LIST_WIDTH, com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.LIST_HEIGHT, com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.ITEM_RENDERER, com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.RENDERER_WIDTH, com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.RENDERER_HEIGHT, com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.LIST_PADDING, true);
        list.__set__dataProvider(_model.getItems());
        list.move(0, 0);
    } // End of the function
    function onItemRollOver(event)
    {
        descriptionBox._x = event.target._x + com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.DESCRIPTIONBOX_X_OFFSET;
        descriptionBox._y = event.target._y + com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.DESCRIPTIONBOX_Y_OFFSET;
        descriptionBox.setModel(event.data);
    } // End of the function
    function onItemRollOut(event)
    {
        descriptionBox._x = -1000;
        descriptionBox._y = -1000;
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView;
    static var LINKAGE_ID = "InsidePagesStampsView";
    static var CONTENT_LIST_CLIP_NAME = "contentList";
    static var ITEM_RENDERER = "StampsRenderer";
    static var RENDERER_WIDTH = 58;
    static var RENDERER_HEIGHT = 54;
    static var LIST_PADDING = 30;
    static var LIST_WIDTH = 365;
    static var LIST_HEIGHT = 360;
    static var DESCRIPTIONBOX_X_OFFSET = 20;
    static var DESCRIPTIONBOX_Y_OFFSET = -5;
} // End of Class
