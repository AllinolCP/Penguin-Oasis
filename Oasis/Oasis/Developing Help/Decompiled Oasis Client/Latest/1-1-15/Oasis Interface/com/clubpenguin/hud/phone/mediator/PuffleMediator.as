class com.clubpenguin.hud.phone.mediator.PuffleMediator extends com.clubpenguin.hud.phone.mediator.AppMediator
{
    var equipmentService, _puffleEquipped, __get__puffleEquipped;
    function PuffleMediator(view, context)
    {
        super(view, context.appClosed, context.languageCode);
        equipmentService = context.equipmentService;
        _puffleEquipped = new org.osflash.signals.Signal();
        view.flare.onPress = com.clubpenguin.util.Delegate.create(this, equipPuffle);
    } // End of the function
    function get puffleEquipped()
    {
        return (_puffleEquipped);
    } // End of the function
    function equipPuffle()
    {
        equipmentService.equipHandItem(DEFAULT_FLARE_ID);
        _puffleEquipped.dispatch();
    } // End of the function
    var DEFAULT_FLARE_ID = 5060;
} // End of Class
