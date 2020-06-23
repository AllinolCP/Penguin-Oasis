class com.clubpenguin.stamps.stampbook.controls.BaseButton extends MovieClip
{
    var useHandCursor, gotoAndStop, __get__enabled, __get__toggle, __get__selected, dispatchEvent, __set__enabled, __set__selected, __set__toggle;
    function BaseButton()
    {
        super();
        com.clubpenguin.util.EventDispatcher.initialize(this);
    } // End of the function
    function onLoad()
    {
        this.configUI();
    } // End of the function
    function get enabled()
    {
        return (_enabled);
    } // End of the function
    function set enabled(value)
    {
        _enabled = value;
        useHandCursor = value;
        this.gotoAndStop(_selected ? ("selected_up") : ("up"));
        null;
        //return (this.enabled());
        null;
    } // End of the function
    function get toggle()
    {
        return (_toggle);
    } // End of the function
    function set toggle(value)
    {
        _toggle = value;
        null;
        //return (this.toggle());
        null;
    } // End of the function
    function get selected()
    {
        return (_selected);
    } // End of the function
    function set selected(value)
    {
        _selected = value;
        this.gotoAndStop(_selected ? ("selected_up") : ("up"));
        null;
        //return (this.selected());
        null;
    } // End of the function
    function onPress()
    {
        if (!_enabled)
        {
            return;
        } // end if
        this.gotoAndStop(_toggle ? (!_selected ? ("down") : ("selected_down")) : ("down"));
        this.dispatchEvent({type: "press"});
    } // End of the function
    function onRelease()
    {
        if (!_enabled)
        {
            return;
        } // end if
        this.gotoAndStop(_toggle ? (!_selected ? ("over") : ("selected_over")) : ("over"));
        this.dispatchEvent({type: "release"});
    } // End of the function
    function onRollOver()
    {
        if (!_enabled)
        {
            return;
        } // end if
        this.gotoAndStop(_toggle ? (!_selected ? ("over") : ("selected_over")) : ("over"));
        this.dispatchEvent({type: "over"});
    } // End of the function
    function onRollOut()
    {
        if (!_enabled)
        {
            return;
        } // end if
        this.gotoAndStop(_toggle ? (!_selected ? ("up") : ("selected_up")) : ("up"));
        this.dispatchEvent({type: "out"});
    } // End of the function
    function configUI()
    {
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.BaseButton;
    static var LINKAGE_ID = "BaseButton";
    var _enabled = true;
    var _toggle = false;
    var _selected = false;
} // End of Class
