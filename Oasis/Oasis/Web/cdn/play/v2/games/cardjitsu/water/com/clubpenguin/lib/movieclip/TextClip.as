class com.clubpenguin.lib.movieclip.TextClip extends MovieClip
{
    var textContent, __get__text, __set__text;
    function TextClip()
    {
        super();
    } // End of the function
    function set text(_val)
    {
        textContent.text = _val;
        //return (this.text());
        null;
    } // End of the function
    function get text()
    {
        var _loc2;
        _loc2 = textContent.text;
        return (_loc2);
    } // End of the function
} // End of Class
