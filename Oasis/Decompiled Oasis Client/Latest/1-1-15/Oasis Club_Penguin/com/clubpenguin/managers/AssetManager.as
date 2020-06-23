package com.clubpenguin.managers
{
    import com.clubpenguin.main.signal.*;
    import com.clubpenguin.managers.vo.*;
    import com.clubpenguin.world.model.*;
    import com.clubpenguin.world.service.http.*;
    import flash.display.*;
    import flash.utils.*;
    import org.osflash.signals.*;

    public class AssetManager extends Object
    {
        public var mainModel:MainModel;
        private var assetLookup:Dictionary;
        public var assetLoaded:Signal;
        public var signalBus:SignalBus;
        private var loadSWFService:LoadSWFService;
        public var loadingAsset:Signal;

        public function AssetManager()
        {
            assetLoaded = new Signal(DisplayObject);
            loadingAsset = new Signal(LoadSWFService);
            assetLookup = new Dictionary();
            loadSWFService = new LoadSWFService();
            return;
        }// end function

        public function loadAsset(param1:String) : void
        {
            var _loc_2:* = mainModel.getEnvironmentData().clientPath;
            var _loc_3:* = mainModel.getEnvironmentData().basePath;
            var _loc_4:* = _loc_2 + param1;
            loadSWFService = new LoadSWFService();
            loadSWFService.setURL(_loc_4);
            loadSWFService.requestFailed.addOnce(onResponse);
            loadSWFService.responseReceived.addOnce(onResponse);
            loadSWFService.send();
            loadingAsset.dispatch(loadSWFService);
            var _loc_5:* = new AssetVO();
            _loc_5.url = _loc_4;
            assetLookup[_loc_4] = _loc_5;
            return;
        }// end function

        private function onResponse(param1:LoadSWFResponse) : void
        {
            var _loc_2:AssetVO = null;
            if (param1.success)
            {
                _loc_2 = AssetVO(assetLookup[param1.id]);
                _loc_2.object = Loader(param1.data).content;
                delete assetLookup[_loc_2.url];
                assetLoaded.dispatch(DisplayObject(_loc_2.object));
            }
            return;
        }// end function

    }
}
