class com.clubpenguin.shell.RoomPuffleModel extends com.clubpenguin.shell.AbstractPuffleModel
{
    var _x, _y, _notifyHunger, _notifyHealth, _notifyRest, _isWalking, _isInteracting, __set__x, __set__y, updateListeners, __get__isWalking, __get__x, __get__y, __get__isInteracting, _frame, __get__frame, __get__notifyHunger, __get__notifyHealth, __get__notifyRest, _lastAction, __get__lastAction, __set__frame, __set__isInteracting, __set__isWalking, __set__lastAction, __set__notifyHealth, __set__notifyHunger, __set__notifyRest;
    function RoomPuffleModel()
    {
        super();
        _x = 0;
        _y = 0;
        _notifyHunger = true;
        _notifyHealth = true;
        _notifyRest = true;
        _isWalking = false;
        _isInteracting = false;
    } // End of the function
    function setPosition(xpos, ypos)
    {
        this.__set__x(xpos);
        this.__set__y(ypos);
        this.updateListeners(com.clubpenguin.shell.RoomPuffleModel.MOVE, this);
    } // End of the function
    function set isWalking(isWalking)
    {
        _isWalking = isWalking;
        this.updateListeners(com.clubpenguin.shell.RoomPuffleModel.WALK, this);
        //return (this.isWalking());
        null;
    } // End of the function
    function get isWalking()
    {
        return (_isWalking);
    } // End of the function
    function get x()
    {
        return (_x);
    } // End of the function
    function set x(x)
    {
        _x = x;
        //return (this.x());
        null;
    } // End of the function
    function get y()
    {
        return (_y);
    } // End of the function
    function set y(y)
    {
        _y = y;
        //return (this.y());
        null;
    } // End of the function
    function get isInteracting()
    {
        return (_isInteracting);
    } // End of the function
    function set isInteracting(bool)
    {
        _isInteracting = bool;
        //return (this.isInteracting());
        null;
    } // End of the function
    function set frame(frame)
    {
        _frame = frame;
        this.updateListeners(com.clubpenguin.shell.RoomPuffleModel.FRAME, this);
        //return (this.frame());
        null;
    } // End of the function
    function get frame()
    {
        return (_frame);
    } // End of the function
    function get notifyHunger()
    {
        return (_notifyHunger);
    } // End of the function
    function set notifyHunger(bool)
    {
        _notifyHunger = bool;
        //return (this.notifyHunger());
        null;
    } // End of the function
    function get notifyHealth()
    {
        return (_notifyHealth);
    } // End of the function
    function set notifyHealth(bool)
    {
        _notifyHealth = bool;
        //return (this.notifyHealth());
        null;
    } // End of the function
    function get notifyRest()
    {
        return (_notifyRest);
    } // End of the function
    function set notifyRest(bool)
    {
        _notifyRest = bool;
        //return (this.notifyRest());
        null;
    } // End of the function
    function get lastAction()
    {
        return (_lastAction);
    } // End of the function
    function set lastAction(action)
    {
        _lastAction = action;
        //return (this.lastAction());
        null;
    } // End of the function
    function cleanUp()
    {
        super.cleanUp();
        _x = null;
        _y = null;
        _isWalking = null;
        _lastAction = null;
        _notifyHunger = null;
        _notifyHealth = null;
        _notifyRest = null;
        _frame = null;
    } // End of the function
    static var WALK = "walk";
    static var MOVE = "move";
    static var FRAME = "frame";
} // End of Class
