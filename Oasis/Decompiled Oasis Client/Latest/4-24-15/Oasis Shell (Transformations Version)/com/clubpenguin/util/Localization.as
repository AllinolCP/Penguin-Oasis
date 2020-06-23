class com.clubpenguin.util.Localization
{
    function Localization()
    {
    } // End of the function
    static function getLocalizedNickname(penguinID, username, approvedLanguagesBitmask, currentLanguageBitmask)
    {
        if (approvedLanguagesBitmask & currentLanguageBitmask)
        {
            return (username);
        } // end if
        return (com.clubpenguin.util.Localization.PENGUIN_ID_PREFIX + String(penguinID));
    } // End of the function
    static var PENGUIN_ID_PREFIX = "P";
} // End of Class
