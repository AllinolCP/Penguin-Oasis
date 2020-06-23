class com.clubpenguin.achievements.verbs.AchievementVerbFactory
{
    var _debug, __get__debug, __set__debug;
    function AchievementVerbFactory(debug)
    {
        _debug = debug;
    } // End of the function
    function createVerb(descriptor)
    {
        this.debugTrace("createVerb - " + descriptor.join(" "));
        var _loc3 = String(descriptor.shift());
        switch (_loc3)
        {
            case "hasProperty":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbHasProperty(descriptor, this.debug()));
            } 
            case "owns":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbOwns(descriptor, this.debug()));
            } 
            case "wearing":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbWearing(descriptor, this.debug()));
            } 
            case "in":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbIn(descriptor, this.debug()));
            } 
            case "hits":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbHit(descriptor, this.debug()));
            } 
            case "occurs":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbOccurs(descriptor, this.debug()));
            } 
            case "occursUniquely":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbOccursUniquely(descriptor, this.debug()));
            } 
            case "puffles":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbPuffles(descriptor, this.debug()));
            } 
            case "isOnFrame":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbIsOnFrame(descriptor, this.debug()));
            } 
            case "hasItemID":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbHasID(descriptor, this.debug(), "item_id"));
            } 
            case "hasEmoteID":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbHasID(descriptor, this.debug(), "emote_id"));
            } 
            case "hasEventID":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbHasID(descriptor, this.debug(), "id"));
            } 
            case "hasPenguinColourID":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbHasID(descriptor, this.debug(), "colour_id"));
            } 
            case "containsText":
            {
                //return (new com.clubpenguin.achievements.verbs.AchievementVerbContainsText(descriptor, this.debug()));
            } 
        } // End of switch
        throw new com.clubpenguin.achievements.AchievementException("createVerb did not recognise verbToken:\"" + _loc3 + "\"");
    } // End of the function
    function set debug(state)
    {
        _debug = state;
        //return (this.debug());
        null;
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
