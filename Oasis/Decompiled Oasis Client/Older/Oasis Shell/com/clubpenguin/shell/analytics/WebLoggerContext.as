class com.clubpenguin.shell.analytics.WebLoggerContext extends com.clubpenguin.shell.analytics.AnalyticsContext
{
    var _categoryMap, _categoryIndexMap, __get__categoryMap, __get__categoryIndexMap, __set__categoryIndexMap, __set__categoryMap;
    function WebLoggerContext()
    {
        super();
        _categoryMap = {};
        _categoryIndexMap = {};
    } // End of the function
    function initFromConfig(config)
    {
        super.initFromConfig(config);
        _categoryMap = config.categoryMap;
        _categoryIndexMap = config.CATEGORY_INDEX_MAP;
    } // End of the function
    function get categoryMap()
    {
        return (_categoryMap);
    } // End of the function
    function set categoryMap(map)
    {
        _categoryMap = map;
        //return (this.categoryMap());
        null;
    } // End of the function
    function get categoryIndexMap()
    {
        return (_categoryIndexMap);
    } // End of the function
    function set categoryIndexMap(map)
    {
        _categoryIndexMap = map;
        //return (this.categoryIndexMap());
        null;
    } // End of the function
    function toString()
    {
        var _loc3 = super();
        _loc3 = _loc3 + ("\n   _categoryMap=" + _categoryMap);
        _loc3 = _loc3 + ("\n   _categoryIndexMap=" + _categoryIndexMap);
        return (_loc3);
    } // End of the function
} // End of Class
