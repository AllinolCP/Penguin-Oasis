﻿package com.adobe.serialization.json
{

    public class JSON extends Object
    {

        public function JSON()
        {
            return;
        }// end function

        public static function decode(param1:String, param2:Boolean = true)
        {
            return new JSONDecoder(param1, param2).getValue();
        }// end function

        public static function encode(param1:Object) : String
        {
            return new JSONEncoder(param1).getString();
        }// end function

    }
}
