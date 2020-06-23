class com.clubpenguin.hybrid.TraceOutput
{
    function TraceOutput()
    {
    } // End of the function
    static function getInstance()
    {
        if (com.clubpenguin.hybrid.TraceOutput.__instance == null)
        {
            __instance = new com.clubpenguin.hybrid.TraceOutput();
        } // end if
        return (com.clubpenguin.hybrid.TraceOutput.__instance);
    } // End of the function
    function init(base_loc)
    {
        this.setBaseLoc(base_loc);
        this.setTextfield(base_loc.debugText);
        this.setScrollArrows();
        this.setupDragging();
        this.setupButtons();
        this.hide();
    } // End of the function
    function setBaseLoc(base_loc)
    {
        __baseLoc = base_loc;
    } // End of the function
    function setTextfield(text_field)
    {
        __textField = text_field;
    } // End of the function
    function setScrollArrows()
    {
        __upArrow = __baseLoc.upArrow_mc;
        __downArrow = __baseLoc.downArrow_mc;
        __upArrow.useHandCursor = false;
        __downArrow.useHandCursor = false;
        __upArrow.onPress = mx.utils.Delegate.create(com.clubpenguin.hybrid.TraceOutput.__instance, scrollUp);
        __downArrow.onPress = mx.utils.Delegate.create(com.clubpenguin.hybrid.TraceOutput.__instance, scrollDown);
        __upArrow.onRelease = __downArrow.onRelease = __downArrow.onReleaseOutside = __downArrow.onReleaseOutside = mx.utils.Delegate.create(com.clubpenguin.hybrid.TraceOutput.__instance, stopScrolling);
    } // End of the function
    function setupDragging()
    {
        __dragHandle = __baseLoc.dragHandle_mc;
        __dragHandle.useHandCursor = false;
        __dragHandle.onPress = mx.utils.Delegate.create(com.clubpenguin.hybrid.TraceOutput.__instance, startDragging);
        __dragHandle.onRelease = __dragHandle.onReleaseOutside = mx.utils.Delegate.create(com.clubpenguin.hybrid.TraceOutput.__instance, stopDragging);
    } // End of the function
    function startDragging()
    {
        __baseLoc.startDrag();
    } // End of the function
    function stopDragging()
    {
        __baseLoc.stopDrag();
    } // End of the function
    function trace(msg, clear_traces, trace_graphic)
    {
        this.show();
        clear_traces = clear_traces != undefined ? (clear_traces) : (false);
        trace_graphic = trace_graphic != undefined ? (trace_graphic) : (com.clubpenguin.hybrid.TraceOutput.DEFAULT_TRACE_GRAPHIC);
        var _loc3 = this.getTraceGraphicLine(trace_graphic);
        var _loc2 = _loc3;
        _loc2 = _loc2 + _loc3;
        _loc2 = _loc2 + (msg + "\n");
        _loc2 = _loc2 + _loc3;
        _loc2 = _loc2 + _loc3;
        if (clear_traces)
        {
            this.clearTraces();
            __textField.text = _loc2;
        }
        else
        {
            __textField.text = __textField.text + "\n";
            __textField.text = __textField.text + _loc2;
        } // end else if
        __textField.scroll = __textField.maxscroll;
    } // End of the function
    function clearTraces()
    {
        __textField.text = "";
    } // End of the function
    function getTraceGraphicLine(trace_graphic)
    {
        var _loc1 = "";
        for (var _loc2 = 0; _loc2 < com.clubpenguin.hybrid.TraceOutput.LINE_WIDTH; ++_loc2)
        {
            _loc1 = _loc1 + trace_graphic;
        } // end of for
        _loc1 = _loc1 + "\n";
        return (_loc1);
    } // End of the function
    function hide()
    {
        __baseLoc._visible = false;
        __baseLoc.x = -2000;
    } // End of the function
    function show()
    {
        __baseLoc._visible = true;
        __baseLoc.x = 0;
    } // End of the function
    function scrollUp()
    {
        __upArrow.gotoAndStop(2);
        __scrollInterval = setInterval(com.clubpenguin.hybrid.TraceOutput.__instance, com.clubpenguin.hybrid.TraceOutput.SCROLL_METHOD, com.clubpenguin.hybrid.TraceOutput.SCROLL_SPEED, com.clubpenguin.hybrid.TraceOutput.UP);
    } // End of the function
    function scrollDown()
    {
        __downArrow.gotoAndStop(2);
        __scrollInterval = setInterval(com.clubpenguin.hybrid.TraceOutput.__instance, com.clubpenguin.hybrid.TraceOutput.SCROLL_METHOD, com.clubpenguin.hybrid.TraceOutput.SCROLL_SPEED, com.clubpenguin.hybrid.TraceOutput.DOWN);
    } // End of the function
    function scroll(scroll_dir)
    {
        if (scroll_dir == com.clubpenguin.hybrid.TraceOutput.UP)
        {
            --__textField.scroll;
        }
        else
        {
            ++__textField.scroll;
        } // end else if
    } // End of the function
    function stopScrolling()
    {
        __upArrow.gotoAndStop(1);
        __downArrow.gotoAndStop(1);
        clearInterval(__scrollInterval);
    } // End of the function
    function getCanvas()
    {
        return (__baseLoc);
    } // End of the function
    function setupButtons()
    {
        __clearButton = __baseLoc.clearBtn;
        __closeButton = __baseLoc.closeBtn;
        __clearButton.onRelease = mx.utils.Delegate.create(this, clearTraces);
        __closeButton.onRelease = mx.utils.Delegate.create(this, hide);
    } // End of the function
    static var DEFAULT_TRACE_GRAPHIC = "^";
    static var LINE_WIDTH = 45;
    static var SCROLL_SPEED = 100;
    static var UP = "up";
    static var DOWN = "down";
    static var SCROLL_METHOD = "scroll";
    static var __instance = null;
    var __baseLoc = null;
    var __textField = null;
    var __upArrow = null;
    var __downArrow = null;
    var __scrollInterval = null;
    var __dragHandle = null;
    var __clearButton = null;
    var __closeButton = null;
} // End of Class
