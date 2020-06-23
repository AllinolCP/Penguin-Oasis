package org.osflash.signals
{

    public interface ISignal
    {

        public function ISignal();

        function add(param1:Function) : Function;

        function addOnce(param1:Function) : Function;

        function remove(param1:Function) : Function;

        function get valueClasses() : Array;

        function get numListeners() : uint;

    }
}
