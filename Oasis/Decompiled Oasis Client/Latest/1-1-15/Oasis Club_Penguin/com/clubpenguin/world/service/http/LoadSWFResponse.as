package com.clubpenguin.world.service.http
{
    import flash.display.*;

    public class LoadSWFResponse extends Object
    {
        public var success:Boolean = false;
        public var data:DisplayObject;
        public var props:Object;
        public var status:int;
        public var id:String;
        public var errorMessage:String;

        public function LoadSWFResponse()
        {
            return;
        }// end function

    }
}
