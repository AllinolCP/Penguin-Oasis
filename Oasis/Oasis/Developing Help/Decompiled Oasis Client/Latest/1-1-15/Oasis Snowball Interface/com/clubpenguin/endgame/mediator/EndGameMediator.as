class com.clubpenguin.endgame.mediator.EndGameMediator
{
    var _view, _model, _endGameClosed, __get__endGameClosed;
    function EndGameMediator(view, model)
    {
        _view = view;
        _model = model;
        _view.setModel(_model);
        _view.setShell(_model.__get__shell());
        _view.__get__endGameClosed().addOnce(onClose, this);
        _view.initialize(_model.__get__endGameParams());
        _endGameClosed = new org.osflash.signals.Signal();
    } // End of the function
    function get endGameClosed()
    {
        return (_endGameClosed);
    } // End of the function
    function onClose()
    {
        _endGameClosed.dispatch();
    } // End of the function
} // End of Class
