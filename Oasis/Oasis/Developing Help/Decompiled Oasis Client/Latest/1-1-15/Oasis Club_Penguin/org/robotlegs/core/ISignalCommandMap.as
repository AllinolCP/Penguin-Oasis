package org.robotlegs.core
{
    import org.osflash.signals.*;

    public interface ISignalCommandMap
    {

        public function ISignalCommandMap();

        function mapSignal(param1:ISignal, param2:Class, param3:Boolean = false) : void;

        function mapSignalClass(param1:Class, param2:Class, param3:Boolean = false) : ISignal;

        function hasSignalCommand(param1:ISignal, param2:Class) : Boolean;

        function unmapSignal(param1:ISignal, param2:Class) : void;

        function unmapSignalClass(param1:Class, param2:Class) : void;

    }
}
