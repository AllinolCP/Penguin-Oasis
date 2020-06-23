class com.clubpenguin.util.Tools
{
    function Tools()
    {
    } // End of the function
    static function applyClassToInstance(theClass, theInstance, constructorArgs)
    {
        theInstance.__proto__ = theClass.prototype;
        theInstance.__constructor__ = theClass;
        theClass.apply(theInstance, constructorArgs);
    } // End of the function
    static function disableAutoTabbing()
    {
        MovieClip.prototype.tabEnabled = false;
        Button.prototype.tabEnabled = false;
        TextField.prototype.tabEnabled = false;
        Selection.setFocus(null);
    } // End of the function
    static function enableAutoTabbing()
    {
        delete MovieClip.prototype.tabEnabled;
        delete Button.prototype.tabEnabled;
        delete TextField.prototype.tabEnabled;
    } // End of the function
    static function capitalize(str)
    {
        return (str.substr(0, 1).toUpperCase() + str.substr(1, str.length));
    } // End of the function
} // End of Class
