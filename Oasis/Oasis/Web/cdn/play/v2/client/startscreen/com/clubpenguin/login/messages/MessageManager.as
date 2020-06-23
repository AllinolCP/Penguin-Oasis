class com.clubpenguin.login.messages.MessageManager extends MovieClip
{
    var _shell, _messages, _iconContainer, _headlineField, _prevButton, _nextButton, _headlineClip, _currentMessage, _previousMessage, getURL, updateListeners, _width, _loadingAnimClip;
    function MessageManager()
    {
        super();
        com.clubpenguin.util.EventDispatcher.initialize(this);
        _shell = _global.getCurrentShell();
        this.setupInterface();
    } // End of the function
    function setupInterface()
    {
        this.setupNavigation();
        this.setupHeadline();
    } // End of the function
    function handleNextButtonPress()
    {
        ++_currentMessageIndex;
        this.loadMessage(_messages[_currentMessageIndex]);
    } // End of the function
    function handlePrevButtonPress()
    {
        --_currentMessageIndex;
        this.loadMessage(_messages[_currentMessageIndex]);
    } // End of the function
    function showLoadingProgress()
    {
        _iconContainer._visible = false;
        this.showLoadingAnimation();
        _headlineField._visible = false;
        this.disableButton(_prevButton);
        this.disableButton(_nextButton);
        delete _headlineClip.onPress;
    } // End of the function
    function hideLoadingProgress()
    {
        _iconContainer._visible = true;
        this.hideLoadingAnimation();
    } // End of the function
    function showMessage(message)
    {
        _previousMessage = _currentMessage;
        _currentMessage = message;
        message.showIcon();
        this.setHeadlineText(message.__get__title());
        this.setupMessageAction();
        this.setupNavigation();
    } // End of the function
    function setupNavigation()
    {
        if (_currentMessageIndex == 0 && _messages.length > 1)
        {
            this.disableButton(_prevButton);
            this.enableButton(_nextButton);
        }
        else if (_currentMessageIndex == _messages.length - 1 && _messages.length > 1)
        {
            this.enableButton(_prevButton);
            this.disableButton(_nextButton);
        }
        else if (_currentMessageIndex == -1)
        {
            _nextButton.onPress = com.clubpenguin.util.Delegate.create(this, handleNextButtonPress);
            _prevButton.onPress = com.clubpenguin.util.Delegate.create(this, handlePrevButtonPress);
            this.disableButton(_nextButton);
            this.disableButton(_prevButton);
        }
        else if (_messages.length == 1)
        {
            this.disableButton(_nextButton);
            this.disableButton(_prevButton);
        }
        else
        {
            this.enableButton(_nextButton);
            this.enableButton(_prevButton);
        } // end else if
    } // End of the function
    function setupHeadline()
    {
        _headlineField.text = "";
        _headlineField._visible = false;
        _headlineClip._alpha = 0;
    } // End of the function
    function setupMessageAction()
    {
        if (_currentMessage.__get__contentURL() != undefined)
        {
            _currentMessage.__get__iconClip().onPress = com.clubpenguin.util.Delegate.create(this, handleMessageAction);
            _headlineClip.onPress = com.clubpenguin.util.Delegate.create(this, handleMessageAction);
        }
        else
        {
            delete _headlineClip.onPress;
            delete _currentMessage.__get__iconClip().onPress;
        } // end else if
    } // End of the function
    function handleMessageAction()
    {
        if (_currentMessage.__get__contentType() == com.clubpenguin.login.messages.Message.TYPE_URL)
        {
            this.getURL(_currentMessage.__get__contentURL(), "_parent");
        }
        else if (_currentMessage.__get__contentType() == com.clubpenguin.login.messages.Message.TYPE_POPUP)
        {
            this.updateListeners(com.clubpenguin.login.messages.MessageManager.SHOW_CONTENT, {url: _currentMessage.__get__contentURL()});
        } // end else if
    } // End of the function
    function enableButton(button)
    {
        button.enabled = true;
        button._visible = true;
    } // End of the function
    function disableButton(button)
    {
        button.enabled = false;
        button._visible = false;
    } // End of the function
    function loadMessage(message)
    {
        _currentMessage.hideIcon();
        this.showLoadingProgress();
        message.__set__container(_iconContainer);
        message.addEventListener(com.clubpenguin.login.messages.Message.LOAD_COMPLETE, handleLoadMessageComplete, this);
        message.load();
    } // End of the function
    function setHeadlineText(text)
    {
        _headlineField.text = text;
        _headlineField._x = Math.abs((_headlineField._width - _width) * 0.500000);
        _headlineField._visible = true;
    } // End of the function
    function handleLoadMessageComplete(event)
    {
        this.hideLoadingProgress();
        var _loc2 = (com.clubpenguin.login.messages.Message)(event.target);
        this.showMessage(_loc2);
    } // End of the function
    function createMessagesFromXMLNode(node)
    {
        var _loc10 = _shell.getStartScreenIconsPath();
        var _loc9 = _shell.getStartScreenPopupsPath();
        _messages = [];
        var _loc11 = node.childNodes;
        for (var _loc4 = _loc11[0]; _loc4 != null; _loc4 = _loc4.nextSibling)
        {
            var _loc2 = _loc4.childNodes;
            var _loc7 = _loc2[0].firstChild.nodeValue;
            var _loc6 = _loc10 + _loc2[1].firstChild.nodeValue;
            var _loc5 = _loc2[2].attributes.type;
            var _loc3 = _loc2[2].firstChild.nodeValue;
            if (_loc5 == com.clubpenguin.login.messages.Message.TYPE_POPUP)
            {
                _loc3 = _loc9 + _loc3;
            } // end if
            var _loc8 = new com.clubpenguin.login.messages.Message(_messages.length, _loc7, _loc6, _loc3, _loc5);
            _messages.push(_loc8);
        } // end of for
        _currentMessageIndex = 0;
        this.loadMessage(_messages[0]);
    } // End of the function
    function hideLoadingAnimation()
    {
        _loadingAnimClip._visible = false;
        _loadingAnimClip.gotoAndStop("park");
    } // End of the function
    function showLoadingAnimation()
    {
        _loadingAnimClip._visible = true;
        _loadingAnimClip.gotoAndPlay("play");
    } // End of the function
    static var LINKAGE_ID = "MessageManagerSymbol";
    static var ROOT_NODE = "messages";
    static var SHOW_CONTENT = "showContent";
    var _currentMessageIndex = -1;
} // End of Class
