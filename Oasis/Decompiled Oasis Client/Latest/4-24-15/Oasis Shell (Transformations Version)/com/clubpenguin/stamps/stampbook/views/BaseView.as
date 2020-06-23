class com.clubpenguin.stamps.stampbook.views.BaseView extends MovieClip
{
    var _shell, _model;
    function BaseView()
    {
        super();
        _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
        com.clubpenguin.util.EventDispatcher.initialize(this);
    } // End of the function
    function onLoad()
    {
        this.configUI();
    } // End of the function
    function reset()
    {
    } // End of the function
    function cleanUp()
    {
    } // End of the function
    function setModel(_model)
    {
        this._model = _model;
        if (_initialized)
        {
            this.populateUI();
        } // end if
    } // End of the function
    function configUI()
    {
        _initialized = true;
        if (_model != null)
        {
            this.populateUI();
        } // end if
    } // End of the function
    function populateUI()
    {
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.BaseView;
    static var LINKAGE_ID = "BaseView";
    var _initialized = false;
} // End of Class
