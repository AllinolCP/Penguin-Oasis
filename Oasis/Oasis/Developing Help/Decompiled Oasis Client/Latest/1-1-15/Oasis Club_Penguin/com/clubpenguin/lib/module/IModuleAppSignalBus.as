package com.clubpenguin.lib.module
{
    import org.osflash.signals.*;

    public interface IModuleAppSignalBus
    {

        public function IModuleAppSignalBus();

        function getHideLoading() : ISignal;

        function getSendBI() : ISignal;

        function getCloseView() : ISignal;

        function getLoadModule() : ISignal;

        function getShowLoading() : ISignal;

        function getSendUserSubmission() : ISignal;

    }
}
