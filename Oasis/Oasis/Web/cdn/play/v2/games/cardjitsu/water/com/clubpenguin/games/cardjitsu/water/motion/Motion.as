class com.clubpenguin.games.cardjitsu.water.motion.Motion implements com.clubpenguin.lib.event.IEventDispatcher, com.clubpenguin.lib.IDisposable
{
    var __uid;
    function Motion()
    {
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.motion.Motion.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.motion.Motion.$_instanceCount;
    } // End of the function
    function updateMotion()
    {
    } // End of the function
    function startMotion()
    {
    } // End of the function
    function dispose()
    {
    } // End of the function
    function toString()
    {
        return (this.getUniqueName());
    } // End of the function
    function getUniqueName()
    {
        return ("[Motion<" + __uid + ">]");
    } // End of the function
    function abort()
    {
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
