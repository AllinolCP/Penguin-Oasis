package org.robotlegs.core
{
    import flash.display.*;

    public interface IMediatorMap
    {

        public function IMediatorMap();

        function mapView(param1, param2:Class, param3:Class = null, param4:Boolean = true, param5:Boolean = true) : void;

        function unmapView(param1) : void;

        function createMediator(param1:Object) : IMediator;

        function registerMediator(param1:Object, param2:IMediator) : void;

        function removeMediator(param1:IMediator) : IMediator;

        function removeMediatorByView(param1:Object) : IMediator;

        function retrieveMediator(param1:Object) : IMediator;

        function hasMediator(param1:IMediator) : Boolean;

        function hasMediatorForView(param1:Object) : Boolean;

        function get contextView() : DisplayObjectContainer;

        function set contextView(param1:DisplayObjectContainer) : void;

        function get enabled() : Boolean;

        function set enabled(param1:Boolean) : void;

    }
}
