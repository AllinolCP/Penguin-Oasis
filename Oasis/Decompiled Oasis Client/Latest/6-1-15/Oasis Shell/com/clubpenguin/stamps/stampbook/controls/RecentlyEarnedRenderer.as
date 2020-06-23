class com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedRenderer extends com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer
{
    var _stampLookUp, _shell, _filePath, _data, _initialized, configUI, load;
    function RecentlyEarnedRenderer()
    {
        super();
        _stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
        _filePath = _shell.getPath("stampbook_stamps");
    } // End of the function
    function setModel(data)
    {
        _data = data;
        if (!_initialized)
        {
            this.configUI();
        } // end if
        this.load();
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedRenderer;
    static var LINKAGE_ID = "RecentlyEarnedRenderer";
} // End of Class
