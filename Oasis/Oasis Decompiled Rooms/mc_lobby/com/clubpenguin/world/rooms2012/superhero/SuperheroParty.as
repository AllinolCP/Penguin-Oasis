class com.clubpenguin.world.rooms2012.superhero.SuperheroParty
{
    function SuperheroParty()
    {
    } // End of the function
    static function canAccessMemberExperience()
    {
        var _loc2 = _global.getCurrentShell();
        return (_loc2.isMyPlayerMember() || _loc2.getTestGroupID() == 0);
    } // End of the function
    static function isVillanPresent(players)
    {
        for (var _loc1 = 0; _loc1 < players.length; ++_loc1)
        {
            return (true);
        } // end of for
        return (false);
    } // End of the function
    static function isPlayerASuperVillan(playerId)
    {
        var _loc3 = _global.getCurrentShell();
        var _loc2 = _loc3.getPlayerObjectById(playerId);
        return (_loc2.avatar_id == 3);
    } // End of the function
    static function isPlayerASuperHero(playerId)
    {
        var _loc3 = _global.getCurrentShell();
        var _loc2 = _loc3.getPlayerObjectById(playerId);
        return (_loc2.avatar_id == 2);
    } // End of the function
    static function isPlayerACivilian(playerId)
    {
        var _loc3 = _global.getCurrentShell();
        var _loc2 = _loc3.getPlayerObjectById(playerId);
        return (_loc2.avatar_id == 4);
    } // End of the function
    static var FREE_CONSTRUCTION_HAT = 429;
    static var FREE_PRESS_HAT = 1129;
    static var FREE_MONEY_BAG = 5153;
    static var MUG_SHOT = 9143;
    static var PRESS_CONFERENCE = 9142;
    static var AUNT_ARCTIC_GIVEAWAY = 9144;
    static var SUPERHERO_PIN = 7111;
    static var SUPERVILLAN_PIN = 7111;
    static var ICE_GLOVES = 5156;
    static var LIGHTNING_GLOVES = 5157;
    static var FIRE_GLOVES = 5158;
    static var HARD_HAT = 403;
    static var OOPS_SKY_KINGDOM_STAFF = "oops_party26_room";
    static var OOPS_MOUNTAIN_GATE = "oops_party26_room";
    static var OOPS_KNIGHTS_QUEST_2 = "oops_party2_room";
    static var OOPS_MEMBER_MOUNTAIN_GATE = "w.p0612.superhero.mountain.needitems";
    static var OOPS_NON_MEMBER_IN_FORT = "oops_party1_room";
    static var DIALOG_CHOOSE_SIDE = "w.p0612.superhero.dialog.chooseside";
    static var PARTY_CATALOG = "w.p0612.superhero.clothing.catalogue";
    static var CLOTHING_CATALOGUE = "w.p0612.superhero.clothing.catalogue";
    static var CIVILLIAN_CATALOGUE = "w.p0612.superhero.civilian.catalogue";
    static var SUPERHERO_ALERT = "w.p0612.superhero.alert";
    static var CONTENT_NEED_STAFF = "w.p0612.superhero.skykingdom.needstaff";
    static var CONTENT_TELESCOPE_CLOSE_UP = "w.p0612.superhero.lighthouse.telescope";
    static var CONTENT_SKY_KINGDOM_SCORN_BATTLE_GATE = "w.p0612.superhero.skygate.note";
    static var CONTENT_TELEPORTER_PROMPT = "w.0612.superhero.herohq.teleportprompt";
    static var VILLIAN_TELEPORTER_PROMPT = "w.0612.superhero.villianhq.teleportprompt";
    static var STAMP_ID_SOLVE_PUZZLE = 183;
    static var STAMP_ID_HIT_50_TARGETS = 185;
} // End of Class
