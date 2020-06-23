package com.clubpenguin.world
{
    import com.clubpenguin.lib.managers.localization.*;
    import com.clubpenguin.lib.managers.resource.*;
    import com.clubpenguin.lib.module.*;
    import com.clubpenguin.lib.services.socketserver.*;
    import com.clubpenguin.main.command.*;
    import com.clubpenguin.main.dialogboxes.mediator.*;
    import com.clubpenguin.main.overlays.mediator.*;
    import com.clubpenguin.main.overlays.view.*;
    import com.clubpenguin.main.signal.*;
    import com.clubpenguin.managers.*;
    import com.clubpenguin.world.command.*;
    import com.clubpenguin.world.command.startup.*;
    import com.clubpenguin.world.mediator.*;
    import com.clubpenguin.world.model.*;
    import com.clubpenguin.world.signal.*;
    import com.clubpenguin.world.view.*;
    import flash.display.*;
    import org.osflash.signals.*;
    import org.robotlegs.core.*;
    import org.robotlegs.mvcs.*;

    public class WorldContext extends SignalContext implements IModuleAppContext
    {
        private var sendAVM1FlashVarsSignal:Signal;
        private var initSWFAddressSignal:Signal;
        private var loadConfigSignal:Signal;
        private var initAVMCommunicationSignal:Signal;
        private var loadAS2Signal:Signal;
        private var as2ContentContainer:AS2ContentView;
        private var mainModel:MainModel;
        private var signalBus:SignalBus;

        public function WorldContext(param1:DisplayObjectContainer)
        {
            loadConfigSignal = new Signal();
            initSWFAddressSignal = new Signal();
            loadAS2Signal = new Signal();
            initAVMCommunicationSignal = new Signal();
            sendAVM1FlashVarsSignal = new Signal();
            as2ContentContainer = new AS2ContentView();
            signalBus = new SignalBus();
            mainModel = new MainModel();
            super(param1);
            return;
        }// end function

        public function getSignalBus() : IModuleAppSignalBus
        {
            return signalBus;
        }// end function

        public function getSocketServer() : ISocketServer
        {
            return null;
        }// end function

        public function getFlashVars() : Object
        {
            var _loc_1:* = new Object();
            if (contextView.loaderInfo.parameters)
            {
                _loc_1 = contextView.loaderInfo.parameters;
            }
            return _loc_1;
        }// end function

        public function onAVMCommunicationReady() : void
        {
            sendAVM1FlashVarsSignal.dispatch();
            return;
        }// end function

        public function getResourceManager() : IResourceManager
        {
            return null;
        }// end function

        public function getLocalizationManager() : ILocalizationManager
        {
            return null;
        }// end function

        public function onConfigLoaded() : void
        {
            initSWFAddressSignal.dispatch();
            loadAS2Signal.dispatch();
            return;
        }// end function

        public function getInjector() : IInjector
        {
            return this.injector;
        }// end function

        public function onAS2Loaded() : void
        {
            initAVMCommunicationSignal.dispatch();
            return;
        }// end function

        public function getModel() : IModuleAppMainModel
        {
            return mainModel;
        }// end function

        override public function startup() : void
        {
            contextView.addChild(as2ContentContainer);
            injector.mapValue(MainModel, mainModel);
            injector.mapSingleton(AssetManager);
            injector.mapValue(WorldContext, this);
            injector.mapValue(AS2ContentView, as2ContentContainer);
            injector.mapValue(SignalBus, signalBus);
            injector.mapValue(IInjector, injector);
            mainModel.signalBus = signalBus;
            signalCommandMap.mapSignal(loadConfigSignal, LoadConfigCommand);
            signalCommandMap.mapSignal(initSWFAddressSignal, InitSWFAddressCommand);
            signalCommandMap.mapSignal(loadAS2Signal, LoadAS2Command);
            signalCommandMap.mapSignal(initAVMCommunicationSignal, InitAVMCommunicationCommand);
            signalCommandMap.mapSignal(sendAVM1FlashVarsSignal, SendAVM1FlashVarsCommand);
            signalCommandMap.mapSignal(signalBus.loadModule, LoadModuleCommand);
            signalCommandMap.mapSignal(signalBus.sendUserSubmission, SendUserSubmissionCommand);
            signalCommandMap.mapSignal(signalBus.sendBI, SendBICommand);
            signalCommandMap.mapSignalClass(AirTowerSignal, LogAirTowerEventCommand);
            mediatorMap.mapView(AS2ContentView, WorldMediator);
            mediatorMap.mapView(MultipleOverlayView, MultipleOverlayViewMediator);
            mediatorMap.mapView(OverlayView, OverlayViewMediator);
            mediatorMap.mapView(DialogBoxDefaultView, DialogBoxViewMediator);
            var _loc_1:* = new MultipleOverlayView();
            contextView.addChild(_loc_1);
            loadConfigSignal.dispatch();
            return;
        }// end function

    }
}
