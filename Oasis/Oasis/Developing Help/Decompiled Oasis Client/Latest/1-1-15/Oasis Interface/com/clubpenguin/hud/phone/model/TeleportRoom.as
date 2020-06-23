class com.clubpenguin.hud.phone.model.TeleportRoom
{
    function TeleportRoom(key, serverID, localizedName)
    {
        this.key = key;
        this.serverID = serverID;
        this.localizedName = localizedName;
    } // End of the function
    function toString()
    {
        return ("[TeleportRoom key=\"" + key + "\" serverID=" + serverID + " localizedName=" + localizedName + "]");
    } // End of the function
    var key = "";
    var serverID = -1;
    var localizedName = "";
} // End of Class
