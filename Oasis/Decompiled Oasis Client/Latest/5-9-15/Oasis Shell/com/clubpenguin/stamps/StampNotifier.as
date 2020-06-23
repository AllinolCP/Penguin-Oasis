class com.clubpenguin.stamps.StampNotifier
{
    var _shell, _queue, _stampEarnedAnimationDone, _pauseNotification, __interface, __get___interface, __get__pauseNotification, __set___interface, __set__pauseNotification;
    function StampNotifier(shell)
    {
        _shell = shell;
        _queue = [];
        _stampEarnedAnimationDone = true;
        _pauseNotification = false;
        _shell.addListener(_shell.STAMP_EARNED_ANIM_DONE, handleStampEarnedAnimationDone, this);
    } // End of the function
    function destroy()
    {
        delete this._queue;
        _shell.removeListener(_shell.STAMP_EARNED_ANIM_DONE, handleStampEarnedAnimationDone);
    } // End of the function
    function set _interface(interfacer)
    {
        __interface = interfacer;
        //return (this._interface());
        null;
    } // End of the function
    function add(stamp)
    {
        _queue.push(stamp);
        this.showStampEarnedAnimation();
    } // End of the function
    function set pauseNotification(pause)
    {
        _pauseNotification = pause;
        if (!_pauseNotification)
        {
            this.showStampEarnedAnimation();
        } // end if
        //return (this.pauseNotification());
        null;
    } // End of the function
    function handleStampEarnedAnimationDone()
    {
        _stampEarnedAnimationDone = true;
        this.showStampEarnedAnimation();
    } // End of the function
    function showStampEarnedAnimation()
    {
        if (!_pauseNotification && _queue.length > 0 && _stampEarnedAnimationDone)
        {
            var _loc2 = (com.clubpenguin.stamps.IStampItem)(_queue.shift());
            _stampEarnedAnimationDone = false;
            __interface.animateStampEarned(_loc2.getMainCategoryID(), _loc2.getDifficulty(), _loc2.getName());
        } // end if
    } // End of the function
} // End of Class
