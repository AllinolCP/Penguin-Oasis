class com.clubpenguin.scrollinglist.ScrollBarMediator
{
    var view, verticalStepSize, _dragged, mouseMoveDelegate, dragArea, __get__stepSize, __get__dragAreaRect, __get__dragged, __set__stepSize;
    function ScrollBarMediator(view, verticalStepSize)
    {
        this.view = view;
        this.verticalStepSize = verticalStepSize || com.clubpenguin.scrollinglist.ScrollBarMediator.DEFAULT_STEP_SIZE;
        _dragged = new org.osflash.signals.Signal(Number, Number);
        view.up.onPress = com.clubpenguin.util.Delegate.create(this, onUpPressed);
        view.down.onPress = com.clubpenguin.util.Delegate.create(this, onDownPressed);
        view.bar.onPress = com.clubpenguin.util.Delegate.create(this, onBarPressed);
        view.bar.onRelease = com.clubpenguin.util.Delegate.create(this, onBarReleased);
        view.bar.onReleaseOutside = view.bar.onRelease;
        mouseMoveDelegate = com.clubpenguin.util.Delegate.create(this, dispatchDragged);
        this.setupDragArea();
    } // End of the function
    function get dragged()
    {
        return (_dragged);
    } // End of the function
    function get dragAreaRect()
    {
        return (dragArea);
    } // End of the function
    function set stepSize(size)
    {
        verticalStepSize = size;
        //return (this.stepSize());
        null;
    } // End of the function
    function get stepSize()
    {
        return (verticalStepSize);
    } // End of the function
    function setupDragArea()
    {
        var _loc2 = view.track._width - view.bar._width;
        if (_loc2 < 0)
        {
            _loc2 = 0;
        } // end if
        var _loc3 = view.track._height - view.bar._height;
        if (_loc3 < 0)
        {
            _loc3 = 0;
        } // end if
        dragArea = new flash.geom.Rectangle(view.track._x, view.track._y, _loc2, _loc3);
    } // End of the function
    function dispatchDragged()
    {
        var _loc2 = 0;
        _loc2 = (view.bar._y - view.track._y) / (view.track._height - view.bar._height);
        if (_loc2 < 0)
        {
            _loc2 = 0;
        }
        else if (_loc2 > 1)
        {
            _loc2 = 1;
        } // end else if
        _dragged.dispatch(_loc2);
    } // End of the function
    function onBarPressed()
    {
        view.bar.startDrag(false, dragArea.left, dragArea.top, dragArea.right, dragArea.bottom);
        view.bar.onMouseMove = mouseMoveDelegate;
    } // End of the function
    function onBarReleased()
    {
        view.bar.stopDrag();
        view.bar.onMouseMove = null;
    } // End of the function
    function onUpPressed()
    {
        if (view.bar._y - verticalStepSize >= dragArea.top)
        {
            view.bar._y = view.bar._y - verticalStepSize;
        }
        else
        {
            view.bar._y = dragArea.top;
        } // end else if
        this.dispatchDragged();
    } // End of the function
    function onDownPressed()
    {
        if (view.bar._y + verticalStepSize <= dragArea.bottom)
        {
            view.bar._y = view.bar._y + verticalStepSize;
        }
        else
        {
            view.bar._y = dragArea.bottom;
        } // end else if
        this.dispatchDragged();
    } // End of the function
    static var DEFAULT_STEP_SIZE = 10;
} // End of Class
