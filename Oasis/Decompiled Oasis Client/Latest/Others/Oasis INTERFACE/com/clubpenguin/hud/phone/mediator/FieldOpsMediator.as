class com.clubpenguin.hud.phone.mediator.FieldOpsMediator extends com.clubpenguin.hud.phone.mediator.AppMediator
{
    var fieldOpsView, _context, commandRoomKey, commandRoomSpawnX, commandRoomSpawnY, currentRoomService, roomCrumbs, epfService, fieldOp;
    function FieldOpsMediator(view, COMMAND_ROOM_KEY, COMMAND_ROOM_SPAWN_X, COMMAND_ROOM_SPAWN_Y, context)
    {
        super(view, context.appClosed, context.languageCode);
        fieldOpsView = view;
        _context = context;
        commandRoomKey = COMMAND_ROOM_KEY;
        commandRoomSpawnX = COMMAND_ROOM_SPAWN_X;
        commandRoomSpawnY = COMMAND_ROOM_SPAWN_Y;
        currentRoomService = context.currentRoomService;
        roomCrumbs = context.roomCrumbs;
        view.goThere.onPress = com.clubpenguin.util.Delegate.create(this, onGoTherePressed);
        epfService = context.epfService;
        epfService.__get__fieldOpStatusReceived().add(onFieldOpStatusReceived, this);
        fieldOp = context.fieldOp;
        this.hideFieldOpStatusViews();
    } // End of the function
    function onGoTherePressed()
    {
        if (_goTherePressed)
        {
            return;
        } // end if
        _goTherePressed = true;
        if (_context.isUserCurrentlyInRoom(roomCrumbs[commandRoomKey].room_id))
        {
        }
        else
        {
            currentRoomService.joinRoom(roomCrumbs[commandRoomKey].room_id, commandRoomSpawnX, commandRoomSpawnY);
        } // end else if
    } // End of the function
    function hideFieldOpStatusViews()
    {
        fieldOpsView.pending._visible = false;
        fieldOpsView.goThere._visible = false;
        fieldOpsView.goThereText._visible = false;
        fieldOpsView.inProgress._visible = false;
        fieldOpsView.done._visible = false;
    } // End of the function
    function onFieldOpStatusReceived(fieldOpStatus)
    {
        this.hideFieldOpStatusViews();
        switch (fieldOpStatus)
        {
            case com.clubpenguin.hud.phone.model.FieldOpStatus.PENDING:
            {
                _goTherePressed = false;
                fieldOpsView.pending._visible = true;
                fieldOpsView.goThere._visible = true;
                fieldOpsView.goThereText._visible = true;
                break;
            } 
            case com.clubpenguin.hud.phone.model.FieldOpStatus.IN_PROGRESS:
            {
                fieldOpsView.inProgress._visible = true;
                fieldOpsView.inProgress.description.text = fieldOp.task;
                break;
            } 
            case com.clubpenguin.hud.phone.model.FieldOpStatus.DONE:
            {
                fieldOpsView.done._visible = true;
            } 
        } // End of switch
    } // End of the function
    var _goTherePressed = false;
} // End of Class
