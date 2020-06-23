class com.clubpenguin.lib.event.ToggleEvent extends com.clubpenguin.lib.event.Event
{
    function ToggleEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    static var ON = "toggleEventOn";
    static var OFF = "toggleEventOff";
} // End of Class
