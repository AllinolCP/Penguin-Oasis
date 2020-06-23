package com.clubpenguin.world.model
{
    import com.asual.swfaddress.*;
    import com.clubpenguin.main.model.vo.*;
    import com.clubpenguin.main.signal.*;
    import com.clubpenguin.main.vo.*;
    import com.clubpenguin.world.service.avmbridge.*;
    import flash.utils.*;
    import org.osflash.signals.*;

    public class MainModel extends Object implements IModuleAppMainModel
    {
        private var moduleLookup:Dictionary;
        private var _currentNewspaperPath:String;
        public var onAppClosed:Signal;
        private var _environmentData:EnvironmentData;
        public var onStateChanged:Signal;
        public var onConfigLoaded:Signal;
        private var _bridge:AVMBridgeService;
        public var myPlayerVO:PlayerVO;
        private var _currentState:String;
        public var signalBus:SignalBus;
        public var onModelReady:Signal;
        private static const BASE_URL:String = "http://play.clubpenguin.com/#";
        public static const LOGIN_STATE:String = "login";
        public static const START_SCREEN_STATE:String = "";
        public static const CREATE_ACCOUNT_STATE:String = "create-account";
        public static const REDEEM_STATE:String = "redeem";

        public function MainModel()
        {
            onConfigLoaded = new Signal();
            onModelReady = new Signal();
            onAppClosed = new Signal();
            onStateChanged = new Signal();
            myPlayerVO = new PlayerVO();
            moduleLookup = new Dictionary();
            _bridge = new AVMBridgeService();
            _bridge.createMyPlayerVO.add(onCreateMyPlayerVO);
            _bridge.openModule.add(onOpenModule);
            _environmentData = new EnvironmentData();
            return;
        }// end function

        private function onCreateMyPlayerVO(param1:Object) : void
        {
            myPlayerVO.username = param1.username;
            myPlayerVO.nickname = param1.nickname;
            myPlayerVO.player_id = param1.player_id;
            return;
        }// end function

        public function initSWFAddress() : void
        {
            SWFAddress.addEventListener(SWFAddressEvent.INIT, onSWFAddressInit, false, 0, true);
            return;
        }// end function

        public function getPlayerID() : String
        {
            return myPlayerVO.player_id;
        }// end function

        public function getClientPath() : String
        {
            return _environmentData.clientPath;
        }// end function

        public function getAVMBridge() : AVMBridgeService
        {
            return _bridge;
        }// end function

        private function onOpenModule(param1:ModuleVO) : void
        {
            Signal(signalBus.loadModule).dispatch(param1);
            return;
        }// end function

        public function get currentState() : String
        {
            return _currentState;
        }// end function

        private function onSWFAddressInit(event:SWFAddressEvent) : void
        {
            SWFAddress.removeEventListener(SWFAddressEvent.INIT, onSWFAddressInit, false);
            SWFAddress.addEventListener(SWFAddressEvent.CHANGE, onSWFAddressChange);
            return;
        }// end function

        private function onAirTowerEventFromAS2(param1:Object) : void
        {
            return;
        }// end function

        private function onMessageFromAS2(param1:Object) : void
        {
            return;
        }// end function

        public function getBasePath() : String
        {
            return _environmentData.basePath;
        }// end function

        private function onSWFAddressChange(event:SWFAddressEvent) : void
        {
            var _loc_2:* = SWFAddress.getPathNames()[0];
            switch(_loc_2)
            {
                case MainModel.START_SCREEN_STATE:
                case MainModel.CREATE_ACCOUNT_STATE:
                case MainModel.LOGIN_STATE:
                case MainModel.REDEEM_STATE:
                {
                    _currentState = _loc_2;
                    break;
                }
                default:
                {
                    _currentState = MainModel.START_SCREEN_STATE;
                    break;
                    break;
                }
            }
            onStateChanged.dispatch();
            return;
        }// end function

        public function getUsername() : String
        {
            return myPlayerVO.username;
        }// end function

        public function getEnvironmentData() : EnvironmentData
        {
            return _environmentData;
        }// end function

        public function setEnvironmentData(param1:Object) : void
        {
            _environmentData.fromObject(param1);
            return;
        }// end function

        public function getNickname() : String
        {
            return myPlayerVO.nickname;
        }// end function

        public function getNewspaperPath() : String
        {
            return _currentNewspaperPath;
        }// end function

        public function configLoaded() : void
        {
            onConfigLoaded.dispatch();
            return;
        }// end function

        public function getLanguage() : String
        {
            return _environmentData.language;
        }// end function

        public function connectAVMBridge() : void
        {
            _bridge.connect(_environmentData.connectionID);
            return;
        }// end function

        public function close() : void
        {
            onAppClosed.dispatch();
            return;
        }// end function

    }
}
