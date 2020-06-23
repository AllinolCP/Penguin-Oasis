class com.clubpenguin.hud.phone.model.PhoneState extends com.clubpenguin.util.Enumeration
{
    var id, layout, isTeleportEnabled, viewID;
    function PhoneState(id, layout, isTeleportEnabled, viewID)
    {
        super();
        this.id = id || "no  id";
        this.layout = layout || com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT;
        this.isTeleportEnabled = isTeleportEnabled || true;
        this.viewID = viewID;
        com.clubpenguin.hud.phone.model.PhoneState.stateLookup[this.id] = this;
    } // End of the function
    static function getStateByIconID(iconID)
    {
        return (com.clubpenguin.hud.phone.model.PhoneState.stateLookup[iconID]);
    } // End of the function
    static var stateLookup = new Object();
    static var CLOSING = new com.clubpenguin.hud.phone.model.PhoneState("closing", com.clubpenguin.hud.phone.model.PhoneLayout.CLOSED, true);
    static var CLOSED = new com.clubpenguin.hud.phone.model.PhoneState("closed", com.clubpenguin.hud.phone.model.PhoneLayout.CLOSED, true);
    static var APP_MENU = new com.clubpenguin.hud.phone.model.PhoneState("appMenu", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, true, "appMenu");
    static var TELEPORT = new com.clubpenguin.hud.phone.model.PhoneState("teleport", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, true, "teleport");
    static var TELEPORTING = new com.clubpenguin.hud.phone.model.PhoneState("teleporting", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, false);
    static var RECRUIT = new com.clubpenguin.hud.phone.model.PhoneState("recruit", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, true, "recruit");
    static var PUFFLE = new com.clubpenguin.hud.phone.model.PhoneState("puffle", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, true, "puffle");
    static var FIELD_OPS = new com.clubpenguin.hud.phone.model.PhoneState("fieldOps", com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT, true, "fieldOps");
    static var FIELD_OPS_OBJECTIVE = new com.clubpenguin.hud.phone.model.PhoneState("fieldOpObjective", com.clubpenguin.hud.phone.model.PhoneLayout.LANDSCAPE, false, "fieldOpObjective");
    static var AGENT_STATUS = new com.clubpenguin.hud.phone.model.PhoneState("agentStatus", com.clubpenguin.hud.phone.model.PhoneLayout.LANDSCAPE_LARGE, true, "agentStatus");
} // End of Class
