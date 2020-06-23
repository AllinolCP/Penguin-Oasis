package com.clubpenguin.lib.module
{
    import com.clubpenguin.lib.managers.localization.*;
    import com.clubpenguin.lib.managers.resource.*;
    import com.clubpenguin.lib.services.socketserver.*;

    public interface IModuleAppContext
    {

        public function IModuleAppContext();

        function getSignalBus() : IModuleAppSignalBus;

        function getModel() : IModuleAppMainModel;

        function getResourceManager() : IResourceManager;

        function getSocketServer() : ISocketServer;

        function getLocalizationManager() : ILocalizationManager;

    }
}
