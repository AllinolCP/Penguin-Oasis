package com.clubpenguin.lib.enums.resource
{

    public class ResourceTypeEnum extends Object
    {
        public var ordinal:int;
        public var value:String;
        public static const CLOTHING:ResourceTypeEnum = new ResourceTypeEnum("clothing", 1);
        public static const FURNITURE:ResourceTypeEnum = new ResourceTypeEnum("furniture", 2);

        public function ResourceTypeEnum(param1:String, param2:int)
        {
            this.value = param1;
            this.ordinal = param2;
            return;
        }// end function

        public function toString() : String
        {
            return "value = " + value + ", ordinal = " + ordinal;
        }// end function

    }
}
