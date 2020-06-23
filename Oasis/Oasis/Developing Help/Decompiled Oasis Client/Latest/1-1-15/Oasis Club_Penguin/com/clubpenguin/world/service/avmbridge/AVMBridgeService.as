package com.clubpenguin.world.service.avmbridge
{
    import com.clubpenguin.main.vo.*;
    import com.gskinner.utils.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import org.robotlegs.mvcs.*;

    public class AVMBridgeService extends Actor
    {
        public var response:LocalConnectionResponse;
        public var createMyPlayerVO:Signal;
        public var connected:Signal;
        public var disconnected:Signal;
        public var openModule:Signal;
        public var messageReceived:Signal;
        private var _bridge:SWFBridgeAS3;
        public var openNewspaper:Signal;
        public var airTowerEventReceived:Signal;
        private static const AS3_GATEWAY_METHOD:String = "messageFromAS2";
        private static const AS2_GATEWAY_METHOD:String = "messageFromAS3";

        public function AVMBridgeService()
        {
            connected = new Signal();
            disconnected = new Signal();
            openNewspaper = new Signal(String);
            createMyPlayerVO = new Signal(Object);
            openModule = new Signal(ModuleVO);
            messageReceived = new Signal(Object);
            airTowerEventReceived = new Signal(Object);
            return;
        }// end function

        public function send(param1:AVMBridgeMessage) : void
        {
            _bridge.send(AS2_GATEWAY_METHOD, {type:param1.type, data:param1.data});
            return;
        }// end function

        public function messageFromAS2(param1:Object) : void
        {
            var _loc_2:ModuleVO = null;
            switch(param1.type)
            {
                case AVMBridgeMessage.MSG_AS2_READY:
                {
                    connected.dispatch();
                    break;
                }
                case AVMBridgeMessage.MSG_MAKE_PLAYER_VO:
                {
                    createMyPlayerVO.dispatch(param1.myGenericPlayerObject);
                    break;
                }
                case AVMBridgeMessage.MSG_OPEN_MODULE:
                {
                    _loc_2 = new ModuleVO();
                    _loc_2.moduleName = param1.name;
                    _loc_2.moduleData = param1.data;
                    openModule.dispatch(_loc_2);
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function onSWFBridgeConnected(event:Event) : void
        {
            return;
        }// end function

        public function sendServerCommand(param1:String, param2:String, param3:Array) : void
        {
            var _loc_4:* = new AVMBridgeMessage(AVMBridgeMessage.MSG_SEND_SERVER_COMMAND);
            var _loc_5:Object = {};
            _loc_5.args = param3;
            _loc_5.commandHandler = param1;
            _loc_5.commandName = param2;
            _loc_4.data = _loc_5;
            send(_loc_4);
            return;
        }// end function

        public function connect(param1:String) : void
        {
            _bridge = new SWFBridgeAS3(param1, this);
            _bridge.addEventListener(Event.CONNECT, onSWFBridgeConnected);
            return;
        }// end function

        public function airTowerEvent(param1:Object) : void
        {
            airTowerEventReceived.dispatch(param1);
            return;
        }// end function

    }
}
