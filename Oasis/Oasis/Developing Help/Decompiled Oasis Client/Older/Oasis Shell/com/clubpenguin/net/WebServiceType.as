class com.clubpenguin.net.WebServiceType
{
    var _name, _webServiceCrumbPath, _isLocalized, __get__isLocalized, __get__name, __get__webServiceCrumbPath;
    function WebServiceType(name, webServiceCrumbPath, isLocalized)
    {
        _name = name;
        _webServiceCrumbPath = webServiceCrumbPath;
        _isLocalized = isLocalized;
    } // End of the function
    static function getServiceTypes()
    {
        return ([com.clubpenguin.net.WebServiceType.STAMPS, com.clubpenguin.net.WebServiceType.POLAROIDS, com.clubpenguin.net.WebServiceType.STAMPBOOK_COVER, com.clubpenguin.net.WebServiceType.GAMES, com.clubpenguin.net.WebServiceType.ANALYTICS]);
    } // End of the function
    function get name()
    {
        return (_name);
    } // End of the function
    function get webServiceCrumbPath()
    {
        return (_webServiceCrumbPath);
    } // End of the function
    function get isLocalized()
    {
        return (_isLocalized);
    } // End of the function
    function toString()
    {
        return (_name);
    } // End of the function
    static var IS_LOCALIZED = true;
    static var IS_NOT_LOCALIZED = false;
    static var GAMES = new com.clubpenguin.net.WebServiceType("Games", "web_service/games.php", com.clubpenguin.net.WebServiceType.IS_LOCALIZED);
    static var STAMPS = new com.clubpenguin.net.WebServiceType("Stamps", "web_service/stamps.php", com.clubpenguin.net.WebServiceType.IS_LOCALIZED);
    static var POLAROIDS = new com.clubpenguin.net.WebServiceType("Polaroids", "web_service/polaroids.php", com.clubpenguin.net.WebServiceType.IS_LOCALIZED);
    static var STAMPBOOK_COVER = new com.clubpenguin.net.WebServiceType("StampBook Cover", "web_service/cover.php", com.clubpenguin.net.WebServiceType.IS_LOCALIZED);
    static var ANALYTICS = new com.clubpenguin.net.WebServiceType("Analytics", "web_service/weblogger.php", com.clubpenguin.net.WebServiceType.IS_NOT_LOCALIZED);
} // End of Class
