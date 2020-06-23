class com.clubpenguin.util.JSONLoader extends com.clubpenguin.util.EventDispatcher
{
    var loadVars, onData, updateListeners;
    function JSONLoader()
    {
        super();
    } // End of the function
    function load(url)
    {
        raw = "";
        data = null;
        loadVars = new LoadVars();
        loadVars.onData = com.clubpenguin.util.Delegate.create(this, onData);
        loadVars.load(url);
    } // End of the function
    null[] = (Error)() == null ? (null, throw , function (jsonText)
    {
        try
        {
            raw = jsonText;
            data = cinqetdemi.JSON.parse(jsonText);
            this.updateListeners(com.clubpenguin.util.JSONLoader.COMPLETE);
        } // End of try
        catch ()
        {
        } // End of catch
    }) : (var e = (Error)(), this.updateListeners(com.clubpenguin.util.JSONLoader.FAIL), "onData");
    function toString()
    {
        return ("[JSONLoader]");
    } // End of the function
    static var COMPLETE = "complete";
    static var FAIL = "fail";
    static var CLASS_NAME = "com.clubpenguin.util.JSONLoader";
    var raw = "";
    var data = null;
} // End of Class
