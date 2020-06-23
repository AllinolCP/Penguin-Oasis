package com.clubpenguin.main.command
{
    import com.clubpenguin.lib.module.*;
    import com.clubpenguin.main.modules.*;
    import com.clubpenguin.main.overlays.type.*;
    import com.clubpenguin.main.overlays.vo.*;
    import com.clubpenguin.main.signal.*;
    import com.clubpenguin.main.vo.*;
    import com.clubpenguin.managers.*;
    import com.clubpenguin.world.*;
    import com.clubpenguin.world.model.*;
    import flash.display.*;
    import org.osflash.signals.*;
    import org.robotlegs.mvcs.*;

    public class LoadModuleCommand extends SignalCommand
    {
        public var moduleVO:ModuleVO;
        private var overlayVO:OverlayVO;
        public var context:WorldContext;
        public var mainModel:MainModel;
        public var signalBus:SignalBus;
        public var assetManager:AssetManager;

        public function LoadModuleCommand()
        {
            overlayVO = new OverlayVO();
            return;
        }// end function

        private function showOverlay(param1:BaseModule) : void
        {
            overlayVO.object = param1;
            Signal(signalBus.showModule).dispatch(overlayVO);
            overlayVO = null;
            return;
        }// end function

        override public function execute() : void
        {
            overlayVO.type = OverlayType.MODULE;
            overlayVO.dataObject = moduleVO.moduleData;
            overlayVO.id = moduleVO.moduleName;
            overlayVO.url = ModuleFilenamesEnum.getFilename(moduleVO.moduleName);
            loadModule(overlayVO);
            return;
        }// end function

        private function loadModule(param1:OverlayVO) : void
        {
            Signal(signalBus.showLoading).dispatch();
            assetManager.assetLoaded.addOnce(onModuleLoaded);
            assetManager.loadAsset(param1.url);
            return;
        }// end function

        private function onModuleLoaded(param1:DisplayObject) : void
        {
            var _loc_2:* = BaseModule(param1);
            _loc_2.setDependencies(IModuleAppContext(this.context), moduleVO.moduleData);
            Signal(signalBus.hideLoading).dispatch();
            showOverlay(BaseModule(param1));
            return;
        }// end function

    }
}
