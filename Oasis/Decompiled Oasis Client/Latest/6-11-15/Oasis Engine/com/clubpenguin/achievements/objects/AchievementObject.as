class com.clubpenguin.achievements.objects.AchievementObject
{
    var _objects, _operation, _debug, __get__debug, _shell, __get__shell, __get__operation, __set__debug, __set__operation, __set__shell;
    function AchievementObject(descriptor)
    {
        _objects = [];
        _operation = com.clubpenguin.achievements.objects.AchievementObject.OPERATION_NONE;
    } // End of the function
    function addElement(descriptor)
    {
        _objects.push(descriptor.shift());
    } // End of the function
    function getCurrentObjects()
    {
        return (_objects);
    } // End of the function
    function set debug(value)
    {
        _debug = value;
        //return (this.debug());
        null;
    } // End of the function
    function set shell(value)
    {
        _shell = value;
        //return (this.shell());
        null;
    } // End of the function
    function set operation(value)
    {
        _operation = value;
        //return (this.operation());
        null;
    } // End of the function
    function get operation()
    {
        return (_operation);
    } // End of the function
    static var LOCALIZE_START_TAG = "localize(\"";
    static var LOCALIZE_END_TAG = "\")";
    static var OPERATION_OR = "or";
    static var OPERATION_AND = "and";
    static var OPERATION_NONE = "none";
} // End of Class
