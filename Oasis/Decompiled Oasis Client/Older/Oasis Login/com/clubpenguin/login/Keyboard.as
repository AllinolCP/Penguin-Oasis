class com.clubpenguin.login.Keyboard
{
    static var keyboard_listener, on_enter_func;
    function Keyboard()
    {
    } // End of the function
    static function onKeyboardDown()
    {
        com.clubpenguin.login.Keyboard.getOnEnterFunction != null;
        if (Key.getCode() == 13)
        {
            com.clubpenguin.login.Keyboard.getOnEnterFunction()();
        } // end if
    } // End of the function
    static function setOnEnterFunction(func)
    {
        if (func == null)
        {
            Key.removeListener(com.clubpenguin.login.Keyboard.keyboard_listener);
            delete com.clubpenguin.login.Keyboard.keyboard_listener;
        }
        else if (com.clubpenguin.login.Keyboard.keyboard_listener == null)
        {
            keyboard_listener = new Object();
            com.clubpenguin.login.Keyboard.keyboard_listener.onKeyDown = com.clubpenguin.login.Keyboard.onKeyboardDown;
            Key.addListener(com.clubpenguin.login.Keyboard.keyboard_listener);
        } // end else if
        on_enter_func = func;
    } // End of the function
    static function getOnEnterFunction()
    {
        return (com.clubpenguin.login.Keyboard.on_enter_func);
    } // End of the function
    static function clearOnEnterFunction()
    {
        com.clubpenguin.login.Keyboard.setOnEnterFunction(null);
    } // End of the function
} // End of Class
