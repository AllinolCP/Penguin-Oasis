class com.clubpenguin.stamps.stampbook.controls.AbstractControl extends MovieClip
{
    var _shell, _data;
    function AbstractControl()
    {
        super();
        com.clubpenguin.util.EventDispatcher.initialize(this);
        _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
    } // End of the function
    function onLoad()
    {
        this.configUI();
    } // End of the function
    function setModel(data)
    {
        _data = data;
        if (_initialized)
        {
            this.populateUI();
        } // end if
    } // End of the function
    function configUI()
    {
        _initialized = true;
        if (_data != null)
        {
            this.populateUI();
        } // end if
    } // End of the function
    function populateUI()
    {
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.AbstractControl;
    static var LINKAGE_ID = "AbstractControl";
    static var BLANK_CLIP_LINKAGE_ID = "Blank";
    var _initialized = false;
} // End of Class
