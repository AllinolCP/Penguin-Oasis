class com.clubpenguin.stamps.stampbook.views.InsidePagesContentView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
{
    var _buttonsList, content_holder_mc, title_txt, _shell, legend, _model, dispatchEvent;
    function InsidePagesContentView()
    {
        super();
    } // End of the function
    function cleanUp()
    {
        var _loc4 = _buttonsList.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            _buttonsList[_loc2].removeEventListener("press", onContentBtnPressed, this);
        } // end of for
        _loc4 = com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.NUM_COLUMNS * com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.NUM_ROWS;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            var _loc3 = content_holder_mc["listButton" + _loc2];
            if (_loc3)
            {
                _loc3.removeMovieClip();
            } // end if
        } // end of for
    } // End of the function
    function configUI()
    {
        _buttonsList = [];
        title_txt.text = _shell.getLocalizedString("contents_category_title");
        legend.titleText.text = _shell.getLocalizedString("toc_legend_title");
        legend.easyText.text = _shell.getLocalizedString("toc_legend_easy");
        legend.mediumText.text = _shell.getLocalizedString("toc_legend_medium");
        legend.hardText.text = _shell.getLocalizedString("toc_legend_hard");
        legend.extremeText.text = _shell.getLocalizedString("toc_legend_extreme");
        legend.memberText.text = _shell.getLocalizedString("toc_legend_member");
        legend.newText.text = _shell.getLocalizedString("toc_legend_new");
        legend.editText.text = _shell.getLocalizedString("toc_legend_edit");
        legend.saveText.text = _shell.getLocalizedString("toc_legend_save");
        legend.newClip.gotoAndStop(_shell.getLocalizedFrame());
        super.configUI();
    } // End of the function
    function populateUI()
    {
        var _loc5 = _buttonsList.length;
        if (_loc5 > 0)
        {
            for (var _loc4 = 0; _loc4 < _loc5; ++_loc4)
            {
                var _loc3 = _model[_loc4];
                if (_loc3.getID() == undefined || _loc3.getID() == com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID)
                {
                    continue;
                } // end if
                var _loc2 = com.clubpenguin.stamps.stampbook.controls.ListButton(_buttonsList[_loc4]);
                _loc2.setModel(_loc3);
                _loc2.indexNumber = _loc4;
            } // end of for
            return;
        } // end if
        _loc5 = com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.NUM_COLUMNS * com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.NUM_ROWS;
        for (var _loc4 = 0; _loc4 < _loc5; ++_loc4)
        {
            _loc3 = _model[_loc4];
            if (_loc3.getID() == undefined || _loc3.getID() == com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID)
            {
                continue;
            } // end if
            _loc2 = com.clubpenguin.stamps.stampbook.controls.ListButton(content_holder_mc.attachMovie(com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.BUTTON_RENDERER, "listButton" + _loc4, content_holder_mc.getNextHighestDepth()));
            _loc2.addEventListener("press", onContentBtnPressed, this);
            _loc2._x = _loc4 % com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.NUM_COLUMNS * (_loc2._width + com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.HORIZONTAL_PADDING);
            _loc2._y = Math.floor(_loc4 / com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.NUM_COLUMNS) * (_loc2._height + com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.VERTICAL_PADDING);
            _loc2.setModel(_loc3);
            _loc2.indexNumber = _loc4;
            _buttonsList.push(_loc2);
        } // end of for
    } // End of the function
    function onContentBtnPressed(event)
    {
        var _loc3 = com.clubpenguin.stamps.stampbook.controls.ListButton(event.target);
        var _loc2 = event.data;
        this.dispatchEvent({type: "itemClick", category: _loc2.getName(), index: _loc3.indexNumber});
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesContentView;
    static var LINKAGE_ID = "InsidePagesContentView";
    static var NUM_COLUMNS = 2;
    static var NUM_ROWS = 5;
    static var VERTICAL_PADDING = 10;
    static var HORIZONTAL_PADDING = 38;
    static var BUTTON_RENDERER = "ListButton";
} // End of Class
