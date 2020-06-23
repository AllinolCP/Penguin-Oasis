class com.clubpenguin.games.cardjitsu.water.cell.CellToggle extends com.clubpenguin.lib.movieclip.ToggleClip
{
    var onEnterFrame, __cellFrame, base1, base2;
    function CellToggle()
    {
        super();
        onEnterFrame = config;
    } // End of the function
    function config()
    {
        delete this.onEnterFrame;
        this.randomizeFrame();
        base1.config(__cellFrame);
        base2.config(__cellFrame);
    } // End of the function
    function randomizeFrame()
    {
        __cellFrame = Math.ceil(Math.random() * base1._totalframes);
    } // End of the function
    function setStateOff()
    {
        base1._visible = false;
        base2._visible = true;
    } // End of the function
    function setStateOn()
    {
        base1._visible = true;
        base2._visible = false;
    } // End of the function
} // End of Class
