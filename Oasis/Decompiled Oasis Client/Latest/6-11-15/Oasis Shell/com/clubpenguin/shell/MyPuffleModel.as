class com.clubpenguin.shell.MyPuffleModel extends com.clubpenguin.shell.AbstractPuffleModel
{
    var _name, __get__name, __set__name;
    function MyPuffleModel()
    {
        super();
    } // End of the function
    function get name()
    {
        return (_name);
    } // End of the function
    function set name(name)
    {
        _name = name;
        //return (this.name());
        null;
    } // End of the function
    function cleanUp()
    {
        super.cleanUp();
        _name = null;
    } // End of the function
} // End of Class
