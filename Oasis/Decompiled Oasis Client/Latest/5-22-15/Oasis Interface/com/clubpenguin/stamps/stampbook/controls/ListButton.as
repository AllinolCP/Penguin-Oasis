class com.clubpenguin.stamps.stampbook.controls.ListButton extends MovieClip
{
    var _shell, load_mc, _filePath, _model, stampIconLoader, label_field, btnHitArea, _initialized, stampIconHolder, dispatchEvent;
    function ListButton()
    {
        super();
        com.clubpenguin.util.EventDispatcher.initialize(this);
        _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
    } // End of the function
    function onLoad()
    {
        this.configUI();
    } // End of the function
    function populateUI()
    {
        stampIconLoader.loadClip(_filePath + _model.getID() + ".swf", load_mc);
        label_field.text = _model.getName();
        label_field.autoSize = "left";
        btnHitArea._width = label_field._x + label_field._width + com.clubpenguin.stamps.stampbook.controls.ListButton.PADDING;
        label_field.textColor = com.clubpenguin.stamps.stampbook.controls.ListButton.ROLLOUT_COLOR;
    } // End of the function
    function setModel(model)
    {
        _model = model;
        if (_initialized)
        {
            this.populateUI();
        } // end if
    } // End of the function
    function configUI()
    {
        _filePath = _shell.getPath("stampbook_category");
        stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        stampIconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
        load_mc = stampIconHolder.createEmptyMovieClip("load_mc", stampIconHolder.getNextHighestDepth());
        _initialized = true;
        if (_model != null)
        {
            this.populateUI();
        } // end if
    } // End of the function
    function onLoadInit(event)
    {
        var _loc1 = event.target;
        _loc1.btnIcon._alpha = com.clubpenguin.stamps.stampbook.controls.ListButton.ROLLOUT_ALPHA;
    } // End of the function
    function onRollOver()
    {
        var _loc2 = load_mc.btnIcon;
        _loc2._alpha = com.clubpenguin.stamps.stampbook.controls.ListButton.ROLLOVER_ALPHA;
        label_field.textColor = com.clubpenguin.stamps.stampbook.controls.ListButton.ROLLOVER_COLOR;
        this.dispatchEvent({type: "over"});
    } // End of the function
    function onRollOut()
    {
        var _loc2 = load_mc.btnIcon;
        _loc2._alpha = com.clubpenguin.stamps.stampbook.controls.ListButton.ROLLOUT_ALPHA;
        label_field.textColor = com.clubpenguin.stamps.stampbook.controls.ListButton.ROLLOUT_COLOR;
        this.dispatchEvent({type: "out"});
    } // End of the function
    function onPress()
    {
        this.dispatchEvent({type: "press", data: _model});
    } // End of the function
    function onRelease()
    {
        this.dispatchEvent({type: "release", data: _model});
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ListButton;
    static var LINKAGE_ID = "ListButton";
    static var ROLLOVER_ALPHA = 100;
    static var ROLLOUT_ALPHA = 50;
    static var ROLLOVER_COLOR = 3355443;
    static var ROLLOUT_COLOR = 6184542;
    static var PADDING = 10;
} // End of Class
