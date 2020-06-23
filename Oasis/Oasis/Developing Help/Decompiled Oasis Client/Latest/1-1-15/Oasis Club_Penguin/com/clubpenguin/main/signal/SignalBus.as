package com.clubpenguin.main.signal
{
    import com.clubpenguin.lib.vo.*;
    import com.clubpenguin.main.overlays.vo.*;
    import com.clubpenguin.main.vo.*;
    import flash.display.*;
    import org.osflash.signals.*;

    public class SignalBus extends Object implements IModuleAppSignalBus
    {
        public const showModule:ISignal;
        public const sendBI:ISignal;
        public const hideLoading:ISignal;
        public const sendUserSubmission:ISignal;
        public const loadModule:ISignal;
        public const closeView:ISignal;
        public const showLoading:ISignal;

        public function SignalBus()
        {
            loadModule = new Signal(ModuleVO);
            showModule = new Signal(OverlayVO);
            closeView = new Signal(DisplayObject);
            showLoading = new Signal();
            hideLoading = new Signal();
            sendUserSubmission = new Signal(UserSubmissionVO);
            sendBI = new Signal(BiVO);
            return;
        }// end function

        public function getShowModule() : ISignal
        {
            return showModule;
        }// end function

        public function getCloseView() : ISignal
        {
            return closeView;
        }// end function

        public function getSendBI() : ISignal
        {
            return sendBI;
        }// end function

        public function getShowLoading() : ISignal
        {
            return showLoading;
        }// end function

        public function getSendUserSubmission() : ISignal
        {
            return sendUserSubmission;
        }// end function

        public function getLoadModule() : ISignal
        {
            return loadModule;
        }// end function

        public function getHideLoading() : ISignal
        {
            return hideLoading;
        }// end function

    }
}
