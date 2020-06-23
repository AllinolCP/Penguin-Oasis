package com.clubpenguin.main.overlays.mediator
{
    import com.clubpenguin.lib.module.*;
    import com.clubpenguin.main.dialogboxes.*;
    import com.clubpenguin.main.overlays.view.*;
    import com.clubpenguin.main.overlays.vo.*;
    import com.clubpenguin.main.signal.*;
    import com.clubpenguin.world.*;
    import com.clubpenguin.world.model.*;
    import com.clubpenguin.world.service.avmbridge.*;
    import flash.display.*;
    import org.robotlegs.core.*;
    import org.robotlegs.mvcs.*;

    public class MultipleOverlayViewMediator extends Mediator
    {
        private var overlays:Array;
        public var view:MultipleOverlayView;
        public var _model:MainModel;
        public var signalBus:SignalBus;
        public var injector:IInjector;
        public var worldContext:WorldContext;

        public function MultipleOverlayViewMediator()
        {
            overlays = [];
            return;
        }// end function

        private function onShowLoading() : void
        {
            var _loc_3:String = null;
            var _loc_1:* = new LoadingDialog();
            var _loc_2:* = _model.getLanguage();
            switch(_loc_2)
            {
                case "en":
                {
                    _loc_3 = "Loading";
                    break;
                }
                case "es":
                {
                    _loc_3 = "Cargando";
                    break;
                }
                case "pt":
                {
                    _loc_3 = "Carregando";
                    break;
                }
                case "fr":
                {
                    _loc_3 = "Chargement";
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_1.textBox.text = _loc_3;
            var _loc_4:* = new LoadingOverlayVO(_loc_1);
            showOverlay(_loc_4);
            return;
        }// end function

        override public function onRegister() : void
        {
            signalBus.showLoading.add(onShowLoading);
            signalBus.hideLoading.add(onHideLoading);
            signalBus.showModule.add(onShowModule);
            signalBus.closeView.add(onCloseOverlayClicked);
            return;
        }// end function

        public function showOverlay(param1:OverlayVO) : void
        {
            if (param1.standalone)
            {
            }
            addNewOverlayView(param1);
            return;
        }// end function

        private function removeAllOtherOverlays(param1:OverlayView) : void
        {
            var _loc_2:OverlayView = null;
            for each (_loc_2 in overlays)
            {
                
                if (_loc_2 != param1)
                {
                    removeOverlayByView(_loc_2);
                }
            }
            return;
        }// end function

        private function onShowModule(param1:OverlayVO) : void
        {
            var _loc_2:* = BaseModule(param1.object);
            _loc_2.init();
            showOverlay(param1);
            return;
        }// end function

        private function onHideLoading() : void
        {
            removeOverlayByID(LoadingOverlayVO.LOADING_OVERLAY_ID);
            return;
        }// end function

        public function removeOverlayByView(param1:OverlayView) : Boolean
        {
            var _loc_2:int = 0;
            if (view.contains(param1))
            {
                view.removeChild(param1);
                if (mediatorMap.hasMediatorForView(param1))
                {
                    mediatorMap.removeMediatorByView(param1);
                }
                _loc_2 = 0;
                while (_loc_2 < overlays.length)
                {
                    
                    if (overlays[_loc_2] == param1)
                    {
                        overlays.splice(_loc_2, 1);
                    }
                    _loc_2 = _loc_2 + 1;
                }
                return true;
            }
            return false;
        }// end function

        private function addNewOverlayView(param1:OverlayVO) : OverlayView
        {
            var _loc_2:* = new OverlayView(param1.object);
            view.addChild(_loc_2);
            OverlayViewMediator(mediatorMap.retrieveMediator(_loc_2)).register(_loc_2);
            _loc_2.addChild(param1.object);
            _loc_2.name = param1.id;
            overlays.push(_loc_2);
            param1 = null;
            return _loc_2;
        }// end function

        private function onCloseOverlayClicked(param1:DisplayObject) : void
        {
            var _loc_3:OverlayView = null;
            _model.getAVMBridge().send(new AVMBridgeMessage(AVMBridgeMessage.MSG_MODULE_CLOSED));
            var _loc_2:int = 0;
            while (_loc_2 < overlays.length)
            {
                
                if (OverlayView(overlays[_loc_2]).contains(param1))
                {
                    _loc_3 = OverlayView(overlays[_loc_2]);
                    removeOverlayByView(_loc_3);
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function removeOverlayByID(param1:String) : void
        {
            var _loc_2:OverlayView = null;
            for each (_loc_2 in overlays)
            {
                
                if (_loc_2.name == param1)
                {
                    removeOverlayByView(_loc_2);
                }
            }
            return;
        }// end function

    }
}
