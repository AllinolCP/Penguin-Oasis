class com.clubpenguin.shell.MyPuffle extends com.clubpenguin.shell.AbstractPuffle
{
    var _stats_interval, _model;
    function MyPuffle(model)
    {
        super(model);
    } // End of the function
    function startStats()
    {
        _stats_interval = setInterval(this, "decreaseStats", com.clubpenguin.shell.MyPuffle.STATS_FREQUENCY);
    } // End of the function
    function stopStats()
    {
        clearInterval(_stats_interval);
        _stats_interval = null;
    } // End of the function
    function decreaseStats()
    {
        _model.health = _model.health - _model.__get__maxHealth() * 0.010000;
        _model.hunger = _model.hunger - _model.__get__maxHunger() * 0.010000;
        _model.rest = _model.rest - _model.__get__maxRest() * 0.010000;
    } // End of the function
    function cleanUp()
    {
        super.cleanUp();
        this.stopStats();
        _model = null;
    } // End of the function
    static var STATS_FREQUENCY = 216000;
} // End of Class
