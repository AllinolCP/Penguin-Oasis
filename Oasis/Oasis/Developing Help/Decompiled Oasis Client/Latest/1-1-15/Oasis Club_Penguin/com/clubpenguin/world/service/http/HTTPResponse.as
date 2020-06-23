package com.clubpenguin.world.service.http
{

    public class HTTPResponse extends Object
    {
        public var status:int;
        public var success:Boolean = false;
        public var data:Object;
        public var errorMessage:String;

        public function HTTPResponse()
        {
            return;
        }// end function

    }
}
