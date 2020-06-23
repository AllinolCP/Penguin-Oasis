class com.clubpenguin.endgame.mediator.StampListMediator
{
    var _view, _model, __get__stampIconRolledOut, __get__stampIconRolledOver;
    function StampListMediator(view, model)
    {
        _view = view;
        _model = model;
    } // End of the function
    function init()
    {
        _view.setShell(_model.__get__shell());
        _view.displayStamps(_model.getStamps(), _model.__get__stampIds());
    } // End of the function
    function get stampIconRolledOver()
    {
        return (_view.stampIconRolledOver);
    } // End of the function
    function get stampIconRolledOut()
    {
        return (_view.stampIconRolledOut);
    } // End of the function
} // End of Class
