﻿package org.robotlegs.core
{
    import flash.system.*;

    public interface IReflector
    {

        public function IReflector();

        function classExtendsOrImplements(param1:Object, param2:Class, param3:ApplicationDomain = null) : Boolean;

        function getClass(param1, param2:ApplicationDomain = null) : Class;

        function getFQCN(param1, param2:Boolean = false) : String;

    }
}
