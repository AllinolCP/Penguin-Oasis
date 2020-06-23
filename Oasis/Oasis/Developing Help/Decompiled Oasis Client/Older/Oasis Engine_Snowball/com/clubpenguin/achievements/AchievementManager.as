class com.clubpenguin.achievements.AchievementManager
{
    var _achievementXmls, _shell, _engine, _interface, _achievementChecks, _achievementGroups;
    var _loc1 = (com.clubpenguin.achievements.AchievementException)() == null ? (null, throw , function (shell, engine, interfaceClip)
    {
        _achievementXmls = [];
        _shell = shell;
        _engine = engine;
        _interface = interfaceClip;
        com.clubpenguin.achievements.AchievementTools.__set__shell(_shell);
        com.clubpenguin.achievements.AchievementTools.__set__engine(_engine);
        _achievementChecks = [];
        _achievementGroups = [];
        _shell.addListener(_shell.ACHIEVEMENT_DONE, deleteAchievement, this);
        try
        {
            this.loadAchievementsXml(_shell.getWebService().url + com.clubpenguin.achievements.AchievementManager.ACHIEVEMENT_XML_LOCATION);
        } // End of try
        catch ()
        {
        } // End of catch
    }) : (var ae = (com.clubpenguin.achievements.AchievementException)(), "AchievementManager");
    null[com.clubpenguin.achievements] = (com.clubpenguin.achievements.AchievementException)() == null ? (null, throw , function (shell, engine, interfaceClip)
    {
        _achievementXmls = [];
        _shell = shell;
        _engine = engine;
        _interface = interfaceClip;
        com.clubpenguin.achievements.AchievementTools.__set__shell(_shell);
        com.clubpenguin.achievements.AchievementTools.__set__engine(_engine);
        _achievementChecks = [];
        _achievementGroups = [];
        _shell.addListener(_shell.ACHIEVEMENT_DONE, deleteAchievement, this);
        try
        {
            this.loadAchievementsXml(_shell.getWebService().url + com.clubpenguin.achievements.AchievementManager.ACHIEVEMENT_XML_LOCATION);
        } } // End of try
        catch ()
        {
        } } // End of catch
    }) : (var ae = (com.clubpenguin.achievements.AchievementException)(), "AchievementManager");
    function deleteAllEarnedAchievements()
    {
        var _loc3 = _shell.getStampManager().myStamps;
        var _loc4 = _loc3.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            this.deleteAchievement(String(_loc3[_loc2].getID()));
        } // end of for
    } // End of the function
    function deleteAchievement(achievementID)
    {
        var _loc7 = _achievementGroups.length;
        for (var _loc3 = 0; _loc3 < _loc7; ++_loc3)
        {
            var _loc4 = _achievementGroups[_loc3].achievements;
            var _loc6 = _loc4.length;
            for (var _loc2 = 0; _loc2 < _loc6; ++_loc2)
            {
                if (_loc4[_loc2].id == achievementID)
                {
                    return;
                } // end if
            } // end of for
        } // end of for
        var _loc9 = this.getAchievementIndex(achievementID);
        if (_loc9 >= 0)
        {
            var _loc8 = _achievementChecks[_loc9].name;
            _achievementChecks[_loc9].destroy();
            _achievementChecks.splice(_loc9, 1);
            _loc6 = _achievementChecks.length;
            for (var _loc3 = 0; _loc3 < _loc6; ++_loc3)
            {
                if (_achievementChecks[_loc3].name == _loc8)
                {
                    this.deleteAchievement(_achievementChecks[_loc3].id);
                } // end if
            } // end of for
        } // end if
    } // End of the function
    function getAchievementIndex(achievementID)
    {
        var _loc3 = _achievementChecks.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (_achievementChecks[_loc2].id == achievementID)
            {
                return (_loc2);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    function loadAchievementsXml(path)
    {
        var _loc2 = new XML();
        _loc2.ignoreWhite = true;
        _loc2.onLoad = com.clubpenguin.util.Delegate.create(this, onAchievementsXmlLoaded, _loc2, path);
        _loc2.load(path);
        _achievementXmls.push(_loc2);
    } // End of the function
    function onAchievementsXmlLoaded(success, achievementDoc, filePath)
    {
        if (success)
        {
            try
            {
                for (var _loc2 = achievementDoc.firstChild; _loc2 != null; _loc2 = _loc2.nextSibling)
                {
                    if (_loc2.nodeName == com.clubpenguin.achievements.AchievementManager.XML_NODENAME_ACHIEVEMENT_DOCUMENT)
                    {
                        this.parseAchievementDocument(_loc2);
                    } // end if
                } // end of for
            } // End of try
            catch ()
            {
            } // End of catch
        } // end if
        this.debugDump();
    } // End of the function
    function parseAchievementDocument(node)
    {
        var _loc5 = [];
        while (node != null)
        {
            var _loc4 = node.childNodes;
            for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
            {
                var _loc2 = _loc4[_loc3];
                if (_loc2.nodeName == com.clubpenguin.achievements.AchievementManager.XML_NODENAME_ACHIEVEMENT)
                {
                    this.parseAchievement(_loc2);
                    continue;
                } // end if
                if (_loc2.nodeName == com.clubpenguin.achievements.AchievementManager.XML_NODENAME_ACHIEVEMENT_GROUP)
                {
                    _loc5.push(_loc2);
                } // end if
            } // end of for
            node = node.nextSibling;
        } // end while
        for (var _loc7 = 0; _loc7 < _loc5.length; ++_loc7)
        {
            this.parseGroupAchievement(_loc5[_loc7]);
        } // end of for
    } // End of the function
    function parseAchievement(node)
    {
        var _loc3 = new com.clubpenguin.achievements.AchievementCheck(_shell);
        _loc3.__set__name(node.attributes.name);
        _loc3.__set__id(node.attributes.id);
        for (var _loc2 = node.firstChild; _loc2 != null; _loc2 = _loc2.nextSibling)
        {
            if (_loc2.nodeName == com.clubpenguin.achievements.AchievementManager.XML_NODENAME_ACHIEVEMENT_EVENT)
            {
                _loc3.addEvent(String(_loc2.firstChild));
                continue;
            } // end if
            if (_loc2.nodeName == com.clubpenguin.achievements.AchievementManager.XML_NODENAME_ACHIEVEMENT_CONDITION)
            {
                _loc3.addCondition(String(_loc2.firstChild), false);
                continue;
            } // end if
            if (_loc2.nodeName == com.clubpenguin.achievements.AchievementManager.XML_NODENAME_ACHIEVEMENT_OPTIONAL_CONDITION)
            {
                _loc3.addCondition(String(_loc2.firstChild), true);
                continue;
            } // end if
            if (_loc2.nodeName == com.clubpenguin.achievements.AchievementManager.XML_NODENAME_ACHIEVEMENT_RESULT)
            {
                _loc3.addResult(String(_loc2.firstChild));
                continue;
            } // end if
            if (_loc2.nodeName == com.clubpenguin.achievements.AchievementManager.XML_NODENAME_DEBUG)
            {
                var _loc5 = String(_loc2.firstChild).toLowerCase() == "true";
                _loc3.__set__debug(_loc5);
                continue;
            } // end if
            if (_loc2.nodeName == com.clubpenguin.achievements.AchievementManager.XML_NODENAME_EXPIRY_DATE)
            {
                var _loc6 = String(_loc2.firstChild);
                var _loc4 = new Date();
                if (_loc4.getTime() >= Number(_loc6 * com.clubpenguin.achievements.AchievementManager.MILLISECONDS))
                {
                    _loc3.destroy();
                    return;
                } // end if
                continue;
            } // end if
            throw new com.clubpenguin.achievements.AchievementException("AchievementManager::parseAchievement() - There was an error creating achievement \"" + _loc3.__get__name() + "\" - the XML property \"" + _loc2.nodeName + "\" was not recognised.");
        } // end of for
        _achievementChecks.push(_loc3);
    } // End of the function
    function parseGroupAchievement(node)
    {
        var _loc9 = true;
        var _loc4 = new com.clubpenguin.achievements.AchievementGroup(_shell);
        _loc4.__set__name(node.attributes.name);
        _loc4.__set__id(node.attributes.id);
        _loc4.__set__type(node.attributes.type);
        for (var _loc2 = node.firstChild; _loc2 != null; _loc2 = _loc2.nextSibling)
        {
            if (_loc2.nodeName == com.clubpenguin.achievements.AchievementManager.XML_NODENAME_ACHIEVEMENT_LINK)
            {
                var _loc6 = String(_loc2.attributes.id);
                var _loc5 = null;
                this.debugTrace("Group \'" + _loc4.__get__name() + "\' is trying to find achievement with ID \'" + _loc6 + "\'");
                for (var _loc3 = 0; _loc3 < _achievementChecks.length; ++_loc3)
                {
                    if (_achievementChecks[_loc3].id == _loc6)
                    {
                        _loc5 = _achievementChecks[_loc3];
                        break;
                    } // end if
                } // end of for
                if (_loc5 != null)
                {
                    _loc4.addAchievement(_loc5);
                }
                else
                {
                    throw new com.clubpenguin.achievements.AchievementException("AchievementManager::parseGroupAchievement() - There was an error creating group achievement \"" + _loc4.__get__name() + "\" - the achievement \"" + _loc6 + "\" was not found.");
                } // end else if
                continue;
            } // end if
            if (_loc2.nodeName == com.clubpenguin.achievements.AchievementManager.XML_NODENAME_ACHIEVEMENT_RESULT)
            {
                _loc4.addResult(String(_loc2.firstChild));
                continue;
            } // end if
            if (_loc2.nodeName == com.clubpenguin.achievements.AchievementManager.XML_NODENAME_DEBUG)
            {
                var _loc7 = String(_loc2.firstChild).toLowerCase() == "true";
                _loc4.__set__debug(_loc7);
                continue;
            } // end if
            throw new com.clubpenguin.achievements.AchievementException("AchievementManager::parseGroupAchievement() - There was an error creating group achievement \"" + _loc4.__get__name() + "\" - the XML property \"" + _loc2.nodeName + "\" was not recognised.");
        } // end of for
        _loc4.completeInitialization();
        _achievementGroups.push(_loc4);
    } // End of the function
    function debugDump()
    {
        for (var _loc2 = 0; _loc2 < _achievementChecks.length; ++_loc2)
        {
            var _loc4 = _achievementChecks[_loc2];
        } // end of for
        for (var _loc2 = 0; _loc2 < _achievementGroups.length; ++_loc2)
        {
            var _loc3 = _achievementGroups[_loc2];
        } // end of for
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
    static var ACHIEVEMENT_XML_LOCATION = "web_service/worldachievements.xml";
    static var XML_NODENAME_ACHIEVEMENT_DOCUMENT = "achievementDocument";
    static var XML_NODENAME_ACHIEVEMENT_GROUP = "achievementGroup";
    static var XML_NODENAME_ACHIEVEMENT = "achievement";
    static var XML_NODENAME_ACHIEVEMENT_EVENT = "event";
    static var XML_NODENAME_ACHIEVEMENT_CONDITION = "condition";
    static var XML_NODENAME_ACHIEVEMENT_OPTIONAL_CONDITION = "optionalCondition";
    static var XML_NODENAME_ACHIEVEMENT_RESULT = "result";
    static var XML_NODENAME_ACHIEVEMENT_LINK = "achievementLink";
    static var XML_NODENAME_DEBUG = "debug";
    static var XML_NODENAME_EXPIRY_DATE = "expiryDate";
    static var MILLISECONDS = 1000;
    var _debug = true;
} // End of Class
