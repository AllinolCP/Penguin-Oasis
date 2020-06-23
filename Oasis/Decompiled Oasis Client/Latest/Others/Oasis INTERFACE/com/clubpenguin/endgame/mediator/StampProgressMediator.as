class com.clubpenguin.endgame.mediator.StampProgressMediator
{
    var _view, _model;
    function StampProgressMediator(view, model)
    {
        _view = view;
        _model = model;
    } // End of the function
    function init()
    {
        _view.setShell(_model.__get__shell());
        _view.displayProgress(_model.__get__completedPercent());
    } // End of the function
} // End of Class
