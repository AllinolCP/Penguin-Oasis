class com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging
{
    function PuffleCareStationLogging()
    {
    } // End of the function
    static function sendPuffleCareStationBI(careStationName, careStationAction, careItem)
    {
        var _loc6 = new Object();
        var _loc2 = _global.getCurrentShell().getMyPlayerObject().attachedPuffle.color;
        if (_global.getCurrentShell().getMyPlayerObject().attachedPuffle.isWildPuffle())
        {
            _loc2 = _loc2 + ("_" + String(_global.getCurrentShell().getMyPlayerObject().attachedPuffle.subTypeID));
        } // end if
        var _loc5;
        var _loc3 = _global.getCurrentEngine().puffleCareEmoteManager;
        var _loc4 = "no";
        if (careItem != undefined && careItem != null)
        {
            _loc5 = "|menu=" + String(careItem);
        }
        else
        {
            _loc5 = "";
        } // end else if
        if (_loc3.careStationTypeEmoted != null && _loc3.careStationTypeEmoted == careStationAction)
        {
            _loc4 = _loc3.careStationTypeEmoted;
        } // end if
        _loc6.message = "station_type=" + careStationName + "|puffle=" + _loc2 + _loc5 + "|emoted=" + _loc4;
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(careStationAction, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.LOGGING_TYPE, _loc6);
    } // End of the function
    static var LOGGING_TYPE = "puffle_station";
} // End of Class
