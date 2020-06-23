class com.clubpenguin.ui.balloons.TextBalloon extends com.clubpenguin.ui.balloons.AbstractBalloon
{
    var hide, __get__mc, _counter, __get__textFormat, setSize, __get__message, _textFormat, __get__maxWidth, __set__maxWidth, __set__message, __set__textFormat;
    function TextBalloon(mc)
    {
        super(mc);
    } // End of the function
    function show()
    {
        this.hide();
        this.__get__mc().gotoAndStop(com.clubpenguin.ui.balloons.TextBalloon.UNPARKED_FRAME);
        this.showText(_multiPartMessage[_multiPartIndex]);
    } // End of the function
    function isDone()
    {
        return (!(_multiPartMessage.length > 1 && _multiPartIndex < _multiPartMessage.length - 1));
    } // End of the function
    function showNextPart()
    {
        ++_multiPartIndex;
        _counter = 0;
        this.show();
    } // End of the function
    function showText(text)
    {
        var _loc2 = this.__get__textFormat().getTextExtent(text, _maxWidth - com.clubpenguin.ui.balloons.TextBalloon.TEXT_X_PADDING);
        this.__get__mc().message_txt.text = text;
        this.__get__mc().message_txt.setTextFormat(this.__get__textFormat());
        this.__get__mc().message_txt._width = _loc2.textFieldWidth;
        this.__get__mc().message_txt._height = _loc2.textFieldHeight + com.clubpenguin.ui.balloons.TextBalloon.TEXT_Y_PADDING * 0.500000 + 20;
        this.setSize(_loc2.textFieldWidth + com.clubpenguin.ui.balloons.TextBalloon.TEXT_X_PADDING, this.__get__mc().message_txt.textHeight + com.clubpenguin.ui.balloons.TextBalloon.TEXT_Y_PADDING + _loc2.descent);
        this.__get__mc().message_txt._x = this.__get__mc().balloon_mc._x - this.__get__mc().balloon_mc._width * 0.500000 + com.clubpenguin.ui.balloons.TextBalloon.TEXT_X_PADDING * 0.500000;
        this.__get__mc().message_txt._y = this.__get__mc().balloon_mc._y;
        this.__get__mc().message_txt._y = this.__get__mc().message_txt._y + com.clubpenguin.ui.balloons.TextBalloon.TEXT_Y_PADDING;
    } // End of the function
    function get message()
    {
        return (_message);
    } // End of the function
    function set message(message)
    {
        _message = message;
        _multiPartMessage = message.split(com.clubpenguin.ui.balloons.TextBalloon.TEXT_DELIMITER);
        _multiPartIndex = 0;
        _counter = 0;
        //return (this.message());
        null;
    } // End of the function
    function get textFormat()
    {
        return (_textFormat);
    } // End of the function
    function set textFormat(textFormat)
    {
        _textFormat = textFormat;
        //return (this.textFormat());
        null;
    } // End of the function
    function set maxWidth(maxWidth)
    {
        _maxWidth = maxWidth;
        //return (this.maxWidth());
        null;
    } // End of the function
    function toString()
    {
        //return ("Text" + super.toString() + "message: " + this.message());
    } // End of the function
    static var UNPARKED_FRAME = "text";
    static var TEXT_Y_PADDING = 8;
    static var TEXT_X_PADDING = 14;
    static var TEXT_DELIMITER = "|";
    var _message = "";
    var _multiPartMessage = [""];
    var _multiPartIndex = 0;
    var _maxWidth = 100;
} // End of Class
