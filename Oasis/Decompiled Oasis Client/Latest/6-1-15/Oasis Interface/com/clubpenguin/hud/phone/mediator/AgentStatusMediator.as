class com.clubpenguin.hud.phone.mediator.AgentStatusMediator extends com.clubpenguin.hud.phone.mediator.AppMediator
{
    var agentStatusView, epfService, inventory, inventoryCrumbs, player, INTERFACE, SHELL, context, view, onClosed, setLanguageCode, delayedServiceCall, itemsList, itemsList2, itemsList3, purchaseItemID, unusedPoints;
    function AgentStatusMediator(view, context)
    {
        super(view, context.appClosed, context.languageCode);
        agentStatusView = view;
        epfService = context.epfService;
        inventory = context.inventory;
        inventoryCrumbs = context.inventoryCrumbs;
        player = context.player;
        INTERFACE = context.INTERFACE;
        SHELL = context.SHELL;
        this.context = context;
        SHELL.addListener(SHELL.WORLD_CONNECT_SUCCESS, com.clubpenguin.util.Delegate.create(this, setupPoints));
        this.initView(view);
    } // End of the function
    function initView(view)
    {
        this.view = view;
        view.closed.add(onClosed, this);
        agentStatusView = view;
        epfService.__get__pointsReceived().add(onPointsReceived, this);
        epfService.__get__itemBought().add(onItemBought, this);
        agentStatusView.insufficientPoints._visible = false;
        agentStatusView.insufficientPoints.ok.onPress = com.clubpenguin.util.Delegate.create(this, confirmInsufficientPoints);
        this.setupFieldOpStatus();
        epfService.getFieldOpStatus();
        this.setupInstructions();
        this.setupItemWindowTabs();
        this.setupItemDialogs();
        this.showPage3();
        this.showPage2();
        this.showPage1();
        this.setLanguageCode(context.languageCode);
    } // End of the function
    function setupFieldOpStatus()
    {
        epfService.__get__fieldOpStatusReceived().add(onFieldOpStatusReceived, this);
    } // End of the function
    function setupPoints()
    {
        _global.clearTimeout(delayedServiceCall);
        delayedServiceCall = _global.setTimeout(com.clubpenguin.util.Delegate.create(this, delayedGetPointsServiceCall), 40);
    } // End of the function
    function delayedGetPointsServiceCall()
    {
        _global.clearTimeout(delayedServiceCall);
        epfService.getPoints();
    } // End of the function
    function setupInstructions()
    {
        agentStatusView.instructions._visible = false;
        agentStatusView.instructions.modal.onPress = null;
        agentStatusView.instructions.modal.useHandCursor = false;
        var _loc2 = com.clubpenguin.util.Delegate.create(this, toggleInstructions);
        agentStatusView.instructionsButton.button.onPress = _loc2;
        agentStatusView.instructions.close.button.onPress = _loc2;
    } // End of the function
    function showPage1()
    {
        agentStatusView.itemsList._visible = true;
        agentStatusView.itemsList2._visible = false;
        agentStatusView.itemsList3._visible = false;
        agentStatusView.windowTab1._visible = true;
        agentStatusView.windowTab2._visible = false;
        agentStatusView.windowTab3._visible = false;
        this.setupItemsList(itemsList);
    } // End of the function
    function showPage2()
    {
        agentStatusView.itemsList._visible = false;
        agentStatusView.itemsList2._visible = true;
        agentStatusView.itemsList3._visible = false;
        agentStatusView.windowTab1._visible = false;
        agentStatusView.windowTab2._visible = true;
        agentStatusView.windowTab3._visible = false;
        this.setupItemsList(itemsList2);
    } // End of the function
    function showPage3()
    {
        agentStatusView.itemsList._visible = false;
        agentStatusView.itemsList2._visible = false;
        agentStatusView.itemsList3._visible = true;
        agentStatusView.windowTab1._visible = false;
        agentStatusView.windowTab2._visible = false;
        agentStatusView.windowTab3._visible = true;
        this.setupItemsList(itemsList3);
    } // End of the function
    function setupItemWindowTabs()
    {
        var _loc2 = com.clubpenguin.util.Delegate.create(this, showPage1);
        var _loc3 = com.clubpenguin.util.Delegate.create(this, showPage2);
        var _loc4 = com.clubpenguin.util.Delegate.create(this, showPage3);
        agentStatusView.eliteGearBackdrop.windowButton1.onPress = _loc2;
        agentStatusView.eliteGearBackdrop.windowButton2.onPress = _loc3;
        agentStatusView.eliteGearBackdrop.windowButton3.onPress = _loc4;
    } // End of the function
    function setupItemDialogs()
    {
        agentStatusView.itemConfirmation._visible = false;
        agentStatusView.itemConfirmation.modal.onPress = null;
        agentStatusView.itemConfirmation.modal.useHandCursor = false;
        agentStatusView.itemConfirmation.ok.onPress = com.clubpenguin.util.Delegate.create(this, confirmBuyItem);
        agentStatusView.itemConfirmation.cancel.onPress = com.clubpenguin.util.Delegate.create(this, cancelBuyItem);
        agentStatusView.itemExists._visible = false;
        agentStatusView.itemExists.modal.onPress = null;
        agentStatusView.itemExists.ok.onPress = com.clubpenguin.util.Delegate.create(this, confirmItemExists);
    } // End of the function
    function setupItemsList(listClip)
    {
        if (listClip == itemsList)
        {
            var _loc10 = (com.clubpenguin.hud.phone.view.AgentStatusView)(view).itemsList;
            itemsList = new com.clubpenguin.scrollinglist.ScrollingList(_loc10);
            var _loc7 = agentStatusView.itemsList.content;
        }
        else if (listClip == itemsList2)
        {
            _loc10 = (com.clubpenguin.hud.phone.view.AgentStatusView)(view).itemsList2;
            itemsList2 = new com.clubpenguin.scrollinglist.ScrollingList(_loc10);
            _loc7 = agentStatusView.itemsList2.content;
        }
        else if (listClip == itemsList3)
        {
            _loc10 = (com.clubpenguin.hud.phone.view.AgentStatusView)(view).itemsList3;
            itemsList3 = new com.clubpenguin.scrollinglist.ScrollingList(_loc10);
            _loc7 = agentStatusView.itemsList3.content;
        } // end else if
        var _loc2;
        var _loc3 = -1;
        var _loc5 = "";
        var _loc4 = 0;
        var _loc6 = false;
        var _loc11;
        for (var _loc8 in _loc7)
        {
            _loc2 = (MovieClip)(_loc7[_loc8]);
            if (!_loc2)
            {
                continue;
            } // end if
            if (_loc2._name.indexOf(com.clubpenguin.hud.phone.mediator.AgentStatusMediator.ITEM_PREFIX) != 0)
            {
                continue;
            } // end if
            _loc3 = parseInt(_loc2._name.slice(com.clubpenguin.hud.phone.mediator.AgentStatusMediator.ITEM_PREFIX.length));
            _loc5 = inventoryCrumbs[_loc3].name;
            _loc4 = parseInt(inventoryCrumbs[_loc3].cost);
            _loc6 = Boolean(inventoryCrumbs[_loc3].is_member);
            _loc2.name.text = _loc5;
            _loc2.cost.text = _loc4;
            _loc2.onPress = com.clubpenguin.util.Delegate.create(this, onItemClicked, _loc3, _loc4, _loc6);
        } // end of for...in
    } // End of the function
    function confirmInsufficientPoints()
    {
        agentStatusView.insufficientPoints._visible = false;
    } // End of the function
    function onItemBought(unusedPoints)
    {
        agentStatusView.unusedPoints.text = String(unusedPoints);
        SHELL.addItemToInventory(purchaseItemID);
    } // End of the function
    function onFieldOpStatusReceived(fieldOpStatus)
    {
        agentStatusView.fieldOpStatus.statusClip.gotoAndStop(fieldOpStatus + 1);
    } // End of the function
    function onPointsReceived(unusedPoints, totalPoints)
    {
        this.unusedPoints = unusedPoints;
        agentStatusView.unusedPoints.text = String(unusedPoints);
        agentStatusView.totalPoints.text = String(totalPoints);
    } // End of the function
    function toggleInstructions()
    {
        agentStatusView.instructions._visible = !agentStatusView.instructions._visible;
    } // End of the function
    function confirmBuyItem()
    {
        epfService.buyItem(purchaseItemID);
        agentStatusView.itemConfirmation._visible = false;
        _global.clearTimeout(delayedServiceCall);
        delayedServiceCall = _global.setTimeout(com.clubpenguin.util.Delegate.create(this, delayedGetPointsServiceCall), 1000);
    } // End of the function
    function confirmItemExists()
    {
        agentStatusView.itemExists._visible = false;
    } // End of the function
    function cancelBuyItem()
    {
        agentStatusView.itemConfirmation._visible = false;
    } // End of the function
    function onItemClicked(itemID, itemCost, itemMembership)
    {
        if (itemMembership && !player.is_member)
        {
            INTERFACE.showContent("oops_inventory");
            return;
        } // end if
        if (this.checkPlayerOwnsItem(itemID))
        {
            agentStatusView.itemExists._visible = true;
            return;
        } // end if
        if (itemCost > unusedPoints)
        {
            agentStatusView.insufficientPoints._visible = true;
            return;
        } // end if
        purchaseItemID = itemID;
        agentStatusView.itemConfirmation._visible = true;
    } // End of the function
    function checkPlayerOwnsItem(itemID)
    {
        for (var _loc2 = 0; _loc2 < inventory.length; ++_loc2)
        {
            if (inventory[_loc2].id == itemID)
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static var ITEM_PREFIX = "item_";
} // End of Class
