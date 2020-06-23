class com.clubpenguin.shell.AbstractPuffle
{
    var _model, __get__id, __get__typeID;
    function AbstractPuffle(model)
    {
        com.clubpenguin.util.EventDispatcher.initialize(this);
        _model = model;
    } // End of the function
    function get id()
    {
        //return (_model.id());
    } // End of the function
    function get typeID()
    {
        //return (_model.typeID());
    } // End of the function
    function cleanUp()
    {
        _model = null;
    } // End of the function
} // End of Class
