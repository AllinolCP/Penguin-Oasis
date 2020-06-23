package com.clubpenguin.lib.vo.resource
{
    import flash.utils.*;

    public class ResourceVO extends Object
    {
        public var isMemberOnly:Boolean;
        public var filePath:Dictionary;
        public var id:int;
        public var cost:int;
        public var name:String;
        public static const FILE_TYPE_PHOTOS:String = "photos";
        public static const FILE_TYPE_ICONS:String = "icons";
        public static const FILE_TYPE_PAPER:String = "paper";
        public static const FILE_TYPE_SPRITES:String = "sprites";

        public function ResourceVO()
        {
            return;
        }// end function

    }
}
