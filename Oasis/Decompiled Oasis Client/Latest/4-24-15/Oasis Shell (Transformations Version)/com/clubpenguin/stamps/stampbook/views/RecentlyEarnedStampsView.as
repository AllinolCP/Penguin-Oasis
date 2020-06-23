class com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView extends com.clubpenguin.stamps.stampbook.views.BaseView
{
    var _shell, _stampManager, background, mouseBlocker, closeBtn, _model, title, description, congratulationsMessage, _selectedCoordinates, stampsHolder, descriptionBox, stampsList, dispatchEvent;
    function RecentlyEarnedStampsView()
    {
        super();
        _stampManager = _shell.getStampManager();
    } // End of the function
    function getWidth()
    {
        return (background._width);
    } // End of the function
    function getHeight()
    {
        return (background._height);
    } // End of the function
    function cleanUp()
    {
    } // End of the function
    function configUI()
    {
        super.configUI();
        mouseBlocker.useHandCursor = false;
        closeBtn.addEventListener("release", onCloseButtonPressed, this);
    } // End of the function
    function populateUI()
    {
        var _loc2 = _model.length;
        switch (_loc2)
        {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            {
                this.drawGrid();
                break;
            } 
            default:
            {
                this.drawList();
                break;
            } 
        } // End of switch
        title.text = _shell.getLocalizedString("recently_earned_title");
        description.text = _shell.getLocalizedString("recently_earned_description");
        var _loc3 = _loc2 > 1 ? (_shell.getLocalizedString("recently_earned_congrats_multiple_stamp")) : (_shell.getLocalizedString("recently_earned_congrats_single_stamp"));
        congratulationsMessage.text = _shell.replace_m(_loc3, [_loc2]);
    } // End of the function
    function drawGrid()
    {
        var _loc5 = _model.length;
        var _loc6 = _loc5 - 1;
        _selectedCoordinates = _coordinate[_loc6];
        var _loc7 = stampsHolder.attachMovie("ListBackground", "listBackground", stampsHolder.getNextHighestDepth());
        _loc7._width = _dimensions[_loc6].width;
        _loc7._height = _dimensions[_loc6].height;
        var _loc4 = stampsHolder.createEmptyMovieClip("gridHolder", stampsHolder.getNextHighestDepth());
        for (var _loc2 = 0; _loc2 < _loc5; ++_loc2)
        {
            var _loc3 = com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedRenderer(_loc4.attachMovie(com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.ITEM_RENDERER, "itemRenderer" + _loc2, _loc4.getNextHighestDepth()));
            _loc3.useHandCursor = false;
            _loc3.addEventListener("over", onStampItemRollOver, this);
            _loc3.addEventListener("out", onStampItemRollOut, this);
            _loc3.setScale(com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.STAMP_BOOK_ITEM_ART_SCALE, com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.STAMP_BOOK_ITEM_ART_SCALE);
            _loc3.move(_selectedCoordinates[_loc2].x, _selectedCoordinates[_loc2].y);
            _loc3.setModel(_model[_loc2]);
        } // end of for
        _loc4._x = com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
        _loc4._y = com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
        stampsHolder._x = background._width - stampsHolder._width >> 1;
        congratulationsMessage._y = stampsHolder._y + stampsHolder._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
        background._height = background._y + congratulationsMessage._y + congratulationsMessage._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
    } // End of the function
    function onStampItemRollOver(event)
    {
        var _loc2 = MovieClip(event.target);
        descriptionBox._x = stampsHolder._x + _loc2._x - _loc2._width + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.DESCRIPTIONBOX_X_OFFSET;
        descriptionBox._y = stampsHolder._y + _loc2._y - _loc2._height / 2 - descriptionBox._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.DESCRIPTIONBOX_Y_OFFSET;
        descriptionBox.setModel(event.data);
    } // End of the function
    function onStampItemRollOut(event)
    {
        this.onStampListRollOut(event);
    } // End of the function
    function drawList()
    {
        var _loc2 = 5;
        var _loc4 = _dimensions[_loc2].width;
        var _loc3 = _dimensions[_loc2].height;
        stampsList = com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedList(stampsHolder.attachMovie(com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.LIST_LINKAGE_ID, "stamps_list", stampsHolder.getNextHighestDepth()));
        stampsList.addEventListener("loadInit", onStampsListInit, this);
        stampsList.addEventListener("over", onStampsListRollOver, this);
        stampsList.addEventListener("out", onStampListRollOut, this);
        stampsList.init(_loc4, _loc3, com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.ITEM_RENDERER, com.clubpenguin.stamps.StampManager.STAMP_ICON_BOX_WIDTH, com.clubpenguin.stamps.StampManager.STAMP_ICON_BOX_HEIGHT, com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING);
        stampsList.__set__dataProvider(Array(_model)[0]);
        stampsList.move(0, 0);
    } // End of the function
    function onStampsListInit(event)
    {
        stampsHolder._x = background._width - stampsHolder._width >> 1;
        stampsHolder._y = description._y + description._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
        congratulationsMessage._y = stampsHolder._y + stampsHolder._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
        background._height = background._y + congratulationsMessage._y + congratulationsMessage._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
    } // End of the function
    function onCloseButtonPressed()
    {
        this.dispatchEvent({type: "close"});
    } // End of the function
    function onStampsListRollOver(event)
    {
        var _loc2 = MovieClip(event.target);
        descriptionBox._x = stampsHolder._x + _loc2._x + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.DESCRIPTIONBOX_X_OFFSET;
        descriptionBox._y = stampsHolder._y + _loc2._y - descriptionBox._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.DESCRIPTIONBOX_Y_OFFSET;
        descriptionBox.setModel(event.data);
    } // End of the function
    function onStampListRollOut(event)
    {
        descriptionBox._x = -1000;
        descriptionBox._y = -1000;
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView;
    static var LINKAGE_ID = "RecentlyEarnedStampsView";
    static var LIST_LINKAGE_ID = "RecentlyEarnedList";
    static var ITEM_RENDERER = "RecentlyEarnedRenderer";
    static var STAMP_BOOK_ITEM_ART_SCALE = 100;
    static var PADDING = 10;
    static var DESCRIPTIONBOX_X_OFFSET = 5;
    static var DESCRIPTIONBOX_Y_OFFSET = 15;
    var _coordinate = [[{x: 35, y: 32.750000}], [{x: 35, y: 32.750000}, {x: 115, y: 32.750000}], [{x: 35, y: 32.750000}, {x: 115, y: 32.750000}, {x: 195, y: 32.750000}], [{x: 35, y: 32.750000}, {x: 115, y: 32.750000}, {x: 35, y: 108.250000}, {x: 115, y: 108.250000}], [{x: 35, y: 32.750000}, {x: 115, y: 32.750000}, {x: 195, y: 32.750000}, {x: 80, y: 108.250000}, {x: 160, y: 108.250000}], [{x: 35, y: 32.750000}, {x: 115, y: 32.750000}, {x: 195, y: 32.750000}, {x: 35, y: 108.250000}, {x: 115, y: 108.250000}, {x: 195, y: 108.250000}]];
    var _dimensions = [{width: 90, height: 85.500000}, {width: 170, height: 85.500000}, {width: 250, height: 85.500000}, {width: 170, height: 161}, {width: 250, height: 161}, {width: 250, height: 161}];
} // End of Class
