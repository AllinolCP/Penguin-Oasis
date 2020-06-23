package com.clubpenguin.lib.services.socketserver
{
    import org.osflash.signals.*;

    public interface ISocketServer
    {

        public function ISocketServer();

        function sendCommand(param1:String, param2:String, param3:Array) : void;

        function setCommandReponseSignal(param1:ISignal, param2:String) : void;

    }
}
